# Fixture: crew-web-app-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. This is the app and automation builder, the backend and pipeline counterpart to the frontend builders in this pack: it ports the five-phase App Builder protocol (Blueprint, Link, Architect, Stylize, Trigger) and the A.N.T. three-layer architecture. It does NOT build a marketing website (that is crew-web-page-builder).

## Case A
INPUT:
Build me a daily data pipeline for "Tidewater Metrics", a fictional fleet-tracking firm. North Star: every morning at 6am, pull yesterday's vehicle telemetry, summarise it, and post the summary to our ops channel. Integrations: a telemetry REST API and a chat webhook, both keys are ready in .env. Source of truth: the telemetry API is the primary data. Delivery payload: a formatted message posted to the ops chat channel. Behavioural rules: never fabricate a metric, mark any missing day as "no data", keep the tone factual. Brand context already onboarded.
EXPECT:
- Step 0: Context Recovery runs first: it checks `~/.claude/crew-state/brand-context.md`. Because the brand is onboarded, the hard gate passes silently (no STOP), and the skill states recovered context from `~/.claude/crew-state/web-design/crew-web-app-builder-handoff.md` or "Brand context found but no prior handoffs. First run in this location."
- Discovery confirms back in one line that all five answers are present (North Star, integrations, source of truth, delivery payload, behavioural rules) before any code.
- Memory files and `app-spec.md` are scaffolded BEFORE any code: the data-first rule holds, the JSON input and output schema is locked in `app-spec.md` first, and coding starts only after the payload shape is fixed.
- The A.N.T. three-layer architecture is built in order: Layer 1 a SOP per tool in `architecture/`, Layer 2 the Navigation reasoning that routes data and sequences the tools, Layer 3 the deterministic scripts in `tools/`, one file per job. LLMs reason, the Python tools execute, the layers stay separate.
- The five phases run in order: Blueprint, Link, Architect, Stylize, Trigger. In Link, each external service (the telemetry API and the chat webhook) is verified with a handshake before full logic is written.
- Behavioural rules are honoured: no metric is fabricated, a missing day is marked "no data", the tone stays factual. Secrets stay in `.env`, intermediates go in `.tmp/`.
- The build report begins with the exact line `APP BUILD PLAN`.
- No em dashes and no en dashes anywhere (text, code comments, JSON, strings).
- Handoff file `~/.claude/crew-state/web-design/crew-web-app-builder-handoff.md` was written.
- Final Step prompts: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" and acts on the answer.

## Case B
INPUT:
Build an invoice-sync automation for a business already onboarded via brand-context.md. North Star: nightly, push approved invoices from our billing API into the accounting system. Integrations: a billing API and an accounting API, keys in .env. Source of truth: the billing API. Delivery payload: rows created in the accounting system. Behavioural rules: soft-write only, never delete. Note: the accounting API credential is wrong and fails on connect.
EXPECT:
- Step 0 reads `~/.claude/crew-state/brand-context.md`, the gate passes, and the skill confirms the brand out loud (who the business is, what it sells, how it sounds) before building.
- Discovery confirms back the five answers, then the data-first rule locks the JSON input and output schema in `app-spec.md` before code.
- The Link phase runs and the accounting API handshake fails. The skill STOPS at the failing link rather than proceeding: it does not move to full logic while any link is broken.
- The failure is logged (the full error, not a guess), and the self-annealing repair loop fires: analyse the full error, patch the tool, test the handshake end to end, then update the matching SOP in `architecture/` so the error never repeats.
- No downstream tool is built on a broken link: the Architect phase for the accounting write waits until the handshake passes, and no soft-write logic runs against a dead connection.
- The build report begins with the exact line `APP BUILD PLAN`, recording the link blocker and the repair applied.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/web-design/crew-web-app-builder-handoff.md` was written, noting the link that failed and the fix.
- Final Step offers to run context-save and records the answer in the handoff.

## Case C
INPUT:
"Just build me an automation."
No North Star given, no integrations named, no source of truth, no delivery payload, no behavioural rules.
EXPECT:
- Loop 1, Missing Input fires. The skill asks the five discovery questions in order: 1 North Star (the singular outcome), 2 Integrations (which external services, keys ready), 3 Source of truth (where the primary data lives), 4 Delivery payload (how and where the result lands), 5 Behavioural rules (tone, logic constraints, do-not rules).
- It scaffolds NO tools and writes no Python until the JSON input and output schema is locked: deterministic logic does not start on a guess.
- It invents no integration, no credential, and no source of truth, and does not scaffold the A.N.T. layers on an assumption.
- The Step 0 brand HARD GATE fires if `~/.claude/crew-state/brand-context.md` does not exist: the skill STOPS, says the business is not onboarded yet, and runs the eleven-question brand onboarding conversation inline, writing `~/.claude/crew-state/brand-context.md` before going further. It does not proceed to its own discovery or workflow until that file exists.
- No `APP BUILD PLAN` report is produced for an automation that was not built.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/web-design/crew-web-app-builder-handoff.md` was written, recording the build as not started and the inputs still needed (the five discovery answers and the locked schema), with no integration or credential assumed.
- Final Step still offers to run context-save.
