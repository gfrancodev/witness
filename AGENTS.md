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
- `/witness:suite`  rodar o comando de unit, integration, mutation ou e2e que o projeto já tem
- `/witness:captcha`  detectar anti-bot; test keys, sessão ou human gate
- `/witness:repro`  Jam URL ou relato; na máquina se o computer-control estiver conectado
- `/witness:debug`  `failure.json`
- `/witness:heal`  só `action.names` + `healing.json`
- `/witness:gaps`  lacunas no grafo e nas camadas de teste
- `/witness:report`  relatório `scenarios`, `coverage` ou `har`
- `/witness:affected`  `git diff` × páginas do fluxo e testes do mesmo módulo

## Rules

- Assertions never heal; locator changes must be auditable in `healing.json`.
- Semantic-first: ARIA role + name → stable attrs → structure → vision last.
- Never mark `pass` without snapshot `evidence` in `result.json`.
- Never invent a step not present in the flow JSON.
- Discover the repo, the diff, and connected tools before asking. Ask only when two hosts disagree, a production write is required, or a tool must be installed.
- Production `readonly`: no purchase, delete, or publish.
- Gherkin é o fluxo exato, um `When` por step; Playwright MCP executa.
