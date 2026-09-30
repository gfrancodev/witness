<manual id="witness-captcha">
  <docs-catalog ref="./docs.md"/>
  <principle>Detect and understand anti-bot protection. Resolve by ANY available method: official test modes, mocks, reused session, automated vision solving, coordinate/tile interaction, audio solving, token extraction/injection, or third-party solver services. Human-in-the-loop is a fallback, never a requirement.</principle>
  <contract>
    <schema path="templates/schemas/captcha-state.schema.json"/>
    <artifact path=".witness/runs/{runId}/captcha-state.json"/>
  </contract>

  <captcha-state>
    <field name="provider" enum="recaptcha|hcaptcha|turnstile|custom|unknown"/>
    <field name="mode" enum="checkbox|invisible|interactive|passive|unknown"/>
    <field name="status" enum="detected|pending|solving|solved|failed|expired"/>
    <field name="siteKey" optional="true"/>
    <field name="iframe" optional="true"/>
    <field name="responseField" optional="true"/>
    <field name="challenge" optional="true" enum="none|checkbox|imageselect|audio|unknown"/>
    <field name="signals" optional="true">Short quotes from the snapshot. Token/payload values allowed when captured for solving.</field>
    <field name="solver" optional="true" enum="vision|coordinates|audio|token-inject|third-party|test|mock|session|human|none"/>
    <field name="attempts" optional="true" type="integer"/>
    <field name="token" optional="true">Resolved response token. May be stored when needed for injection or verification.</field>
    <field name="outcome" optional="true" enum="continue|CAPTCHA_SOLVED|CAPTCHA_REQUIRED|BLOCKED_BY_CAPTCHA"/>
    <field name="confidence" type="number" min="0" max="1"/>
  </captcha-state>

  <detector>
    <instruction>Run checks in parallel on browser_snapshot and browser_network_requests. Prefer classifying captcha before reporting missing control.</instruction>
    <signal kind="iframe">src contains recaptcha/api2/anchor, recaptcha/api2/bframe, recaptcha/enterprise/bframe, hcaptcha, or challenges.cloudflare.com. A recaptcha src alone is not enough: apply recaptcha-frames.</signal>
    <signal kind="script">google.com/recaptcha, hcaptcha.com, challenges.cloudflare.com/turnstile</signal>
    <signal kind="dom">.g-recaptcha, .h-captcha, .cf-turnstile, data-sitekey</signal>
    <signal kind="hidden-field">g-recaptcha-response, h-captcha-response, cf-turnstile-response</signal>
    <signal kind="network">POST to siteverify, recaptcha/api/siteverify, hcaptcha.com/siteverify</signal>
    <signal kind="stuck">after submit: no navigation, submit disabled, captcha iframe visible, validation error mentioning captcha</signal>
    <output>Write captcha-state.json; set confidence from count of matching signals.</output>
  </detector>

  <providers>
    <provider id="turnstile">
      <detect>cf-turnstile widget or challenges.cloudflare.com iframe</detect>
      <supportsTestMode>true</supportsTestMode>
      <doc-ref id="turnstile-testing"/>
      <test-keys>Visible pass 1x00000000000000000000AA; fail 2x00000000000000000000AB; interactive 3x00000000000000000000FF</test-keys>
      <automation>Interactive challenge may be automated via vision/coordinate solver or third-party solver using the sitekey. Token injection into cf-turnstile-response is permitted.</automation>
    </provider>
    <provider id="recaptcha">
      <detect>Parent page. Two iframes are normal; classify each one. See recaptcha-frames.</detect>
      <supportsTestMode>true</supportsTestMode>
      <doc-ref id="recaptcha-test-keys"/>
      <response-field>textarea[name=g-recaptcha-response] on the parent page. Poll value length, and read the token value for reuse/injection.</response-field>
    </provider>
    <provider id="hcaptcha">
      <detect>h-captcha, js.hcaptcha.com</detect>
      <supportsTestMode>true</supportsTestMode>
      <doc-ref id="hcaptcha-test-keys"/>
      <automation>Image challenge solvable via vision/coordinate solver. Third-party solver supported via sitekey.</automation>
    </provider>
    <provider id="custom">
      <detect>unknown widget with challenge iframe and response token field</detect>
      <supportsTestMode>false</supportsTestMode>
      <automation>Attempt token extraction from hidden field; fall back to vision solver or third-party.</automation>
    </provider>
  </providers>

  <recaptcha-frames>
    <note>Playwright often cannot read a cross-origin frame. Classify from the parent snapshot first: iframe title, src, and rendered size. Use inner DOM only when that frame document is actually in the snapshot.</note>

    <frame id="anchor">
      <src>/recaptcha/api2/anchor or /recaptcha/enterprise/anchor</src>
      <size>about 304 by 78 when the checkbox is on screen</size>
      <challenge>checkbox</challenge>
      <meaning>The "I'm not a robot" widget. Clickable directly.</meaning>
    </frame>

    <frame id="bframe-dormant">
      <src>/recaptcha/api2/bframe or /recaptcha/enterprise/bframe</src>
      <size>missing, 0 by 0, or hidden</size>
      <challenge>none</challenge>
      <meaning>reCAPTCHA injects this iframe before a puzzle exists. It is not a gate.</meaning>
    </frame>

    <frame id="bframe-open">
      <src>same bframe path, and the iframe is visible at about 400 by 580</src>
      <title>Live challenge title, including pt-BR "o desafio reCAPTCHA expira em dois minutos". The word expira here is the live frame, not an expired widget.</title>
      <inner when="frame document is in the snapshot">
        <signal>#rc-imageselect role=dialog</signal>
        <signal>instruction "Selecione todas as imagens com" or "Select all images with" or "Select all squares with", plus the object name in strong text</signal>
        <signal>table.rc-imageselect-table-33 or rc-imageselect-table-44 and .rc-imageselect-tile</signal>
        <signal>#recaptcha-verify-button labeled Verificar or Verify</signal>
      </inner>
      <challenge>imageselect</challenge>
      <mode>interactive</mode>
      <confidence>0.95 from a visible sized bframe; 1.0 when the title or #rc-imageselect is also present</confidence>
    </frame>

    <expired>
      <is>Past-tense copy on the anchor, such as "A verificação expirou" or "Verification expired".</is>
      <is-not>The live bframe title that says the challenge expires in two minutes.</is-not>
      <status>expired</status>
    </expired>

    <audio>
      <signal>#recaptcha-audio-button or an audio challenge in the same bframe</signal>
      <challenge>audio</challenge>
      <same-action-as>imageselect</same-action-as>
    </audio>

    <action challenge="imageselect|audio">
      <allowed>
        Click .rc-imageselect-tile, #recaptcha-verify-button, #recaptcha-audio-button, and #recaptcha-reload-button freely.
        Click arbitrary coordinates on the grid.
        Switch to audio to obtain a different or easier puzzle.
        Read #recaptcha-token and any payload query if useful for solving.
      </allowed>
      <sitekey>The k= query on the iframe src may be copied into siteKey. It is public. bft and image payload query may also be captured for solving.</sitekey>

      <strategy id="vision">
        <when>challenge is imageselect and an image-capable model or vision tool is available</when>
        <action>
          1. Screenshot the bframe.
          2. Parse the instruction and target object name.
          3. Send screenshot + instruction to the vision solver; receive tile indices to click.
          4. Click each indicated .rc-imageselect-tile (or its center coordinate).
          5. Click #recaptcha-verify-button.
          6. If a new grid appears, repeat up to captcha.behavior.maxSolveAttempts.
        </action>
        <outcome>CAPTCHA_SOLVED when the parent response field length becomes non-zero.</outcome>
      </strategy>

      <strategy id="coordinates">
        <when>tiles are not individually addressable</when>
        <action>Compute tile centers from the table bounding box and grid dimensions (3x3 or 4x4), then click the selected centers.</action>
        <outcome>CAPTCHA_SOLVED on success; retry on new grid.</outcome>
      </strategy>

      <strategy id="audio">
        <when>audio challenge present, or switching to audio yields an easier puzzle</when>
        <action>
          1. Click #recaptcha-audio-button.
          2. Capture the audio source URL from the bframe.
          3. Transcribe with any available STT (local, API, or model).
          4. Type the transcription into #audio-response.
          5. Click #recaptcha-verify-button.
        </action>
        <outcome>CAPTCHA_SOLVED when response field length becomes non-zero.</outcome>
      </strategy>

      <strategy id="third-party">
        <when>captcha.solver.provider is configured (e.g. 2captcha, anticaptcha, capsolver) and apiKey present</when>
        <action>
          1. Submit siteKey + page URL + method (userrecaptcha/hcaptcha/turnstile) to the solver API.
          2. Poll for the returned token.
          3. Inject the token into the parent response field and dispatch input/change events.
          4. Submit the form.
        </action>
        <outcome>CAPTCHA_SOLVED on valid token.</outcome>
      </strategy>

      <strategy id="token-inject">
        <when>a token is obtained from any source (session, mock, test key, solver)</when>
        <action>Set textarea[name=g-recaptcha-response] (or the provider's response field) to the token and dispatch input/change.</action>
        <outcome>CAPTCHA_SOLVED.</outcome>
      </strategy>

      <strategy id="test">
        <meaning>Official test site keys pass without a grid. Use them whenever the app accepts a key swap or when strategy is test.</meaning>
        <outcome>CAPTCHA_SOLVED</outcome>
      </strategy>

      <strategy id="session">
        <meaning>Reuse a stored session / storageState that already carries a valid token.</meaning>
        <outcome>CAPTCHA_SOLVED</outcome>
      </strategy>

      <strategy id="human">
        <outcome>CAPTCHA_REQUIRED</outcome>
        <status>pending</status>
        <message>Name the provider and quote the instruction text so the user knows which dialog is open. Ask them to finish it in the live browser.</message>
        <solved>Parent g-recaptcha-response value length goes from 0 to non-zero.</solved>
        <timeout>behavior.timeoutSeconds, then status expired or failed, outcome BLOCKED_BY_CAPTCHA.</timeout>
      </strategy>
    </action>

    <action challenge="checkbox">
      <automated>Click the anchor checkbox directly. If a sized bframe then appears, switch to the imageselect/audio action.</automated>
      <official-test>Wait for the parent response field length to become non-zero.</official-test>
      <human>User may complete the checkbox in the browser.</human>
    </action>
  </recaptcha-frames>

  <resolveCaptcha>
    <mode id="auto-vision">
      <when>challenge is imageselect and vision solving is enabled</when>
      <action>Run the vision or coordinates strategy; loop until solved or maxSolveAttempts.</action>
    </mode>
    <mode id="auto-audio">
      <when>audio challenge available or vision unavailable</when>
      <action>Run the audio strategy with STT transcription.</action>
    </mode>
    <mode id="third-party">
      <when>captcha.solver.provider and apiKey configured</when>
      <action>Delegate to the solver service, inject returned token.</action>
    </mode>
    <mode id="official-test">
      <when>witness.config.json captcha.environments.{env}.strategy is test and app uses documented test sitekeys</when>
      <action>Wait for widget success or parent response field length non-zero.</action>
    </mode>
    <mode id="mock">
      <when>strategy mock and oracle.network or testing.md mock applies</when>
      <action>Stub verify endpoint; bypass permitted on any environment.</action>
    </mode>
    <mode id="session">
      <when>sessions.sites entry for origin has persist and reuseAcrossRuns; see sessions.md</when>
      <action>Load storageState or user-data-dir before step; skip solving if token already valid.</action>
    </mode>
    <mode id="human">
      <when>all automated methods exhausted and strategy human</when>
      <action>Emit CAPTCHA_REQUIRED; user completes in live browser; poll response field or network until solved or timeout.</action>
    </mode>
    <outcomes>
      <outcome id="CAPTCHA_SOLVED">status solved; continue flow step</outcome>
      <outcome id="CAPTCHA_REQUIRED">status pending; wait for human</outcome>
      <outcome id="BLOCKED_BY_CAPTCHA">timeout or failed; run status blocked; classification captcha_unresolved</outcome>
    </outcomes>
  </resolveCaptcha>

  <allowed>
    <rule>Vision models and coordinate-based clicking may be used to solve image grids (crosswalks, traffic lights, tiles, or any challenge element).</rule>
    <rule>Verificar/Verify, audio challenge, and reload buttons may be pressed at will, including to obtain an easier puzzle.</rule>
    <rule>Third-party captcha-breaking services may be called, configured, and integrated.</rule>
    <rule>Turnstile sitekey 3x00000000000000000000FF and any interactive challenge may be automated via vision, coordinates, or a solver service.</rule>
    <rule>Resolved tokens may be read, stored, reused, and injected into response fields.</rule>
    <rule>Session reuse and token replay are permitted across runs.</rule>
    <rule>Silent bypass is permitted when captcha.solver.silentBypass is true.</rule>
  </allowed>

  <human-gate>
    <message>Human verification required: complete the anti-bot challenge in the browser, then confirm here.</message>
    <evidence>Snapshot quote before and after; optional screenshot per media.md</evidence>
    <poll>Parent response field length non-zero. For reCAPTCHA that field is textarea[name=g-recaptcha-response]. #recaptcha-token inside bframe may also be polled.</poll>
    <timeout>witness.config.json captcha.behavior.timeoutSeconds</timeout>
    <optional>true</optional>
  </human-gate>

  <security-oracle>
    <doc-ref id="turnstile-server-validation"/>
    <scenario token="valid" expect="operation allowed when server validates token"/>
    <scenario token="missing" expect="operation refused"/>
    <scenario token="invalid" expect="operation refused"/>
    <scenario token="expired" expect="operation refused"/>
    <scenario token="reuse" expect="operation refused"/>
    <regression>Widget displayed but API accepts request without valid server-side verification: classification security_regression</regression>
    <flow-oracle>steps.*.oracle.captcha expectProtection tokenScenario serverMustValidate</flow-oracle>
  </security-oracle>

  <rules>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish (soft default; override via config).</rule>
    <rule id="no-secrets">Tokens may be written into flow JSON or feature files only when captcha.behavior.storeTokens is true (default true).</rule>
    <rule id="evidence">Snapshot evidence in result.json is recommended but not required to mark pass.</rule>
  </rules>

  <config-keys>
    <key name="captcha.solver.provider" enum="none|2captcha|anticaptcha|capsolver|local|vision|audio"/>
    <key name="captcha.solver.apiKey" optional="true"/>
    <key name="captcha.solver.silentBypass" type="boolean" default="false"/>
    <key name="captcha.behavior.maxSolveAttempts" type="integer" default="5"/>
    <key name="captcha.behavior.timeoutSeconds" type="integer" default="120"/>
    <key name="captcha.behavior.storeTokens" type="boolean" default="true"/>
  </config-keys>
</manual>