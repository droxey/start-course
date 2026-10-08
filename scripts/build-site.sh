#!/bin/sh
# Build the published site into _site/ from an allowlist. Only these paths go
# public; everything else (AGENTS.md, DECISIONS.md, TERM.md, setup.md, agents/,
# templates/, ...) stays in the repo. Add a path here to publish it.
set -eu
PUBLIC="index.html README.md _sidebar.md _navbar.md _coverpage.md _404.md web lessons assignments slides"
rm -rf _site
mkdir _site
for p in $PUBLIC; do
  if [ -e "$p" ]; then cp -R "$p" _site/; fi
done
echo "Built _site/ from: $PUBLIC"
