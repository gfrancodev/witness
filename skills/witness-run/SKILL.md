---
name: witness-run
description: Execute flow steps in order; @critical and @smoke filters; evidence required on pass (/witness:run).
---

<skill name="witness-run">
  <purpose>Regression run following the .feature When lines and the matching flow JSON steps, in the same order.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/gherkin.md"/>
    <ref path="../witness-spec/SKILL.md"/>
    <ref path="../witness/references/computer-control.md"/>
    <doc-ref id="computer-control"/>
    <doc-ref id="getting-started"/>
    <doc-ref id="emulation"/>
    <doc-ref id="capabilities"/>
    <doc-ref id="aria-snapshots"/>
    <schema path="templates/schemas/result.schema.json"/>
    <example path="templates/runs/checkout-pass/result.json"/>
    <ref path="../witness/references/media.md"/>
    <doc-ref id="playwright-screenshots"/>
    <example path="templates/runs/checkout-visual/result.json"/>
    <example path="templates/runs/checkout-visual/media-manifest.json"/>
    <schema path="templates/schemas/media-manifest.schema.json"/>
    <ref path="../witness/references/testing.md"/>
    <doc-ref id="json-server"/>
    <doc-ref id="playwright-mock"/>
    <example path="templates/mocks/checkout-db.json"/>
    <ref path="../witness/references/captcha.md"/>
    <ref path="../witness/references/sessions.md"/>
    <ref path="../witness/references/actors.md"/>
    <ref path="../witness-captcha/SKILL.md"/>
    <doc-ref id="storage"/>
    <ref path="../witness/references/har.md"/>
    <doc-ref id="mcp-network"/>
    <doc-ref id="mcp-tracing"/>
    <schema path="templates/schemas/har-report.schema.json"/>
    <example path="templates/runs/checkout-fail/har-report.json"/>
  </read>
  <inputs>
    <input name="flowId">File under paths.flows</input>
    <input name="tag">Optional @critical or @smoke from feature filters scenarios or steps with smoke true in flow JSON</input>
    <input name="surface">Per step or defaultSurface</input>
  </inputs>
  <steps>
    <step n="1">Read witness.config.json, the .feature for the flow, and the flow JSON. If the feature is missing or count(When) is not count(steps) for the selected path, stop and run witness-spec before any browser action. If tag smoke only run steps with smoke true and the matching When lines. If flow.actors spawn sub-agent per account per actors.md or sequential-fallback.</step>
    <step n="1b">Load sessions.sites storageState or userDataDir for origins in flow; enable --caps=storage when needed.</step>
    <step n="2">If any step oracle.network mock is json-server and mocks.jsonServer.enabled start npx json-server on configured port and db before browser steps.</step>
    <step n="3">Assign runId; directory .witness/runs/{runId}/. If reports.har is not off and devtools cap is on, browser_start_tracing per har.md.</step>
    <step n="4">For each When in scenario order, take the JSON step with the same step index. Apply surface resize device or MCP restart if needed.</step>
    <step n="5">If oracle.network mock browser-route register route before navigation per playwright-mock doc.</step>
    <step n="6">Navigate to pages[from].url when required; enforce sites.allowlist; execute hop when step.site and step.hop match crossSite config.</step>
    <step n="6b">Before failing a missing control, invoke witness-captcha; classify captcha before an unknown button. If the control is a native file, save, print, or permission dialog, or a window whose title is not the page, and computer-control tools are connected, follow the native-dialog mode in computer-control.md. Do not click page coordinates while an accessible role exists.</step>
    <step n="7">If the step was not already completed as a native dialog, act via role and action.names on the snapshot.</step>
    <step n="8">Evaluate expect and oracle ui HTTP and oracle.captcha security matrix against live json-server or mocked route. After each step call browser_console_messages and browser_network_requests per har.md when reports.har is always or when evaluating oracle.network.</step>
    <step n="8b">Save per-site session when persist true; write collaborative barrier files when step.barrier set.</step>
    <step n="9">Follow media.md ladder; write media-manifest.json when screenshot, vision, os-screenshot, or ffmpeg frames are used; set step mediaMode and media artifact ids. On a native dialog, mediaMode is os-ocr and evidence quotes the OCR line or the window title.</step>
    <step n="10">Append to result.json: pass only with evidence. On a page step the evidence is a snapshot quote. On a native dialog it is the OCR quote or the window title. Fail with evidence of the gap.</step>
    <step n="11">Do not edit expect skip steps or invent steps.</step>
    <step n="12">On first fail write har-report.json when reports.har is on-fail or always; stop tracing when started; then invoke witness-debug for failure.json unless user asks to continue.</step>
    <step n="13">On full pass write har-report.json when reports.har is always; browser_stop_tracing when tracing was started.</step>
  </steps>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Never mark pass without snapshot evidence in result.json.</rule>
    <rule id="one-when-per-step">Execute one When per JSON step. Do not skip a When or run a JSON step the scenario does not name.</rule>
    <rule id="no-invent">Never add a step not present in the flow JSON.</rule>
  </rules>
  <done>result.json complete for executed steps; failure.json if any fail.</done>
</skill>
