# CLAUDE.md

Loaded at the start of every Claude Code session. Keep it under 200 lines.
CLAUDE.md is advisory, hooks are deterministic, skills load on demand.

Project overview, stack, commands and conventions live in AGENTS.md, imported
here so every tool shares one source of truth:

@AGENTS.md

## Claude Code layer (`.claude/`)

- `hooks/` — run every time, registered in `settings.json`:
  - `SessionStart.sh` adds branch, recent commits, dirty files and the last pre-compact snapshot to context.
  - `validate-bash.sh` (PreToolUse) blocks obviously destructive shell commands.
  - `PostToolUse.sh` auto-commits edited files as `NM-123: update <path>`, only on ticket branches.
  - `PreCompact.sh` saves working state to `.claude/state/` before compaction.
- `commands/` — `/review`, `/fix-issue`, `/ship`.
- `skills/` — `deploy`, `carousel`, `drill`; loaded only when the task matches.
- `agents/` — `code-reviewer`, `security-auditor`, `researcher`, `log-analyzer`. Delegate reviews after code changes and security passes before committing auth, input-handling or secrets code.
- `rules/` — path-scoped rules; `api.md` loads only for `src/api/**`.
- `output-styles/terse.md` — code-only answers (`/output-style terse`).
- `plugins/vercel/` — bundled deploy command, agent and MCP server (`claude --plugin-dir .claude/plugins/vercel`).
- `statusline` — bottom-bar display.
- `settings.json` — shared permissions, model, hooks. Personal settings go in `settings.local.json` (git-ignored).

## Local overrides

Machine-specific notes go in `CLAUDE.local.md` (git-ignored; copy from `CLAUDE.local.md.example`).
