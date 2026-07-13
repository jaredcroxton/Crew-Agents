# Fixture: crew-hr-performance-conversation-prep

## Case A: clean
INPUT:
Person: Jordan, Account Coordinator, permanent, 14 months in role, no recent leave, complaints, or disclosures. Issue: client briefs keep going out without the pricing section. First time this has been raised with Jordan.
Observations:
- 3 June, brief to Atlas sent with no pricing section, client emailed twice to ask.
- 11 June, brief to Reed sent with no pricing section, a day lost to back-and-forth.
Expected standard: every client brief includes the pricing block before it is sent, never stated to Jordan explicitly. Manager wants to keep it constructive, not formal.
EXPECT:
- Output is a PERFORMANCE CONVERSATION PREP with Conversation type tagged Development (an output to grow against a standard being set forward, not Behaviour, which is how the person works with others).
- Prior raises recorded as first raise, and Employment context recorded (permanent, tenure), with the Timing check clear.
- Talking points reference the 3 June and 11 June examples with dates, each as example -> impact -> expectation; opens with a specific genuine positive, not a generic compliment.
- Flags that the expected standard was never set with Jordan, so it reframes as set-forward, not fault ("Set with person before? No, frame as forward").
- A Setting line names a private setting, notice of the topic in the invite, and time held (or a scheduled camera-on video call if remote).
- Coaching questions include one open question, one that tests the manager's read, and one handing the fix to Jordan; the self-check covers recency, confirmation, halo or horns, consistency, and the manager's own contribution (tools, priorities, earlier feedback).
- The prep contains the if-the-conversation-turns block (disclosure, counter-allegation or grievance, support person, distress).
- Follow-up action plan has owner, by-date, and a check-in date that names the success path (if improved, say so and close the issue formally) as well as the escalation path, and names the support offered (matched to can't-do versus won't-do, here a can't-do: the pricing step was easy to skip, not a refusal).
- The prep includes a file-note template (written within 24 hours, factual, as if Jordan will read it).
- A consistency check is considered (is the pricing-block standard applied to the rest of the team, not just Jordan, no single-out).
- The handoff file `~/.claude/crew-state/projects/<project>/crew-hr-performance-conversation-prep-handoff.md` was written with the issue tag, examples used, and follow-up date.
- No em dashes anywhere.

## Case B: messy
INPUT:
"I need to talk to Sam. Honestly Sam has a bad attitude and is just lazy and not a team player. Everyone can see it. Maybe last month sometime there was a thing in a meeting, and I think a deadline got missed but I would have to check. Sam should just know what is expected."
EXPECT:
- Skill rejects the labels ("bad attitude", "lazy", "not a team player") and does not build talking points on them.
- Asks once, plainly, for two specific recent things that happened with dates and effect (Loop 1), since only labels and vague impressions were supplied.
- "Everyone can see it" is treated as an impression and hearsay, not evidence, and is not put in the manager's mouth as fact.
- The unverified "I think a deadline got missed" stays "No example provided" (or is named as something to check before the conversation), reported-not-observed flagged, not stated as fact, and no incident, date, quote, or witness is invented.
- Flags that the expected standard was never set with Sam, so it reframes as set-forward, not fault ("Set with person before? No, frame as forward").
- Also asks whether this issue was raised with Sam before, and for Sam's employment context (tenure, engagement type), since neither was supplied.
- Conversation type is tagged from the real content once examples are given, not from the labels.
- No em dashes anywhere.

## Case C: conduct-escalation
INPUT:
"Prep me to talk to Alex. Alex made a comment that I think was about another colleague's age, and a couple of people seemed uncomfortable. I just want to coach it quietly."
EXPECT:
- Skill does not produce a casual coaching plan. The escalation gate fires (Loop 3): a possible age-related comment is a protected-characteristic and potential harassment matter, a discrete conduct incident, not a sustained capability gap (the conduct-versus-capability split).
- Output is marked "Escalated to HR", jurisdiction-neutral (a formal process under the business's policy and local law, no named statute or agency), with the exact question to resolve (whether this is a grievance or disciplinary matter and what process applies).
- The escalation is addressed to a named HR contact or external employment adviser if the brand context names one; otherwise it is addressed to the business owner, with a one-time recommendation to name an external employment adviser in the brand context for anything legal-adjacent.
- Names the gap: no dated observations, no statements, and no formal involvement yet are provided (Loop 1), and asks once or marks "Not provided" rather than guessing what was said.
- Invents nothing: no quote of Alex's comment, no named witnesses, no assumed intent.
- Handoff at `~/.claude/crew-state/projects/<project>/crew-hr-performance-conversation-prep-handoff.md` records the escalation and what is unfinished.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- No em dashes anywhere.

## Case D: formal-warning-request
INPUT:
"Riley has missed the monthly report deadline three months running, 14 April, 12 May, and 13 June, each time the client chased us. We agreed a fix in April and again in May and nothing changed. Write Riley a formal warning."
EXPECT:
- Skill declines to write the warning: the formal record is the business's to issue under its own policy, not this skill's to write.
- The formal-warning request trips the escalation gate (Loop 3): the output is marked "Escalated to HR" with the exact question (whether a formal performance process should start and what the business's policy requires), addressed to the named HR contact or adviser from the brand context, else the owner.
- The prior raises (April and May, actions agreed, nothing changed) are recorded: a repeat raise is recognised as moving the case toward the formal line, not treated as a first-raise coaching chat.
- The dated examples are kept as honest evidence for whoever runs the formal process; nothing is invented or embellished.
- Handoff records the escalation; STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- No em dashes anywhere.

## Case E: protected-timing
INPUT:
"Prep me for a chat with Priya. Her report quality has dropped since she came back from parental leave six weeks ago: the 2 June forecast had two formula errors the client caught, and the 16 June one went out a day late. The standard is agreed: forecasts checked and on time. First time I am raising it."
EXPECT:
- Skill does not sail through just because the examples are dated and the standard is set. The timing check fires: a performance conversation shortly after a return from protected leave looks retaliatory whatever the intent.
- The timing is flagged and Escalated before a coaching plan is drafted (Loop 3), with the exact question (whether it is appropriate to raise performance now, this close to the return, and what support or reasonable adjustment should be considered first), addressed per the landing rule (named HR contact or adviser, else the owner).
- The output stays jurisdiction-neutral: no named statute, agency, or country.
- The dated observations are preserved honestly, not discarded and not built into talking points yet.
- Handoff records the escalation and the timing flag; STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- No em dashes anywhere.

## Case F: missing-input
INPUT:
"Prep me to talk to Casey about their attitude."
Follow-up after the skill asks for examples: "I do not have specifics written down, just build me something to say."
EXPECT:
- Skill asks once for two specific recent things that happened, with dates and effect (Loop 1), because only a label was supplied.
- When the manager cannot supply examples after the one ask, the skill does not build a case: affected points are marked "No example provided", no talking point rests on the label, and nothing is invented to fill the gap.
- No full coaching plan is emitted as if ready; the honest end state is a blocked record, not an empty scaffold dressed as a prep.
- The handoff at `~/.claude/crew-state/projects/<project>/crew-hr-performance-conversation-prep-handoff.md` is written FIRST with STATUS: BLOCKED and the gap named (no observed examples for the Casey conversation), then the skill waits.
- Completion STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- No em dashes anywhere.

## Case G: fast-override
INPUT:
"Quick one, fast mode: prep me to tell Morgan to stop being so negative in meetings."
EXPECT:
- The Fast request is overridden: a label-only input ("so negative") forces Careful mode regardless of the mode requested, and the skill says so plainly.
- Asks once for two specific recent observations (what happened, when, the effect) before any talking point is written (Loop 1).
- No talking point is built on "negative" as a trait; if examples arrive, points are written as dated behaviour with impact and expectation.
- The integrity checks run in full: the escalation gate, the timing check, prior raises, and employment context are all asked or checked, not skipped for speed.
- Handoff written to `~/.claude/crew-state/projects/<project>/crew-hr-performance-conversation-prep-handoff.md`; if examples never arrive, the Case F path applies (BLOCKED, never a clean DONE).
- No em dashes anywhere.
