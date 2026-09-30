---
name: witness-explore
description: Explore URL with Playwright MCP, record flow JSON, and write the matching detailed .feature (/witness:explore).
---

<skill name="witness-explore">
  <purpose>Observe the app, write or update .witness/graph/flows/{id}.json, then write the exact .feature in the same session. One When per observed step. If the user does not want a durable flow and computer-control is connected, offer a machine proof instead of Playwright.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/gherkin.md"/>
    <ref path="../witness-spec/SKILL.md"/>
    <ref path="../witness/references/computer-control.md"/>
    <doc-ref id="computer-control"/>
    <doc-ref id="emulation"/>
    <doc-ref id="locators"/>
    <doc-ref id="accessibility"/>
    <doc-ref id="aria-snapshots"/>
    <doc-ref id="capabilities"/>
    <example path="templates/graph/unknown-state.json"/>
    <ref path="../witness/references/media.md"/>
    <ref path="../witness/references/captcha.md"/>
    <ref path="../witness/references/sessions.md"/>
    <doc-ref id="playwright-screenshots"/>
  </read>
  <when>User provides URL or default baseUrl from witness.config.json environments.</when>
  <inputs>
    <input name="url">User URL or environments.{default}.baseUrl</input>
    <input name="flowId">Optional; derive from journey if omitted</input>
  </inputs>
  <steps>
    <step n="1">If the user does not ask for a durable flow and computer-control tools are connected, follow the proof mode in computer-control.md and stop after the .feature and result.json. Otherwise snapshot before any click.</step>
    <step n="2">Apply step.surface or defaultSurface from config; use surfaces viewport or device keys.</step>
    <step n="3">If MCP needs restart for viewport, restart with --device or --viewport-size and record active surface.</step>
    <step n="4">For each stable screen, add pages entry: url, title, site id when origin maps to sessions.sites, captcha subset when detector signals, regions id tag role name, elements with interactive controls only stateClasses disabled is-loading ng-invalid stable attrs visible enabled motion.blocksAction.</step>
    <step n="4b">If origin not in sites.allowlist ask user to add allowlist entry before recording cross-origin navigation or hop.</step>
    <step n="5">For each observed action add step: from, target, intent snake_case, surface, action role and names, to, expect natural Then phrase, oracle ui network and visual when canvas map video or motion.blocksAction without ARIA node.</step>
    <step n="6">Do not dump full HTML or utility-only classes.</step>
    <step n="7">If screen does not match expected node, run captcha detector first; if captcha classify pending not unknown-state. If the missing control is a native file, save, print, or permission dialog, or a window that is not the page, and computer-control tools are connected, follow the native-dialog mode in computer-control.md and record the step only if the action was observed. The When names the dialog or the visible text, not the coordinate. Else write .witness/graph/unknown-state.json with url headings last action console network and stop. Do not click to discover.</step>
    <step n="8">On same url update pages and append new steps; do not delete steps used in regression without user request.</step>
    <step n="9">Follow witness-spec and gherkin.md. Write or refresh features/{flowId}.feature so each observed step is its own When and Then, in order. Do not leave explore with only JSON.</step>
  </steps>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="one-when-per-step">The .feature has one When per JSON step written in this session.</rule>
    <rule id="no-invent">Never add a step not observed in the session.</rule>
  </rules>
  <done>Flow JSON and the matching .feature both reflect the observed path, one When per step.</done>
</skill>
