# Crew SKILL.md Template (locked)

Copy this shape for every Crew skill. Section order is fixed. Target 90 to 160 lines. The Context Loop (Step 0 and the Final Step) is mandatory in every skill, in every pack, even stateless ones. Read `crew-method.md` before authoring; the loops referenced below are defined there.

Hard rules:
- Frontmatter has `name` and `description` only. `name` MUST equal the folder name exactly: `crew-<pack>-<skill>`.
- No em dashes anywhere (use commas, periods, or parentheses). No AI-slop. Specific nouns over adjectives.
- Never ship a brand name other than Crew. No internal names.
- Every skill has a fixture at `packs/<NN-pack>/tests/<skill>.fixture.md` covering three cases: clean, messy, missing-input.

---

## Section order

```
1. Frontmatter            name + description ONLY
2. Title + role opening   # Crew: <Name>, then the expert role
3. Inputs                 what it needs; the missing-input fork (Loop 1)
4. Workflow               Step 0 Context Recovery -> the work -> verification -> Final Step Handoff Save
5. Output format          ONE fenced block: the artifact + a filled example
6. Guardrails             Never... lines (business risk, evidence, house style)
7. Handoffs               sibling crew skills + the Crew Method standards by name
```

The Context Loop is NOT a separate section. It lives inside Workflow as Step 0 and the Final Step.

---

## Skeleton (fill every bracket)

````markdown
---
name: crew-<pack>-<skill>
description: <One sentence on what it does>. <Natural-language triggers: invoke when the user says X, asks for Y, or when Z lands>. (120 to 400 chars, no em dashes.)
---

# Crew: <Skill Name>

You are <a specific expert role>. Your job is <the one thing it produces>, for <who reads the output>. <The cognitive instinct this role brings, stated as "you do X, not Y", e.g. "you work from evidence, not vibes">. You are not <the thing it must not drift into>.

## Inputs

You need:
- <input 1>
- <input 2>

If <a required input> is missing, <ask once / proceed and mark the gap> following Loop 1 (Missing Input). Never invent <this skill's specific fabrication risk: a number, a name, a price, a quote>.

## Workflow

**Step 0: Context Recovery.** Read `.claude/crew-state/<pack>/<skill>-handoff.md`. If it exists, load it and state what was recovered. If not, state "No prior context, first run." (Loop 4.)

1. **<First real step>.** <Sub-steps: a taxonomy/enum with definitions, or a decision fork, or a forcing question asked one at a time.>
2. **<Second step>.** <...>
3. **<...expand the catalogue's 6 bullets into a deterministic process. Where you summarise or recommend, name the specific mechanism, not the category.>**
N. **Verify before emitting.** Re-read the inputs and confirm every requirement is covered. If a gap remains, follow Loop 2 (Quality Failure) before continuing. If a decision is beyond this skill, follow Loop 3 (Escalation).

**Final Step: Handoff Save.** Write `.claude/crew-state/<pack>/<skill>-handoff.md` (mkdir -p first) with: output produced, decisions made, unfinished work, what the next skill needs, and any "Learned" note (Loop 5). Always write it, even with no output ("No output, run completed [date]"). (Loop 4.)

## Output format

```
<ARTIFACT NAME>
<Field>: <...>
<Field>: <...>
```

Example (filled):
```
<a short, realistic filled instance so the output looks finished>
```

## Guardrails

- Never <business risk specific to this skill>.
- Never present an inference as a fact. Label claims, name sources. If you do not know, say so.
- No AI-slop: no filler, no "in today's fast-paced world", no hedging. Specific nouns, current facts.
- Never use em dashes. Use commas, periods, or parentheses.
- If a project playbook exists, it is the authority. Follow it over these defaults.

## Handoffs

- Hand off to `crew-<pack>-<next-skill>` for <the next step in the chain>.
- Before anything ships, run `crew-core-quality-checker`. Pairs with the Crew Method standard "Verify before claiming done".
- To persist work across a long session, the Context Loop already writes the handoff; for a full session save use `crew-core-context-save`.
````

---

## Fixture requirement (Condition 2)

Each skill has one fixture file at `packs/<NN-pack>/tests/<skill>.fixture.md` with three labelled cases:

```
# Fixture: crew-<pack>-<skill>

## Case A: clean
INPUT: <a well-formed, complete scenario>
EXPECT: <output markers/fields that must appear>

## Case B: messy
INPUT: <noisy, partial, or contradictory data>
EXPECT: <how the skill copes: flags, "Assumed", correct taxonomy>

## Case C: missing-input
INPUT: <a required input absent>
EXPECT: <Loop 1 behaviour: names the gap, asks once or marks "Not provided", invents nothing>
```

The smoke test in `qa-check.sh` feeds each case to the skill and asserts the EXPECT markers appear and that the handoff file was written.
