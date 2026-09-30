<manual id="witness-har">
  <docs-catalog ref="./docs.md"/>
  <principle>Network evidence explains when the UI lies or the API breaks. Prefer snapshot and console first; HAR and trace supplement failure.json. Never store cookies, Authorization headers, or response bodies in har-report.json by default.</principle>
  <diagnosis-ladder>
    <step order="1">browser_snapshot for UI expect.</step>
    <step order="2">browser_console_messages level error then warning.</step>
    <step order="3">browser_network_requests filter api or path from oracle.network includeStatic false.</step>
    <step order="4">includeHeaders or includeBody only when status alone does not explain the failure.</step>
    <step order="5">browser_start_tracing before reproducing a flaky fail; browser_stop_tracing after; open with npx playwright show-trace per trace doc.</step>
  </diagnosis-ladder>
  <tools>
    <tool id="browser_network_requests" cap="core">
      <doc-ref id="mcp-network"/>
      <params>filter includeStatic includeHeaders includeBody</params>
    </tool>
    <tool id="browser_console_messages" cap="core">
      <doc-ref id="capabilities"/>
    </tool>
    <tool id="browser_start_tracing" cap="devtools">
      <doc-ref id="mcp-tracing"/>
    </tool>
    <tool id="browser_stop_tracing" cap="devtools">
      <doc-ref id="mcp-tracing"/>
      <output>trace zip and optional .network file under .witness/runs/{runId}/</output>
    </tool>
    <tool id="tracing-startHar" optional="true">
      <doc-ref id="playwright-har"/>
      <rule>Call tracing.startHar and stopHar only when browser_run_code or an MCP tool schema exposes them in this session. Otherwise build har-report.json from browser_network_requests with source network-requests.</rule>
      <defaults>path .witness/runs/{runId}/network.har content omit mode full urlFilter from oracle path when set</defaults>
    </tool>
  </tools>
  <oracle>
    <instruction>For each step with oracle.network compare method path expectedStatus to live or listed requests.</instruction>
    <match expected="status matches oracle">match expected</match>
    <match expected="status differs">match mismatch; witness-debug firstDivergence network</match>
    <match expected="request not in oracle">match undeclared; list in har-report only do not auto-fail unless user asked</match>
    <rule>Green UI with HTTP 4xx or 5xx on a declared oracle is fail.</rule>
  </oracle>
  <artifact>
    <path>.witness/runs/{runId}/har-report.json</path>
    <schema>templates/schemas/har-report.schema.json</schema>
    <config>witness.config.json reports.har on-fail always off</config>
    <when-on-fail>Write after first failing step before witness-debug.</when-on-fail>
    <when-always>Write at end of run even on pass.</when-always>
    <when-off>Only when user runs witness-report kind har.</when-off>
  </artifact>
  <redaction>
    <rule>Do not copy cookie set-cookie authorization bearer or captcha tokens into har-report entries.</rule>
    <rule>har-report lists method path status durationMs oracleExpectedStatus match stepIntent.</rule>
  </redaction>
  <reports>
    <kind id="scenarios">witness-report default; result.json and failure.json.</kind>
    <kind id="coverage">witness-report kind coverage; witness-gaps logic on flows graph.</kind>
    <kind id="har">witness-report kind har; har-report.json mismatches first then tracePath harPath.</kind>
  </reports>
  <rules>
    <rule id="read-before-act">Read mcp-network mcp-tracing playwright-har before flags.</rule>
    <rule id="no-secrets">Redact secrets in summaries; full HAR file uses content omit.</rule>
    <rule id="no-invent">Do not add network expectations not in flow oracle.network.</rule>
  </rules>
</manual>
