---
name: witness-init
description: Discover the repo, write witness.config.json, and continue the requested skill (/witness:init).
---

<skill name="witness-init">
  <purpose>Read the project and fill witness.config.json. Ask only when two sources disagree or a tool must be installed. Then continue the skill the user already asked for.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/discovery.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/mcps.md"/>
    <ref path="../witness/references/setup.md"/>
    <doc-ref id="lightpanda-requirements"/>
    <doc-ref id="lightpanda-one-liner"/>
    <doc-ref id="lightpanda-docker"/>
    <doc-ref id="lightpanda-serve"/>
    <doc-ref id="playwright-browsers"/>
    <doc-ref id="getting-started"/>
    <doc-ref id="options"/>
    <doc-ref id="capabilities"/>
    <doc-ref id="user-profile"/>
    <doc-ref id="computer-control"/>
    <ref path="../witness/references/computer-control.md"/>
    <doc-ref id="jam-docs"/>
    <doc-ref id="jam-mcp"/>
    <doc-ref id="jam-creating"/>
    <doc-ref id="maestro"/>
  </read>
  <when>User requests init, bootstrap, or any Witness skill while witness.config.json is missing in PROJECT_ROOT.</when>
  <steps>
    <phase id="prerequisites" order="first">
      <instruction>Follow discovery.md and setup.md. Check node, npx, and git. Record ffmpeg with command -v. Do not ask about Lightpanda or ffmpeg. Show an install command and stop only when the next skill cannot run without that tool.</instruction>
      <instruction>If Playwright later reports a missing browser, install Chromium from the browsers doc after the user confirms that one install.</instruction>
    </phase>
    <phase id="mcp-interview">
      <instruction>Do not ask yes or no per server. Record what is already connected. Merge playwright from PLUGIN_ROOT/agents/mcp.json when npx exists and the user asked to explore or run. Set computer-control enabled when its tools are connected. Enable jam only for a pasted Jam URL or when Jam tools are connected. Leave lightpanda disabled.</instruction>
      <instruction>Before writing MCP: command -v npx. Merge playwright without a fixed viewport. Do not start a second browser. Persist mcps in witness.config.json.</instruction>
    </phase>
    <phase id="testing">
      <instruction>Discover testing.layers from manifests, CI jobs, and test file paths per discovery.md and testing.md. Record each command or null. Set testing.unitRunner to the unit command. Do not ask the user to name a framework. Do not install a runner.</instruction>
      <instruction>Leave mocks.jsonServer.enabled false unless a flow step already declares oracle.network mock json-server.</instruction>
      <ref path="../witness/references/testing.md"/>
      <doc-ref id="test-pyramid"/>
      <doc-ref id="mutation-testing"/>
      <doc-ref id="json-server"/>
      <doc-ref id="api-testing"/>
    </phase>
    <phase id="captcha-sessions-actors">
      <instruction>Keep captcha defaults from the template: test keys on local and staging, human on production. Do not ask which origins persist. persist stays false until a login is observed. Do not ask for account ids until a flow names two actors. Never store passwords.</instruction>
      <ref path="../witness/references/captcha.md"/>
      <ref path="../witness/references/sessions.md"/>
      <ref path="../witness/references/actors.md"/>
      <doc-ref id="storage"/>
      <doc-ref id="turnstile-testing"/>
    </phase>
    <phase id="media">
      <instruction>command -v ffmpeg. Record media.ffmpeg.available. Keep visionCap opt-in. Do not ask.</instruction>
      <ref path="../witness/references/media.md"/>
      <doc-ref id="ffmpeg"/>
    </phase>
    <phase id="bootstrap">
      <when-missing file="witness.config.json">
        <step n="1">Copy PLUGIN_ROOT/templates/witness.config.json to PROJECT_ROOT/witness.config.json</step>
        <step n="2">Fill project.name, environment, and baseUrl from discovery.md. Ask only when two sources name different hosts.</step>
        <step n="3">Keep defaultSurface desktop.</step>
        <step n="4">Create .witness/graph/flows/, .witness/graph/healing.json as [], .witness/runs/, .witness/sessions/, .witness/sessions/accounts/, .witness/sessions/profiles/, .witness/mocks/, features/ or paths.features</step>
        <step n="5">Do not copy the checkout example unless the repo has no app to observe.</step>
      </when-missing>
      <when-exists file="witness.config.json">
        <instruction>Keep project.name, baseUrl, and paths. Refresh testing.layers and mcps from discovery.md. Overwrite the URL only when the user names a different host.</instruction>
      </when-exists>
    </phase>
    <phase id="close">
      <instruction>In the same turn, continue the skill the user asked for. A goal goes to witness-mission or witness-suite. A URL goes to witness-explore. A Jam link or bug narrative goes to witness-repro. A diff with no screen goes to witness-suite. Do not stop after listing skills.</instruction>
    </phase>
  </steps>
  <rules>
    <rule id="discover-first">Ask only when two hosts disagree, a production write is required, or a tool must be installed.</rule>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
  <done>witness.config.json matches the repo. The requested skill has started. Questions were only for a conflicting host, a production write, or a missing tool.</done>
</skill>
