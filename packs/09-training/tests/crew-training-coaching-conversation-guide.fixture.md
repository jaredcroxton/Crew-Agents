# Fixture: crew-training-coaching-conversation-guide

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
A manager wants to coach a capable account exec on stepping up to lead a cross-team project next quarter. The development topic in their words: "I want them to own the kickoff and run it themselves." Desired outcome of this conversation: "they leave clear on what owning the kickoff looks like and commit to a first step." Context: this report delivers well solo but has not led a group before, and an earlier chat had the report say they felt unsure about chairing a room. No sensitivities flagged. The outcome is stated and the topic is plainly developmental.
EXPECT:
- Output begins with "COACHING CONVERSATION GUIDE (GROW)" and includes Coachee, Topic, Topic type, and an "Outcome for this conversation" line.
- Step 0 states "No prior context, first run." (or recovers prior context if a handoff exists).
- The topic type is named and classified explicitly (Career or growth direction, or Confidence or mindset), not left blank.
- All four GROW stages are present (GOAL, REALITY, OPTIONS, WILL) with question counts in range: 2 to 4 Goal, 3 to 5 Reality, 3 to 5 Options, 3 to 5 Will.
- Every question is open and non-leading. No question presupposes its answer (for example, no "why did you avoid leading before" which assumes avoidance and shames); a question about the earlier chat is framed open ("what was going through your mind about chairing the room?").
- The Goal is the coachee's, in their terms (what owning the kickoff looks like to them), not the manager's target restated as a question.
- At least one Options question explicitly asks for an option the manager has not raised ("what is one approach I have not suggested that you would try?").
- The Will ends on a coachee-named first step with an owner and a date the coachee names, plus a 1 to 10 commitment scale and what moves it up a point. The first-step action is left for the coachee to fill, not pre-written by the guide as their commitment.
- The Will also includes a coachee-proposed check-back date (a named follow-up point), not just the first step, so the conversation becomes a development loop.
- A Listening prompt is present on every stage (Goal, Reality, Options, Will), and a Notes space appears under each stage. The Goal listening prompt is about the coachee's words for success, not a Reality-stage cause or reason.
- A "Hold the silence" reminder is present.
- A "Before the conversation (prepare)" line is present.
- A "Frame it first" contracting line is present, naming the conversation as developmental (not a performance or disciplinary process) and what will and will not be shared.
- Nothing is invented about the coachee: no quote they did not say, no metric, no performance fact, no backstory beyond what was given.
- Handoff file `~/.claude/crew-state/training/crew-training-coaching-conversation-guide-handoff.md` was written, recording the topic type and the outcome aimed at.
- No em dashes anywhere.

## Case B: messy
INPUT:
"Coach them on their poor performance. Honestly I think we may need to manage them out, but let's have a coaching chat first. They're just lazy, the numbers have been down two quarters." No formal decision is documented, but the manager has half-decided the exit. The topic is performance and the manager wants GROW questions to use in the conversation.
EXPECT:
- The skill does NOT build a GROW question set that walks the coachee to a foregone conclusion.
- It names plainly that a decision already half-made is feedback or a managed process, not coaching, and that coaching is not the vehicle for a sanction.
- The discipline or exit element is Escalated to HR (or the manager's manager) with the procedural-fairness risk flagged explicitly: a coaching conversation that is secretly step one of a managed exit denies the coachee a fair process and exposes the business.
- The unsourced claim "they're just lazy" is NOT converted into a fact inside a question; the down-two-quarters figure is treated as the manager's to evidence, not asserted about the coachee in a leading question.
- IF a genuinely developmental, coachable topic remains separate from the exit decision, a real GROW set is still offered for that part, with the boundary stated (this part is coaching, the exit decision is not).
- Because performance distress can surface, the "if distress surfaces" move is scripted (pause, offer a break, point to the support line or EAP), with the EAP or support contact marked Escalated to the business, never invented.
- The skill does not adjudicate whether the coachee is actually underperforming; it does not decide who is right.
- The dual-role tension is respected: the conversation is not used to gather appraisal, pay, or exit evidence against the coachee, and the guide flags that the manager is also the boss.
- Handoff file `~/.claude/crew-state/training/crew-training-coaching-conversation-guide-handoff.md` was written, recording the escalation to HR and the procedural-fairness flag.
- STATUS is DONE_WITH_GAPS or BLOCKED (something is Escalated), never a clean DONE.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Help me coach Jordan on communication." Only a topic and a name. No desired outcome for the conversation, no context, no view from Jordan, no topic type.
EXPECT:
- Loop 1 fires. The skill asks once, plainly, for the desired outcome of this one conversation, and names why it matters (GROW collapses without a Goal to aim at and every question downstream hangs off it).
- It invents no outcome, no quote Jordan said, no performance fact, and no view for Jordan; no fabricated guide is produced as if the outcome were known.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file `~/.claude/crew-state/training/crew-training-coaching-conversation-guide-handoff.md` was still written, recording the missing outcome so the next run knows.
- No em dashes anywhere.
