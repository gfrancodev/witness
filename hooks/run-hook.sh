#!/usr/bin/env bash
# SessionStart: inject Witness XML orientation for the harness.
set -euo pipefail
PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cat <<EOF
<witness-session-start>
  <read path="${PLUGIN_ROOT}/skills/witness/SKILL.md"/>
  <schemas dir="${PLUGIN_ROOT}/templates/schemas/"/>
  <docs-catalog path="${PLUGIN_ROOT}/skills/witness/references/docs.md"/>
  <mcp-catalog path="${PLUGIN_ROOT}/skills/witness/references/mcps.md"/>
  <rules>
    <rule id="no-heal-expect">Never heal expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="no-invent">Never invent a step not in the flow JSON.</rule>
    <rule id="surfaces">Use surfaces from witness.config.json; not desktop-only by default.</rule>
  </rules>
</witness-session-start>
EOF
