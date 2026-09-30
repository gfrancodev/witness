---
name: witness-heal
description: Heal action.names only; append healing.json; expect untouched (/witness:heal).
---

<skill name="witness-heal">
  <purpose>Update locator names when UI label changed but control is the same.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/gherkin.md"/>
    <doc-ref id="locators"/>
    <doc-ref id="accessibility"/>
  </read>
  <when>Snapshot shows same control but action.names no longer match; witness.config.json healing.assertions is never.</when>
  <steps>
    <step n="1">Update action.names on the affected step in flow JSON. If the matching When quotes the old accessible name, update that When to the new name. Never change Then or expect.</step>
    <step n="2">Append healing.json entry with intent field action.names from to reason confidence at ISO-8601.</step>
    <step n="3">Run witness-run for affected step or scenario only.</step>
    <step n="4">If expect fails revert flow and healing entry and report fail.</step>
  </steps>
  <forbidden>Change expect oracle or Then in feature.</forbidden>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Heal persists only if rerun passes with evidence.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
  <done>Healing applied only after passing rerun with evidence.</done>
</skill>
