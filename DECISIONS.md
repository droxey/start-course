# Course Ops Decisions

Instructor/agent decision log for ACS course ops. Not a published syllabus page. Do not link from `_sidebar.md`.

**Agents:** after any planning interview or standing lock, first update the relevant canonical document or skill, then append a dated entry here with **Decision**, **Reason**, and **Canon**. Do not leave locks only in chat. Related: [TERM.md](TERM.md) · [CALENDAR.md](CALENDAR.md) · [SLACK.md](SLACK.md).

## Entry Format

```markdown
## YYYY-MM-DD — Session or theme title

### Short decision title

- **Decision:** …
- **Reason:** …
- **Canon:** path or skill updated
```

---

## 2026-09-21 — Term plan + day-1 interview

### Audit scope (Tech-at-DU nightly)

- **Decision:** Locked order 4210 → 3210 → 2951 → Make-Chat → Proud-Petes → 4996 → 3220 → 1100 → 4220. Drop `makescraper`. Include ACS-3220 for next-term prep. 4220 last.
- **Reason:** Dani teaching load + next-term 3220; makescraper out of scope; 4220 lower priority.
- **Canon:** Nightly Audit Engineer target list (fleet); not learner-facing.

### AI-writing gate

- **Decision:** Keep on Writer — mandatory, stricter pass-gate. No dedicated detection bot.
- **Reason:** Dani chose Writer ownership over a new bot.
- **Canon:** TERM.md human/autonomous tables; Writer standing.

### Course content order

- **Decision:** outcomes → week topics → README `## Schedule` (one pass for Dani review) → `Lessons/OUTLINE.md` → full lessons → sidebar.
- **Reason:** Dani’s preferred plan sequence before day-1 launch.
- **Canon:** TERM.md; [acs-term-start](agents/skills/acs-term-start/SKILL.md).

### Keep intact / no prior-term redraft

- **Decision:** If outcomes / week topics / schedule / OUTLINE / plans already exist, do not redraft from a prior term; section-only updates only.
- **Reason:** Preserve live curriculum; avoid churn.
- **Canon:** TERM.md.

### Who drafts when missing

- **Decision:** Assistant drafts first outcomes + week topics when missing; Dani edits.
- **Reason:** Dani answered “you” (assistant).
- **Canon:** TERM.md.

### One-pass review

- **Decision:** Outcomes + week topics + `## Schedule` go to Dani in one pass (not separate approvals between each).
- **Reason:** Dani chose one pass.
- **Canon:** TERM.md.

### OUTLINE.md

- **Decision:** Create `Lessons/OUTLINE.md` with `## Day X - Topic` and outline under each header for every lesson before full lesson files. Instructor-only — no `_sidebar.md` link.
- **Reason:** Thin outline layer before full plans; keep off Docsify nav like setup.
- **Canon:** TERM.md; path `Lessons/OUTLINE.md` (or `lessons/OUTLINE.md` per repo casing).

### Always update Schedule

- **Decision:** When updating a course, always update README `## Schedule`.
- **Reason:** Dani standing during course-update interview.
- **Canon:** TERM.md; setup/course ops.

### Day-1 launch set (full)

- **Decision:** Slack invites → calendar series live → Docsify verify. That is the full set (no extra Grain/Form/email required in this lock).
- **Reason:** Dani confirmed full set.
- **Canon:** TERM.md.

### Slack

- **Decision:** Channel pattern `#acs-xxxx` (4-digit code from repo prefix). Channels usually already created — invites only. Roster from Ellucian CSV. When Dani hands the list, add people (handoff = OK for invites). Confirm before Slack *sends*; no grades/scores; no private feedback in channels.
- **Reason:** Dani interview + existing faculty guardrails.
- **Canon:** SLACK.md; [acs-slack](agents/skills/acs-slack/SKILL.md).

### Calendar

- **Decision:** Once dates are set, draft full term series (Zoom bits + EXDATEs) and **ask approval before creating**. Rules: America/Los_Angeles; invite danielle.roxberry@dominican.edu; title `ACS 4210` space form; Zoom only (bit.ly zoom + meet in description); EXDATE holidays; no Fri/weekend class meetings; teaching/work calendar.
- **Reason:** Dani interview + prior standing calendar rules.
- **Canon:** CALENDAR.md; [acs-google-calendar-class-series](agents/skills/acs-google-calendar-class-series/SKILL.md).

### Docsify

- **Decision:** Usually already live — verify before day 1; fix only if broken.
- **Reason:** Dani.
- **Canon:** TERM.md.

### Agent autonomy wiring

