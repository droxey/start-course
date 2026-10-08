#!/bin/sh
# Build the published Docsify site into SRC/_site/. This only selects and copies
# files; Docsify still renders Markdown in the browser.
#
# Public:
#   - every .html, .css, .js, and image file, and all of web/
#   - Docsify runtime pages: README.md, _sidebar.md, _navbar.md, _coverpage.md, _404.md
#   - every .md under docs/
#   - every .md linked from a public _sidebar.md or _navbar.md (nested ones too) or
#     from a table of contents on a public page (<!-- toc --> blocks, or the list
#     under a "Table of Contents" / "Contents" heading), plus ':include' embeds
#   - the Markdown a linked slide deck loads (reveal.js data-markdown)
#   - other files (PDFs, fonts, downloads) referenced by public pages, HTML, or CSS
# Every other .md is private. Links from a public page (Markdown body or HTML) to a
# private .md are printed as warnings (broken on the site); --strict makes them fail.
#
# Usage: sh scripts/build-site.sh [--strict] [SRC_DIR]
set -eu

strict=0
if [ "${1:-}" = "--strict" ]; then strict=1; shift; fi
cd "${1:-.}"
out=_site
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

find . \( -name .git -o -name node_modules -o -name _site -o -name test-results \
  -o -name playwright-report \) -prune -o -type f -print |
  sed 's|^\./||' | LC_ALL=C sort > "$tmp/all"

