---
name: witness-suite
description: Run the project's own unit, integration, mutation, or e2e command and quote its output (/witness:suite).
---

<skill name="witness-suite">
  <purpose>Prove a layer of the test pyramid with the runner the app already has. Do not open the browser for a unit or integration command. Do not install a framework unless the user agrees.</purpose>
  <read>
    <ref path="../witness/references/docs.md"/>
    <ref path="../witness/references/discovery.md"/>
    <ref path="../witness/references/testing.md"/>
    <doc-ref id="test-pyramid"/>
    <doc-ref id="unit-test-bliki"/>
    <doc-ref id="integration-test-bliki"/>
    <doc-ref id="mutation-testing"/>
    <schema path="templates/schemas/suite-result.schema.json"/>
  </read>
  <inputs>
    <input name="layer">unit, integration, mutation, or e2e. If omitted, pick from the diff using testing.md place-risk.</input>
    <input name="writeTest">Only when the user asks for a new test.</input>
  </inputs>
  <steps>
    <step n="1">Discover commands from manifests, CI test jobs, and test file paths in discovery.md and testing.md. Do not invent a runner.</step>
    <step n="2">Write witness.config.json testing.layers.unit, integration, mutation, and e2e. command is the exact script, or null. Set testing.unitRunner to the unit command, or null.</step>
    <step n="3">Choose the layer the user named. If they did not, read discovery.md: the diff, the open files, and the user message. A pure function is unit. A route, repository, or handler is integration. An observed screen stays on /witness:run. Do not ask which layer.</step>
    <step n="4">If that layer command is null, write suite.json status absent and stop. Say the layer is missing. Do not install a dependency until the user says yes. For mutation, read the mutation-testing doc before naming any CLI.</step>
    <step n="5">Run the discovered command. Do not add flags that are not in the project script or that tool's docs.</step>
    <step n="6">Write .witness/runs/{id}/suite.json. status pass only when exit code is 0 and evidence is a literal excerpt of the output. status fail when the exit code is not 0, with that excerpt. For mutation, copy killed, survived, and timeout from the tool report. Do not compute a score the tool did not print.</step>
    <step n="7">If the user asked for a new test, write it in the style of tests already in the repo, for one behavior read in the code or seen in a run. Do not assert a behavior that is in neither. Then run the layer command again and update suite.json.</step>
  </steps>
  <forbidden>Do not start Playwright for unit or integration. Do not rewrite a .feature as a unit test. Do not add Stryker, pytest, Jest, or Testcontainers unless the user agrees.</forbidden>
  <rules>
    <rule id="no-framework">The stack is the app under test.</rule>
    <rule id="no-invent-behavior">A new test locks observed or code-read behavior only.</rule>
    <rule id="evidence">pass requires exit code 0 and a quoted runner excerpt.</rule>
    <rule id="readonly">On readonly production do not POST PUT PATCH DELETE to live APIs.</rule>
    <rule id="no-secrets">Never write secrets into suite.json, tests, or config.</rule>
  </rules>
  <done>suite.json written for the chosen layer, or absent when the project has no command.</done>
</skill>