- **Decision:** Wire TERM.md + skills + Sunday/weekday routines to read TERM.md and execute autonomous steps. Keep human gates: content review, calendar approval, CSV handoff, send confirm.
- **Reason:** Dani chose docs+skill+routines without widening calendar autonomy.
- **Canon:** TERM.md; acs-term-start; Daily ACS lesson plan refresh + Sunday ACS week kick routines.

### Capture everything

- **Decision:** All planning locks must be filed (docs + skills + this log). No exceptions for chat-only decisions.
- **Reason:** Dani: “Everything has to be captured, no exceptions.”
- **Canon:** This file; end-of-planning-chat gap check.

### Skills shipped to template

- **Decision:** Ship `acs-term-start`, `acs-google-calendar-class-series`, `acs-slack` under `agents/skills/` (PR #32). Prefer **guardrails** wording over “do not” headings.
- **Reason:** Dani asked skills saved to Syllabus-Template; fleet wording.
- **Canon:** agents/skills/*; agents.md file map.

### Code snippet review gate

- **Decision:** Before any ACS lesson plan or tutorial is ready-to-PR or used as teach-from, code snippets must be handed to Code Review to verify they run. Fail closed until pass or Dani waives.
- **Reason:** Dani 2026-09-21 — snippets in tutorials and lesson plans must be checked for correctness.
- **Canon:** TERM.md; agents/TEACHING-FLEET.md; Teacher → Code Review handoff.

### Teaching fleet docs in template

- **Decision:** Document Writer AI-writing gate, Code Review snippet gate, and CodeRabbit cleanup routine in `agents/TEACHING-FLEET.md`. Sync live `acs-lesson-plan` bars into Syllabus-Template.
- **Reason:** Dani asked to save Grok Bot teaching platform hooks into the syllabus template; lesson-plan bars were behind on remote.
- **Canon:** agents/TEACHING-FLEET.md; agents/skills/acs-lesson-plan/SKILL.md.

### Sole starter path lessons/Lesson1.md

- **Decision:** Canonical lesson starter in Syllabus-Template is `lessons/Lesson1.md` (lowercase `lessons/` to match the repo). `templates/LESSON_TEMPLATE.md` is a pointer only.
- **Reason:** agents.md had been updated to `Lessons/Lesson1.md` but that path did not exist; only `templates/LESSON_TEMPLATE.md` was on disk. Avoid `Lessons/` vs `lessons/` case collision.
- **Canon:** lessons/Lesson1.md; agents.md; acs-lesson1-only-template; acs-lesson-plan.

### Restore LESSON_TEMPLATE sole starter name

- **Decision:** Canonical lesson starter filename is `templates/LESSON_TEMPLATE.md`. `lessons/Lesson1.md` is a pointer only. Template content keeps **baseline bar fixes** (Activity topic titles, DONE WHEN callouts, Title Case author headings, no beat, session wording).
- **Reason:** Dani 2026-09-21 — wants it called LESSON_TEMPLATE; bar fixes are baseline for the starter, not Lesson1-specific.
- **Canon:** templates/LESSON_TEMPLATE.md; agents.md; acs-lesson1-only-template; acs-lesson-plan.

### TypeSafe ACS pilot order

- **Decision:** Pilot TypeSafe on ACS workflows in this order: (5) executor-done on one ACS-4210 section patch, then (4) bar compliance smoke on Interfaces/Protocols-class lessons. TypeSafe densifies Choice/Score/Noul judgments between TERM gates only — does not replace Writer, human content review, calendar approve, Slack confirm-before-send, snippet Code Review, or DECISIONS.md.
- **Reason:** Dani 2026-09-21 approved TypeSafe’s proposed pilot order.
- **Canon:** agents/TEACHING-FLEET.md; TERM.md human gates; Teacher ↔ TypeSafe handoff.

## 2026-10-08 — Published files

### Root ops docs are not public

- **Decision:** GitHub Pages deploys `_site/` (built by `scripts/build-site.sh`) through GitHub Actions, not the repo root. Every `.html`, `.css`, `.js`, and image file is public, plus everything under `lessons/` (linked or not), `web/`, and the Docsify runtime pages (`README.md`, `_sidebar.md`, `_navbar.md`). Any other `.md` file is public only if it is under `docs/` or linked from `_sidebar.md`, `_navbar.md`, or a table of contents on a public page; every other `.md` stays private. Agent and ops docs stay at the repo root for agents but are never on the site.
- **Reason:** Dani: root `.md` files must not be public. Branch deploy served `AGENTS.md`, `agents.md`, `DECISIONS.md`, `TERM.md`, `SLACK.md`, `CALENDAR.md`, `setup.md`, `agents/`, and config files on every course site.
- **Canon:** scripts/build-site.sh; .github/workflows/pages.yml; setup.md; agents.md.
