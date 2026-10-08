# Course setup

Course-level setup and instructor/agent ops live **here**. Not in lesson bodies. Not as skill-name dumps.

This file is for instructors and agents standing up a course repo. It is not a published syllabus. Agent jobs are in [AGENTS.md](AGENTS.md).

## Clone and placeholders

1. Clone this repo, or use it as the GitHub template.
2. Replace every `ALL_CAPS` token. Search for `COURSE_`, `REPO_NAME`, `GITHUB_ORG`, `INSTRUCTOR_EMAIL`.
3. Set `index.html` title, description, author, `repo`, `name`, `search.namespace`, and OG URLs.
4. Rewrite `README.md` as this course's syllabus. Keep the ACS-3220 section order.
5. After you add `web/logo-icononly.svg`, set `logo: 'web/logo-icononly.svg'` in `index.html`.

`_sidebar.md` and `package.json` have no tokens. Link new lessons in `_sidebar.md` after the files exist on disk.

| Token | Where | Example |
| ----- | ---- | ------- |
| `COURSE_TITLE` | `index.html` title + OG, `README.md` H1 | `ACS 3220: Docker, DevOps, & Deployments` |
| `COURSE_NAME` | Docsify sidebar name | `ACS 3220` |
| `COURSE_DESCRIPTION` | meta description, syllabus pitch | one paragraph |
| `COURSE_WHY` | `README.md` why block | one paragraph |
| `COURSE_INSTRUCTOR` | author meta | `Dani Roxberry` |
| `INSTRUCTOR_EMAIL` | author meta | `dani@musexmachine.com` |
| `COURSE_KEYWORDS` | meta keywords | `docker, devops, deployment` |
| `COURSE_DELIVERY` | `README.md` specifics | `online` or `in-person` |
| `COURSE_WEEKS` | `README.md` specifics | `7` |
| `COURSE_SESSIONS` | `README.md` specifics | `12` |
| `COURSE_CREDITS` | `README.md` specifics | `3 units` |
| `COURSE_OUTCOME_1` … `_4` | `README.md` outcomes | action-verb outcome |
| `COURSE_START` / `COURSE_END` | `README.md` schedule | term dates |
| `COURSE_MEETING_DAYS` / `COURSE_MEETING_TIME` | `README.md` schedule | `Mon/Wed` / `4:00pm–5:30pm PT` |
| `GITHUB_ORG` | OG URLs, `repo` | `droxey` or `Tech-at-DU` |
| `REPO_NAME` | OG URLs, `repo`, search namespace | `ACS-3220-Docker-DevOps-Deployments` |
| `LESSON_TITLE` | `templates/LESSON_TEMPLATE.md` H1, syllabus schedule | topic name, not `Lesson 1` |
| `CONCEPT_1` … `_3` | lesson starter objectives / TT | topic terms |
| `DATE_*` / `HOLIDAY_NAME` | syllabus schedule | session dates |
| `PREREQUISITE_1` / `_2` | syllabus prereq link text | course or skill name |
| `TUTORIAL_NAME` / `TUTORIAL_URL` | syllabus tutorials | name + URL |
| `CHALLENGE_NAME` | syllabus challenges | challenge title |
| `GRADESCOPE_URL` | syllabus submit link | Gradescope assignment URL |
| `RECORDINGS_URL` | syllabus recordings | recordings index URL |
| `COURSE_SLUG` | `grain/course.yaml` | kebab-case course id |
| `COURSE_PVC_VOICE_ID` | `grain/course.yaml` | ElevenLabs PVC id (not an API key) |

## Docsify preview and GitHub Pages

```bash
npm install
npm run serve
```

Open `http://localhost:3000`. Enable GitHub Pages from the default branch. `.nojekyll` is already in the repo so Jekyll does not drop `_sidebar.md` / `_navbar.md`.

CDN scripts in `index.html` are pinned jsDelivr URLs without SRI. That is accepted CDN trust for this template. Keep `executeScript` off and do not load `external-script`.

Link check (local targets only; leftover placeholders are listed, not failed):

```bash
npm run check-links
```

Add course-specific Prism languages in `index.html` if you need them (`prism-docker`, `prism-go`, …).

Do not link this file from `_sidebar.md`. Search only sees sidebar links; keep setup off the published nav.

## New lessons (LESSON_TEMPLATE only)

Copy `templates/LESSON_TEMPLATE.md` → `lessons/<topic_name>.md` (kebab or short TopicCase). That file is the only starter. Never author from `Lesson2`.

Link every published lesson from `_sidebar.md` after the file exists. Do not add a syllabus link to a path that is not on disk yet.

`test/sample-course/` is a filled proof that tokens can be replaced. Its lesson bodies are historical — they do not match today's bars. Do not author a new course from those modules.

## Lesson instructor notes

Lesson-level instructor notes go **only** in the lesson template author block at the bottom of the lesson:

1. After `## Additional Resources`
2. Inside `<details>` wrapping `## For curriculum authors`
3. Subheads: `### In Class`, `### Facilitator notes`, `### Expert follow-ups`

Do not put instructor prep in the published mid-body (warm-up, TT, activity, lab, wrap). Do not put it in a header LESSON PREP toggle.

## Additional Resources

The heading is always exactly `## Additional Resources`. Never rename it. Never add parentheticals.

This section is **topic sources only**: official docs, APIs, specs, and short topic references. Official sources first (list order, not heading text).

Do **not** put pedagogy or how-to-teach links here. Teaching notes belong under `## For curriculum authors`.

## Course content voice

Published lesson, syllabus, activity, and README prose is **on-the-job / builder** voice: practical, direct, example-first, I/you/we on the work.

Never frame that prose as students, classroom, or academic.

Never write `jobsim`, `JOBSIM`, or `job simulator`.

Never cite skill names in published course Markdown.

## Term Start And Course Plan

Full content + day-1 checklist (with human gates) lives in [TERM.md](TERM.md). Decision log: [DECISIONS.md](DECISIONS.md) · [agents/TEACHING-FLEET.md](agents/TEACHING-FLEET.md). Agents read TERM.md before course-plan or day-1 work.

Calendar: [CALENDAR.md](CALENDAR.md). Slack: [SLACK.md](SLACK.md).

## Google Calendar Class Series

Class recurrence / Zoom invite rules live in [CALENDAR.md](CALENDAR.md) (instructor/agent ops only — do not link from `_sidebar.md`).

## Slack Course Channels

Channel naming (`#acs-xxxx`), invites, and send guardrails live in [SLACK.md](SLACK.md) (instructor/agent ops only — do not link from `_sidebar.md`).

## Agent jobs

Refresh, runtime bumps, tech trends, missing curriculum, and the rest of the agent job list live in [AGENTS.md](AGENTS.md). Read that file after this one.
