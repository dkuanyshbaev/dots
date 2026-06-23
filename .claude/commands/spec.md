---
description: Turn a decided task discussion into one complete, unambiguous spec a non-deciding worker can execute — channel-agnostic, routes to a local TASK or a Linear card.
---

/spec is the orchestrator step that converts a task we've ALREADY decided together into a written spec. It sits above /delegate (local) and above the Cyrus/Linear channel: the same spec format feeds both. The worker (local or Cyrus) is an executor, not a planner — so a spec with any open decision is a bug.

Core principle: decisions are Denis's. This command does NOT invent or "reasonably guess" any design choice. If a needed decision isn't made yet, STOP and bring it to Denis as a concrete fork (options → trade-offs → my recommendation), get his call, THEN write the spec. Never ship a spec with a gap for the worker to fill.

Decisions pre-flight (run before writing anything — if any is unresolved, stop and ask):
- Target: which repo, which base branch.
- The "how": the approach is chosen, and the alternatives Denis rejected are known (so the spec records the decision, not a menu).
- Every fork surfaced in the discussion has a decided answer. A fork the worker would otherwise hit = stop and decide now.
- Scope is narrow and singular (one logical change). If it bundles adjacent cleanups, split it — incremental scope by design.

Spec template (write exactly these sections, plain text):
- Title: conventional-commit-style subject (becomes branch name, PR title, card title). Pick the type that fits (feat/fix/refactor/ci/...).
- Target: `<repo>` + base branch (usually dev, or a PR head ref).
- Context: 1–3 lines of why, plus links (Linear id, related PR). Facts only.
- What: the change, precisely. The observable end state.
- How: the decided approach, and the key decisions already made so the worker does NOT re-decide (e.g. "use X not Y because Z"). This is where Denis's calls get recorded.
- Acceptance: a verifiable checklist. Each item must be checkable, not vibes.
- Out of scope / do-not-touch: explicit. Files, behaviours, refactors the worker must leave alone (stay in scope, no noise).
- Verify: the exact commands, run from the repo/worktree dir (cargo check / clippy --all-targets / fmt --check / test / audit, as relevant to the change). Note who runs them per channel (see Channel split).
- Conventions: match surrounding code (naming, idioms, comment density); repo rules (no unwrap/expect in non-test, import style, conventional commits); and the executor rules below.

Executor rules to embed in every spec:
- The worker makes NO design decisions. On any ambiguity, missing detail, or a spec that turns out wrong: STOP and report (what was done, what blocked, what needs deciding). Do not guess.
- Implement exactly the spec, nothing more. No extra features/abstractions/error-handling the spec didn't ask for.

Sharpness step (before finalizing — CLAUDE.md "keep me sharp"):
- Surface back to Denis the decisions embedded in the spec and any fork I had to resolve to write it. Let him sign off or correct. Don't present a finished spec as a fait accompli over a real design choice.

Channel split (route the finished spec):
- Local / personal-mode (your projects, interim company work, fast iteration): hand the spec to /delegate (it writes TASK in the worktree and runs worker→reviewer). Worker EDITS + reports; orchestrator verifies + commits; Denis reviews + merges.
- Work-mode / Cyrus (unattended company work, test-covered modules): create a Linear card carrying the full spec (target repo, what/how, acceptance, do-not-touch). This is a Linear WRITE — show Denis the exact card text first and get explicit go before posting (Linear writes need permission). Card text is facts only: no reasoning/hypotheses. Do not assign the card. Cyrus picks it up; we review the In Review queue together.

Hard rules:
- A missing or ambiguous decision = STOP and ask. Never let the spec decide for Denis.
- One spec = one narrow change = one repo. Cross-repo work = one spec per repo.
- The merge is always Denis's. The spec never authorizes push/merge.
- Keep the spec executable by a non-deciding worker: if you can't, the upstream decision work isn't done — go back to it.
