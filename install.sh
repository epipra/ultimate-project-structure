#!/usr/bin/env bash
# Installs the Ultimate Project Structure into the current directory (or $1).
# Usage: curl -fsSL https://raw.githubusercontent.com/epipra/ultimate-project-structure/main/install.sh | bash -s -- /path/to/project
set -euo pipefail

REPO_URL="https://github.com/epipra/ultimate-project-structure.git"
TARGET="${1:-.}"
TMP_DIR="$(mktemp -d)"

echo "Cloning template..."
git clone --depth 1 "$REPO_URL" "$TMP_DIR" >/dev/null 2>&1

mkdir -p "$TARGET"
cd "$TMP_DIR"
rm -rf .git

echo "Copying structure into $TARGET (existing files are skipped, not overwritten)..."
find . -type f | while read -r f; do
  dest="$TARGET/${f#./}"
  if [ -f "$dest" ]; then
    echo "  skip (exists): $f"
  else
    mkdir -p "$(dirname "$dest")"
    cp "$f" "$dest"
    echo "  add: $f"
  fi
done

chmod +x "$TARGET/.claude/hooks/validate-bash.sh" 2>/dev/null || true
rm -rf "$TMP_DIR"

echo ""
echo "Done. Next steps:"
echo "  1. Edit CLAUDE.md with your project's real name, stack, and commands."
echo "  2. Fill in .claude/skills/deploy/deploy-config.md if you deploy."
echo "  3. Adjust .claude/rules/*.md to match your team's actual conventions."
echo "  4. cp .claude/settings.local.json.example .claude/settings.local.json and customize."
