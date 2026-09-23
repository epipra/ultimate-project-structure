---
description: Build, lint, test, and deploy in one go
argument-hint: "[environment, default: production]"
allowed-tools: Bash, Read
---

Ship the current branch to the environment named in `$ARGUMENTS` (default: production).

1. Confirm the working tree is clean (`git status --short`). If not, stop and list the dirty files.
2. Run the lint, test, and build commands from `AGENTS.md` → Commands, in that order. Stop at the first failure and show the shortest decisive error line.
3. Deploy with the target and command in `.claude/skills/deploy/deploy-config.md`. If it is not filled in, stop and ask.
4. Smoke-check the health check URL from deploy-config.md (expect HTTP 200).
5. Report: commit SHA shipped, environment, URL, and anything skipped.