prog=$(cat <<'AWK'
function dirname(p) { if (p !~ /\//) return ""; sub(/\/[^\/]*$/, "", p); return p }
function norm(p,   n, a, i, k, o, s, trail) {
  trail = (p ~ /\/$/); n = split(p, a, "/"); k = 0
  for (i = 1; i <= n; i++) {
    if (a[i] == "" || a[i] == ".") continue
    if (a[i] == "..") { if (k == 0) return "\001"; k--; continue }
    o[++k] = a[i]
  }
  s = ""; for (i = 1; i <= k; i++) s = (i == 1) ? o[i] : s "/" o[i]
  if (trail && s != "") s = s "/"
  return s
}
# Resolve p against base the way Docsify does: dir/ -> dir/README.md, no extension -> .md
function try(p, base, ignore,   last) {
  p = norm(base == "" ? p : base "/" p)
  if (p == "\001") return ""
  if (p == "" || p ~ /\/$/) {
    if (ignore && ((p "index.html") in exists)) return p "index.html"
    return ((p "README.md") in exists) ? p "README.md" : ""
  }
  if (p in exists) return p
  last = p; sub(/.*\//, "", last)
  if (last !~ /\./ && ((p ".md") in exists)) return p ".md"
  return ""
}
# Markdown link target -> existing file, or "". Docsify (relativePath: false) resolves
# from the site root; fall back to the linking file's folder (GitHub-style links).
function resolve(raw, curdir, ignore,   r) {
  if (raw ~ /^[A-Za-z][A-Za-z0-9+.-]*:/ || raw ~ /^\/\//) return ""
  if (raw ~ /^#\//) raw = substr(raw, 2)
  else if (raw ~ /^#/) return ""
  sub(/[?#].*$/, "", raw); gsub(/%20/, " ", raw)
  if (raw == "") return ""
  if (substr(raw, 1, 1) == "/") return try(substr(raw, 2), "", ignore)
  r = try(raw, "", ignore)
  if (r == "" && curdir != "") r = try(raw, curdir, ignore)
  return r
}
# HTML/CSS reference -> existing file, resolved like a browser (relative to the file).
function asset(raw, curdir) {
  if (raw ~ /^[A-Za-z][A-Za-z0-9+.-]*:/ || raw ~ /^\/\// || raw ~ /^#/) return ""
  sub(/[?#].*$/, "", raw); gsub(/%20/, " ", raw)
  if (raw == "") return ""
  if (substr(raw, 1, 1) == "/") return try(substr(raw, 2), "", 0)
  return try(raw, curdir, 0)
}
function pub(f) { if (!(f in published)) { published[f] = 1; order[++no] = f } }
function mdpub(f) { if (!(f in pubmd)) { pubmd[f] = 1; pub(f); q[++qt] = f } }
function handle(kind, src, ln, inner, curdir,   t, raw, title, ignore, include) {
  sub(/^[ \t]+/, "", inner)
  if (inner ~ /^</) { t = inner; sub(/^</, "", t); sub(/>.*$/, "", t); title = inner; sub(/^<[^>]*>/, "", title) }
  else { t = inner; sub(/[ \t].*$/, "", t); title = inner; sub(/^[^ \t]*/, "", title) }
  ignore = (title ~ /:ignore/); include = (title ~ /:include/)
  raw = t; t = resolve(t, curdir, ignore)
  if (t == "") return
  if (tolower(t) ~ /\.md$/) {
    if (kind == "nav" || include) mdpub(t)
    else { nw++; wsrc[nw] = src ":" ln; wraw[nw] = raw; wt[nw] = t }
  } else {
    pub(t)
    if (tolower(t) ~ /\.html?$/) slidedeck(t)
  }
}
# A public page links to this HTML file: publish the Markdown it loads (reveal.js data-markdown).
function slidedeck(h,   line, s, v, t) {
  if (h in decks) return
  decks[h] = 1
  while ((getline line < h) > 0) {
    s = line
    while (match(s, /data-markdown=["'][^"']+["']/)) {
      v = substr(s, RSTART + 15, RLENGTH - 16); s = substr(s, RSTART + RLENGTH)
      t = asset(v, dirname(h)); if (t != "") mdpub(t)
    }
  }
  close(h)
}
function scan_md(f,   curdir, base, d, line, ln, fence, toc, htoc, kind, s, h, inner) {
  curdir = dirname(f); base = f; sub(/.*\//, "", base)
  # Docsify looks for _sidebar.md / _navbar.md in the page folder, then each parent.
  d = curdir
  while (1) {
    if (((d == "" ? "" : d "/") "_sidebar.md") in exists) mdpub((d == "" ? "" : d "/") "_sidebar.md")
    if (((d == "" ? "" : d "/") "_navbar.md") in exists) mdpub((d == "" ? "" : d "/") "_navbar.md")
    if (d == "") break
    d = dirname(d)
  }
  ln = 0; fence = 0; toc = 0; htoc = 0
  while ((getline line < f) > 0) {
    ln++
    if (line ~ /^[ \t]*(```|~~~)/) { fence = !fence; continue }
    if (fence) continue
    if (line ~ /<!--[ \t]*(tocstop|\/toc|\/TOC|toc:end)[ \t]*-->/) { toc = 0; continue }
    if (line ~ /<!--[ \t]*(toc|TOC)([ \t:][^>]*)?-->/) { toc = 1; continue }
    if (line ~ /^[ \t]*#+[ \t]/) {
      h = tolower(line); gsub(/[^a-z ]/, "", h); gsub(/^ +| +$/, "", h)
      htoc = (h == "table of contents" || h == "contents" || h == "toc")
    }
    kind = (base == "_sidebar.md" || base == "_navbar.md" || toc || htoc) ? "nav" : "body"
    s = line
    while (match(s, /\]\([^)]*\)/)) {
      inner = substr(s, RSTART + 2, RLENGTH - 3); s = substr(s, RSTART + RLENGTH)
      handle(kind, f, ln, inner, curdir)
    }
    if (line ~ /^[ \t]*\[[^]]+\]:[ \t]*[^ \t]/) {
      s = line; sub(/^[ \t]*\[[^]]+\]:[ \t]*/, "", s); handle(kind, f, ln, s, curdir)
    }
    s = line
    while (match(s, /(href|src)[ \t]*=[ \t]*["'][^"']*["']/)) {
      inner = substr(s, RSTART, RLENGTH); s = substr(s, RSTART + RLENGTH)
      sub(/^[^"']*["']/, "", inner); sub(/["']$/, "", inner)
      handle(kind, f, ln, inner, curdir)
    }
  }
  close(f)
}
# Fonts, images, PDFs, ... referenced from public HTML (src/href) or CSS (url(), @import).
function scan_assets(f,   line, ln, s, v, t, css) {
  css = (tolower(f) ~ /\.css$/); ln = 0
  while ((getline line < f) > 0) {
    ln++; s = line
    while (css ? match(s, /(url\([^)]*\)|@import[ \t]+["'][^"']+["'])/) : match(s, /(href|src)[ \t]*=[ \t]*["'][^"']*["']/)) {
      v = substr(s, RSTART, RLENGTH); s = substr(s, RSTART + RLENGTH)
      if (css) { sub(/^(url\(|@import[ \t]+)[ \t]*["']?/, "", v); sub(/["']?[ \t]*\)?$/, "", v) }
      else { sub(/^[^"']*["']/, "", v); sub(/["']$/, "", v) }
      t = asset(v, dirname(f))
      if (t == "") continue
      if (tolower(t) !~ /\.md$/) pub(t)
      else if (!(t in pubmd)) { nw++; wsrc[nw] = f ":" ln; wraw[nw] = v; wt[nw] = t }
    }
  }
  close(f)
}
{ exists[$0] = 1; files[++nf] = $0 }
END {
  for (i = 1; i <= nf; i++) {
    f = files[i]; lf = tolower(f)
    if (lf ~ /\.(html?|css|m?js|png|jpe?g|gif|svg|webp|avif|ico|bmp)$/ || f ~ /^web\//) pub(f)
    if (lf ~ /\.md$/ && f ~ /^docs\//) mdpub(f)
  }
  n = split("README.md _sidebar.md _navbar.md _coverpage.md _404.md", rt, " ")
  for (i = 1; i <= n; i++) if (rt[i] in exists) mdpub(rt[i])
  while (qh < qt) scan_md(q[++qh])
  for (i = 1; i <= no; i++) if (tolower(order[i]) ~ /\.(html?|css)$/) scan_assets(order[i])
  for (i = 1; i <= no; i++) print order[i] > filelist
  for (i = 1; i <= nw; i++) if (!(wt[i] in pubmd)) print wsrc[i] ": links to private " wt[i] " (" wraw[i] ")" > warnlist
  for (i = 1; i <= nf; i++) if (tolower(files[i]) ~ /\.md$/ && !(files[i] in pubmd)) print files[i] > privlist
}
AWK
)

: > "$tmp/files"; : > "$tmp/warn"; : > "$tmp/private"
awk -v filelist="$tmp/files" -v warnlist="$tmp/warn" -v privlist="$tmp/private" "$prog" "$tmp/all"

rm -rf "$out"
mkdir "$out"
while IFS= read -r f; do
  mkdir -p "$out/$(dirname "$f")"
  cp -p "$f" "$out/$f"
done < "$tmp/files"

echo "Built $out/: $(wc -l < "$tmp/files" | tr -d ' ') files published; $(wc -l < "$tmp/private" | tr -d ' ') .md files kept private."
if [ -s "$tmp/warn" ]; then
  echo "Warning: $(wc -l < "$tmp/warn" | tr -d ' ') link(s) from public pages to private .md files (broken on the site):" >&2
  sed 's/^/  /' "$tmp/warn" >&2
  if [ "$strict" -eq 1 ]; then exit 1; fi
fi
