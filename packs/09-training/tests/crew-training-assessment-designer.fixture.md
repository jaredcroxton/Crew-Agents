# Fixture: crew-training-assessment-designer

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Module: Refund Policy Compliance.
Outcomes: O1 learner can state the refund window; O2 learner can apply the window to a request; O3 learner can judge an exception case.
Levels: O1 recall, O2 application, O3 scenario.
Stakes: used for sign-off (a fail blocks the learner from handling refunds unsupervised).
Source: policy doc, section 2.1 (window is 30 days), section 2.3 (out-of-window options), section 4 (manager discretion on documented exceptions).
EXPECT:
- Output begins with "ASSESSMENT" and includes Module, Designed date, and Items count.
- A "Blueprint" coverage grid mapping each outcome to a level count, with no empty row for a required outcome.
- At least one Recall, one Application, and one Scenario item, each tagged "(Checks: [Outcome])".
- The item type matches the outcome's level: O1 (recall) gets a recall item, O2 (application) gets an application case, O3 (scenario, the sign-off outcome) gets a Scenario item, not a recall MC.
- Every multiple-choice distractor is labelled as a real misconception, not filler.
- An "Answer key" section where every entry names the outcome it checks and a "Why" that cites a source section (2.1, 2.3, or 4).
- The scenario item carries a model answer and a rubric so two assessors would score it the same way.
- The pass standard is ESCALATED to the training owner, not set by the designer, and the consumer-law exposure under local law (jurisdiction from brand-context.md) is flagged for a "competent" sign-off.
- Handoff file `~/.claude/crew-state/training/crew-training-assessment-designer-handoff.md` was written.

## Case B: messy
INPUT:
Module: "the new CRM thing". Outcomes given loosely: "they should get how to log a deal and roughly know the stages".
Level not stated per outcome. Source: a one-page cheat sheet that lists 5 pipeline stages but does not say what counts as a correct deal-log.
One outcome ("roughly know the stages") is vague.
EXPECT:
- Skill restates the loose outcomes as observable verbs and tags a level per outcome (does not leave level blank).
- A "Blueprint" coverage grid is present, with the restated outcomes mapped to item levels.
- Every item is tagged "(Checks: [Outcome])" and each item type matches the level the skill assigned to that outcome.
- The vague outcome is flagged and tightened or marked "Assumed:", not silently passed through.
- Any item whose correct answer the source does not settle (what counts as a correct deal-log) is marked "answer pending source", not fabricated, and the answer key says the source does not define it.
- No invented passing score and no invented stage definitions beyond the 5 listed; the pass standard, if any sign-off use is implied, is ESCALATED, not set.
- Handoff file written, noting the vague outcome and any pending-source items as unfinished work, with STATUS DONE_WITH_GAPS (not DONE).

## Case C: missing-input
INPUT:
"Write me a quiz on the onboarding module." No outcomes provided, no source material attached.
EXPECT:
- Skill follows Loop 1: it asks once for the learning outcomes, because a question that maps to no outcome is not a valid assessment.
- It does not invent outcomes and silently build a quiz against them.
- If it proceeds at all, it proposes draft outcomes explicitly for the trainer to confirm, builds a Blueprint grid against those draft outcomes, tags every item "(Checks: [Outcome])", and marks the items "answer pending source" because no source is attached, inventing no correct answers and no passing score.
- No pass standard is set by the designer; any consequence is ESCALATED.
- Handoff file written, recording the missing outcomes and source as the blocker the next run needs, with STATUS NEEDS_CONTEXT or BLOCKED (not DONE).
