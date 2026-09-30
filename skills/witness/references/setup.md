<manual id="witness-setup">
  <docs-catalog ref="./docs.md"/>
  <principle>Witness has no application code. The host must already have the tools below. Read each doc page before a flag. Show the install command, ask before installing, then verify with command -v. Do not leave a long-running server up after init.</principle>
  <required>
    <tool id="node">
      <why>Playwright MCP runs through npx.</why>
      <check>command -v node &amp;&amp; command -v npx</check>
      <need>Node.js 18 or newer</need>
      <doc-ref id="getting-started"/>
      <install>https://nodejs.org/</install>
    </tool>
    <tool id="git">
      <why>witness-affected reads git diff.</why>
      <check>command -v git</check>
      <doc-ref id="git"/>
    </tool>
  </required>
  <playwright>
    <install>npx -y @playwright/mcp@latest</install>
    <browsers>When mcps.playwright.browser is chromium and the first snapshot fails for a missing browser, read the browsers doc and run npx playwright install chromium. Do not invent a channel.</browsers>
    <doc-ref id="playwright-browsers"/>
    <doc-ref id="options"/>
    <config>Merge PLUGIN_ROOT/agents/mcp.json into the project MCP config. Do not pin a viewport in that default block.</config>
  </playwright>
  <lightpanda optional="true">
    <why>Headless browser for fast runs. Playwright MCP stays the tool surface. Lightpanda is only the browser behind --cdp-endpoint.</why>
    <doc-ref id="lightpanda-intro"/>
    <doc-ref id="lightpanda-requirements"/>
    <systems>Debian 12, Ubuntu 22.04 or 24.04, x86-64 or arm64. macOS 13 or later. Windows 10+ via WSL2.</systems>
    <install id="one-liner">
      <needs>curl, jq, sha256sum</needs>
      <command>curl -fsSL https://pkg.lightpanda.io/install.sh | bash</command>
      <pin>curl -fsSL https://pkg.lightpanda.io/install.sh | bash -s "0.4.1"</pin>
      <doc-ref id="lightpanda-one-liner"/>
    </install>
    <install id="docker">
      <command>docker run -d --name lightpanda -p 127.0.0.1:9222:9222 lightpanda/browser:nightly</command>
      <doc-ref id="lightpanda-docker"/>
    </install>
    <install id="windows-wsl">
      <steps>wsl --install, restart, wsl --install -d Ubuntu, then inside WSL: curl -L -o lightpanda https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-x86_64-linux &amp;&amp; chmod a+x ./lightpanda</steps>
      <doc-ref id="lightpanda-one-liner"/>
    </install>
    <telemetry>Default on. User may set LIGHTPANDA_DISABLE_TELEMETRY=true. Privacy: https://lightpanda.io/privacy-policy</telemetry>
    <serve>
      <command>lightpanda serve --obey-robots --host 127.0.0.1 --port 9222</command>
      <doc-ref id="lightpanda-serve"/>
      <doc-ref id="lightpanda-playwright"/>
      <playwright-mcp-flag>--cdp-endpoint ws://127.0.0.1:9222</playwright-mcp-flag>
      <rule>Start serve before the MCP client. Do not combine a second --browser launch with this endpoint.</rule>
      <rule>Pass --obey-robots. Do not hammer third-party sites.</rule>
    </serve>
    <limits>
      <rule>One lightpanda serve process is one browser. Two accounts need two ports from the serve doc, each child with its own ws URL. Otherwise keep Playwright chromium and user-data-dir per actors.md.</rule>
      <rule>Device emulation and IndexedDB profiles are Chromium behavior. If a surface or session include fails on Lightpanda, switch that run back to Playwright chromium and say so.</rule>
      <rule>lightpanda mcp is a different tool list. witness-explore and witness-run keep calling Playwright MCP tools. Add the Lightpanda MCP server only when the user asks, from the MCP doc, and do not rename its tools to browser_snapshot.</rule>
      <doc-ref id="lightpanda-mcp"/>
    </limits>
    <secrets>Cloud CDP needs a token. Never write LPD_TOKEN or the websocket URL with a token into witness.config.json, flows, or features. The user keeps it in the environment.</secrets>
    <check>command -v lightpanda</check>
    <config>witness.config.json mcps.lightpanda.enabled false by default. When true, record cdpEndpoint and obeyRobots. Do not record a token.</config>
  </lightpanda>
  <jam-mcp>
    <config>PLUGIN_ROOT/agents/mcp.json jam url https://mcp.jam.dev/mcp</config>
    <doc-ref id="jam-mcp"/>
    <note>User authenticates in IDE; permissions mirror Jam workspace access.</note>
  </jam-mcp>
  <optional>
    <tool id="ffmpeg">
      <why>Frame extract for Jam or user video. media.md</why>
      <check>command -v ffmpeg</check>
      <doc-ref id="ffmpeg"/>
    </tool>
    <tool id="uv">
      <why>Only if the user enables computer-control.</why>
      <check>command -v uvx</check>
      <install>uvx computer-control-mcp@latest</install>
      <doc-ref id="uv"/>
      <doc-ref id="computer-control"/>
    </tool>
    <tool id="json-server">
      <why>Only when mocks.jsonServer.enabled.</why>
      <check>npx json-server --help</check>
      <doc-ref id="json-server"/>
    </tool>
  </optional>
  <on-missing>Print the check that failed, the doc URL, and the install command. Stop until the user confirms. Do not mark the tool available in config.</on-missing>
</manual>
