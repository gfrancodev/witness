---
name: witness-repro
description: Jam URL or narrative reproduced on the machine when computer-control is connected; otherwise Playwright (/witness:repro).
---

<skill name="witness-repro">
  <purpose>Reproduce a reported bug from a Jam URL or a user narrative. Prefer the real machine when computer-control tools are connected. Do not emit Playwright code on that path.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/how.md"/>
    <ref path="../witness/references/computer-control.md"/>
    <doc-ref id="computer-control"/>
    <doc-ref id="getting-started"/>
    <doc-ref id="emulation"/>
    <doc-ref id="capabilities"/>
    <doc-ref id="aria-snapshots"/>
    <doc-ref id="jam-docs"/>
    <doc-ref id="jam-mcp"/>
    <doc-ref id="jam-creating"/>
    <ref path="../witness/references/media.md"/>
    <doc-ref id="ffmpeg"/>
  </read>
  <inputs>
    <input name="jamUrl">Optional pasted Jam URL</input>
    <input name="narrative">Optional text steps url expected outcome</input>
  </inputs>
  <steps>
    <step n="1">When mcps.jam enabled and Jam MCP connected, paste jamUrl and call getDetails then getUserEvents getConsoleLogs getNetworkRequests per jam-mcp doc; use getFrames overview or at for video Jams before Playwright. Else extract url and narrative from user only.</step>
    <step n="2">If video present run ffmpeg per media.md into .witness/runs/{id}/media/ and write media-manifest.json before replay.</step>
    <step n="3">If computer-control tools are connected, follow the proof mode in computer-control.md. Do not start Playwright. list_windows and activate_window on the product window. If it is not open, ask for the URL or the app and stop. OCR before each click, act only on text that screenshot showed, OCR again, and pass only when the new quote matches the expected outcome.</step>
    <step n="3b">If computer-control tools are absent, reproduce with Playwright on the appropriate surface.</step>
    <step n="4">Write .witness/runs/{id}/result.json with evidence. On the machine path, evidence is the OCR quote or the window title, mediaMode os-ocr, and media-manifest kind os-screenshot.</step>
    <step n="5">State conclusion reproduced, not-reproduced, or blocked with reason login captcha_unresolved captcha data environment origin_not_allowlisted window_not_open.</step>
    <step n="6">Write the .feature of what was seen, one When per click, naming the visible text. If the user wants a durable flow after a machine proof, offer witness-explore on Playwright. Do not invent unobserved steps and do not write a Playwright script from the machine path.</step>
  </steps>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="readonly">On readonly production, do not purchase, delete, or publish.</rule>
    <rule id="no-secrets">Never write secrets into flow JSON or .feature files.</rule>
    <rule id="no-heal-expect">Never change expect or Then.</rule>
    <rule id="evidence">Document the OCR quote or the snapshot quote in result.json. A screenshot path alone is not a pass.</rule>
    <rule id="no-captcha-grid">Do not click captcha image grids or call a captcha-breaking service, including with click_screen.</rule>
    <rule id="no-invent">Never add a step not observed during repro.</rule>
  </rules>
  <done>Explicit repro conclusion and run artifacts.</done>
</skill>
