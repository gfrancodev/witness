---
name: witness-map
description: Summarize flows, their .feature scenarios, and unknown-state (/witness:map).
---

<skill name="witness-map">
  <purpose>Produce a readable map of flows and the exact Gherkin scenarios that document them.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/gherkin.md"/>
    <schema path="templates/schemas/flow.schema.json"/>
    <schema path="templates/schemas/witness.config.schema.json"/>
  </read>
  <inputs>
    <input name="flowsDir">witness.config.json paths.flows default .witness/graph/flows/</input>
  </inputs>
  <steps>
    <step n="1">List all *.json in flows directory.</step>
    <step n="2">Per flow report id, baseUrl, page count, step count, feature path, Scenario titles, and whether count(When) equals count(steps).</step>
    <step n="3">Summarize each Scenario as the ordered When lines, then the JSON from/to for the same step index.</step>
    <step n="4">If .witness/graph/unknown-state.json exists highlight url and context.</step>
    <step n="5">If healing.json exists report entry count only; do not modify.</step>
    <step n="6">If JSON contradicts observation cite file and field; do not silently fix.</step>
  </steps>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
  <done>User receives the map with flow paths, feature paths, and any scenario thinner than its flow.</done>
</skill>
