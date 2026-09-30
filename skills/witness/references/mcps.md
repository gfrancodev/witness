<mcp-catalog id="witness-mcps">
  <usage>Use during witness-init interview. Enable only what the user accepts. Persist choices in witness.config.json under mcps.</usage>
  <docs-catalog ref="./docs.md"/>
  <entry id="lightpanda" optional="true">
    <purpose>Headless browser behind Playwright MCP via CDP. Not a replacement for browser_snapshot tools.</purpose>
    <install>Read setup.md. One-liner or Docker from the Lightpanda docs. Verify command -v lightpanda.</install>
    <project-mcp>When enabled, user starts lightpanda serve, then add --cdp-endpoint from mcps.lightpanda.cdpEndpoint to the Playwright MCP args. Read options and lightpanda-serve first.</project-mcp>
    <doc-ref id="lightpanda-intro"/>
    <doc-ref id="lightpanda-one-liner"/>
    <doc-ref id="lightpanda-serve"/>
    <doc-ref id="lightpanda-playwright"/>
    <ref path="./setup.md"/>
  </entry>
  <entry id="playwright" recommended="true">
    <purpose>Navigate, accessibility snapshot, click, fill, console, network, upload, download, device emulation.</purpose>
    <install>Node 18+. command npx, package @playwright/mcp@latest</install>
    <project-mcp>Copy block from PLUGIN_ROOT/agents/mcp.json into project MCP config. Adjust --device or --viewport-size per surface from witness.config.json surfaces.</project-mcp>
    <doc-ref id="getting-started"/>
    <doc-ref id="options"/>
    <doc-ref id="capabilities"/>
    <doc-ref id="emulation"/>
    <doc-ref id="accessibility"/>
    <viewport>Do not fix desktop for all runs. Use surfaces.desktop, surfaces.tablet, surfaces.mobile and step.surface.</viewport>
  </entry>
  <entry id="computer-control" optional="true">
    <purpose>Fast proof on the real machine without Playwright code, and native dialogs the DOM snapshot cannot reach. Not a replacement for witness-run.</purpose>
    <install>uvx computer-control-mcp@latest</install>
    <available>Connected when the session already exposes list_windows or take_screenshot_with_ocr. Then set mcps.computerControl.enabled true. If the flag is true and the tools are missing, stay on Playwright.</available>
    <project-mcp>Merge from agents/mcp.optional.json only if the user agrees and the tools are not already connected. Screenshot dir is .witness/runs.</project-mcp>
    <modes ref="./computer-control.md">proof for repro and proof-only mission; native-dialog during regression.</modes>
    <doc-ref id="computer-control"/>
  </entry>
  <entry id="jam" recommended="true">
    <purpose>Load Jam recording context via MCP when user pastes a link; witness-repro then replays with Playwright.</purpose>
    <install>Merge jam block from PLUGIN_ROOT/agents/mcp.json: url https://mcp.jam.dev/mcp. Restart Cursor after change. Complete OAuth when prompted.</install>
    <doc-ref id="jam-mcp"/>
    <doc-ref id="jam-docs"/>
    <doc-ref id="jam-creating"/>
    <tools>getDetails getUserEvents getConsoleLogs getNetworkRequests getMetadata getFrames getVideoTranscript analyzeVideo; read jam-mcp doc before calling</tools>
    <fallback>If Jam MCP disabled or auth fails, ask user for narrative url and expected outcome only.</fallback>
  </entry>
  <entry id="native-app" out-of-scope="true">
    <purpose>If target is not a browser, state Witness is web-focused. Point to user tool e.g. Maestro. Do not add invented mobile MCP.</purpose>
    <doc-ref id="maestro"/>
  </entry>
  <verify>
    <check command="command -v node">Node 18+</check>
    <check command="command -v npx">Playwright MCP</check>
    <check command="command -v git">witness-affected</check>
    <check command="command -v lightpanda">Only when mcps.lightpanda.enabled</check>
    <check command="command -v ffmpeg">Only when media.ffmpeg.required</check>
    <check command="command -v uvx">Only when computer-control accepted</check>
    <on-missing>Follow setup.md. Show the doc URL and install command. Stop until the user confirms.</on-missing>
  </verify>
</mcp-catalog>
