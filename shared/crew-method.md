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
4. Never invent the missing value. A blank field beats a fabricated one. Record the gap in the handoff so the next skill knows.

### Loop 2: Quality Failure

**Triggers when** the verification step finds the output does not meet the brief, or a self-check fails.

1. Stop. Do not ship the output.
2. Name the specific gap, not "needs work". State the requirement that is unmet and the evidence.
3. Fix the gap directly if it is within this skill's job. If it is not, route it (see Escalation).
4. Re-run the verification step. Only pass once the gap is closed. Record what failed and what fixed it in the handoff.

### Loop 3: Escalation

**Triggers when** the work needs a decision, an authority, or a capability this skill does not have (a price the business must set, a legal or compliance call, a sensitive customer situation, a budget approval).

1. Stop at the boundary. Do not guess across it.
2. Produce everything up to the boundary so the human picks up a prepared decision, not a blank page.
3. Name who or what the decision needs (role, policy, or sibling skill) and the exact question they must answer.
4. Mark the output "Escalated: [what is needed]" and write it into the handoff. Never quietly make the call yourself.

### Loop 4: Context Change

**Triggers** at the start and end of every single run. This is the mandatory Context Loop, realised as Step 0 and the Final Step of every skill.

1. **On start (Step 0):** read this skill's handoff file at `~/.claude/crew-state/<pack>/<skill>-handoff.md`. The state root is always the home-global `~/.claude/crew-state/`, never a project-relative path; a relative path forks the memory into a second store the other skills never read. If the handoff exists, load it and state what was recovered ("Recovered: a research brief for Northwind from 2026-06-17, conversation angle still open"). If it does not exist, state "No prior context, first run."
2. **Staleness:** when a handoff was recovered, state its date; if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it.
3. **Upstream read (the chain):** if this run was chained from an upstream skill, also read only the handoffs of the skills this skill's Handoffs section names as sources, at most two files. State what was inherited, and record "Consumed: [upstream skill] handoff dated [date]" in this run's own handoff. If a named upstream handoff does not exist, proceed without comment. Never scan the folder outside Governed mode.
4. Use recovered context to avoid repeating work or contradicting an earlier decision.
5. **On finish (Final Step):** write the handoff file with what was produced, what was decided, what is unfinished, and what the next skill needs. Always write it, even if the run produced nothing ("No output, run completed [date]").
6. **The handoff frame:** open every handoff with a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / NO OUTPUT); then the content above as its own headed blocks, with LEARNED and ESCALATED blocks when present. The frame is what lets `crew-core-context-restore` and any downstream reader classify the state without guessing.
7. **Copy-forward:** when rewriting an existing handoff, carry forward every prior Learned note and any unresolved Escalated or Not-provided item. A rewrite must never erase a lesson or an open flag.
8. **The run receipt always speaks:** silent mode suppresses commentary, never the loop's own evidence. Every run prints a three-line receipt after the deliverable: what context was recovered (Step 0), the verdict if a gate ran, and the handoff path that was written. The receipt is part of the deliverable, not commentary; without it a silent skill's memory writes are invisible and a failed-then-self-repaired gate leaves no trace the user ever sees.

### Sub-skill consult (one skill invoking another)

When one Crew skill consults another mid-run (a design-gate leg, an animation authoring reference), the consulted skill must not re-run onboarding or re-prompt the user. The trigger is a literal artifact, never an inference:

1. The CALLING skill opens the consult instruction with this exact preamble: `CREW CONSULT from crew-<caller>: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md`.
2. On that literal preamble, the consulted skill skips its Step 0 onboarding stop and its Final Step context-save prompt. It still reads the brand context, still does its job, and still writes its own handoff.
3. Absent that literal preamble, the consulted skill runs its full Step 0 including the brand hard stop, even if the request mentions another skill. A user merely referring to a sibling skill is not a consult.

### Loop 5: Learning Capture

**Triggers when** a run reveals something reusable: a correction the user made, a preference, a fact about the business, a pattern worth not relearning.

1. Notice it in the moment ("the user corrected the size band to enterprise, not mid-market").
2. Record it in the handoff under a "Learned" note so the next run starts smarter.
3. If a project playbook exists, the durable version of the learning belongs there, and the playbook is the authority over these defaults.
4. Never silently drop a correction. An unrecorded lesson is a repeated mistake.

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
