# Crew SKILL.md Template (locked)

Copy this shape for every Crew skill. Section order is fixed. Target 90 to 160 lines. The Context Loop (Step 0 and the Final Step) is mandatory in every skill, in every pack, even stateless ones. Read `crew-method.md` before authoring; the loops referenced below are defined there.

Hard rules:
- Frontmatter has `name` and `description` only. `name` MUST equal the folder name exactly: `crew-<pack>-<skill>`.
- No em dashes anywhere (use commas, periods, or parentheses). No AI-slop. Specific nouns over adjectives.
- Never ship a brand name other than Crew. No internal names.
- Every skill has a fixture at `packs/<NN-pack>/tests/<skill>.fixture.md` covering three cases: clean, messy, missing-input.
- The state root is always the home-global `~/.claude/crew-state/`, never a project-relative path. A relative path forks the memory into a second store the other skills never read.

Catalogue conventions (carried by every shipped skill; include them when the skill has the section they live in):
- **Silent mode** (in `## Modes and when to use them`, after the mode bullets): "All three modes run silent by default. The agent suppresses progress, confirmation, and status lines, except the three-line run receipt (context recovered, verdict if a gate ran, handoff written to its path), which always prints after the deliverable. Only the deliverable, the receipt, and genuine blockers (Missing Input, Quality Failure, Escalation) reach the user. To see full commentary, say "verbose" at any time."
- **Silent principle** (the LAST numbered principle in `## How the <role> thinks`): "**Silent by default.** Suppress every line that is not the deliverable or a genuine blocker. The user asked for an output, not a running commentary on how you built it. Progress updates and confirmations stay internal. The run receipt (context recovered, verdict if a gate ran, handoff written) and the Loops always speak."
- The brand hard gate and the context-save prompt are baked into Step 0 and the Final Step in the skeleton below; copy them as written.
- **Sub-skill consult** (skills that other skills consult, review legs and authoring references): honour the literal `CREW CONSULT from crew-<caller>:` preamble per the Crew Method's Sub-skill consult rule: skip the onboarding stop and the context-save prompt, still write your own handoff. Absent the literal preamble, run the full Step 0 including the brand hard stop.

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

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, STOP. Say: "Your business is not onboarded yet. I need to know who you are before I can work. Let us fix that now." Then run the eleven-question brand onboarding conversation inline (the same conversation `crew-core-brand-context` runs) and write the file before going further. This is a hard stop, not a suggestion: do not proceed to this skill's own discovery or workflow until `~/.claude/crew-state/brand-context.md` exists. If the brand context exists but this skill's handoff directory is empty, state: "Brand context found but no prior handoffs. First run in this location. If you expected prior work, check your crew-state path." Then read this skill's own handoff at `~/.claude/crew-state/<pack>/<skill>-handoff.md`. If it exists, load it and state what was recovered. If not, state "No prior context, first run." When a handoff was recovered, state its date; if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. (Loop 4.) If this run was chained from an upstream skill, also read only the handoffs of the skills this skill's Handoffs section names as sources, at most two files; state what was inherited, and record "Consumed: [upstream skill] handoff dated [date]" in this run's own handoff. If a named upstream handoff does not exist, proceed without comment. Never scan the folder outside Governed mode.

1. **<First real step>.** <Sub-steps: a taxonomy/enum with definitions, or a decision fork, or a forcing question asked one at a time.>
2. **<Second step>.** <...>
3. **<...expand the catalogue's 6 bullets into a deterministic process. Where you summarise or recommend, name the specific mechanism, not the category.>**
N. **Verify before emitting.** Re-read the inputs and confirm every requirement is covered. If a gap remains, follow Loop 2 (Quality Failure) before continuing. If a decision is beyond this skill, follow Loop 3 (Escalation).

**Final Step: Handoff Save.** Write `~/.claude/crew-state/<pack>/<skill>-handoff.md` (mkdir -p first) with: output produced, decisions made, unfinished work, what the next skill needs, and any "Learned" note (Loop 5). Always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the content above as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing handoff, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. (Loop 4.) Then prompt: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" If the user says yes, invoke `crew-core-context-save`. If no, note in the handoff: "Context-save declined by user."

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

The smoke test in `qa-check.sh` (run with `--smoke`) seeds a synthetic brand fixture, feeds Case A to the skill with a sanctioned test state root, and asserts the Output-format header appears in the reply and the handoff file was written. A separate negative case runs one skill with no brand fixture and asserts the brand hard gate fires. Cases B and C document the messy and missing-input behaviour for authoring and review; the harness does not execute them.
