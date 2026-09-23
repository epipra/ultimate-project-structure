#!/usr/bin/env bash
# Installs the Ultimate Project Structure into a project. Existing files are never overwritten.
# Usage: curl -fsSL https://raw.githubusercontent.com/epipra/ultimate-project-structure/main/install.sh | bash -s -- /path/to/project
#    or: ./install.sh /path/to/project   (from a local clone)
set -euo pipefail

REPO_URL="https://github.com/epipra/ultimate-project-structure.git"
TARGET="$(mkdir -p "${1:-.}" && cd "${1:-.}" && pwd)"
TEMPLATE_ONLY='^(install\.sh|README\.md|LICENSE)$'

command -v jq >/dev/null || echo "warning: jq not found; hooks and statusline need it." >&2

SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
if [ -n "$SELF_DIR" ] && [ -f "$SELF_DIR/install.sh" ] && [ -d "$SELF_DIR/.claude" ]; then
  SRC="$SELF_DIR"
else
  SRC="$(mktemp -d)"
  trap 'rm -rf "$SRC"' EXIT
  echo "Cloning template..."
  git clone --depth 1 -q "$REPO_URL" "$SRC"
fi
[ "$SRC" = "$TARGET" ] && { echo "Target is the template itself; pass a project path." >&2; exit 1; }

echo "Copying structure into $TARGET (existing files are skipped)..."
cd "$SRC"
git ls-files | grep -vE "$TEMPLATE_ONLY" | while read -r f; do
  dest="$TARGET/$f"
  if [ -e "$dest" ]; then
    echo "  skip (exists): $f"
  else
    mkdir -p "$(dirname "$dest")"
    cp -p "$f" "$dest"
    echo "  add: $f"
  fi
done

for f in CLAUDE.local.md .claude/settings.local.json; do
  [ -e "$TARGET/$f" ] || cp "$TARGET/$f.example" "$TARGET/$f"
done
chmod +x "$TARGET"/.claude/hooks/*.sh "$TARGET/.claude/statusline"

echo
echo "Done. Next steps:"
echo "  1. Fill in AGENTS.md: overview, stack, commands. CLAUDE.md imports it."
echo "  2. Fill in .claude/skills/deploy/deploy-config.md if you deploy."
echo "  3. Set GITHUB_TOKEN, or remove the github server from .mcp.json."
echo "  4. Use ticket branches (NM-123-foo) to enable auto-commit after edits."
echo "  5. Delete pointer files for tools you don't use (.windsurfrules, GEMINI.md, ...)."
