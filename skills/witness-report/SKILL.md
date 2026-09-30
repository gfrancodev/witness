---
name: witness-report
description: Evidence report scenarios coverage or HAR from a run (/witness:report).
---

<skill name="witness-report">
  <purpose>Summarize a run for the user without reinterpreting expect. Three report kinds.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/har.md"/>
    <ref path="../witness-gaps/SKILL.md"/>
    <doc-ref id="aria-snapshots"/>
    <doc-ref id="mcp-network"/>
    <doc-ref id="mcp-tracing"/>
    <doc-ref id="playwright-show-trace"/>
    <schema path="templates/schemas/result.schema.json"/>
    <schema path="templates/schemas/failure.schema.json"/>
    <schema path="templates/schemas/har-report.schema.json"/>
    <example path="templates/runs/checkout-pass/result.json"/>
    <example path="templates/runs/checkout-fail/failure.json"/>
    <example path="templates/runs/checkout-fail/har-report.json"/>
    <example path="templates/runs/captcha-human-blocked/result.json"/>
    <example path="templates/runs/two-actors/result.json"/>
    <ref path="../witness/references/captcha.md"/>
    <ref path="../witness/references/actors.md"/>
    <example path="templates/runs/checkout-visual/media-manifest.json"/>
    <ref path="../witness/references/media.md"/>
  </read>
  <inputs>
    <input name="runId">Or path .witness/runs/{id}/</input>
    <input name="kind">scenarios default, coverage, or har</input>
  </inputs>
  <kinds>
    <kind id="scenarios" default="true">
      <step n="1">Read result.json and optional failure.json.</step>
      <step n="2">Report flowId surface overall status concurrency and per-actor status when actors array present.</step>
      <step n="2b">If captcha-state.json exists summarize provider status timeline without token values.</step>
      <step n="3">Per step quote the matching When and Then from the .feature, then intent, status, and evidence excerpt literally.</step>
      <step n="4">If failure.json present include classification and firstDivergence.</step>
      <step n="5">If media-manifest.json exists list artifacts kind path source timeSeconds.</step>
      <step n="6">Cite paths to artifacts under .witness/runs/.</step>
    </kind>
    <kind id="coverage">
      <step n="1">Run witness-gaps steps on paths.flows without inventing steps.</step>
      <step n="2">Deliver gap report: unused pages, missing transitions, When lines without JSON steps, and flows whose .feature has fewer When lines than steps.</step>
      <step n="3">Suggest witness-explore targets only.</step>
    </kind>
    <kind id="har">
      <step n="1">Read .witness/runs/{runId}/har-report.json if present else build from failure.json and last browser_network_requests for that run.</step>
      <step n="2">List entries with match mismatch first then expected then undeclared.</step>
      <step n="3">Cite harPath tracePath and doc-ref playwright-show-trace when tracePath set.</step>
      <step n="4">Do not paste Authorization cookies or bodies.</step>
    </kind>
  </kinds>
  <rules>
    <rule id="no-heal-expect">Quote expect and evidence; do not rewrite Then.</rule>
    <rule id="no-secrets">Redact secrets if accidentally present in evidence; do not paste credentials.</rule>
  </rules>
  <done>Human-readable report for the requested kind.</done>
</skill>
