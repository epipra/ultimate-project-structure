# Ultimate Project Structure

A clean, reusable **Claude Code** project layout: `CLAUDE.md`, rules, custom
slash commands, auto-loaded skills, sub-agents, and hooks — all wired up and
ready to customize for any codebase.

```
project/
├── CLAUDE.md                    — project overview & config
├── CLAUDE.local.md              — personal overrides (git-ignored)
├── .mcp.json                    — MCP server integrations
└── .claude/                     — all Claude config lives here
    ├── settings.json            — shared team settings
    ├── settings.local.json.example
    ├── rules/                   — coding conventions Claude follows
    │   ├── code-style.md
    │   ├── testing.md
    │   └── api-conventions.md
    ├── commands/                — custom slash workflows
    │   ├── review.md            — /review
    │   └── fix-issue.md         — /fix-issue
    ├── skills/                  — auto-loaded when relevant
    │   └── deploy/
    │       ├── SKILL.md
    │       └── deploy-config.md
    ├── agents/                  — specialized sub-agents
    │   ├── code-reviewer.md
    │   └── security-auditor.md
    └── hooks/                   — event-driven scripts
        └── validate-bash.sh
```

## Install

**New project, one line:**

```bash
mkdir my-project && cd my-project
curl -fsSL https://raw.githubusercontent.com/epipra/ultimate-project-structure/main/install.sh | bash
```

**Existing project (won't overwrite files you already have):**

```bash
cd my-existing-project
curl -fsSL https://raw.githubusercontent.com/epipra/ultimate-project-structure/main/install.sh | bash -s -- .
```

**Or clone directly:**

```bash
git clone https://github.com/epipra/ultimate-project-structure.git my-project
cd my-project
rm -rf .git && git init
```

## After installing

1. Edit `CLAUDE.md` — real project name, tech stack, and dev/test/build commands.
2. `cp .claude/settings.local.json.example .claude/settings.local.json` and add personal permissions.
3. Fill in `.claude/skills/deploy/deploy-config.md` if the project deploys anywhere.
4. Adjust `.claude/rules/*.md` to match your actual team conventions — these are starting points, not gospel.
5. Add more `.claude/agents/*.md` or `.claude/commands/*.md` as the project grows.

## Why this layout

- **`CLAUDE.md`** is read automatically at session start — put stack, commands, and gotchas here so Claude doesn't have to rediscover them every time.
- **`rules/`** are always-on conventions (style, testing, API patterns) — short and specific beats long and vague.
- **`commands/`** are reusable slash-command prompts (`/review`, `/fix-issue`) — same workflow, one word.
- **`skills/`** auto-load only when relevant (e.g. deploying), keeping context lean the rest of the time.
- **`agents/`** are focused sub-agents with their own tool scope (code review, security audit) you can delegate to explicitly or proactively.
- **`hooks/`** run on tool events — the included example blocks obviously destructive Bash commands.

## License

MIT — use it, fork it, ship it.
