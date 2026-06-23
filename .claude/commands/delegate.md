---
description: Personal-mode delegation — run an already-decided, plan-mode-approved plan through the local worker→reviewer pipeline, then hand back the branch + findings for my review and merge.
---

/delegate executes a plan we have already decided and approved in plan mode. It decides nothing. Work-mode tasks go through Linear + the virtual worker (later), not this command.

Preconditions:
- The plan is approved. Understand → decide → plan mode is already done. If the plan is not settled, STOP and finish deciding it first — never guess it.
- The target is one of the anyip repos under `/home/denis/src/anyip` (peer, node, shared, semaphore).

How it works (the modern primitives, no hand-built worktrees):
- The `worker` agent runs with the harness's built-in `isolation: worktree`. The harness creates its own worktree at `<repo>/.claude/worktrees/agent-<id>` on its own branch, off the repo's current HEAD. There is no manual `git worktree add`, no write-probe gate, no `TASK` scratch file — those were workarounds for the 2.1.185 background-auto-deny bug, fixed in 2.1.186.
- The worker branches off whatever the target repo currently has checked out. Check out the intended base (usually `dev`) in the repo BEFORE delegating, or the worker branches off the wrong base.
- The worker's Write/Edit surfaces a permission prompt in the main session (2.1.186 behavior). I approve them — that keeps me seeing exactly what it touches.

Steps:
1. First /delegate run in a given repo: add `.claude/` to that repo's `.gitignore` (the worktree lands under `<repo>/.claude/`). Per-repo, added as we first work each repo — do it on a clean state, not mixed into an unrelated branch.
2. Set the target base: `cd /home/denis/src/anyip/<repo>` (cwd persists across calls in 2.1.186) and `git checkout <base>`. The worker branches from here.
3. Worker. Spawn the `worker` agent (Sonnet). Pass the approved plan in the prompt — no file on disk. It implements exactly the plan and returns a report. It EDITS and reports only: no commit, no push, no merge. On any ambiguity it STOPS and reports instead of guessing.
4. Review. Spawn the `reviewer` agent (Opus) on the worker's diff (`git -C <repo> diff <branch>`, or read the worktree). It returns findings grouped bugs / decisions / nits, plus a verdict. For Rust it calls out idiomatic / allocation / redundant-op decisions for me to weigh.
5. Surface to me. Bring the branch name, the findings (especially the embedded decisions), and the verdict. Then STOP — I review the branch and merge/PR it myself.
6. Loop. Verdict "needs another round" and under 2 rounds: resume the same worker with the reviewer's findings, then re-review. Max 2 rounds; past that, stop and bring it to me.

Hard rules:
- The worker makes no design decisions. Any gap → it stops for me.
- Never merge, never push, never commit to my branch. The work stays on its branch; the merge is mine.
- One task per worker. Parallelism lives one layer up, at the orchestrator — not in worker autonomy.
- Surface the reviewer's embedded decisions, not just "ready".

Cleanup (after I merge): `git -C <repo> worktree remove --force <path>` then `git branch -D <branch>`. An untouched worktree the harness removes itself.
