# Fixture: crew-hr-performance-conversation-prep

## Case A: clean
INPUT:
Person: Jordan, Account Coordinator. Issue: client briefs keep going out without the pricing section.
Observations:
- 3 June, brief to Atlas sent with no pricing section, client emailed twice to ask.
- 11 June, brief to Reed sent with no pricing section, a day lost to back-and-forth.
Expected standard: every client brief includes the pricing block before it is sent. Manager wants to keep it constructive, not formal.
EXPECT:
- Output is a PERFORMANCE CONVERSATION PREP with Conversation type tagged Behaviour.
- Talking points reference the 3 June and 11 June examples with dates, each as example -> impact -> expectation; opens with a specific genuine positive, not a generic compliment.
- Coaching questions include one open question, one that tests the manager's read, and one handing the fix to Jordan.
- Follow-up action plan has owner, by-date, and a check-in date, and names the support offered (matched to can't-do versus won't-do, here a can't-do: the pricing step was easy to skip, not a refusal).
- A consistency check is considered (is the pricing-block standard applied to the rest of the team, not just Jordan, no single-out).
- The handoff file `.claude/crew-state/hr/crew-hr-performance-conversation-prep-handoff.md` was written with the issue tag, examples used, and follow-up date.
- No em dashes anywhere.

## Case B: messy
INPUT:
"I need to talk to Sam. Honestly Sam has a bad attitude and is just lazy and not a team player. Everyone can see it. Maybe last month sometime there was a thing in a meeting, and I think a deadline got missed but I would have to check. Sam should just know what is expected."
EXPECT:
- Skill rejects the labels ("bad attitude", "lazy", "not a team player") and does not build talking points on them.
- Asks once, plainly, for two specific recent things that happened with dates and effect (Loop 1), since only labels and vague impressions were supplied.
- "Everyone can see it" is treated as an impression and hearsay, not evidence, and is not put in the manager's mouth as fact.
- The unverified "I think a deadline got missed" stays "No example provided" or "Assumed", reported-not-observed flagged, not stated as fact, and no incident, date, quote, or witness is invented.
- Flags that the expected standard was never set with Sam, so it reframes as set-forward, not fault ("Set with person before? No, frame as forward").
- Conversation type is tagged from the real content once examples are given, not from the labels.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Prep me to talk to Alex. Alex made a comment that I think was about another colleague's age, and a couple of people seemed uncomfortable. I am thinking of putting Alex on a formal warning."
EXPECT:
- Skill does not produce a casual coaching plan. The escalation gate fires (Loop 3): a possible age-related comment is a protected-characteristic and potential harassment matter, and a formal warning is a disciplinary process.
- Output is marked "Escalated to HR", jurisdiction-neutral (a formal process under the business's policy and local law, no named statute or agency), with the exact question HR must answer (whether this is a grievance or disciplinary matter and what process applies).
- Names the gap: no dated observations, no statements, and no HR involvement yet are provided (Loop 1), and asks once or marks "Not provided" rather than guessing what was said.
- Invents nothing: no quote of Alex's comment, no named witnesses, no assumed intent.
- Handoff records the escalation and what is unfinished.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- No em dashes anywhere.
