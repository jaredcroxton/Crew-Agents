# Crew SKILL.md Template (locked)

Copy this shape for every Crew skill. Section order is fixed. Target 180 to 240 lines. The Context Loop (Step 0 and the Final Step) is mandatory in every skill, in every pack, even stateless ones. Read `crew-method.md` before authoring; the loops referenced below are defined there.

Hard rules:
- Frontmatter has `name` and `description` only. `name` MUST equal the folder name exactly: `crew-<pack>-<skill>`.
- No em dashes anywhere (use commas, periods, or parentheses). No AI-slop. Specific nouns over adjectives.
- Never ship a brand name other than Crew. No internal names.
- Every skill has a fixture at `packs/<NN-pack>/tests/<skill>.fixture.md` covering three cases: clean, messy, missing-input.
- The state root is always the home-global `~/.claude/crew-state/`, never a project-relative path. A relative path forks the memory into a second store the other skills never read.
- The chat Completion block is verbatim `STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT` (crew-method Loop 4 rule 10); the QA harness enforces it.

Catalogue conventions (carried by every shipped skill; the silent-mode paragraph and the silent principle are mandatory, not optional):
- **Silent mode** (in `## Modes and when to use them`, after the mode bullets, mandatory): "All three modes run silent by default. The agent suppresses progress, confirmation, and status lines, except the three-line run receipt (context recovered, verdict if a gate ran, handoff written to its path), which always prints after the deliverable. Only the deliverable, the receipt, and genuine blockers (Missing Input, Quality Failure, Escalation) reach the user. To see full commentary, say "verbose" at any time."
- **Silent principle** (the LAST numbered principle in `## How the <role> thinks`, mandatory): "**Silent by default.** Suppress every line that is not the deliverable or a genuine blocker. The user asked for an output, not a running commentary on how you built it. Progress updates and confirmations stay internal. The run receipt (context recovered, verdict if a gate ran, handoff written) and the Loops always speak."
- The brand hard gate and the context-save prompt are baked into Step 0 and the Final Step in the skeleton below; copy them as written.
- **Sub-skill consult** (skills that other skills consult, review legs and authoring references): honour the literal `CREW CONSULT from crew-<caller>:` preamble per the Crew Method's Sub-skill consult rule: first check `~/.claude/crew-state/brand-context.md` exists (an absent file voids the preamble), then skip the onboarding stop and the context-save prompt, still write your own handoff. Absent the literal preamble, run the full Step 0 including the brand hard stop.

---

## Section order

```
1.  Frontmatter               name + description ONLY
2.  Title + role opening      # Crew: <Name>, then the expert role
3.  Discovery                 the ways in (fresh / continuing via own record / brand on file) + the pre-work
4.  Inputs                    what it needs; the missing-input fork (Loop 1)
5.  Modes and when to use them  Fast / Careful / Governed + the silent-mode paragraph (mandatory)
6.  How the <role> thinks     numbered principles; "Silent by default" is always the last one
7.  Workflow                  Step 0 Context Recovery -> the work -> verification -> Final Step Record Save
8.  Output format             ONE fenced block: the artifact + a filled example
9.  Decision briefs           the conservative call for each genuinely ambiguous case
10. Guardrails                Never... lines (business risk, evidence, house style)
11. Handoffs                  sibling crew skills + the Crew Method standards by name
12. Plan mode                 what plan mode reads and drafts, and every write it defers
13. Verification              the checklist confirmed before the run is marked done
14. Completion                the chat STATUS block (crew-method Loop 4 rule 10, verbatim)
```

The Context Loop is NOT a separate section. It lives inside Workflow as Step 0 and the Final Step. A skill may add named body sections between How the <role> thinks and Workflow (a taxonomy, a sequence, a grading rubric) when the method needs them.

---

## Skeleton (fill every bracket)

````markdown
---
name: crew-<pack>-<skill>
description: <One sentence on what it does>. <Natural-language triggers: invoke when the user says X, asks for Y, or when Z lands>. (120 to 400 chars, no em dashes.)
---

