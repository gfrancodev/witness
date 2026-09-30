---
name: witness-gaps
description: List pages and transitions without matching steps (/witness:gaps).
---

<skill name="witness-gaps">
  <purpose>Find coverage holes in the flow graph.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/gherkin.md"/>
    <doc-ref id="gherkin-reference"/>
    <doc-ref id="gherkin-languages"/>
  </read>
  <steps>
    <step n="1">Load each flow under paths.flows.</step>
    <step n="2">List all page ids.</step>
    <step n="3">For each from to pair implied by navigation or explore notes verify a step exists.</step>
    <step n="4">List pages never used as from or to in any step.</step>
    <step n="5">List feature comment intents and When lines without a matching JSON step.</step>
    <step n="5b">List flows with no .feature, and flows where count(When) is less than count(steps). Those are thin scenarios, not coverage.</step>
    <step n="6">Suggest witness-explore for missing observations and witness-spec to expand a thin feature. Do not auto-invent steps.</step>
  </steps>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
  <done>Gap report with flow ids and suggested explore targets.</done>
</skill>
