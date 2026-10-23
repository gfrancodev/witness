<manual id="witness-plane">
  <docs-catalog ref="./docs.md"/>
  <doc-ref id="plane-skills"/>
  <doc-ref id="plane-mcp"/>
  <doc-ref id="plane-mcp-dev"/>
  <replaces>Jira work items and Confluence pages. Do not create, search, or update Jira issues or Confluence pages.</replaces>
  <instance>
    <baseUrl>https://plane.nashdigital.com.br</baseUrl>
    <workspaceSlug>nash</workspaceSlug>
    <projectId>e8606777-bc6e-45d8-ae26-2b0170bc1d5a</projectId>
    <modulesUrl>https://plane.nashdigital.com.br/nash/projects/e8606777-bc6e-45d8-ae26-2b0170bc1d5a/modules/</modulesUrl>
    <rule>This Plane is self-hosted. Do not call https://mcp.plane.so. That host only reaches Plane Cloud.</rule>
  </instance>
  <mcp>
    <when-connected>If Plane tools such as workitem or page are already in the session, use them. Read each tool description before the action argument. Do not invent tool names.</when-connected>
    <stdio>When they are not connected, merge the plane block from agents/mcp.optional.json. The user sets PLANE_API_KEY in that env block on their machine. Never write the key into witness.config.json, a flow, a feature, or git.</stdio>
    <command>uvx plane-mcp-server stdio</command>
    <env>
      <key>PLANE_BASE_URL</key>
      <value>https://plane.nashdigital.com.br</value>
      <key>PLANE_WORKSPACE_SLUG</key>
      <value>nash</value>
    </env>
  </mcp>
  <skills>
    <doc>https://docs.plane.so/ai/ai-skills</doc>
    <rule>A Plane skill is a slash command inside Plane AI, with variables such as work item, project, module, and page. Witness does not invent skill instructions. When the user names a Plane skill, do the same outcome through the Plane MCP if those tools are connected. Do not pretend the slash command ran inside Plane AI.</rule>
  </skills>
  <write>
    <work-item>Create or update a work item in projectId. Title is the failing intent or the bug. Description quotes evidence, the Then line, and firstDivergence. Do not paste cookies, tokens, or passwords.</work-item>
    <page>Create a page in the same project with the scenario report or the repro conclusion, and link it to the work item. The page is the evidence note. It does not replace result.json.</page>
    <module>List modules in the project before choosing one. Use a module the list returned. If none matches, leave the work item on the project and say so.</module>
  </write>
  <absent>If Plane tools are missing and the user has not set PLANE_API_KEY, write the local JSON and say Plane is not connected. Do not invent a work item id.</absent>
</manual>
