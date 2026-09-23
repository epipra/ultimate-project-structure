#!/usr/bin/env bash
# PreToolUse hook for Bash: blocks obviously destructive commands (exit 2 = block).
set -euo pipefail

cmd=$(cat | jq -r '.tool_input.command // empty')

if echo "$cmd" | grep -qE 'rm -rf /(\s|$)|:\(\)\{ :\|:& \};:'; then
  echo "Blocked: destructive command detected" >&2
  exit 2
fi

exit 0
