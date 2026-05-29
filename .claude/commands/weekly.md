---
description: Weekly sync prep — what I shipped, what's in progress, what I touched, plans for next week (from Linear)
allowed-tools: mcp__linear__list_issues, mcp__linear__get_issue
---

Prepare my weekly sync report from Linear. Linear is the single source of truth — do not pull from git or anywhere else.

Steps:
1. Fetch my issues: `list_issues` with assignee `me`, `includeArchived: false`, `limit: 150`, `orderBy: updatedAt`. This returns issues across all my teams.
2. Window = the last 7 days from the current date/time.
3. Build four sections, in this order. Each issue appears in AT MOST ONE section — once placed, exclude it from later sections.
   - Done this week: statusType `completed` AND `completedAt` within the window.
   - In progress: statusType `started`.
   - Touched this week: `updatedAt` within the window AND not already in Done or In progress. Issues worked on without a Done/started status change — append the current status in parens, e.g. `(Todo)`, `(Backlog)`.
   - Plans next week: statusType `unstarted` (Todo), sorted by priority (Urgent > High > Medium > Low > None), top 7, EXCLUDING anything already shown in Touched.
4. Skip `canceled` and `duplicate` entirely.

Output rules (match my preferences):
- Plain text. No markdown headers (#), no bold (**), no code fences, no tables.
- Four plain labels: `Done this week:`, `In progress:`, `Touched this week:`, `Plans next week:`. Dash-prefixed items under each.
- Each item: `- COR-201 — Switch peer onto shared metadata crate`. Always include the identifier before the title.
- If a section is empty, write `- none`.
- In the Done section, group by team if I worked across more than one team (`SDK Engineering:` / `Core Engineering:` sub-labels), otherwise a flat list.
- Keep it tight. Flag blocked items inline as `(blocked: reason)`.
