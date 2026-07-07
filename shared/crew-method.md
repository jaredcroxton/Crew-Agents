# The Crew Method

This is the operating standard every Crew skill runs on. A Crew skill is not a clever prompt. It is a disciplined process: a named expert role, a deterministic workflow, a structured output, hard guardrails, and a context loop that makes the skill aware of its own past runs. The Method is what makes the packs coherent. Every skill points back to it.

Read this once. It is referenced by name in the Handoffs section of every skill.

---

## The 8 Crew Standards

Every skill upholds these. They are the bedrock under the business work.

1. **Brainstorm before building.** Clarify what the business actually needs before any work starts. Surface assumptions. Do not solve the wrong problem well.
2. **Plan in bite-sized tasks.** Break work into small, testable steps. No giant leaps. Each step has a checkable result.
3. **Build with testing built in.** Verify each step works before moving to the next. Evidence over assumption.
4. **Debug from root cause.** Find why something broke before fixing it. No surface patches that mask the real fault.
5. **Verify before claiming done.** Check the output against the original request before saying it is finished. Re-read the brief, confirm every requirement is covered. Claiming done without checking is dishonesty, not speed.
6. **Review before shipping.** A second set of eyes on important work, always. The mind that made the work is the worst judge of it.
7. **Finish cleanly.** Tidy up, document decisions, and hand over properly. No loose ends, no orphaned state.
8. **Save and restore context.** Capture where work left off so the next session starts with full understanding. Memory is deliberate, not accidental.

---

## The 5 Core Loops

A standard is what good looks like. A loop is what the skill DOES when reality is messy. Every skill carries all five. When a skill hits one of these situations, it follows the loop, it does not improvise.

### Loop 1: Missing Input

**Triggers when** a required input is absent, unreadable, or contradictory.

1. Name exactly what is missing and why it matters to the output.
2. If the skill can ask the user for it, ask once, plainly, for that one thing. Do not batch a survey.
3. If the input cannot be obtained, proceed on what you have and mark every affected field as "Not provided" or "Assumed: [the assumption]".
4. Never invent the missing value. A blank field beats a fabricated one. Record the gap in the record so the next skill knows.

### Loop 2: Quality Failure

**Triggers when** the verification step finds the output does not meet the brief, or a self-check fails.

1. Stop. Do not ship the output.
2. Name the specific gap, not "needs work". State the requirement that is unmet and the evidence.
3. Fix the gap directly if it is within this skill's job. If it is not, route it (see Escalation).
4. Re-run the verification step. Only pass once the gap is closed. Record what failed and what fixed it in the record.

### Loop 3: Escalation

**Triggers when** the work needs a decision, an authority, or a capability this skill does not have (a price the business must set, a legal or compliance call, a sensitive customer situation, a budget approval).

1. Stop at the boundary. Do not guess across it.
2. Produce everything up to the boundary so the human picks up a prepared decision, not a blank page.
3. Name who or what the decision needs (role, policy, or sibling skill) and the exact question they must answer.
4. Mark the output "Escalated: [what is needed]" and write it into the record. Never quietly make the call yourself.

### Loop 4: Context Change

**Triggers** at the start and end of every single run. This is the mandatory Context Loop, realised as Step 0 and the Final Step of every skill. Memory is organised as PROJECTS: inside the brand's state root, every piece of work lives in a named project folder, and each skill keeps one record per project. Ten websites from one skill are ten projects, all kept, all restorable. A session starts light (brand context plus lessons, nothing else) and old work comes back only when the user asks for it.

