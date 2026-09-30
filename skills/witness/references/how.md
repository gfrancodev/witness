<manual id="witness-how">
  <tagline>See it. Test it. Prove it.</tagline>
  <model>Plugin only. The agent executes. Flow JSON stores locators and oracles. The .feature is the exact ordered journey, one When per step. Playwright MCP runs the browser.</model>
  <docs>
    <ref path="./docs.md">Official catalog; resolve doc ids to href before tools and flags.</ref>
    <doc-ref id="getting-started"/>
    <doc-ref id="emulation"/>
    <doc-ref id="locators"/>
    <doc-ref id="aria-snapshots"/>
    <doc-ref id="options"/>
    <ref path="./mcps.md"/>
    <ref path="./setup.md"/>
    <ref path="./media.md"/>
    <ref path="./testing.md"/>
    <ref path="./captcha.md"/>
    <ref path="./sessions.md"/>
    <ref path="./actors.md"/>
    <ref path="./har.md"/>
  </docs>
  <paths>
    <path id="PLUGIN_ROOT">Plugin root: skills/, agents/, templates/</path>
    <path id="PROJECT_ROOT">Application under test</path>
  </paths>
  <artifacts>
    <file path="witness.config.json">baseUrl, surfaces, mcps, captcha, sessions.sites, sites.crossSite, accounts</file>
    <file path=".witness/graph/flows/*.json">pages and ordered steps</file>
    <file path="features/**/*.feature">Exact Gherkin journey; one When and Then per flow step</file>
    <file path=".witness/runs/{id}/result.json">pass or fail per step; evidence required on pass and fail</file>
    <file path=".witness/runs/{id}/failure.json">structured classification</file>
    <file path=".witness/graph/healing.json">append-only name history</file>
    <file path=".witness/graph/unknown-state.json">unexpected screen; stop after captcha ruled out</file>
    <file path=".witness/runs/{id}/captcha-state.json">CaptchaState during run</file>
    <file path=".witness/runs/{id}/actors/{accountId}/result.json">per-account run when flow.actors set</file>
    <file path=".witness/runs/{id}/barriers/{barrierId}.json">collaborative sync between actors</file>
    <file path=".witness/sessions/*.json">storageState paths only in config; not in flow JSON</file>
    <file path=".witness/runs/{id}/har-report.json">network entries vs oracle; witness-report kind har</file>
    <file path=".witness/runs/{id}/network.har">optional full HAR when startHar available content omit</file>
  </artifacts>
  <schemas dir="templates/schemas"/>
  <examples>
    <example path="templates/flows/checkout.json" kind="flow"/>
    <example path="templates/runs/checkout-pass/result.json" kind="result-pass"/>
    <example path="templates/runs/checkout-fail/failure.json" kind="failure-network"/>
    <example path="templates/runs/checkout-fail/har-report.json" kind="har-report"/>
    <example path="templates/graph/unknown-state.json" kind="unknown-state"/>
    <example path="templates/runs/checkout-visual/result.json" kind="result-visual"/>
    <example path="templates/runs/checkout-visual/media-manifest.json" kind="media-manifest"/>
    <example path="templates/runs/checkout-visual/failure.json" kind="failure-visual"/>
    <example path="templates/mocks/checkout-db.json" kind="json-server-db"/>
    <example path="templates/features/security/captcha.feature" kind="feature-security"/>
    <example path="templates/runs/captcha-security/failure.json" kind="failure-security-regression"/>
    <example path="templates/runs/captcha-human-blocked/result.json" kind="result-blocked-captcha"/>
    <example path="templates/runs/two-actors/result.json" kind="result-multi-actor"/>
  </examples>
  <surfaces>
    <instruction>Read witness.config.json surfaces and defaultSurface. Each step may declare surface.</instruction>
    <instruction>Feature tags @mobile and @desktop must match the same surface key.</instruction>
    <instruction>If viewport only applies at MCP startup, restart Playwright with --device or --viewport-size from config and record surface in result.json.</instruction>
    <instruction>A flow observed only on desktop must not become a mobile scenario without re-explore.</instruction>
    <doc-ref id="emulation"/>
  </surfaces>
  <playwright>
    <step n="1">Snapshot before click; see doc-ref capabilities browser_snapshot.</step>
    <step n="2">Use role and accessible name; doc-ref locators.</step>
    <step n="3">Default image-responses omit; doc-ref options.</step>
    <step n="4">MCP artifacts under .witness/runs/; copy to PROJECT_ROOT if the process started outside the app.</step>
    <step n="5">Load and save per-site sessions per sessions.md; doc-ref storage user-profile playwright-auth.</step>
    <step n="6">On anti-bot signals invoke witness-captcha before treating UI as broken; doc-ref turnstile-testing.</step>
  </playwright>
  <regression>
    <instruction>Read the .feature and execute each When with the JSON step of the same index. Do not replan. Do not edit expect or Then. A feature with fewer When lines than steps is not ready to run. Mark pass only with evidence quoting the snapshot; doc-ref aria-snapshots. A native dialog uses computer-control.md and quotes the OCR line instead.</instruction>
  </regression>
  <computer-control>
    <ref path="./computer-control.md"/>
    <instruction>When list_windows or take_screenshot_with_ocr is connected, witness-repro and a proof-only mission drive the open product window and do not start Playwright. witness-run stays on Playwright until the snapshot cannot reach the control.</instruction>
  </computer-control>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without evidence in result.json: a snapshot quote, or an OCR quote on a machine proof.</rule>
    <rule id="one-when-per-step">One When per JSON step, in order.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
</manual>
