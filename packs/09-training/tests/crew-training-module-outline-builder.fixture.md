# Fixture: crew-training-module-outline-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Topic: handling price objections on outbound calls. Audience: new field reps, 0 to 6 months, group of 8. Length: 90 minutes. Delivery: in-person. Prerequisites: reps can already run a basic discovery call and know the product tiers.
Outcome: reps run the LAER pattern (Listen, Acknowledge, Explore, Respond) on a price objection without caving on the discount, and can tell a price objection from a value objection. The LAER model is the confirmed house standard.
EXPECT:
- Output begins with "MODULE OUTLINE" and includes Topic, Audience, Length, Job context, and a Prerequisites line.
- 2 to 4 objectives, each with an observable verb (run, classify) and a named "Bloom level" (Apply, Analyse), none using a banned verb (know, understand, appreciate, be aware). Each objective carries a measurable degree or standard (the Analyse objective names a criterion, for example "correctly in at least 4 of 5 cases"), not a bare verb with no standard.
- A session flow with Tell, Show, Do, and Check sections, opening with a Hook and closing with a Transfer step, each section mapped to an objective number.
- Do and Check are front-loaded: practice and retrieval hold more of the clock than Tell.
- Timings per section with a "Total: 90 of 90 minutes" line that sums correctly.
- An assessment approach with a Kirkpatrick Level, a format that fits the objective's Bloom level (an observed role-play with a rubric for the Apply objective, not a recall quiz), a pass standard, and an item map tracing each item to an objective with NO orphan (every assessment item maps to a Do the learners actually rehearsed).
- The Analyse objective (price vs value) is rehearsed and tested by an Analyse-level activity of its own (a classify or sort with a forced decision), not carried only by the Apply role-play and the LAER-steps scorecard; the pass standard scores its degree.
- A "Reinforcement / transfer" line names a spaced follow-up after the session (an on-the-job application, a manager check, or a later retrieval).
- Nothing is invented: the LAER model is used because it was confirmed, and any gap is marked "content needed from SME" rather than filled.
- Handoff file `.claude/crew-state/training/crew-training-module-outline-builder-handoff.md` was written.

## Case B: messy
INPUT:
"Need a quick objections thing for the team, maybe an hour, whenever. We want them to understand the product better and stop losing deals on price." No model named, no confirmed content. Audience described only as "the sales team", size and level unknown. A note says "the old deck had some stat about 80% of deals dying on price" but no source. The team handles regulated financial products, so any pass mark is tied to a compliance sign-off.
EXPECT:
- Skill restates topic, audience, and length for the SME to correct (Step 1), and marks the unknown group size and level "Assumed:".
- The objective "understand the product" is rewritten to an observable, measurable verb with a named Bloom level (for example, an Apply objective such as "handle a price objection using [the confirmed model] without conceding the discount"), not left as "understand".
- It does not invent a model, a procedure, or fill the Tell content. Missing content is marked "content needed from SME".
- The unsourced "80%" stat is not stated as fact. It is flagged as unverified or dropped, never presented as confirmed SME content.
- Timings still sum to the stated length (60 of 60). When the sections overrun, a Tell is cut, never a Do, and what was cut is stated.
- The compliance-linked pass standard is NOT set by the skill. It is marked "Escalated: pass standard and sign-off authority needed from [role]" (Loop 3).
- The assessment format matches the objective's Bloom level (an observed practical for an Apply objective, not a recall quiz).
- Handoff file written, noting the unconfirmed model, the assumed group size and level, and the escalated pass standard as unfinished work.

## Case C: missing-input
INPUT:
Topic: "first aid refresher for warehouse staff." No audience detail and no session length given, and it is a certification-linked module.
EXPECT:
- Skill follows Loop 1: it asks once for the one input that blocks most (the session length, because timings and the section structure cannot be set without it, or the audience if that blocks first), rather than guessing a duration or an audience.
- Because the module is certification-linked, the skill does NOT fall back to "Assumed: 60 min" or any assumed structure for the missing length or audience; on a regulated topic a missing structural input is BLOCKED, never an assumed duration, since the section structure a certification depends on cannot be fabricated.
- It invents no timing, no objective, no audience size, and no first-aid procedures, steps, or facts (content needed from SME).
- The pass standard and sign-off are not set by the skill. The assessment is marked "Escalated: pass standard and sign-off authority needed from [certifying body or role]" (Loop 3).
- Nothing is fabricated: no invented length, no invented procedure, no invented pass mark, no invented objective.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, so an empty scaffold is not mistaken for a finished outline.
- Handoff file `.claude/crew-state/training/crew-training-module-outline-builder-handoff.md` was written, recording the missing length and audience and the escalated certification decision the next run needs.
