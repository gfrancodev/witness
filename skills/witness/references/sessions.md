<manual id="witness-sessions">
  <docs-catalog ref="./docs.md"/>
  <principle>Persist browser state per origin and site id. Never copy cookie or storage values into flow JSON, features, or result evidence.</principle>
  <config path="witness.config.json">
    <block name="sessions.default">persist false when site not listed</block>
    <block name="sessions.sites">per-site origins, storageState path, store, include, reuseAcrossRuns</block>
    <block name="sites.allowlist">origins permitted for navigation and hops</block>
    <block name="sites.crossSite">enabled, maxHopsPerRun, hops with from to returnTo shareContext readonly</block>
  </config>
  <store kind="storage-state">
    <use-when>include is cookies and localStorage only, or sessionStorage sidecar</use-when>
    <mcp>browser_storage_state, browser_set_storage_state; --caps=storage</mcp>
    <doc-ref id="storage"/>
  </store>
  <store kind="user-data-dir">
    <use-when>include contains indexedDB or cache, or MCP storage_state lacks indexedDB parameter</use-when>
    <mcp>--user-data-dir per site; --isolated when switching accounts</mcp>
    <doc-ref id="user-profile"/>
    <doc-ref id="options"/>
  </store>
  <include>
    <item id="cookies">browser_storage_state</item>
    <item id="localStorage">browser_storage_state</item>
    <item id="sessionStorage">sidecar .witness/sessions/{siteId}.session.json; restore with browser_sessionstorage_set after navigate to origin</item>
    <item id="indexedDB">library storageState indexedDB true if tool supports; else user-data-dir</item>
    <item id="cache">user-data-dir only; no official serialize</item>
  </include>
  <persistence>
    <rule>If persist false: do not save state for that origin.</rule>
    <rule>If persist true: save on leaving origin or end of run for that site id only.</rule>
    <rule>If reuseAcrossRuns true: load artifact at run start when file or profile exists.</rule>
  </persistence>
  <cross-site>
    <rule>Navigate only to origins in sites.allowlist or environments baseUrl for active environment.</rule>
    <rule>Hop must match sites.crossSite.hops id or flow step hop id when crossSite enabled.</rule>
    <rule>shareContext true: same browser context for SSO and captcha already solved.</rule>
    <rule>shareContext false: separate context; hop reads public page only.</rule>
    <blocked>origin_not_allowlisted: result status blocked; failure classification environment</blocked>
  </cross-site>
  <flow-fields>
    <pages site="sessions.sites id" captcha="last CaptchaState subset from explore"/>
    <step site="site id" hop="id returnTo capture snapshot|http"/>
  </flow-fields>
  <captcha-link>
    <ref path="./captcha.md">resolveCaptcha mode session uses this site storage</ref>
  </captcha-link>
  <rules>
    <rule id="no-secrets">Only paths in JSON; never token or storage payload in artifacts except storageState files under .witness/sessions/</rule>
    <rule id="read-before-act">Read doc-ref storage user-profile playwright-auth browser-context before flags</rule>
  </rules>
</manual>
