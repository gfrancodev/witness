<manual id="witness-actors">
  <docs-catalog ref="./docs.md"/>
  <ref path="./sessions.md"/>
  <principle>One MCP browser context cannot hold two logged-in accounts. Use one sub-agent per account with isolated profile or storageState.</principle>
  <config path="witness.config.json">
    <block name="accounts">array of id, site, storageState, userDataDir; no passwords</block>
  </config>
  <isolation>
    <requirement>Distinct --user-data-dir or isolated context per account</requirement>
    <doc-ref id="user-profile"/>
    <doc-ref id="options"/>
    <forbidden>Two accounts in same context treated as parallel</forbidden>
  </isolation>
  <flow-modes>
    <mode id="parallel">
      <description>Same flow steps; independent data per account</description>
      <orchestration>Parent spawns sub-agent per accountId; each runs witness-run subset</orchestration>
      <output>.witness/runs/{runId}/actors/{accountId}/result.json</output>
    </mode>
    <mode id="collaborative">
      <description>Steps tagged with actor; barriers synchronize</description>
      <barrier path=".witness/runs/{runId}/barriers/{barrierId}.json"/>
      <step-fields>actor, barrier, afterBarrier</step-fields>
    </mode>
  </flow-modes>
  <concurrency>
    <value id="sub-agents">Host supports Task or sub-agent; each child own MCP profile</value>
    <value id="sequential-fallback">Shared MCP: run account A save state, load B, one at a time; record on parent result</value>
  </concurrency>
  <result-fields>
    <field name="concurrency">sub-agents | sequential-fallback</field>
    <field name="actors">array id status resultRef path to actor result.json</field>
  </result-fields>
  <captcha>
    <rule>Human gate per actor; readonly production applies to all actors</rule>
  </captcha>
  <rules>
    <rule id="no-secrets">Never store passwords in witness.config.json flows or features</rule>
    <rule id="no-invent">witness-spec writes actor only when observed in flow JSON</rule>
  </rules>
</manual>