# Crew: <Skill Name>

You are <a specific expert role>. Your job is <the one thing it produces>, for <who reads the output>. <The cognitive instinct this role brings, stated as "you do X, not Y", e.g. "you work from evidence, not vibes">. You are not <the thing it must not drift into>.

## Discovery

Before the work starts, know which way in this run is. There are three.

- **Starting fresh.** No prior context for this skill. Run Step 0 (Context Recovery) to load the brand, then confirm the pre-work below.
- **Continuing via this skill's own record.** Run `crew-core-context-restore` (or name the project) and read this skill's record in that project; state what you recovered and carry the open items forward rather than starting cold.
- **An existing brand via brand-context.md.** The business is already onboarded. Read `~/.claude/crew-state/brand-context.md`, confirm the business out loud ("Working with [brand]. [Product]. [Audience]. Voice: [tone]."), and work in the terms that business uses.

Then confirm the pre-work, one line each: <the two or three facts this skill must have straight before it spends the run>.

## Inputs

You need:
- <input 1>
- <input 2>

If <a required input> is missing, <ask once / proceed and mark the gap> following Loop 1 (Missing Input). Never invent <this skill's specific fabrication risk: a number, a name, a price, a quote>.

## Modes and when to use them

- **Fast mode:** <the quick path for a small clear case, and which checks it skips; name the integrity checks that survive Fast and are never lighter; name when to abandon Fast and finish in Careful>.
- **Careful mode (default):** <the full process, end to end>.
- **Governed mode:** <the full process, plus the cross-reference against prior records in this project (`~/.claude/crew-state/projects/<project>/`) and the house-convention enforcement; use where the output becomes a reference others rely on>.

All three modes run silent by default. The agent suppresses progress, confirmation, and status lines, except the three-line run receipt (context recovered, verdict if a gate ran, handoff written to its path), which always prints after the deliverable. Only the deliverable, the receipt, and genuine blockers (Missing Input, Quality Failure, Escalation) reach the user. To see full commentary, say "verbose" at any time.

## How the <role> thinks

1. **<Principle 1>.** <The instinct, stated concretely.>
2. **<Principle 2>.** <...>
N. **Silent by default.** Suppress every line that is not the deliverable or a genuine blocker. The user asked for an output, not a running commentary on how you built it. Progress updates and confirmations stay internal. The run receipt (context recovered, verdict if a gate ran, handoff written) and the Loops always speak.

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, STOP. Say: "Your business is not onboarded yet. I need to know who you are before I can work. Let us fix that now." Then run the eleven-question brand onboarding conversation inline (the same conversation `crew-core-brand-context` runs) and write the file before going further. This is a hard stop, not a suggestion: do not proceed to this skill's own discovery or workflow until `~/.claude/crew-state/brand-context.md` exists. Next, read this skill's lessons file at `~/.claude/crew-state/lessons/<skill>-lessons.md` if it exists, and apply every lesson in it as a standing rule for this run. Then settle the project (Loop 4): if the request is a pure question with nothing to build, skip the project question; settle a project only when real work starts. If `~/.claude/crew-state/active-project` is already set, confirm it in one line ("Continuing in project <name>") instead of asking; ask the question only when no active project exists and the request does not name one. Otherwise, if the request does not already answer it, ask once: "Is this a new project, or are we continuing an existing one?" For a NEW project, take a short name from the request or ask for one ("websites", "learnos", a client name all work), create `~/.claude/crew-state/projects/<project>/`, write the name to `~/.claude/crew-state/active-project`, and start from zero: the brand context and the lessons file are the whole context, read nothing else. For CONTINUING, the user runs `crew-core-context-restore` first (or names the project): read the `~/.claude/crew-state/active-project` pointer, then ONLY this skill's own record at `~/.claude/crew-state/projects/<project>/<skill>-handoff.md`; state what was recovered and its date, and if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. If the record does not exist in that project, state "No prior record in this project for this skill." Records in other projects, and legacy handoffs from before the Projects model, are never read automatically. (Loop 4, Context Change.) If this run was chained from an upstream skill, also read only the records of the skills this skill's Handoffs section names as sources, from the same active project, at most two files; state what was inherited, and record "Consumed: [upstream skill] record dated [date]" in this run's own record. If a named upstream record does not exist in the project, proceed without comment. Never scan outside the active project outside Governed mode.

