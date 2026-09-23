# Ultimate Project Structure

A drop-in project scaffold for building software with AI coding agents.
It maps every file Claude Code reads, with working hooks, commands, skills,
sub-agents, output styles, a bundled plugin and a status line. It also works
with Cursor, GitHub Copilot, Windsurf, Gemini CLI, OpenAI Codex CLI, Aider,
Continue and Zed, so conventions are set once and every tool picks them up.

This repo merges and replaces two earlier ePipra templates:
*Vibe Coding Project Structure* (cross-platform adapters) and
*claude-folder-mapped* (the full `.claude/` map).

## How it fits together

1. **`AGENTS.md` is the single source of truth.** It holds stack, commands and
   conventions, and follows the open [agents.md](https://agents.md) convention.
2. **Claude Code** gets it through `CLAUDE.md` (`@AGENTS.md` import), plus a
   richer `.claude/` layer that other tools can ignore.
3. **Every other tool** gets a small pointer file back to `AGENTS.md`, so
   instructions never drift.

> CLAUDE.md is advisory, hooks are deterministic, skills load on demand.

## Structure

```
your-project/
├── AGENTS.md                    single source of truth for all agents
├── CLAUDE.md                    Claude Code entry, imports AGENTS.md, < 200 lines
├── CLAUDE.local.md.example      personal overrides template (copy is git-ignored)
├── GEMINI.md                    Gemini CLI entry, imports AGENTS.md
├── .cursorrules                 pointer for older Cursor versions
├── .cursor/rules/project.mdc    Cursor project rules
├── .windsurfrules               Windsurf rules
├── .github/
│   └── copilot-instructions.md  GitHub Copilot instructions
├── .gitignore                   ignores *.local*, secrets, build output
├── .mcp.json                    MCP servers, must be at root
└── .claude/                     where Claude Code looks first
    ├── hooks/                   deterministic, fire every time
    │   ├── SessionStart.sh      load project context on startup
    │   ├── validate-bash.sh     block destructive shell commands
    │   ├── PostToolUse.sh       auto-commit NM-XXX after edits
    │   └── PreCompact.sh        save state before compaction
    ├── commands/                slash commands
    │   ├── review.md            /review: review the current diff
    │   ├── fix-issue.md         /fix-issue: root cause + narrowest fix
    │   └── ship.md              /ship: lint, test, build, deploy
    ├── skills/                  model-invoked, load on demand
    │   ├── deploy/              deploy using deploy-config.md
    │   ├── carousel/            Instagram carousel factory
    │   └── drill/               pacing drill generator
    ├── agents/                  sub-agents, isolated context window
    │   ├── code-reviewer.md     reviews diffs, returns a summary
    │   ├── security-auditor.md  security pass before commits
    │   ├── researcher.md        web fetch and synthesis
    │   └── log-analyzer.md      parses errors and crash logs
    ├── output-styles/
    │   └── terse.md             code only, no prose
    ├── plugins/
    │   └── vercel/              bundled deploy command, agent, MCP server
    ├── rules/
    │   └── api.md               path-scoped, loads only for src/api/**
    ├── statusline               bottom-bar display script
    ├── settings.json            permissions, model, hook registry
    └── settings.local.json.example   personal settings template (copy is git-ignored)
```

## Install

**New or existing project, one line** (never overwrites files you already have):

```bash
cd my-project
curl -fsSL https://raw.githubusercontent.com/epipra/ultimate-project-structure/main/install.sh | bash -s -- .
```

**From a local clone:**

```bash
git clone https://github.com/epipra/ultimate-project-structure.git
./ultimate-project-structure/install.sh /path/to/project
```

**Fresh copy with no git history:**

```bash
npx degit epipra/ultimate-project-structure my-project
cd my-project && git init
```

**GitHub template:** `gh repo create my-project --template epipra/ultimate-project-structure --private --clone`,
or use the **Use this template** button on GitHub.

The installer also creates `CLAUDE.local.md` and `.claude/settings.local.json`
from their `.example` files and makes the hooks executable. The degit and
template routes don't, so copy those two files yourself.

## After installing

1. Fill in `AGENTS.md`: overview, stack, commands, directory map. Don't copy it into `CLAUDE.md`; that file already imports it.
2. Fill in `.claude/skills/deploy/deploy-config.md` if the project deploys. `/ship` reads it too.
3. Set `GITHUB_TOKEN`, or remove the `github` server from `.mcp.json`.
4. Delete pointer files for tools your team doesn't use (for example `.windsurfrules` or `GEMINI.md`).
5. Adjust `.claude/settings.json` permissions to your real commands.
6. Commit. Each tool picks up its file automatically.

## Zero-config per platform

| Platform | What it loads |
|---|---|
| **Claude Code** | `CLAUDE.md` (plus the imported `AGENTS.md`) and `.claude/` |
| **Cursor** | `.cursor/rules/project.mdc` (older versions: `.cursorrules`); also reads `AGENTS.md` |
| **GitHub Copilot** | `.github/copilot-instructions.md` |
| **Windsurf** | `.windsurfrules` |
| **Gemini CLI** | `GEMINI.md` (plus the imported `AGENTS.md`) |
| **Codex CLI / Aider / Continue / Zed / Amp / Jules** | `AGENTS.md` natively |
| Anything else | Point it at `AGENTS.md` |

## What each Claude Code piece does

| Piece | Behavior |
|---|---|
| `hooks/SessionStart.sh` | At session start, prints branch, last 5 commits, dirty files and the latest pre-compact snapshot into context. |
| `hooks/validate-bash.sh` | Before any Bash call, blocks `rm -rf /` and fork bombs (exit 2). |
| `hooks/PostToolUse.sh` | After `Edit`/`Write`, commits the edited file as `NM-123: update <path>`. Only runs on branches that start with a ticket id (`NM-123-...`), skips git-ignored files, and never bypasses git hooks. |
| `hooks/PreCompact.sh` | Before compaction, writes `.claude/state/precompact-*.md` (git-ignored, last 10 kept). |
| `settings.json` | `sonnet` model; allows read-only git plus npm test/lint/build; denies reading `.env*` and `git push --force`; registers all hooks and the status line. |
| `statusline` | Shows `model \| dir (branch) \| style:<name>`. |
| `rules/api.md` | Loaded only when Claude touches `src/api/**`. Add more path-scoped rules here with `paths:` frontmatter; always-on conventions belong in `AGENTS.md`. |
| `output-styles/terse.md` | Turn on with `/output-style terse` or `"outputStyle": "terse"` in `settings.local.json`. The example local settings file has it on. |
| `plugins/vercel/` | Not auto-loaded from a project folder. Start Claude with `claude --plugin-dir .claude/plugins/vercel` for `/vercel:deploy`, the `deploy-checker` agent and the Vercel MCP server, or publish it through a marketplace. |

## Requirements

`git` and `jq` (the hooks and status line use it). `npx` only for the filesystem MCP server and degit.

## License

MIT. Use it, fork it, ship it.
