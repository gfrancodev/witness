---
name: witness-spec
description: Write a detailed .feature with one When/Then per observed flow step (/witness:spec).
---

<skill name="witness-spec">
  <purpose>Write the exact Gherkin journey for an existing flow. One When and one Then per JSON step, in order. Do not summarize.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/gherkin.md"/>
    <doc-ref id="gherkin-reference"/>
    <doc-ref id="gherkin-languages"/>
    <template flow="templates/flows/checkout.json" feature="templates/features/checkout.feature"/>
    <ref path="../witness/references/testing.md"/>
    <doc-ref id="istqb-smoke"/>
    <example path="templates/features/security/captcha.feature"/>
    <ref path="../witness/references/captcha.md"/>
  </read>
  <inputs>
    <input name="flowId">User id or single flow in paths.flows</input>
  </inputs>
  <steps>
    <step n="1">Load .witness/graph/flows/{flowId}.json and pages for titles, paths, and accessible names.</step>
    <step n="2">Write # language, Feature title, and a description of the exact outcome. Background is the first page as seen: title, path, visible region.</step>
    <step n="3">One Scenario per surface and actor. Inside it, each JSON step is its own When naming role and accessible name, then Then equal to expect. And only repeats oracle.ui.visible text.</step>
    <step n="4">Under each When add comments intent, surface, flow, and step index starting at 1. Tags @critical @smoke @security @desktop @mobile; @smoke only when step.smoke is true; @security when oracle.captcha present; name the actor only when step.actor was observed.</step>
    <step n="5">No CSS selectors, test ids, or JSON in feature text. count(When) must equal count(steps) for that path.</step>
    <step n="6">Do not include a When for a step missing from JSON. Do not drop a JSON step to shorten the scenario.</step>
    <step n="7">Write to paths.features e.g. features/{flowId}.feature without changing expect in JSON.</step>
  </steps>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Then equals expect; never change either.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="one-when-per-step">One When per JSON step, in order. A summary scenario is not done.</rule>
    <rule id="no-invent">Only steps that exist in flow JSON.</rule>
  </rules>
  <done>Feature file written under paths.features with one When per flow step.</done>
</skill>
