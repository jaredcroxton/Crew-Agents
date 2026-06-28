# Fixture: crew-project-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear, and that the handoff file was written.

## Case A: clean
INPUT:
Build an automation. Goal: every morning at 7am Brisbane, scrape a public review listing and write a dated summary to a Google Doc. Integrations: Firecrawl for the scrape, Google for the Doc, both keys are ready. Source of truth: the listing URL I will provide. Delivery: a new dated doc per run. Rules: no auto-reply, no invented contact details, a human approves every drafted reply.
EXPECT:
- Output begins with "PROJECT BUILD PLAN" with Project, Phase, Status fields.
- The scaffold is listed: CLAUDE.md, memory/ (task_plan, findings, progress, decisions), architecture/, execution/, .tmp/, .env.example.
- The five discovery answers are recorded, and the data schema is noted as locked in CLAUDE.md before any code.
- Next phase named (Link). No real credential value is written into .env.example, placeholders only.
- Handoff file `~/.claude/crew-state/infrastructure/crew-project-builder-handoff.md` was written.
- No em dashes anywhere.

## Case B: messy
INPUT:
Spin up a new tool that posts a daily digest to Slack. I know I need a Slack webhook and an OpenAI key but I do not have either yet. The data is in a Postgres table somewhere, I will confirm the connection later.
EXPECT:
- The skill scaffolds the structure and writes .env.example listing the required keys as placeholders, with no real values.
- Missing credentials are flagged as blocked (Phase 2 Link cannot pass), and the build halts at the credential gate rather than proceeding to full logic.
- No API key, webhook URL, or database connection string is invented.
- The unconfirmed Postgres source is recorded as "to confirm", not guessed.
- Handoff file written, recording the blocked credentials and the phase reached.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
Scaffold a project for me.
EXPECT:
- The skill asks the five discovery questions one at a time (North Star, Integrations, Source of truth, Delivery payload, Behavioural rules), waiting for each answer.
- It does not write any Python or lock a schema until discovery is answered and the data schema is filled in (Loop 1, Missing Input).
- It does not invent a goal, an integration, or a data source.
- STATUS is not complete (NEEDS_CONTEXT or BLOCKED) because the build cannot proceed without discovery.
- Handoff file written, recording the build as not started and discovery as the blocking gate.
- No em dashes anywhere.