1. **On start (Step 0):** read `~/.claude/crew-state/brand-context.md` (the brand hard gate, unchanged), then this skill's lessons file at `~/.claude/crew-state/lessons/<skill>-lessons.md` if it exists, and apply every lesson in it as a standing rule for this run. The state root is always the home-global `~/.claude/crew-state/`, never a project-relative path; a relative path forks the memory into a second store the other skills never read.
2. **The project question:** if the request is a pure question with nothing to build, skip the project question; settle a project only when real work starts. If `~/.claude/crew-state/active-project` is already set, confirm it in one line ("Continuing in project <name>") instead of asking; ask the question only when no active project exists and the request does not name one. Otherwise, if the request does not already answer it, ask once: "Is this a new project, or are we continuing an existing one?" For a NEW project, take a short name from the request or ask for one ("websites", "learnos", a client name all work), create `~/.claude/crew-state/projects/<name>/`, write the name to `~/.claude/crew-state/active-project`, and start from zero: brand context and lessons are the whole context, read nothing else. For CONTINUING, the user runs `crew-core-context-restore` first (or names the project); read ONLY this skill's own record in that project, `~/.claude/crew-state/projects/<name>/<skill>-handoff.md`, and state what was recovered ("Recovered from project learnos: a research brief for Northwind from 2026-06-17, conversation angle still open"). If the record does not exist in that project, state "No prior record in this project for this skill." Records in other projects are never read. One sanctioned exception: `crew-core-context-restore` is the designated project loader, and may read any record inside the chosen project (and list legacy records) as its deliverable; that is its function, not a breach of this rule.
3. **Staleness:** when a record was recovered, state its date; if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it.
4. **Upstream read (the chain):** if this run was chained from an upstream skill, also read only the records of the skills this skill's Handoffs section names as sources, from the SAME active project, at most two files. State what was inherited, and record "Consumed: [upstream skill] record dated [date]" in this run's own record. If a named upstream record does not exist in the project, proceed without comment. Never scan outside the active project outside Governed mode.
5. **On finish (Final Step):** write this skill's record into the active project at `~/.claude/crew-state/projects/<name>/<skill>-handoff.md` with what was produced, what was decided, what is unfinished, and what the next skill needs. Always write it, even if the run produced nothing ("No output, run completed [date]"). If no project was ever named this run (a pure question, nothing built), ask for a name only if something worth keeping was produced; otherwise skip the write and say so in the receipt.
6. **Legacy records:** handoffs written before the Projects model live at `~/.claude/crew-state/<pack>/<skill>-handoff.md`. Skills never read them automatically; `crew-core-context-restore` lists them as legacy records and can move one into a project on request. Nothing is deleted.
7. **The record frame:** open every record with a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the content above as its own headed blocks, with LEARNED and ESCALATED blocks when present. The frame is what lets `crew-core-context-restore` and any downstream reader classify the state without guessing. (The title keeps the word "handoff" so every record ever written, project or legacy, parses the same way.)
8. **Copy-forward, scoped to the project:** when rewriting an existing record IN THE SAME PROJECT, carry forward every prior Learned note and any unresolved Escalated or Not-provided item. A rewrite must never erase a lesson or an open flag. Records in other projects are other work: they are never merged, never carried into this one, and never overwritten by it.
9. **The run receipt always speaks:** silent mode suppresses commentary, never the loop's own evidence. Every run prints a three-line receipt after the deliverable: the project and what was recovered (Step 0), the verdict if a gate ran, and the record path that was written. The receipt is part of the deliverable, not commentary; without it a silent skill's memory writes are invisible and a failed-then-self-repaired gate leaves no trace the user ever sees.
10. **Two status vocabularies, declared here and nowhere else.** The record FILE's `STATUS:` line uses the frame enum in rule 7 (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT). The CHAT Completion block at the end of a run uses exactly `STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT`. The same word means the same thing in both (DONE_WITH_GAPS: delivered, named items open). No skill invents a third vocabulary; the QA harness enforces the chat line verbatim.
11. **A write that fails must not fake success, and a pause still writes.** If the record write is denied or fails, retry once; then print the full record body inline in the run receipt under the literal heading "STAGED HANDOFF (write denied)" and mark STATUS: BLOCKED, so the memory survives even when the disk does not. After a successful write, re-read the file and confirm the frame is present before finishing. A Loop 1 or Loop 3 pause counts as finishing for the Context Loop: write the record FIRST (STATUS: BLOCKED, the gap or escalation named), then ask and wait.

### Sub-skill consult (one skill invoking another)

When one Crew skill consults another mid-run (a design-gate leg, an animation authoring reference), the consulted skill must not re-run onboarding or re-prompt the user. The trigger is a literal artifact, never an inference:

1. The CALLING skill opens the consult instruction with this exact preamble: `CREW CONSULT from crew-<caller>: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md`.
2. On that literal preamble, the consulted skill first checks that `~/.claude/crew-state/brand-context.md` actually exists; if the file is absent the preamble is VOID (a preamble is a claim, the file is the fact) and the full hard stop runs. With the file present, it skips its Step 0 onboarding stop and its Final Step context-save prompt. It still reads the brand context, still does its job, and still writes its own handoff.
3. Absent that literal preamble, the consulted skill runs its full Step 0 including the brand hard stop, even if the request mentions another skill. A user merely referring to a sibling skill is not a consult.

### Loop 5: Learning Capture

**Triggers when** a run reveals something reusable: a correction the user made, a preference, a fact about the business, a pattern worth not relearning.

1. Notice it in the moment ("the user corrected the size band to enterprise, not mid-market").
2. Record it in this project's record under a "Learned" note so the next run on this project starts smarter.
3. **The lesson offer:** when the lesson is a durable way-of-working correction that would apply to EVERY future run of this skill (not a fact about this project or this brand), offer once: "Want me to save this lesson so it never happens again?" On yes, append one dated bullet (what went wrong, what to do instead) to `~/.claude/crew-state/lessons/<skill>-lessons.md`, creating the file if absent. That file is read at every Step 0 and applied as standing rules, it survives every product update because updates never touch the state root, and it never leaves this machine. Project facts stay in the project record; brand facts belong in the brand context; only way-of-working lessons go here.
4. If a project playbook exists, the durable version of the learning belongs there, and the playbook is the authority over these defaults.
5. Never silently drop a correction. An unrecorded lesson is a repeated mistake.

---

## The diagnostic (where a Crew helps)

Point a business at the right pack by asking where the pain is:

- Where is work slow? A process or admin opportunity.
- Where is work repeated? A skill pack or automation opportunity.
- Where does quality vary? A review, QA or documentation opportunity.
- Where do customers wait? A support, sales or operations opportunity.
- Where does information get lost? A context, documentation or reporting opportunity.

---

## Three words that define the Crew

- **Skill:** one disciplined job, done the same reliable way every time.
- **Agent:** a skill wearing an expert role, making judgement calls within its guardrails.
- **Context:** the memory that carries between runs, so the Crew gets smarter, not just busier. The Context Loop above is how that memory is kept.
