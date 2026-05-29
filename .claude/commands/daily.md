---
description: Standup prep — what I did in the last 24h, what's in progress, what I touched, what's next (from Linear)
allowed-tools: mcp__linear__list_issues, mcp__linear__get_issue
---

Prepare my daily standup report from Linear. Linear is the single source of truth — do not pull from git or anywhere else.

Steps:
1. Fetch my issues: `list_issues` with assignee `me`, `includeArchived: false`, `limit: 100`, `orderBy: updatedAt`. This returns issues across all my teams.
2. Window = the last 24 hours from the current date/time.
3. Build four sections, in this order. Each issue appears in AT MOST ONE section — once placed, exclude it from later sections.
   - Done (24h): statusType `completed` AND `completedAt` within the window.
   - In progress: statusType `started`.
   - Touched (24h): `updatedAt` within the window AND not already in Done or In progress. These are issues worked on without a Done/started status change (a comment, a created card, an edit) — append the current status in parens, e.g. `(Todo)`, `(Backlog)`. This is the backward-looking "what I actually poked today".
   - Up next: statusType `unstarted` (Todo), sorted by priority (Urgent > High > Medium > Low > None), top 5, EXCLUDING anything already shown in Touched. Forward-looking "what I'll pick up".
4. Skip `canceled` and `duplicate` entirely.

Output rules (match my preferences):
- Plain text. No markdown headers (#), no bold (**), no code fences, no tables.
- Four plain labels: `Done (24h):`, `In progress:`, `Touched (24h):`, `Up next:`. Dash-prefixed items under each.
- Each item: `- COR-201 — Switch peer onto shared metadata crate`. Always include the identifier before the title.
- If a section is empty, write `- none`.
- Keep it short — a list to read aloud at standup, not prose. Flag blocked items inline as `(blocked: reason)`.
