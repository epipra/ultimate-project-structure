#!/usr/bin/env bash
# Snapshots working state before context compaction so SessionStart can restore it.
set -euo pipefail
cd "${CLAUDE_PROJECT_DIR:-.}"

input=$(cat)
trigger=$(printf '%s' "$input" | jq -r '.trigger // "unknown"')
mkdir -p .claude/state
out=".claude/state/precompact-$(date +%Y%m%d-%H%M%S).md"

{
  echo "# Pre-compact snapshot ($trigger) $(date -Iseconds)"
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Branch: $(git symbolic-ref --short HEAD 2>/dev/null || echo detached)"
    echo '```'
    git status --short
    git diff --stat
    echo '```'
  fi
} > "$out"

# keep last 10 snapshots
ls -1t .claude/state/precompact-*.md | tail -n +11 | xargs -r rm --
exit 0
