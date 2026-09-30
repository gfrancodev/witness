<gherkin id="witness-gherkin">
  <authority>The .feature file is the exact journey in order. Flow JSON stores pages, locators, expect, and oracle so Playwright MCP can act. Gherkin is not a runner. A flow without a matching .feature is incomplete. A .feature that collapses several clicks into one When is incomplete.</authority>
  <docs-catalog ref="./docs.md"/>
  <doc-ref id="gherkin-reference"/>
  <doc-ref id="gherkin-languages"/>
  <template flow="templates/flows/checkout.json" feature="templates/features/checkout.feature"/>
  <shape>
    <rule>Start with # language matching the product UI. Checkout examples use pt.</rule>
    <rule>Feature names the journey. The description under Feature states the exact outcome in one or two sentences.</rule>
    <rule>One Scenario per exact path: one surface, one actor, one outcome. A second surface or actor is another Scenario, not a tag on a collapsed story.</rule>
    <rule>Background states the first screen as the user sees it: page title, path, and the visible region name. No CSS, no JSON.</rule>
    <rule>Each flow step becomes its own When plus Then, in the same order as steps[]. When names the accessible role and the observed accessible name. Then is the expect phrase, unchanged.</rule>
    <rule>And after Then only restates text already in oracle.ui.visible. And never hides another click.</rule>
    <rule>Under each When, comments record intent, surface, flow id, and step index. Comments do not replace a missing When.</rule>
    <rule>count(When) must equal count(steps) for that Scenario. If they differ, rewrite the feature from the flow before any run.</rule>
    <rule>Do not invent a When for a step that is not in the flow JSON. Do not leave a JSON step without a When.</rule>
    <rule>Security matrices such as templates/features/security/captcha.feature stay outcome scenarios. They do not replace the journey feature.</rule>
  </shape>
  <feature-example>
    <when>clico no botão "Confirmar pagamento"</when>
    <comment># intent: confirm_payment</comment>
    <comment># surface: desktop</comment>
    <comment># flow: checkout</comment>
    <comment># step: 1</comment>
    <then>vejo a confirmação do pedido</then>
    <constraint>No CSS selectors, test ids, or JSON fragments in Gherkin.</constraint>
  </feature-example>
  <sync>
    <rule>witness-explore and witness-mission write or refresh the .feature in the same session as the flow JSON.</rule>
    <rule>witness-spec is the only writer of scenario text. Other skills call it instead of drafting a summary.</rule>
    <rule>witness-heal may update a When that quotes a renamed accessible name. It never changes Then or expect.</rule>
  </sync>
  <oracle>
    <ui>Then and And quote text, heading, or URL the snapshot must show.</ui>
    <network>The HTTP check stays in oracle.network. Gherkin may say the visible result of that call, not the status code table.</network>
  </oracle>
  <rules>
    <rule id="no-heal-expect">Then equals expect; never change either.</rule>
    <rule id="one-when-per-step">One When per JSON step. Never summarize a path.</rule>
    <rule id="evidence">pass requires evidence.</rule>
    <rule id="no-invent">Only steps that exist in flow JSON.</rule>
  </rules>
</gherkin>
