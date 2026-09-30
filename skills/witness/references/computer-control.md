<manual id="witness-computer-control">
  <docs-catalog ref="./docs.md"/>
  <doc-ref id="computer-control"/>
  <source href="https://github.com/AB498/computer-control-mcp"/>
  <principle>Use this MCP only when its tools are already connected in the session. Playwright remains the regression runner. Computer control drives the real machine for a fast proof, or a native window the DOM snapshot cannot reach. It does not emit Playwright code.</principle>
  <available>
    <when>The session exposes list_windows, activate_window, take_screenshot, take_screenshot_with_ocr, click_screen, type_text, press_keys, drag_mouse, get_screen_size, or wait_milliseconds.</when>
    <config>If those tools exist, set witness.config.json mcps.computerControl.enabled true even when it was false. If enabled is true and the tools are absent, say so and stay on Playwright. Do not install uvx or the package unless the user asks.</config>
  </available>
  <tools>
    <tool name="list_windows">Find the product window already open.</tool>
    <tool name="activate_window">Bring that window forward by title. Read the tool schema before flags.</tool>
    <tool name="take_screenshot">Capture the screen or a window. Save under the run media dir.</tool>
    <tool name="take_screenshot_with_ocr">Read visible text and coordinates. Quote that text in evidence.</tool>
    <tool name="click_screen">Click a point the latest OCR showed. Do not guess a coordinate.</tool>
    <tool name="type_text">Type into the focused field. Never type a password into the flow, the feature, or the result.</tool>
    <tool name="press_keys">Keys and shortcuts the OCR path needs.</tool>
    <tool name="drag_mouse">Only when the observed action is a drag.</tool>
    <tool name="get_screen_size">Know the screen before a click.</tool>
    <tool name="wait_milliseconds">Short wait after a click before the next OCR.</tool>
  </tools>
  <screenshot-dir>
    <env>COMPUTER_CONTROL_MCP_SCREENSHOT_DIR=.witness/runs</env>
    <run>.witness/runs/{runId}/media/</run>
    <manifest>Register kind os-screenshot, source computer-control, in media-manifest.json.</manifest>
  </screenshot-dir>
  <mode id="proof">
    <when>The user wants to prove or reproduce an outcome, without a suite and without Playwright code, and the tools are connected. witness-repro always prefers this. witness-mission uses it when the user asks only for proof. witness-explore offers it when the user does not ask for a durable flow.</when>
    <do-not>Do not start Playwright MCP. Do not emit codegen.</do-not>
    <steps>
      <step n="1">list_windows and activate_window on the product window already open. If it is not open, ask for the URL or the app and stop.</step>
      <step n="2">take_screenshot_with_ocr before every click. The OCR text is the evidence.</step>
      <step n="3">click_screen, type_text, or press_keys only on text this screenshot showed.</step>
      <step n="4">Screenshot again. pass only when the new OCR quote matches the expected outcome.</step>
      <step n="5">Write result.json with status reproduced, not-reproduced, or blocked, and evidence as the OCR quote or the window title.</step>
      <step n="6">Write the .feature of what was seen, one When per click, naming the visible text, not the coordinate. Do not write a Playwright script.</step>
    </steps>
  </mode>
  <mode id="native-dialog">
    <when>witness-run or a durable explore is already on Playwright, and the snapshot cannot reach the control.</when>
    <order>
      <step n="1">browser_snapshot and act by role and accessible name.</step>
      <step n="2">browser_file_upload for an input type file.</step>
      <step n="3">Playwright screenshot when the node is missing but the page is still the browser.</step>
      <step n="4">Computer control for a native file, save, print, or permission dialog; a window whose title is not the page; or a window Playwright returns black, via take_screenshot_with_ocr.</step>
    </order>
    <rule>Do not click page coordinates while an accessible role exists.</rule>
    <gherkin>The When names the dialog or the visible text, not the coordinate.</gherkin>
  </mode>
  <forbidden>
    <rule>Do not click captcha image grids, use captcha audio, or call a captcha-breaking service.</rule>
    <rule>On production readonly, do not confirm purchase, delete, or publish, including in an OS dialog.</rule>
    <rule>Do not type a secret with type_text in order to store it.</rule>
    <rule>Do not invent a click the OCR did not show.</rule>
  </forbidden>
  <evidence>
    <pass>Quote the OCR line or the window title in result.json evidence. A screenshot path alone is not a pass.</pass>
    <mediaMode>os-ocr</mediaMode>
  </evidence>
</manual>
