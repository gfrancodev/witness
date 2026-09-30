<docs-catalog id="witness-official-docs">
  <rule id="read-before-act">Before calling a tool, device name, or CLI flag, read the cited doc page. Use names and flags exactly as documented. Do not invent MCP servers, flags, or device strings.</rule>
  <default-mcp file="PLUGIN_ROOT/agents/mcp.json">
    <enabled>@playwright/mcp@latest, chromium, caps devtools, codegen none, snapshot-mode full, image-responses omit, save-session, output-dir .witness/runs</enabled>
    <opt-in cap="storage">Add --caps=storage when any witness.config.json sessions.sites persist or accounts use storageState; see storage doc and browser_storage_state.</opt-in>
    <opt-in cap="vision">Only when accessibility snapshot lacks the control; see capabilities doc.</opt-in>
  </default-mcp>
  <playwright-mcp>
    <doc id="getting-started" href="https://playwright.dev/docs/getting-started-mcp">
      <use-when>First MCP setup, overview of browser tools, network and storage overview.</use-when>
    </doc>
    <doc id="options" href="https://playwright.dev/mcp/configuration/options">
      <use-when>CLI flags: --device, --viewport-size, --storage-state, --cdp-endpoint, --image-responses, --snapshot-mode, --caps, timeouts.</use-when>
    </doc>
    <doc id="capabilities" href="https://playwright.dev/mcp/capabilities">
      <use-when>browser_snapshot, browser_take_screenshot, browser_resize, browser_network_requests, browser_console_messages; cap groups network storage vision devtools. Vision cap opt-in per media.md ladder.</use-when>
    </doc>
    <doc id="playwright-screenshots" href="https://playwright.dev/docs/screenshots">
      <use-when>When snapshot is insufficient; pairs with browser_take_screenshot before vision cap.</use-when>
    </doc>
    <doc id="user-profile" href="https://playwright.dev/mcp/configuration/user-profile">
      <use-when>Persistent vs isolated profile, --user-data-dir, loading storage on startup.</use-when>
    </doc>
    <doc id="storage" href="https://playwright.dev/mcp/tools/storage">
      <use-when>browser_storage_state, browser_set_storage_state; requires --caps=storage.</use-when>
    </doc>
    <doc id="emulation" href="https://playwright.dev/docs/emulation">
      <use-when>Registry devices e.g. iPhone 15, Pixel 7; viewport and userAgent; surfaces in witness.config.json.</use-when>
    </doc>
    <doc id="locators" href="https://playwright.dev/docs/locators">
      <use-when>getByRole, getByLabel, getByTestId; semantic-first action.names in flow JSON.</use-when>
    </doc>
    <doc id="accessibility" href="https://playwright.dev/docs/accessibility-testing">
      <use-when>Accessibility audits context; complements snapshot-first explore and heal.</use-when>
    </doc>
    <doc id="aria-snapshots" href="https://playwright.dev/docs/aria-snapshots">
      <use-when>YAML accessibility tree shape; quoting snapshot text in result.json evidence.</use-when>
    </doc>
    <doc id="playwright-auth" href="https://playwright.dev/docs/auth">
      <use-when>storageState reuse, IndexedDB and sessionStorage persistence patterns; sessions.md and actors.md.</use-when>
    </doc>
    <doc id="browser-context" href="https://playwright.dev/docs/api/class-browsercontext#browser-context-storage-state">
      <use-when>storageState indexedDB option when library API used; fallback to user-data-dir per sessions.md.</use-when>
    </doc>
    <doc id="playwright-browsers" href="https://playwright.dev/docs/browsers">
      <use-when>Install Chromium when Playwright MCP reports a missing browser. npx playwright install chromium.</use-when>
    </doc>
    <doc id="mcp-network" href="https://playwright.dev/mcp/tools/network-mocking">
      <use-when>browser_network_requests filter includeStatic includeHeaders includeBody; witness-run and har.md.</use-when>
    </doc>
    <doc id="mcp-tracing" href="https://playwright.dev/mcp/tools/tracing">
      <use-when>browser_start_tracing browser_stop_tracing; requires devtools cap; show-trace for zip.</use-when>
    </doc>
    <doc id="playwright-har" href="https://playwright.dev/docs/api/class-tracing#tracing-start-har">
      <use-when>tracing.startHar stopHar content omit mode urlFilter; only when tool exists in session.</use-when>
    </doc>
    <doc id="playwright-show-trace" href="https://playwright.dev/docs/trace-viewer">
      <use-when>npx playwright show-trace after browser_stop_tracing; cite path in har report.</use-when>
    </doc>
  </playwright-mcp>
  <lightpanda>
    <doc id="lightpanda-intro" href="https://lightpanda.io/docs/">
      <use-when>What Lightpanda is. Headless browser, CDP, low memory. Not a Witness runtime.</use-when>
    </doc>
    <doc id="lightpanda-requirements" href="https://lightpanda.io/docs/run-locally/installation/system-requirements">
      <use-when>OS support before install: Debian 12, Ubuntu 22.04 or 24.04, macOS 13+, Windows via WSL2.</use-when>
    </doc>
    <doc id="lightpanda-one-liner" href="https://lightpanda.io/docs/run-locally/installation/one-liner">
      <use-when>Install script, pinned release, Windows WSL binary, telemetry env.</use-when>
    </doc>
    <doc id="lightpanda-docker" href="https://lightpanda.io/docs/run-locally/installation/docker">
      <use-when>docker run lightpanda/browser:nightly publishing 127.0.0.1:9222.</use-when>
    </doc>
    <doc id="lightpanda-serve" href="https://lightpanda.io/docs/run-locally/commands/serve">
      <use-when>lightpanda serve --host --port --obey-robots before Playwright connects.</use-when>
    </doc>
    <doc id="lightpanda-playwright" href="https://lightpanda.io/docs/usage/cdp/playwright">
      <use-when>connectOverCDP to ws://127.0.0.1:9222. Witness uses Playwright MCP --cdp-endpoint, not a second runner.</use-when>
    </doc>
    <doc id="lightpanda-mcp" href="https://lightpanda.io/docs/usage/mcp">
      <use-when>Optional lightpanda mcp server. Different tools from Playwright MCP. Do not swap them into witness-run.</use-when>
    </doc>
  </lightpanda>
  <captcha-providers>
    <doc id="turnstile-testing" href="https://developers.cloudflare.com/turnstile/troubleshooting/testing/">
      <use-when>Official Turnstile test sitekeys and secrets; pass fail interactive scenarios; captcha.md resolveCaptcha official-test.</use-when>
    </doc>
    <doc id="turnstile-server-validation" href="https://developers.cloudflare.com/turnstile/get-started/server-side-validation/">
      <use-when>Mandatory siteverify; token single-use 300s; security-oracle in captcha.md.</use-when>
    </doc>
    <doc id="recaptcha-test-keys" href="https://developers.google.com/recaptcha/docs/faq#id-like-to-run-automated-tests-with-recaptcha.-what-should-i-do">
      <use-when>Google reCAPTCHA v2 test keys for automated tests; separate v3 test keys for scores.</use-when>
    </doc>
    <doc id="hcaptcha-test-keys" href="https://docs.hcaptcha.com/#local-development-and-testing">
      <use-when>hCaptcha test sitekeys and secret; enterprise safe-user and bot-detected scenarios.</use-when>
    </doc>
  </captcha-providers>
  <gherkin>
    <doc id="gherkin-reference" href="https://cucumber.io/docs/gherkin/reference/">
      <use-when>Feature, Scenario, Given When Then, tags, comments for witness-spec.</use-when>
    </doc>
    <doc id="gherkin-languages" href="https://cucumber.io/docs/gherkin/languages/">
      <use-when>Non-English features; header # language: pt or other code.</use-when>
    </doc>
  </gherkin>
  <integrations read-only="true">
    <doc id="jam-docs" href="https://jam.dev/docs">
      <use-when>Jam product overview and extension.</use-when>
    </doc>
    <doc id="jam-mcp" href="https://jam.dev/docs/jam-mcp">
      <use-when>Cursor MCP config url https://mcp.jam.dev/mcp OAuth; getDetails getConsoleLogs getNetworkRequests getUserEvents getFrames witness-repro.</use-when>
    </doc>
    <doc id="jam-creating" href="https://jam.dev/docs/creating-a-jam">
      <use-when>Understanding what a Jam recording contains.</use-when>
    </doc>
    <doc id="computer-control" href="https://github.com/AB498/computer-control-mcp">
      <use-when>MCP already connected. Fast proof on the machine without Playwright code, or a native dialog after the DOM snapshot fails. Read references/computer-control.md before any tool.</use-when>
    </doc>
    <doc id="maestro" href="https://docs.maestro.dev/">
      <use-when>User says target is not a website; Witness stays web-focused.</use-when>
    </doc>
  </integrations>
  <host-tools>
    <doc id="ffmpeg" href="https://ffmpeg.org/documentation.html">
      <use-when>Extract frames from Jam or user video; read flags here before shell. See references/media.md.</use-when>
    </doc>
    <doc id="git" href="https://git-scm.com/downloads">
      <use-when>git missing and witness-affected needs git diff.</use-when>
    </doc>
    <doc id="uv" href="https://docs.astral.sh/uv/getting-started/installation/">
      <use-when>uvx missing and the user accepted computer-control.</use-when>
    </doc>
  </host-tools>
  <testing>
    <doc id="test-pyramid" href="https://martinfowler.com/articles/practical-test-pyramid.html">
      <use-when>Allocate effort across unit integration and E2E; Witness smoke maps to thin top slice.</use-when>
    </doc>
    <doc id="unit-test-bliki" href="https://martinfowler.com/bliki/UnitTest.html">
      <use-when>What unit tests are; Witness only points at the project runner.</use-when>
    </doc>
    <doc id="integration-test-bliki" href="https://martinfowler.com/bliki/IntegrationTest.html">
      <use-when>Integration scope; pairs with oracle.network and mocks.</use-when>
    </doc>
    <doc id="istqb-smoke" href="https://glossary.istqb.org/en_US/search?term=smoke+test">
      <use-when>@smoke tag meaning; main functionality before planned testing.</use-when>
    </doc>
    <doc id="api-testing" href="https://playwright.dev/docs/api-testing">
      <use-when>HTTP API checks with request fixture; integration without browser when appropriate.</use-when>
    </doc>
    <doc id="playwright-mock" href="https://playwright.dev/docs/mock">
      <use-when>browser_route fulfill; UI tests without live API.</use-when>
    </doc>
    <doc id="playwright-network" href="https://playwright.dev/docs/network">
      <use-when>Route interception overview; serviceWorkers block if routes missing.</use-when>
    </doc>
    <doc id="json-server" href="https://github.com/typicode/json-server">
      <use-when>Local REST mock from db.json; run npx json-server --help; v1 string ids _page _per_page.</use-when>
    </doc>
  </testing>
  <local>
    <ref path="./setup.md">Host installs: Node, git, Playwright browsers, optional Lightpanda CDP, ffmpeg, uv.</ref>
    <ref path="./media.md">Media ladder, manifest, ffmpeg output layout.</ref>
    <ref path="./testing.md">Unit integration smoke json-server browser-route contract.</ref>
    <ref path="./captcha.md">Captcha detection resolveCaptcha human gate security oracle.</ref>
    <ref path="./sessions.md">Per-site storage hops allowlist IndexedDB sessionStorage.</ref>
    <ref path="./actors.md">Multi-account sub-agents barriers concurrency.</ref>
    <ref path="./har.md">DevTools network HAR har-report three report kinds.</ref>
    <schemas dir="templates/schemas/">witness.config, flow, result, failure, media-manifest, captcha-state JSON schemas.</schemas>
  </local>
</docs-catalog>
