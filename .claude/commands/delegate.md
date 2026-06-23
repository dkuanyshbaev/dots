---
description: Personal-mode delegation — run a decided spec through the local worker→reviewer pipeline in an allow-listed worktree, then hand back the branch + findings for my review and merge.
---

/delegate runs the personal-mode pipeline for a spec we've already decided in this conversation. Work-mode tasks go through Linear + Cyrus + GitHub (PR reviewed by me + Greptile), not this command.

Preconditions:
- The target is one of the anyip repos under `/home/denis/src/anyip` (peer, node, shared, semaphore). The working repo has a clean tree.
- The spec is decided (understand → decide → spec already done with me). If it isn't clear yet, stop and finish deciding it first — never guess the spec.

Why worktrees are mandatory (do not skip): the only paths a background worker is permitted to write are `Edit/Write(/home/denis/src/anyip/worktrees/**)` (see dots settings, with `worktree.bgIsolation: none`). A worker pointed anywhere else — the live repo, or the Agent tool's built-in `isolation:"worktree"` (it lands in a harness temp dir OUTSIDE that glob) — gets every Edit/Write silently denied. So the worktree must be created by hand at an explicit path under `worktrees/`, and the worker pointed at that absolute path. There is no judgement call here.

Steps:
1. Pick names. `<repo>` = the repo dir name (e.g. peer). `<type>` = the conventional-commit type that fits the change. `<slug>` = short kebab summary of the essence. Worktree path = `/home/denis/src/anyip/worktrees/<repo>-<slug>`.
2. Create the worktree explicitly (NOT via Agent `isolation`):
   `git -C /home/denis/src/anyip/<repo> worktree add --no-track -b <type>/<slug> /home/denis/src/anyip/worktrees/<repo>-<slug> <base>`
   `<base>` is the agreed base (usually `dev`, or the PR head ref). If branching off `origin/<base>`, keep `--no-track` so my later push isn't bound to the base.
3. Write-probe gate — run this the FIRST delegate run in a fresh environment, and after any settings / permissions / restart change (not needed every run once proven this session): spawn a one-line `worker` whose only job is to Write a throwaway file under the worktree path and report. If it cannot write, STOP — the permission setup is broken (check the `worktrees/**` allow rule + `bgIsolation: none` + that a restart happened). Do NOT proceed to the real run; fix the config first. Delete the probe file.
4. Capture the spec. Write the agreed spec, as plain text, to `TASK` at the WORKTREE root (`/home/denis/src/anyip/worktrees/<repo>-<slug>/TASK`); add `TASK` to that tree's `.gitignore`. Scratch file, never committed.
5. Worker. Spawn the `worker` agent (Sonnet), cwd = the worktree path, pointed at `TASK`. It implements the spec and returns a report — or stops with a blocker if the spec doesn't cover something. The worker EDITS and reports only; it does not commit. (Verification/commit is mine in step 7 — do not depend on the worker's Bash having the toolchain.)
6. Review. Spawn the `reviewer` agent (Opus) with the worker's diff. It returns findings grouped bugs / decisions / nits, plus a verdict (ready / needs another round).
7. Verify + commit (orchestrator). In the worktree, run the repo's gates (`cargo check` / `clippy` / `fmt` / `test`, audit where relevant) and commit on the branch. If a gate fails, treat it as a review round.
8. Loop. If the verdict is "needs another round" and we're under 2 rounds, resume the worker with the reviewer's findings, then re-review. Maximum 2 rounds.
9. Hand back (never merge):
   - Done (reviewer satisfied, gates green): bring me the branch name, the spec, the reviewer's findings (bugs / decisions / nits), and the verdict. Then STOP — I review the branch and merge it myself. Remove the worktree after merge.
   - Blocked (worker hit an ambiguity, or reviewer still not satisfied after 2 rounds): bring me the blocker / open question and the partial state on the branch. We clarify, then resume.

Hard rules:
- The worker's cwd MUST be under `/home/denis/src/anyip/worktrees/`. Never point a worker at a live repo path, never rely on Agent `isolation:"worktree"` for a write-worker. If it isn't under `worktrees/`, that's a setup bug — stop.
- If a worker's Edit/Write is denied, STOP and report the misconfiguration. NEVER silently take over the edits yourself — that hides the broken channel and wastes the run.
- A decided spec that needs a write-worker goes through THIS command, not a hand-rolled Agent call.
- Never merge, never push, never commit to my main branch. The work stays on its branch; the merge is mine.
- The worker makes no design decisions; on any gap it stops for me.
- Surface the reviewer's findings to me — the embedded decisions especially — don't just report "ready".
