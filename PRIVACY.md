# Privacy

Witness has no application server and does not send usage data to the plugin author.

The agent writes artifacts in the project under test: flow JSON, Gherkin, run results, and optional browser session files under `.witness/sessions/`. Those files stay on the machine that ran the test. Do not commit cookies, storage state, passwords, or captcha tokens.

`witness.config.json` holds URLs, surface names, and paths to session files. It must not hold secrets, cloud tokens, or captcha response values. A public site key may appear in captcha state as an identifier. The response token must not.

Playwright MCP and Jam MCP are separate products. Their network traffic follows those products' own policies. Jam sign-in is the user's Jam account. Lightpanda stays off until the user turns it on, and a cloud browser token must stay in the environment, not in the plugin config.
