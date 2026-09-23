# AGENTS.md

One-paragraph description of what this project does and who it's for.

This is the **single source of truth** for every AI coding agent in this repo,
following the [agents.md](https://agents.md) convention. OpenAI Codex CLI,
Aider, Continue, Zed, Amp, Jules and Cursor read it natively. Claude Code gets
it through `CLAUDE.md`, and Gemini CLI, Cursor, Windsurf and GitHub Copilot get
it through small pointer files. Edit conventions here, not in the pointer files.

## Tech stack

- Language/runtime:
- Framework:
- Database:
- Package manager:
- Infra / hosting:

## Setup

```bash
# install deps
# copy env: cp .env.example .env
```

## Commands

| Task | Command |
|---|---|
| Install | `<fill in>` |
| Dev server | `<fill in>` |
| Test | `<fill in>` |
| Lint | `<fill in>` |
| Build | `<fill in>` |
| Deploy | see `.claude/skills/deploy/deploy-config.md` |

## Code style

- No comments unless explaining a non-obvious WHY.
- Prefer editing existing files over creating new ones.
- No premature abstraction: 3 similar lines beats a helper for 1 use case. Don't build for hypothetical future requirements.
- Match the existing formatting/lint config and the style of the file you're editing.

## Testing

- Run the project's existing test suite before calling a task done.
- New behavior gets a test; bug fixes get a regression test where practical.
- No mocked-only tests for anything touching a real DB/API when integration risk exists.
- Never disable or skip tests to make CI pass.

## APIs, data and secrets

- Validate at system boundaries (user input, external API responses); trust internal code.
- Never send secrets, tokens, or user email/PII to unrelated third-party endpoints.
- Prefer existing MCP connectors or first-party SDKs over raw curl when one fits.
- Never commit secrets, `.env` files, keys, or credentials. Reference them as env vars (`${VAR}`).

## Git

- Branch names carry the ticket id: `NM-123-short-desc`.
- Commit format: `<type>: <description>` with type one of feat, fix, refactor, docs, test, chore, perf, ci.
- Never commit directly to `main`/`master` without review.

## Boundaries

- Ask before: deleting data, force-pushing, changing CI/CD, upgrading major dependencies.
- Never: hardcode secrets, bypass git hooks, disable tests to go green.

## Directory map

- `src/` — application code
- `src/api/` — API handlers (extra rules in `.claude/rules/api.md`)
- `tests/` — test suite
- `.claude/` — Claude Code config (hooks, commands, skills, agents, styles, plugins, rules). Other tools can ignore it.

## Notes for agents

Add anything project-specific here: architecture decisions, gotchas, env vars that must be set, flaky services — things not obvious from the code.
