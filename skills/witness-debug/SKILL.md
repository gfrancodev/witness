---
name: witness-debug
description: Fill failure.json with classification and firstDivergence (/witness:debug).
---

<skill name="witness-debug">
  <purpose>Structured failure analysis after a failed or blocked run step.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <doc-ref id="capabilities"/>
    <schema path="templates/schemas/failure.schema.json"/>
    <example path="templates/runs/checkout-fail/failure.json"/>
    <example path="templates/runs/checkout-visual/failure.json"/>
    <ref path="../witness/references/media.md"/>
    <ref path="../witness/references/testing.md"/>
    <ref path="../witness/references/captcha.md"/>
    <example path="templates/runs/captcha-security/failure.json"/>
    <ref path="../witness/references/har.md"/>
    <example path="templates/runs/checkout-fail/har-report.json"/>
    <schema path="templates/schemas/har-report.schema.json"/>
    <doc-ref id="mcp-network"/>
  </read>
  <inputs>
    <input name="runId">Directory under .witness/runs/</input>
  </inputs>
  <steps>
    <step n="1">Read result.json har-report.json when present and MCP console network from the failing step. Prefer har-report entry with match mismatch for firstDivergence network request expected actual.</step>
    <step n="2">Write failure.json with status failed.</step>
    <step n="3">Set classification one of frontend backend network data authentication authorization visual flaky environment captcha_unresolved security_regression unknown.</step>
    <step n="4">Set firstDivergence type ui network or captcha with detail; for network include method path expected and actual status and whether mock was json-server browser-route or live.</step>
    <step n="5">For classification visual set firstDivergence.type ui and optional mediaRef to manifest artifact id.</step>
    <step n="6">Set confidence between 0 and 1.</step>
    <step n="7">Quote the Then of the failing When. Do not alter expect in flow JSON or Then in the feature.</step>
  </steps>
  <forbidden>Conclude backend without structured firstDivergence object.</forbidden>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
  <done>failure.json written and consistent with schema intent.</done>
</skill>
