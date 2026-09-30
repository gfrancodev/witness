---
name: witness-affected
description: Cross git diff with flow pages; list scenarios to rerun (/witness:affected).
---

<skill name="witness-affected">
  <purpose>Recommend regression scope from code changes without running browser itself.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
  </read>
  <inputs>
    <input name="gitRange">Optional diff range; default working tree diff</input>
  </inputs>
  <steps>
    <step n="1">Run git diff for changed files routes components strings.</step>
    <step n="2">Load all .witness/graph/flows/*.json.</step>
    <step n="3">Match diff to pages url elements attrs action.names visible strings heuristically.</step>
    <step n="4">List affected flow ids, Scenario titles, and the When lines whose accessible name or page matches the diff. Use feature comments only as the step index back to JSON.</step>
    <step n="5">Suggest witness-run with flowId and tags.</step>
    <step n="6">If no match list @critical flows for manual review.</step>
  </steps>
  <forbidden>Auto-run browser unless user requests witness-run next.</forbidden>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
  <done>Affected flows and rerun suggestions listed.</done>
</skill>
