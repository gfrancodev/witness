#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
"$ROOT/scripts/package-plugin.sh"
OUT="$ROOT/dist/plugin"
test -f "$OUT/LICENSE"
test -f "$OUT/CHANGELOG.md"
test -f "$OUT/PRIVACY.md"
test -f "$OUT/README.md"
test -f "$OUT/.cursor-plugin/plugin.json"
test -f "$OUT/.cursor-plugin/marketplace.json"
test -f "$OUT/.claude-plugin/plugin.json"
test -f "$OUT/.claude-plugin/marketplace.json"
test -f "$OUT/.codex-plugin/plugin.json"
test -f "$OUT/.agents/plugins/marketplace.json"
test -f "$OUT/agents/witness.md"
test -f "$OUT/skills/witness-run/SKILL.md"
test -f "$OUT/skills/witness-affected/SKILL.md"
test -f "$OUT/templates/witness.config.json"
test -f "$OUT/skills/witness/references/docs.md"
test -f "$OUT/skills/witness/references/setup.md"
test -f "$OUT/skills/witness/references/har.md"
test -f "$OUT/templates/schemas/har-report.schema.json"
test -f "$OUT/templates/runs/checkout-fail/har-report.json"
test -f "$OUT/agents/mcp.json"
test -f "$OUT/hooks/hooks-cursor.json"
test -f "$OUT/templates/runs/checkout-pass/result.json"
test -f "$OUT/templates/runs/checkout-fail/failure.json"
test -f "$OUT/templates/graph/unknown-state.json"
test -f "$OUT/skills/witness/references/media.md"
test -f "$OUT/templates/runs/checkout-visual/media-manifest.json"
test -f "$OUT/templates/schemas/media-manifest.schema.json"
test -f "$OUT/skills/witness/references/testing.md"
test -f "$OUT/templates/mocks/checkout-db.json"
test -f "$OUT/skills/witness/references/captcha.md"
test -f "$OUT/skills/witness/references/sessions.md"
test -f "$OUT/skills/witness/references/actors.md"
test -f "$OUT/skills/witness-captcha/SKILL.md"
test -f "$OUT/templates/schemas/captcha-state.schema.json"
test -f "$OUT/templates/features/security/captcha.feature"
test -f "$OUT/templates/runs/captcha-security/failure.json"
test -f "$OUT/templates/runs/captcha-human-blocked/result.json"
test -f "$OUT/templates/runs/two-actors/result.json"
"$ROOT/scripts/validate-witness-contract.py"
if grep -R "witness.config.yaml" "$OUT" >/dev/null 2>&1; then
  echo "package still references witness.config.yaml" >&2
  exit 1
fi
if grep -R "go build" "$OUT/skills" "$OUT/agents" >/dev/null; then
  echo "skills still mention go build" >&2
  exit 1
fi
echo "test-plugin-package: ok"
