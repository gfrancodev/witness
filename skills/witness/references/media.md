<manual id="witness-media">
  <docs-catalog ref="./docs.md"/>
  <principle>ARIA snapshot evidence remains required on pass and fail when a tree exists. Media artifacts supplement audit; they do not replace expect or heal assertions.</principle>
  <ladder>
    <step order="1" mode="aria-only">
      <tool>browser_snapshot</tool>
      <when>Default for every step. Quote snapshot lines in result.json evidence.</when>
    </step>
    <step order="2" mode="screenshot">
      <tool>browser_take_screenshot</tool>
      <when>Canvas, map, chart, video element, or control missing from snapshot but page is otherwise interactive.</when>
      <output>Save under .witness/runs/{runId}/media/; register in media-manifest.json kind screenshot.</output>
    </step>
    <step order="3" mode="vision">
      <when>Screenshot insufficient; model must inspect image via Playwright MCP vision cap.</when>
      <mcp>Restart or extend args: --caps=devtools,vision and --image-responses allow only for this run or step. Revert after step.</mcp>
      <output>Register kind vision-attachment in media-manifest.json with path from MCP output-dir.</output>
    </step>
    <step order="4" mode="os-ocr">
      <tool>take_screenshot_with_ocr</tool>
      <when>Fast proof on the machine, or regression when the control is a native dialog or a window Playwright cannot read. Read computer-control.md. Skip this step when those tools are not connected.</when>
      <output>Save under .witness/runs/{runId}/media/; register kind os-screenshot and source computer-control. Quote the OCR text in evidence.</output>
    </step>
    <step order="5" mode="ffmpeg">
      <when>Jam or user supplies video; repro needs frame timeline before or alongside browser replay.</when>
      <verify>command -v ffmpeg before use.</verify>
      <output>Extract frames to .witness/runs/{runId}/media/frame-%04d.jpg; cap count with witness.config.json media.maxFramesPerRun.</output>
    </step>
  </ladder>
  <ffmpeg>
    <instruction>Read doc-ref ffmpeg before any flag. Do not invent syntax.</instruction>
    <example purpose="uniform frames">ffmpeg -i "{sourceVideo}" -vf "fps=1" -frames:v {maxFrames} ".witness/runs/{runId}/media/frame-%04d.jpg"</example>
    <example purpose="single moment">ffmpeg -ss {seconds} -i "{sourceVideo}" -frames:v 1 ".witness/runs/{runId}/media/frame-at-{seconds}.jpg"</example>
    <rule>Store only relative paths in JSON. Do not commit large video files into the app repo.</rule>
  </ffmpeg>
  <media-manifest>
    <path>.witness/runs/{runId}/media-manifest.json</path>
    <schema>templates/schemas/media-manifest.schema.json</schema>
    <fields>runId, artifacts with kind screenshot|frame|vision-attachment|os-screenshot, path, source, timeSeconds, width, height, sha256 optional</fields>
  </media-manifest>
  <result-step>
    <field name="mediaMode">aria-only | screenshot | vision | os-ocr</field>
    <field name="media">array of artifact ids matching media-manifest.json artifacts</field>
    <field name="evidence">still required. Quote the ARIA snapshot when a tree exists. On a machine proof, quote the OCR line or the window title.</field>
  </result-step>
  <flow-oracle>
    <field name="oracle.visual.lookFor">strings to seek in screenshot or frames; not pixel-diff product</field>
    <field name="oracle.visual.mediaRequired">when true run must produce media-manifest entries for the step</field>
  </flow-oracle>
  <failure>
    <classification>visual</classification>
    <firstDivergence type="ui" detail="required" mediaRef="optional artifact id from manifest"/>
  </failure>
  <rules>
    <rule id="semantic-first">ARIA role and accessible name, then stable attrs, then structure, vision last.</rule>
    <rule id="no-heal-expect">oracle.visual never changes expect or Then.</rule>
    <rule id="evidence">pass still requires evidence string; media does not waive it.</rule>
  </rules>
</manual>
