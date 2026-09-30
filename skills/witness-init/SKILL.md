---
name: witness-init
description: Bootstrap witness.config.json, MCP interview, and .witness folders (/witness:init).
---

<skill name="witness-init">
  <purpose>First-time setup: MCP interview then copy config and create graph directories.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
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
      <instruction>Follow setup.md. Check node, npx, and git. On missing, show the doc URL and install command. Stop until the user confirms.</instruction>
      <instruction>Ask whether to install Lightpanda. Default no. If yes, check OS against lightpanda-requirements, then run the one-liner or show the Docker command. Verify command -v lightpanda. Record mcps.lightpanda.enabled, cdpEndpoint ws://127.0.0.1:9222, obeyRobots true. Never store a cloud token.</instruction>
      <instruction>Tell the user the serve command and that they start it before a run. Do not leave lightpanda serve running after init.</instruction>
      <instruction>If Playwright later reports a missing browser, install Chromium from the browsers doc.</instruction>
    </phase>
    <phase id="mcp-interview">
      <instruction>One choice at a time. For each: explain purpose, show real install command, ask yes or no.</instruction>
      <item id="playwright">Browser for the product. npx @playwright/mcp@latest</item>
      <item id="computer-control">Fast proof on the machine, and native OS dialogs. If list_windows or take_screenshot_with_ocr is already connected, set mcps.computerControl.enabled true and do not ask again. Otherwise ask, and on yes merge PLUGIN_ROOT/agents/mcp.optional.json. Do not install uvx unless the user asks. Read computer-control.md.</item>
      <item id="jam">Bug context from Jam links. Merge jam url https://mcp.jam.dev/mcp from PLUGIN_ROOT/agents/mcp.json; restart IDE; OAuth per jam-mcp doc. Set witness.config.json mcps.jam enabled mode mcp.</item>
      <item id="native-app">If not a website, Witness is web-focused; point to Maestro or user-named tool</item>
      <instruction>Before writing MCP: command -v npx and, only when the user accepted computer-control and the tools are not already connected, command -v uvx. Merge playwright and jam servers from PLUGIN_ROOT/agents/mcp.json into project MCP config without fixed viewport on Playwright. Merge computer-control from mcp.optional.json only after a yes. If mcps.lightpanda.enabled, append --cdp-endpoint with the configured ws URL. Do not start a second browser.</instruction>
      <instruction>Persist choices in witness.config.json mcps.</instruction>
    </phase>
    <phase id="testing">
      <instruction>Ask which unit test runner the app uses; record witness.config.json testing.unitRunner string or null.</instruction>
      <instruction>Ask if json-server mock is needed; set mocks.jsonServer.enabled port and db path; optional copy templates/mocks/checkout-db.json to .witness/mocks/db.json.</instruction>
      <ref path="../witness/references/testing.md"/>
      <doc-ref id="test-pyramid"/>
      <doc-ref id="json-server"/>
      <doc-ref id="api-testing"/>
    </phase>
    <phase id="captcha-sessions-actors">
      <instruction>Explain captcha policies: test keys in local staging, human in production; no puzzle vision.</instruction>
      <instruction>Ask which origins persist session; record sessions.sites with store include reuseAcrossRuns; create .witness/sessions/accounts/ and profiles/ when needed.</instruction>
      <instruction>Ask sites.allowlist and crossSite hops if multi-origin flows expected.</instruction>
      <instruction>Ask account ids for multi-user tests; paths only never passwords; record accounts array.</instruction>
      <instruction>Add --caps=storage to Playwright MCP when any persist or accounts storageState.</instruction>
      <ref path="../witness/references/captcha.md"/>
      <ref path="../witness/references/sessions.md"/>
      <ref path="../witness/references/actors.md"/>
      <doc-ref id="storage"/>
      <doc-ref id="turnstile-testing"/>
    </phase>
    <phase id="media">
      <instruction>Ask if ffmpeg is installed command -v ffmpeg. Record witness.config.json media.ffmpeg.available and whether Jam video repro is expected.</instruction>
      <instruction>Explain visionCap opt-in default; media.maxFramesPerRun and outputSubdir media.</instruction>
      <ref path="../witness/references/media.md"/>
      <doc-ref id="ffmpeg"/>
    </phase>
    <phase id="bootstrap">
      <when-missing file="witness.config.json">
        <step n="1">Copy PLUGIN_ROOT/templates/witness.config.json to PROJECT_ROOT/witness.config.json</step>
        <step n="2">Ask project.name, environment local staging production, baseUrl</step>
        <step n="3">Adjust surfaces desktop tablet mobile for the product</step>
        <step n="4">Create .witness/graph/flows/, .witness/graph/healing.json as [], .witness/runs/, .witness/sessions/, .witness/sessions/accounts/, .witness/sessions/profiles/, .witness/mocks/, features/ or paths.features</step>
        <step n="5">Optional copy templates/flows/checkout.json and templates/features/checkout.feature as examples</step>
      </when-missing>
      <when-exists file="witness.config.json">
        <instruction>Do not overwrite. Show baseUrl, paths, mcps, surfaces. Overwrite only on explicit user request preserving baseUrl and project.name.</instruction>
      </when-exists>
    </phase>
    <phase id="close">
      <instruction>List available skills and suggest witness-explore with the app URL.</instruction>
    </phase>
  </steps>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
  <done>witness.config.json exists, mcps recorded, directories created, user knows next explore step.</done>
</skill>
