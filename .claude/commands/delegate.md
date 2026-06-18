---
description: Personal-mode delegation — run a decided spec through the local worker→reviewer pipeline on its own branch, then hand back the branch + findings for my review and merge.
---

/delegate runs the personal-mode pipeline for a spec we've already decided in this conversation. Work-mode tasks go through Linear + Cyrus + GitHub (PR reviewed by me + Greptile), not this command.

Preconditions:
- We're in a git repo with a clean working tree.
- The spec is decided (understand → decide → spec already done with me). If it isn't clear yet, stop and finish deciding it first — never guess the spec.

Steps:
1. Capture the spec. Write the agreed spec, as plain text, to a single rolling file `TASK` at the repo root (overwrite it each run). Ensure `TASK` is in `.gitignore` — it's a scratch file, never committed.
2. Branch. Create a branch named `<type>/<slug>`: `<type>` is the conventional-commit type that fits the change (feat, fix, refactor, ...); `<slug>` is a short kebab summary of the essence (e.g. `feat/peer-bandwidth-report`).
3. Worker. Spawn the `worker` agent (Sonnet) in an isolated worktree on that branch, pointed at `TASK`. It implements the spec, self-verifies (build + relevant tests), and returns a report — or stops with a blocker if the spec doesn't cover something.
4. Review. Spawn the `reviewer` agent (Opus) with the worker's diff. It returns findings grouped bugs / decisions / nits, plus a verdict (ready / needs another round).
5. Loop. If the verdict is "needs another round" and we're under 2 rounds, resume the worker with the reviewer's findings, then re-review. Maximum 2 rounds.
6. Hand back (never merge):
   - Done (reviewer satisfied): bring me the branch name, the spec, the reviewer's findings (bugs / decisions / nits), and the verdict. Then STOP — I review the branch and merge it myself.
   - Blocked (worker hit an ambiguity, or reviewer still not satisfied after 2 rounds): bring me the blocker / open question and the partial state on the branch. We clarify, then resume.

Hard rules:
- Never merge, never push, never commit to my main branch. The work stays on its branch; the merge is mine.
- The worker makes no design decisions; on any gap it stops for me.
- Surface the reviewer's findings to me — the embedded decisions especially — don't just report "ready".
