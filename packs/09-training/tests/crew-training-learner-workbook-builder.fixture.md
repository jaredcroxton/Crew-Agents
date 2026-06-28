# Fixture: crew-training-learner-workbook-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
A complete, approved facilitator guide for a 60-minute "Objection Handling" session, A4 double-sided requested, audience frontline sales staff. Objectives: 1) Name the four LAER steps (recall). 2) Apply LAER to a live objection (apply). 3) Spot which step a stalled call skipped (analyse). Guide sections with footprint: Welcome (Tell), The LAER loop (Tell, teaches Listen, Acknowledge, Explore, Respond), Model a LAER call (Show), Practise on a real objection (Do, a lift-the-activity worksheet with four prompts), Pairs debrief (Discuss), Check (Check, two questions with answers held in the guide). The guide also carries room setup, timing cues, and the trainer's debrief answers. Source guide name: objection-handling-facilitator-guide.
EXPECT:
- Output begins with "LEARNER WORKBOOK" and the header carries Session, Built date, Format "A4, double sided", and Source guide.
- The cover lists the three objectives as "By the end of this session you will be able to..." and carries a one-line "How to use this workbook".
- The cover carries a learner name and date field, because the workbook is the learner's copy to keep.
- Every objective is served by at least one block (no orphan objective, no orphan block).
- The Tell section "The LAER loop" becomes guided notes with the four step meanings blanked (not full paragraphs to read), and the page is not completable without attending the session.
- The Do section "Practise on a real objection" becomes a worksheet lifted from the guide (not redesigned), with the learner's own write-in space and a "My takeaway" line, not the trainer's debrief answer.
- The Check questions appear with the correct answers WITHHELD, and an "Answers" line states where they live (the facilitator guide, or via crew-training-assessment-designer).
- The check type matches the objective Bloom level: a scenario or application check for the apply or analyse objective, not only a recall quiz.
- The Discuss section "Pairs debrief" becomes a learner reflection block with the learner's own write-in space; it is NOT cut wholesale. Only the trainer's debrief answers are held back.
- Trainer-only content (room setup, timing cues, the trainer's debrief answers) is cut, never converted to a learner page, and noted in Build notes.
- An accessibility / format line is present (readable size, contrast, not colour-only, plain language, write-in space sized to handwrite, a digital alternative or named accommodation, the requested A4 double-sided).
- A keepable take-away or transfer element is present (a job aid or summary the learner keeps, plus an application prompt).
- Blocks are in session order; nothing is invented beyond the guide.
- Handoff file `~/.claude/crew-state/training/crew-training-learner-workbook-builder-handoff.md` was written, with block count and what crew-training-assessment-designer needs next.
- No em dashes anywhere.

## Case B: messy
INPUT:
Only a draft OUTLINE exists for "Coaching Conversations" (not a final approved facilitator guide). One objective ("Run a full GROW conversation end to end") is not covered by any section in the outline. One Check question in the source has no validated answer attached. The requester also asks for "a graded test at the back with a pass mark of 70%".
EXPECT:
- The skill builds from the outline but marks every block "Built from outline, confirm against final guide", and does not treat the workbook as final.
- The uncovered objective ("Run a full GROW conversation end to end") is marked "Not in guide, confirm" and NO block is invented to serve it.
- The Check question with no validated answer is withheld (no answer printed) and routed to crew-training-assessment-designer for a validated answer, never guessed onto the page.
- The requested "graded test with a 70% pass mark" is recognised as a summative instrument, NOT built as a workbook check, and is Escalated and routed to crew-training-assessment-designer. The workbook checks stay formative, with no pass mark and no grade printed.
- Nothing is invented: no activity, no answer, no objective, no content beyond the outline.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- Handoff file `~/.claude/crew-state/training/crew-training-learner-workbook-builder-handoff.md` was written, recording the outline-not-final state, the uncovered objective, the missing check answer, and the escalated graded assessment.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Make the workbook for the leadership session." No facilitator guide, no outline, no objectives, and no page format attached. Only the topic.
EXPECT:
- Loop 1 fires. The skill names what is missing (the approved facilitator guide, or at least the outline and the objectives) and why it matters (a workbook with no parent guide drifts out of alignment with what the trainer will say and do).
- It asks once, plainly, for the approved facilitator guide (or at least the outline and objectives).
- It invents no activity, no check question, no objective, and no content.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file `~/.claude/crew-state/training/crew-training-learner-workbook-builder-handoff.md` was still written, recording the missing guide so the next run knows.
- No em dashes anywhere.
