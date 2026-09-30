# Changelog

## 0.1.0

First release of the Witness QA plugin for Cursor, Claude, and Codex.

- Records only observed steps in flow JSON and writes the exact Gherkin journey, one When per step.
- Skills for init, explore, map, spec, mission, run, captcha, repro, debug, heal, gaps, report, and affected.
- Proves behavior with Playwright MCP. When computer-control is already connected, a fast proof runs on the machine without Playwright code.
- QA agent, Cursor session-start hook, and templates for Playwright, Jam, and optional computer-control.
- JSON schemas for config, flows, results, failures, captcha state, HAR, and media.
- Marketplace catalogs for Claude Code and Codex, and the Cursor plugin manifest.
