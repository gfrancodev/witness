<manual id="witness-testing">
  <docs-catalog ref="./docs.md"/>
  <principle>Witness does not ship a test runner and does not pick a framework. The stack is the app under test. Discover the command the repo already declares, read that tool's docs before any flag, and mark pass only with the runner's own output. Playwright and the .feature stay the observed e2e journey. Do not rewrite that journey as a unit test.</principle>
  <discover>
    <instruction>Read the manifest that exists. Record the command string exactly as the project runs it. If a layer has no command, store null. Do not invent Jest, pytest, Stryker, PIT, mutmut, cargo-mutants, or Testcontainers.</instruction>
    <manifests>package.json scripts, pyproject.toml or pytest.ini, go.mod plus go test, pom.xml or build.gradle, *.csproj, Cargo.toml, composer.json, Makefile test targets, and .github/workflows jobs whose name contains test.</manifests>
    <files>Unit: *.test.*, *.spec.*, *_test.go, *Test.java, test_*.py next to source. Integration or e2e: path or script name says integration, e2e, or api. Mutation: stryker, pitest, mutmut, or cargo-mutants config in the repo.</files>
    <config>
      <field name="testing.layers.unit.command">Isolated behavior.</field>
      <field name="testing.layers.integration.command">API, database, or queue without a browser.</field>
      <field name="testing.layers.mutation.command">Mutator already in the repo, or null.</field>
      <field name="testing.layers.e2e.command">Project e2e script when one exists. The Witness journey remains /witness:run.</field>
      <field name="testing.unitRunner">Mirror of testing.layers.unit.command so older configs still resolve.</field>
    </config>
  </discover>
  <place-risk>
    <rule>A pure function change is proved by the project's unit command, not by opening the browser.</rule>
    <rule>A route, repository, or message handler is proved by the integration command.</rule>
    <rule>An observed screen is proved by the .feature and /witness:run.</rule>
    <rule>Mutation runs only when testing.layers.mutation.command is set, or after the user accepts the mutator of that ecosystem.</rule>
  </place-risk>
  <levels>
    <level id="unit">
      <scope>One behavior, isolated from network and UI.</scope>
      <witness-role>Run the discovered command via /witness:suite. A new test is allowed only when the user asks, written in the style of tests already in the repo, for a behavior read in the code or seen in a run.</witness-role>
      <doc-ref id="unit-test-bliki"/>
    </level>
    <level id="mutation">
      <scope>The project's mutator changes code and checks whether tests fail.</scope>
      <witness-role>Read the mutation concepts page before any CLI. Evidence is the tool report: killed, survived, timeout. Do not invent a score. If no mutator is installed, say the layer is absent and stop until the user says yes.</witness-role>
      <doc-ref id="mutation-testing"/>
    </level>
    <level id="integration">
      <scope>API, database, or queue. Contract checks live here when the repo already has them.</scope>
      <witness-role>Use the mock the project already uses. Do not start a browser for this layer.</witness-role>
      <doc-ref id="integration-test-bliki"/>
      <doc-ref id="api-testing"/>
    </level>
    <level id="e2e">
      <scope>Observed UI journey.</scope>
      <witness-role>The .feature and /witness:run. @smoke tags steps with smoke true. Do not collapse the path into a unit test.</witness-role>
      <doc-ref id="istqb-smoke"/>
    </level>
  </levels>
  <mocks>
    <prefer>The double, HTTP stub, or container the repository already uses.</prefer>
    <kind id="in-process">Language mock or fake next to the unit test. Do not add a new library.</kind>
    <kind id="http">Project HTTP mock. json-server only when a flow step declares oracle.network mock json-server.</kind>
    <kind id="browser-route">oracle.network mock browser-route during /witness:run. Not a substitute for the integration command.</kind>
    <kind id="container">Only when the repo already starts one. Do not add Testcontainers unasked.</kind>
  </mocks>
  <json-server>
    <doc-ref id="json-server"/>
    <when>A flow step declares oracle.network mock json-server. Not the default backend mock.</when>
    <start>command -v npx; npx json-server --help before flags; npx json-server on the configured port and db.</start>
    <rules>v1 ids are strings; pagination _page and _per_page; relationships _embed not _expand.</rules>
    <config>witness.config.json mocks.jsonServer enabled port db path under .witness/mocks/</config>
    <template>templates/mocks/checkout-db.json</template>
  </json-server>
  <browser-mock>
    <when>UI fetch must not hit live backend; oracle.network mock browser-route.</when>
    <mcp>Add network cap per capabilities doc; use browser_route in Playwright MCP.</mcp>
    <doc-ref id="playwright-mock"/>
    <doc-ref id="playwright-network"/>
    <doc-ref id="capabilities"/>
  </browser-mock>
  <pyramid>
    <doc-ref id="test-pyramid"/>
    <doc-ref id="unit-test-bliki"/>
    <doc-ref id="integration-test-bliki"/>
    <doc-ref id="mutation-testing"/>
  </pyramid>
  <suite-evidence>
    <path>.witness/runs/{id}/suite.json</path>
    <schema>templates/schemas/suite-result.schema.json</schema>
    <pass>exit code 0 and a literal excerpt of the runner output. A remembered result is not a pass.</pass>
    <mutation>Quote killed, survived, and timeout from the tool report. Do not compute a score the tool did not print.</mutation>
    <absent>Command is null. Say the layer is missing. Do not install a dependency until the user agrees.</absent>
  </suite-evidence>
  <rules>
    <rule id="no-framework">Do not add a test framework, mutator, or container tool unless the user agrees.</rule>
    <rule id="no-invent-behavior">A new test locks a behavior read in the code or seen in a run. Do not assert a behavior that is in neither.</rule>
    <rule id="evidence">Browser runs still require snapshot or OCR evidence. Suite runs require the runner excerpt in suite.json.</rule>
    <rule id="readonly">On readonly production do not POST PUT PATCH DELETE to live APIs; use the project's mock or browser-route only.</rule>
  </rules>
</manual>
