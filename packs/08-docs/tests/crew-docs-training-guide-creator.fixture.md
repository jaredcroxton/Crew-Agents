# Fixture: crew-docs-training-guide-creator

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Topic: new CRM rollout, teaching contact logging and the team pipeline view. Audience: 8 sales reps, new to the CRM. Time: 60 minutes, delivered by the team lead, in person with sandbox logins. System owner confirmed the menu paths (Contacts > New, Owner is a required field, Pipeline view in top nav).
EXPECT:
- Output begins with a fenced block whose first content line is exactly "TRAINING GUIDE", with a "Topic:" line carrying Audience, Duration, and Delivered by directly beneath it.
- The guide carries Prerequisites, Materials and setup, Performance outcome, Objectives, a Session flow table, Scripted sections, Activities, Check questions, and an Accessibility note.
- Objectives use observable action verbs (locate, log, decide) each with a Level tag (Recall / Apply / Judge), never "understand"; there are two to four of them, and at least one carries a visible standard of done (for example, "so the record saves without an error"), not just a bare verb.
- Every objective maps to a section in the flow AND a check question by number (constructive alignment is visible on the page).
- Session flow uses Tell, Show, Do, Check modes and the timings sum to 60 minutes with Do the largest block and Tell the shortest; the split is fit to the topic, not asserted as a fixed 10/15/25/10 ratio.
- Each objective gets a real Do block at its verb level (an Apply or Judge objective is practised, not just mentioned), so the minutes-per-objective is not too thin to learn from.
- The scripted Show section names the real field (Owner required) and button (Save), not a generic category, and nothing about the system is invented (confirmed paths stated as fact, the unconfirmed Pipeline label marked "[Confirm with system owner]").
- One check question per objective, mapped by number, each with a markable Correct answer for the facilitator; the Recall check has the learner locate the real thing (open the pipeline view and show the trainer), not a define-the-term quiz, and the practical Apply check carries a rubric (done well versus not yet).
- Accessibility honoured: alt text written only for screenshots that exist (none here, so none invented), the Save button named by label and position rather than colour alone, reading level matched to a new-hire room.
- Handoff written to `~/.claude/crew-state/docs/crew-docs-training-guide-creator-handoff.md` recording the time split and the objective verbs chosen.

## Case B: messy
INPUT:
"Train the team on the new CRM. They should basically understand the whole thing. Make it good." No time given, audience given as "the team" with no size. The requester describes a "Quick Add button on the dashboard" but the skill has not seen the system and cannot confirm that screen exists, and there are clearly more than an hour's worth of objectives implied.
EXPECT:
- Skill asks once for the missing time (the one blocking field), per Loop 1, before building the timed flow, or proceeds and marks timed fields "Assumed: [the assumption]".
- The vague "understand the whole thing" is rewritten into observable Apply or Judge objectives (or flagged as needing a checkable verb); "understand" is not kept as an objective.
- Objectives are cut to fit the available (or assumed) time rather than padded or crammed, with the honest scope recommended (for example, two objectives done well, the rest deferred to a second session), no padded run-of-show.
- The unconfirmed "Quick Add button" is written as "[Confirm with system owner]" rather than scripted as fact. No invented menu path, field, or screen.
- Audience size left as "Assumed" or flagged, not fabricated.
- Handoff written, with a "Learned" note if the requester corrected anything and the unconfirmed screen and the cut objectives logged under Open items.

## Case C: missing-input
INPUT:
"Make me a training guide." No topic, no audience, no time.
EXPECT:
- Loop 1 fires: names the missing topic as the blocking gap (audience and time cannot be scoped without it) and asks once, plainly, for the topic. It asks once, not a batched survey.
- Does not invent a topic, a system, objectives, a timing, or any screen detail.
- No TRAINING GUIDE block is emitted with fabricated content. Any placeholder timed fields read "Assumed" or "Not provided", not a guessed value.
- Handoff still written to `~/.claude/crew-state/docs/crew-docs-training-guide-creator-handoff.md` recording "No output, run completed [date]" and the input that was requested.
