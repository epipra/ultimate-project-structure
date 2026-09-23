#!/usr/bin/env bash
# Stdout from a SessionStart hook is added to Claude's context.
set -euo pipefail
cd "${CLAUDE_PROJECT_DIR:-.}"

echo "## Session context"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Branch: $(git symbolic-ref --short HEAD 2>/dev/null || echo detached)"
  echo
  echo "Recent commits:"
  git log --oneline -5 2>/dev/null || true
  echo
  echo "Uncommitted changes:"
  git status --short | head -20
fi

latest=$(ls -1t .claude/state/precompact-*.md 2>/dev/null | head -1 || true)
if [ -n "$latest" ]; then
  echo
  echo "Last saved state ($latest):"
  head -40 "$latest"
fi
exit 0
