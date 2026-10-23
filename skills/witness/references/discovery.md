<manual id="witness-discovery">
  <principle>Read the context you were given and act. Fill witness.config.json from the repo, the open files, the git diff, the user message, and the MCP tools already connected. Ask only when two sources name different targets, when a step would purchase, delete, or publish on production, or when installing a tool. Do not run an interview first.</principle>
  <order>
    <step n="1">If witness.config.json exists, keep project.name, baseUrl, and paths. Refresh testing.layers and mcps from what you can see. Do not overwrite a URL the user already set.</step>
    <step n="2">If it is missing, copy templates/witness.config.json and fill the fields below. Then continue the skill the user asked for in the same turn.</step>
  </order>
  <project>
    <name>Directory name, or the name field in package.json, pyproject.toml, go.mod, pom.xml, or Cargo.toml. Do not ask.</name>
    <environment>Host localhost, 127.0.0.1, or a *.local name is local. A host containing staging, hml, or qa is staging. Any other public host is production and readonly.</environment>
    <baseUrl>First match wins: URL in the user message, then a script or README dev URL, then docker-compose published port, then .env.example (never .env). If two of these disagree, ask once which host to prove.</baseUrl>
    <surfaces>defaultSurface desktop until a step names another surface.</surfaces>
  </project>
  <tests>
    <ref path="./testing.md"/>
    <sources>package.json scripts, pyproject.toml, pytest.ini, go.mod, pom.xml, build.gradle, *.csproj, Cargo.toml, composer.json, Makefile, and .github/workflows test jobs.</sources>
    <files>Classify by path: unit next to source (*.test.*, *_test.go, *Test.java, test_*.py); integration or e2e when the path or script name says so; mutation when a mutator config exists (stryker, pitest, mutmut, cargo-mutants).</files>
    <act>If the user named no layer, use place-risk on the diff or the open files and run that command. Do not ask which runner they use.</act>
  </tests>
  <mcps>
    <playwright>If browser tools are already connected, set mcps.playwright.enabled true. If npx exists and the user asked to explore or run, merge agents/mcp.json without asking.</playwright>
    <computer-control>If list_windows or take_screenshot_with_ocr is connected, set mcps.computerControl.enabled true and use it. Do not ask.</computer-control>
    <jam>Enable only when the user pasted a Jam URL or Jam tools are already connected.</jam>
    <lightpanda>Leave enabled false. Do not ask.</lightpanda>
  </mcps>
  <host>
    <check>command -v node, npx, git, and ffmpeg. Record media.ffmpeg.available from the check. Do not ask if ffmpeg is installed.</check>
    <missing>Show the doc URL and the install command only when the next skill cannot run without that tool. Stop for a yes only then.</missing>
  </host>
  <sessions>
    <default>persist false. Do not ask for accounts or an allowlist up front.</default>
    <when>After a login is observed, record that origin. After a flow names two actors, ask only for the account ids, never passwords.</when>
  </sessions>
  <mocks>
    <prefer>The mock the repo already uses. Leave mocks.jsonServer.enabled false unless a flow step already declares oracle.network mock json-server.</prefer>
  </mocks>
  <then>
    <rule>A goal in the user message goes to witness-mission or witness-suite without waiting for explore to be suggested.</rule>
    <rule>A URL goes to witness-explore.</rule>
    <rule>A Jam link or a bug narrative goes to witness-repro.</rule>
    <rule>A diff with no screen goes to witness-suite on the discovered layer.</rule>
  </then>
</manual>
