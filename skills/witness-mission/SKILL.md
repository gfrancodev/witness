---
name: witness-mission
description: Business goal to explore, record flow, feature only if expect passed (/witness:mission).
---

<skill name="witness-mission">
  <purpose>Combine witness-explore validation and conditional witness-spec for a stated business outcome.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/gherkin.md"/>
    <ref path="../witness/references/computer-control.md"/>
    <doc-ref id="computer-control"/>
    <ref path="../witness-spec/SKILL.md"/>
    <doc-ref id="emulation"/>
    <doc-ref id="locators"/>
    <doc-ref id="accessibility"/>
    <doc-ref id="aria-snapshots"/>
    <doc-ref id="capabilities"/>
    <ref path="../witness/references/captcha.md"/>
    <ref path="../witness-captcha/SKILL.md"/>
  </read>
  <inputs>
    <input name="goal">One-sentence business outcome</input>
    <input name="surface">Optional surface key from config</input>
  </inputs>
  <steps>
    <step n="1">Parse goal into observable end state.</step>
    <step n="2">Run witness-init if witness.config.json missing.</step>
    <step n="3">If the user asked only for proof and computer-control tools are connected, follow the proof mode in computer-control.md. Do not start Playwright and do not emit codegen. Otherwise explore with Playwright on the requested surface and create or update flow JSON.</step>
    <step n="4">For each new step execute action; on CAPTCHA_REQUIRED pause with clear message for human gate; verify expect in snapshot and oracle.network if present.</step>
    <step n="5">For steps whose expect passed with quotable evidence, write or update the .feature: one When and one Then per proven step, in order. On Playwright, the When uses the accessible name via witness-spec. On a machine proof, the When names the visible OCR text, not the coordinate. Do not collapse the path into a single When. Leave unproven steps out of the Scenario and list them as not yet in the feature.</step>
    <step n="6">Optionally write partial .witness/runs/{id}/result.json.</step>
    <step n="7">Stop on unknown-state or expect failure without healing Then text.</step>
  </steps>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without a snapshot quote or, on a machine proof, an OCR quote in result.json.</rule>
    <rule id="one-when-per-step">Proven steps appear as their own When/Then. A summary scenario is not done.</rule>
    <rule id="no-invent">Never add a step not observed in the session.</rule>
  </rules>
  <done>The .feature lists each proven step in order. A machine proof also has result.json with the OCR quote and does not add a Playwright script.</done>
</skill>
