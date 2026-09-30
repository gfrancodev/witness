<manual id="witness-testing">
  <docs-catalog ref="./docs.md"/>
  <principle>Witness does not replace the app unit test runner. It documents integration and smoke flows in JSON and runs them with Playwright MCP when appropriate.</principle>
  <levels>
    <level id="unit">
      <scope>Fast isolated tests in the app repo.</scope>
      <witness-role>Record which script the project uses in witness.config.json testing.unitRunner. Do not invent unit cases or frameworks.</witness-role>
      <examples>npm test, pnpm test, pytest, go test - read package.json or project docs.</examples>
    </level>
    <level id="integration">
      <scope>HTTP contracts and UI against real or mocked APIs.</scope>
      <witness-role>Declare oracle.network on flow steps with method path expectedStatus and mock mode. Green UI with API 500 is fail.</witness-role>
      <doc-ref id="api-testing"/>
      <doc-ref id="playwright-mock"/>
      <doc-ref id="playwright-network"/>
    </level>
    <level id="smoke">
      <scope>Short suite covering main functionality before deeper testing; ISTQB smoke test definition.</scope>
      <witness-role>Tag @smoke on feature scenarios for steps with smoke true in flow JSON. witness-run filters @smoke when user requests smoke only.</witness-role>
      <doc-ref id="istqb-smoke"/>
    </level>
  </levels>
  <json-server>
    <doc-ref id="json-server"/>
    <when>Backend missing, local dev, or readonly production UI exercise with mocked API only when flow declares oracle.network mock json-server.</when>
    <start>command -v npx; npx json-server --help before flags; npx json-server witness.config.json mocks.jsonServer.db --port from config.</start>
    <rules>v1 ids are strings; pagination _page and _per_page; relationships _embed not _expand.</rules>
    <config>witness.config.json mocks.jsonServer enabled port db path under .witness/mocks/</config>
    <template>templates/mocks/checkout-db.json</template>
  </json-server>
  <browser-mock>
    <when>UI fetch must not hit live backend; oracle.network mock browser-route.</when>
    <mcp>Add network cap per capabilities doc; use browser_route in Playwright MCP.</mcp>
    <doc-ref id="capabilities"/>
  </browser-mock>
  <pyramid>
    <doc-ref id="test-pyramid"/>
    <doc-ref id="unit-test-bliki"/>
    <doc-ref id="integration-test-bliki"/>
  </pyramid>
  <rules>
    <rule id="evidence">Integration and smoke runs still require result.json evidence from snapshot when ARIA exists.</rule>
    <rule id="no-invent">Do not add network expectations not observed or declared in flow JSON.</rule>
    <rule id="readonly">On readonly production do not POST PUT PATCH DELETE to live APIs; use mock or browser-route only.</rule>
  </rules>
</manual>
