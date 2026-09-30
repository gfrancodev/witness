---
name: witness
description: Witness QA agent hub. Flow JSON stores locators and oracles. The .feature is the exact journey, one When per step. Playwright MCP executes.
---

<skill name="witness">
  <tagline>See it. Test it. Prove it.</tagline>
  <purpose>Route user intent to specialized witness-* skills and enforce the JSON contract.</purpose>
  <read>
    <ref path="references/docs.md">Official documentation catalog; resolve doc-ref ids to href before tools and flags.</ref>
    <ref path="references/setup.md"/>
    <ref path="references/how.md"/>
    <ref path="references/gherkin.md"/>
    <ref path="references/mcps.md"/>
    <ref path="references/media.md"/>
    <ref path="references/testing.md"/>
    <ref path="references/captcha.md"/>
    <ref path="references/sessions.md"/>
    <ref path="references/actors.md"/>
    <ref path="references/har.md"/>
  </read>
  <commands>
    <command skill="witness-init">Bootstrap and MCP interview</command>
    <command skill="witness-explore">Record flow JSON and the matching detailed .feature</command>
    <command skill="witness-map">Summarize graph and scenario When lines</command>
    <command skill="witness-spec">Write .feature with one When/Then per observed step</command>
    <command skill="witness-mission">Business goal to flow and optional feature</command>
    <command skill="witness-run">Execute steps in order</command>
    <command skill="witness-captcha">Detect and resolve anti-bot gate</command>
    <command skill="witness-debug">Write failure.json</command>
    <command skill="witness-heal">Heal action.names only</command>
    <command skill="witness-repro">Jam or narrative; machine proof when computer-control is connected</command>
    <command skill="witness-gaps">Missing steps and transitions</command>
    <command skill="witness-report">Report kind scenarios coverage or har</command>
    <command skill="witness-affected">git diff crossed with flow pages</command>
  </commands>
  <contract>
    <file path="witness.config.json">surfaces, mcps, healing.assertions never</file>
    <file path=".witness/graph/flows/{id}.json">pages, locators, expect, oracle</file>
    <file path="features/{id}.feature">exact journey, one When per step</file>
    <file path=".witness/runs/{id}/result.json">evidence required on pass</file>
  </contract>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="one-when-per-step">Every flow step has its own When and Then. Never collapse a path into one step.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
</skill>