1. **<First real step>.** <Sub-steps: a taxonomy/enum with definitions, or a decision fork, or a forcing question asked one at a time.>
2. **<Second step>.** <...>
3. **<...expand the catalogue's 6 bullets into a deterministic process. Where you summarise or recommend, name the specific mechanism, not the category.>**
N. **Verify before emitting.** Re-read the inputs and confirm every requirement is covered. If a gap remains, follow Loop 2 (Quality Failure) before continuing. If a decision is beyond this skill, follow Loop 3 (Escalation).

**Final Step: Record Save.** Confirm the active project: read `~/.claude/crew-state/active-project`. If no project was named this run, ask for a name only if something worth keeping was produced; otherwise skip the write and say so in the receipt. Write `~/.claude/crew-state/projects/<project>/<skill>-handoff.md` (mkdir -p first) with: output produced, decisions made, unfinished work, what the next skill needs, and any "Learned" note (Loop 5). When a project is active, always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the content above as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing record in the same project, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. Records in other projects are other work: never merged into this one and never overwritten by it. If the handoff write is denied or fails, retry once; if it still fails, do not fake success: print the full handoff body inline in the run receipt under the literal heading "STAGED HANDOFF (write denied)" so the user can save it, and mark STATUS: BLOCKED. After a successful write, re-read the file and confirm the frame is present (the title line, the Date line, and a STATUS from the sanctioned list); fix it before finishing if not. If this run captured a durable way-of-working lesson (not a project or brand fact), offer once: "Want me to save this lesson so it never happens again?" On yes, append one dated bullet (what went wrong, what to do instead) to `~/.claude/crew-state/lessons/<skill>-lessons.md`, creating the file if absent; it is read at every Step 0 and never leaves this machine (Loop 5, the lesson offer). A Loop 1 or Loop 3 pause counts as finishing for the Context Loop: write the handoff FIRST (STATUS: BLOCKED, the gap or escalation named), then ask and wait. (Loop 4 and Loop 5.) Then prompt: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" If the user says yes, invoke `crew-core-context-save`. If no, note in the handoff: "Context-save declined by user."

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

## Decision briefs

When a call is genuinely ambiguous, make the conservative call below rather than guessing.

- **<Ambiguous case 1>.** <The conservative call and why.>
- **<Ambiguous case 2>.** <...>

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

## Plan mode

In plan mode this skill reads the brand context and its own prior record and DRAFTS the deliverable for discussion, marked "(DRAFT, plan mode)". It does NOT write to `~/.claude/crew-state/` (no record, no pointer, no lesson append) and does NOT <this skill's irreversible action: send, deploy, publish, edit the work>. The record save runs only after plan mode is exited.

## Verification

Before the run is marked done, confirm:

```
[ ] <requirement 1 from the brief is covered>
[ ] <requirement 2>
[ ] The record was written into the active project (~/.claude/crew-state/projects/<project>/<skill>-handoff.md)
[ ] No em dashes anywhere in the output
```

## Completion

If <nothing real could be produced: the required input never arrived, the Loop 1 ask returned nothing>, set STATUS NEEDS_CONTEXT or BLOCKED, never DONE, so an empty scaffold is not mistaken for real output. If the output was delivered with named items open (a "Not provided" field, an Escalated call), set DONE_WITH_GAPS, never a clean DONE, so the open loops stay visible.

```
STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT
REASON: [why this status, specific]
RECOMMENDATION: [what should happen next]
```
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
