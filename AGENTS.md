# Witness

**See it. Test it. Prove it.**

Plugin de QA para Cursor, Claude e Codex. **JSON** guarda páginas, locators e oráculos. **Gherkin** é o fluxo exato, um `When` por step. **Playwright MCP** executa. Não há código de aplicação no plugin.

## Agent commands

- `/witness:init`  entrevista MCP + `witness.config.json` e pastas `.witness/`
- `/witness:explore`  explorar URL, gravar fluxo JSON e o `.feature` correspondente
- `/witness:map`  resumo dos fluxos, cenários e estados desconhecidos
- `/witness:spec`  `.feature` com um `When`/`Then` por step observado
- `/witness:mission`  missão de negócio → fluxo (+ feature se passou)
- `/witness:run`  executar `steps` na ordem; `@critical` filtra
- `/witness:captcha`  detectar anti-bot; test keys, sessão ou human gate
- `/witness:repro`  Jam URL ou relato; na máquina se o computer-control estiver conectado
- `/witness:debug`  `failure.json`
- `/witness:heal`  só `action.names` + `healing.json`
- `/witness:gaps`  lacunas no grafo
- `/witness:report`  relatório `scenarios`, `coverage` ou `har`
- `/witness:affected`  `git diff` × páginas do fluxo

## Rules

- Assertions never heal; locator changes must be auditable in `healing.json`.
- Semantic-first: ARIA role + name → stable attrs → structure → vision last.
- Never mark `pass` without snapshot `evidence` in `result.json`.
- Never invent a step not present in the flow JSON.
- Production `readonly`: no purchase, delete, or publish.
- Gherkin é o fluxo exato, um `When` por step; Playwright MCP executa.
