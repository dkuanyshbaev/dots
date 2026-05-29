Commit workflow. Run these steps in order, stop on any failure or concern:

1. Run cargo fmt --all.
2. Run cargo audit. If any advisory — stop, show them. (Same check quality-gate.yml runs on CI; catch it locally before push.)
3. Run cargo clippy --all-targets. If warnings/errors — stop, show them.
4. Run cargo test. If failures — stop, show them.
5. Run git diff and git status. Review all changes:
   - If you see anything suspicious (debug prints, unintended changes, forgotten files) — stop, tell me.
   - If anything is unclear about intent — stop, ask me.
6. Stage specific files (never git add -A). Only stage files related to the current change.
7. Generate a commit message following this style:
   - Conventional commits: type(scope): description
   - One line, no body
   - Types: feat, fix, refactor, ci, test, docs, chore, perf, style
   - Use scope when helpful: feat(ffi):, fix(auth):
   - Keep it short and precise
8. Show me the proposed commit message and list of staged files. Wait for my approval.
9. After approval — git commit.

If $ARGUMENTS is provided, use it as the commit message directly (skip step 7-8 message generation, still run steps 1-6).
