#!/usr/bin/env bash
# Example PreToolUse hook for Bash — blocks obviously destructive commands.
set -euo pipefail

cmd=$(cat | jq -r '.tool_input.command // empty')

if echo "$cmd" | grep -qE 'rm -rf /(\s|$)|:\(\)\{ :\|:& \};:'; then
  echo "Blocked: destructive command detected" >&2
  exit 2
fi

exit 0
