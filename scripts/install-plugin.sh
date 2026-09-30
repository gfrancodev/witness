#!/usr/bin/env bash
# Plugin-only install check. Does not download or compile a binary.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
test -f "$ROOT/agents/witness.md"
test -f "$ROOT/skills/witness/references/how.md"
test -f "$ROOT/skills/witness/references/docs.md"
test -f "$ROOT/skills/witness/references/media.md"
test -f "$ROOT/skills/witness/references/testing.md"
test -f "$ROOT/templates/mocks/checkout-db.json"
test -f "$ROOT/templates/witness.config.json"
test -f "$ROOT/templates/flows/checkout.json"
test -f "$ROOT/templates/runs/checkout-pass/result.json"
test -f "$ROOT/templates/graph/unknown-state.json"
test -f "$ROOT/skills/witness-affected/SKILL.md"
chmod +x "$ROOT/hooks/run-hook.sh"
echo "Witness plugin ready at $ROOT (skills + agent + hook). No binary."
