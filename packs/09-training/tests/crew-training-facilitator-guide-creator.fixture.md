# Fixture: crew-training-facilitator-guide-creator

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Approved module outline "Customer Empathy in Service Calls", 60 min, audience 8 frontline support staff, room delivery, single table. Objectives: 1) Name the emotion behind a complaint. 2) Acknowledge before solving. Outline flow with timings: Opening frame (Tell, 8 min), Model the move (Show, 12 min), Pairs practice (Do, 25 min), Check (Check, 15 min), with an open and a close around them. Activity notes: pairs role-play with three scenario cards. Materials available: whiteboard, scenario cards, timer. Facilitator is a team leader running training for the first time. The outline is marked approved.
EXPECT:
- Output begins with "FACILITATOR GUIDE" and includes Module, Total, Audience, Setting, a "Room / platform setup" line, and a "Pre-work" line.
- Step 0 states "No prior context, first run."
- Scripting depth is chosen, named, and held as Full-script (because the facilitator is first-time), with the reasoning stated, and the same depth runs across every section.
- Every section traces to a section in the approved outline (Opening frame, Model the move, Pairs practice, Check, plus a real open and close); no section is invented.
- Every section carries a Tell/Show/Do/Check type and a timing, and the running total is written out and sums to exactly 60 min, with no section silently shrunk to fake a buffer; the named "if it runs over" cuts are the slack.
- An Energy map line is present (heaviest input early while fresh, no two passive blocks stacked).
- The Welcome states the contract: the ground rules and the finish time the facilitator says aloud, not just a hook.
- SAY: and DO: lines are separated on every section.
- The Show section carries a Modelling tip.
- The Pairs practice has Setup, Run, and Debrief, with 2 to 3 open coaching questions ordered what / so-what / now-what that are non-leading (no question that presupposes its answer, for example not "where did you jump to a fix"), an "if it goes quiet" prompt, and an "if it runs over" cut.
- A psychological-safety frame is scripted on the role-play (volunteers, confidentiality, no surprise hot-seating).
- An accessibility line or note names an alternative for any single-channel activity (the board read aloud, large-print cards, the audio demo narrated, an observer seat), so a low-vision, Deaf, or hard-of-hearing learner is not excluded.
- Each objective has a Check that tests it.
- A Watch-for derail and one-line recovery is present per section, the close included, and across the guide the four common derails (dominator, flat room, wrong answer unchallenged, tangent) each appear at least once.
- Transition buffers are built into the timing, and an "if it runs over" cut on a Tell or passive block is named, never a Do.
- The materials list and the room setup are named (whiteboard, scenario cards, timer, table layout), with no vague "the materials".
- Nothing is invented: no stat, no customer name, no policy, no objective beyond the outline.
- Handoff file `~/.claude/crew-state/training/crew-training-facilitator-guide-creator-handoff.md` was written, naming what crew-training-learner-workbook-builder needs next.
- No em dashes anywhere.

## Case B: messy
INPUT:
An approved outline for "Handling Difficult Conversations", but the facilitator is confident and knows the topic well, and the session runs virtually for a 30-person group with no breakout rooms available. The outline's role-play activity was designed for pairs in a room. One objective's section has no timing on it. A Tell section references "the 80% stat from last year's survey", which is not part of the approved outline content.
EXPECT:
- Output begins with "FACILITATOR GUIDE" and names the modality as virtual with the 30-person group size and the no-breakout-rooms constraint in the room / platform setup line.
- The role-play activity is reshaped for the virtual large group (for example a fishbowl demo with two volunteers and chat reactions, not 30 silent pairs), and what changed is stated explicitly.
- The scripting depth is set to Cue-card (or Beats-only) for the confident facilitator, named and held, with the reasoning stated.
- The missing section timing is flagged "Not provided" with the warning that the guide cannot be run to time and the running total cannot be confirmed; no section duration is invented as fact.
- The "80% stat" is NOT scripted: it is marked "content needed, not in the approved outline" (or Escalated to the training owner to confirm the figure), and the number is not fabricated into a SAY line.
- A psychological-safety frame is still scripted on the reshaped role-play.
- Because "Handling Difficult Conversations" is a genuinely sensitive topic, the skill escalates whether a non-expert lead should facilitate it at all, and scripts an "if distress surfaces" move (pause, offer a break, point to the support line or EAP, do not press a disclosure), with the support contact marked Escalated to the business, never invented.
- An accessibility note covers the reshaped virtual activity (chat alternative for those who cannot speak on camera, captions or a narrated demo), so no learner is silently excluded.
- No objective, customer name, quote, or policy beyond the outline is invented.
- Handoff file `~/.claude/crew-state/training/crew-training-facilitator-guide-creator-handoff.md` was written, recording the reshaped activity, the missing timing, and the unapproved stat as unfinished work.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Write me the facilitator guide for the empathy session." No approved outline, no objectives, no timings, no audience attached. Only the topic.
EXPECT:
- Loop 1 fires. The skill names exactly what is missing (the approved module outline with objectives, the Tell/Show/Do/Check flow, and timings) and why it matters (a facilitator guide is an expansion of a fixed outline, inventing the structure defeats the point).
- It asks once, plainly, for the approved outline.
- It invents no objectives, no sections, no timings, no scripted lines, and no audience. No fabricated guide is produced.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file `~/.claude/crew-state/training/crew-training-facilitator-guide-creator-handoff.md` was still written, recording the gap ("blocked: no approved outline provided") so the next run knows.
- No em dashes anywhere.
