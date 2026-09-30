# Contributing to Witness

Witness is a QA plugin. It has no application code. Skills tell the agent what to record, Gherkin states the exact journey, and Playwright MCP (or computer-control, when that MCP is already connected) proves what was seen.

## Ways to contribute

- Report a skill that invents a step, marks pass without evidence, or heals an assertion.
- Improve a skill, a template, a JSON schema, or the docs.
- Add an example under `templates/` that matches a schema already in the repo.

Open an issue before a large change to the contract (`flow` JSON, `result.json`, or the shape of a `.feature`).

## Rules that contributions must keep

- One `When` and one `Then` per observed step, in the same order as the flow JSON. Do not collapse a path into a single step.
- Flow JSON stores pages, locators, `expect`, and oracles. Gherkin does not run the browser.
- Never heal `expect` or a Gherkin `Then`. Locator name changes belong in `healing.json`.
- Never mark `pass` without evidence: a snapshot quote, or an OCR quote on a machine proof.
- Never invent a step that was not observed.
- Never write secrets, cookies, tokens, or passwords into skills, flows, features, or config.
- Never click captcha image grids or call a captcha-breaking service.
- Production `readonly`: no purchase, delete, or publish.
- Do not add application code, a Go module, or a shipped binary. The package check fails if those appear under `dist/plugin`.

## Change a skill

1. Say which command should behave differently (`/witness:run`, `/witness:repro`, and so on).
2. Point at the current step in `skills/` that causes the gap.
3. Edit that skill, and the reference it reads (`skills/witness/references/`), together.
4. If the contract changes, update the schema in `templates/schemas/` and an example under `templates/runs/` or `templates/flows/`.
5. Run:

```bash
make test-plugin
```

Keep one concern per pull request.

## Version and release

Maintainers publish. Do not bump the version inside a behavior-only pull request.

1. Bump [`VERSION`](VERSION) and the `version` field in each `plugin.json`.
2. Add the same version to [`CHANGELOG.md`](CHANGELOG.md).
3. Run `make test-plugin`.
4. Tag `vX.Y.Z` and push. The release workflow attaches `dist/witness-plugin_X.Y.Z.zip`.

Do not rename the plugin `witness`. Installs are stored under that name.

## Local check before a marketplace listing

Copy the checkout to `~/.cursor/plugins/local/witness` as a real directory, not a symlink that points outside that folder. Reload Cursor and confirm the skills, the `witness` agent, and the session-start hook.

Claude Code: `claude plugin validate --strict .`

Privacy expectations are in [`PRIVACY.md`](PRIVACY.md). The license is [MIT](LICENSE).
