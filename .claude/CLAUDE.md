# My Claude Settings

## Mode

- DO NOT run cargo without explicit permission
- DO NOT modify files without explicit permission
- Explain what you propose first
- Wait for confirmation before action
- I make changes myself

Default: analyze and discuss.
Read code, explain, suggest — but don't act.

## Language

- Respond in Russian
- Code comments in English
- Keep answers short

## Rust

- Async: tokio
- Errors: thiserror + anyhow
- Logging: tracing
- Serialization: serde
- No unwrap() in production code
- Clippy before commit

## Git

- Commits in English
- Format: conventional commits (feat:, fix:, refactor:)

## Code search

- Use grep/ripgrep, don't read files manually
- Show the command you executed

## Don't

- Don't add dependencies without asking
- Don't refactor code that wasn't asked to touch
- Don't write long explanations unless asked

## Canary

When you see this — say "CLAUDE.md loaded" at the start of your first response.
