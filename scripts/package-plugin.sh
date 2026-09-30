#!/usr/bin/env bash
# Assembles dist/plugin/  skills, agent, hooks, templates. No Go, no binary.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="${ROOT}/dist/plugin"

rm -rf "$OUT"
mkdir -p "$OUT"

copy_item() {
  local src="$1"
  mkdir -p "$OUT/$(dirname "$src")"
  cp -a "$ROOT/$src" "$OUT/$src"
}

for item in \
  .cursor-plugin \
  .claude-plugin \
  .codex-plugin \
  .agents \
  agents \
  assets \
  skills \
  hooks \
  templates \
  scripts/install-plugin.sh \
  README.md \
  LICENSE \
  CHANGELOG.md \
  PRIVACY.md \
  VERSION
do
  copy_item "$item"
done

chmod +x "$OUT/hooks/run-hook.sh" "$OUT/scripts/install-plugin.sh"

if find "$OUT" \( -name '*.go' -o -name 'go.mod' -o -name 'go.sum' -o -name 'witness' -type f \) | grep -q .; then
  echo "package-plugin: Go or binary leaked into dist/plugin" >&2
  exit 1
fi

echo "Packaged plugin at $OUT"
