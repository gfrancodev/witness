---
name: witness-captcha
description: Detect anti-bot, including an open reCAPTCHA image challenge (bframe / rc-imageselect), and resolve only via test keys, session, or human gate (/witness:captcha).
---

<skill name="witness-captcha">
  <purpose>Captcha Awareness Engine: tell checkbox from an open image challenge, then resolveCaptcha without touching the puzzle. Write captcha-state evidence.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/captcha.md"/>
    <ref path="../witness/references/sessions.md"/>
    <doc-ref id="turnstile-testing"/>
    <doc-ref id="turnstile-server-validation"/>
    <doc-ref id="recaptcha-test-keys"/>
    <doc-ref id="hcaptcha-test-keys"/>
    <schema path="templates/schemas/captcha-state.schema.json"/>
  </read>
  <inputs>
    <input name="runId">Current run under .witness/runs/{runId}/</input>
    <input name="pageId">Page key from flow JSON</input>
    <input name="environment">witness.config.json environment.default or override</input>
    <input name="forceHuman">Optional; override strategy to human for this invocation</input>
  </inputs>
  <steps>
    <step n="1">Read witness.config.json captcha and sessions for active environment.</step>
    <step n="2">browser_snapshot and browser_network_requests. Classify with captcha.md before any click. For reCAPTCHA, separate the anchor checkbox iframe from an open bframe image challenge.</step>
    <step n="3">Score confidence; write or update .witness/runs/{runId}/captcha-state.json. Quote the visible instruction when the snapshot has it. Never store token values.</step>
    <step n="4">If no captcha signals and step not stuck, return continue without gate. A bframe iframe with no visible size is dormant, not a gate.</step>
    <step n="5">If challenge is imageselect or audio, do not use official-test wait-for-autosolve. That grid does not pass by itself. Branch human or BLOCKED_BY_CAPTCHA per captcha.md.</step>
    <step n="6">Otherwise branch resolveCaptcha: official-test mock session human per policy and forceHuman.</step>
    <step n="7">waitForResolution on the parent response field length only, until solved failed expired or timeoutSeconds. Do not read the token inside the challenge frame.</step>
    <step n="8">Snapshot evidence; optional screenshot when captureEvidence true per media.md. The screenshot proves the gate; it is not a puzzle to solve.</step>
    <step n="9">Emit outcome CAPTCHA_SOLVED CAPTCHA_REQUIRED or BLOCKED_BY_CAPTCHA for parent run skill.</step>
    <step n="10">If oracle.captcha on current step evaluate security matrix; security_regression when server accepts without validation.</step>
  </steps>
  <rules>
    <rule id="forbidden-vision">Never use vision cap, tile clicks, or coordinates on an image or audio challenge.</rule>
    <rule id="no-solveCaptcha">Use resolveCaptcha modes only; never third-party breaking services, the audio button, reload, or Verificar.</rule>
    <rule id="no-inner-token">Poll the parent response field length. Never copy #recaptcha-token, bft, or payload query values into captcha-state, flow, or feature.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write captcha tokens into flow JSON or feature files.</rule>
    <rule id="evidence">Parent step pass still requires snapshot evidence in result.json.</rule>
  </rules>
  <done>captcha-state.json updated; outcome code stated to caller.</done>
</skill>
