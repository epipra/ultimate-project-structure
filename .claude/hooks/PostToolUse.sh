#!/usr/bin/env bash
# Auto-commits after Edit/Write when the branch carries a ticket id (e.g. NM-123-foo).
# No ticket in branch name = no commit, so main/master never get surprise commits.
set -euo pipefail

input=$(cat)
file=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')
[ -z "$file" ] && exit 0

cd "${CLAUDE_PROJECT_DIR:-.}"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

branch=$(git symbolic-ref --short HEAD 2>/dev/null || true)
ticket=$(printf '%s' "$branch" | grep -oE '^[A-Z]+-[0-9]+' || true)
[ -z "$ticket" ] && exit 0

rel=$(realpath --relative-to="$PWD" "$file" 2>/dev/null || printf '%s' "$file")
git check-ignore -q -- "$rel" && exit 0

git add -- "$rel"
git diff --cached --quiet && exit 0
git commit -q -m "$ticket: update $rel"
echo "auto-committed $rel as $ticket" >&2
exit 0
