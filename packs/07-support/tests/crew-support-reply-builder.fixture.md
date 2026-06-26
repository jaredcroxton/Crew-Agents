# Fixture: crew-support-reply-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear, and that the handoff file was written.

## Case A: clean
INPUT:
Write the reply (Careful mode). Triage card: Category Billing, Priority P2 High, Escalation No, Sentiment Negative. Customer: Priya. Channel: email.
Message: "You charged me twice for the May plan. I want one charge back. This is the second time I have emailed."
Approved language: macro "double-charge-acknowledge" exists. Refund approval needed for any amount.
EXPECT:
- Output is a "SUPPORT REPLY" block with Ticket, Sentiment, Macro, Words, and Self-score fields, a Customer reply, an Internal note, and an Escalation line.
- The reply follows the five-part structure: thanks Priya by name, acknowledges the specific double charge in the customer's words, gives a clear next step with a real channel, closes warmly.
- The reply contains zero banned phrases (no "Unfortunately", no "we value your feedback", no "rest assured") and is under 150 words.
- The refund value is NOT promised in the reply; it is bracketed and the Escalation line reads "Escalated: refund amount, who approves", routed to crew-support-escalation-review.
- No invented order number, amount, or account detail; unknowns marked "Not provided".
- Handoff file `.claude/crew-state/support/crew-support-reply-builder-handoff.md` was written.

## Case B: messy
INPUT:
Reply to this. "Your app deleted my data and I have lost a day of work. If this is not fixed I am going to my lawyer and posting this everywhere. By the way your support agent Dan was actually really helpful last week."
No macro provided.
EXPECT:
- The skill reads the sentiment as At-risk (legal threat, public-complaint language) and does NOT draft a breezy public reply.
- It returns an escalation: no public reply is sent as final, the legal exposure is flagged "Escalated" and routed to crew-support-escalation-review.
- It does not argue, does not promise compensation, and does not blame the customer.
- The positive aside about the agent is noted (acknowledged warmly or logged), not turned into the whole reply.
- Because the direction is contested (acknowledge publicly vs handle privately), a short decision brief is produced.
- Marks "Uses default voice, no approved macro found". No invented facts. Handoff written, recording the escalation.

## Case C: missing-input
INPUT:
Can you write the reply?
EXPECT:
- The skill asks once for the message to answer and the triage card or core facts (Loop 1, Missing Input), because a reply built on a guessed fact is worse than a short delay.
- It does not invent a customer, an issue, a refund, or a reply.
- It does not draft until the message text exists.
- Handoff file written, recording the run as not started and the input still needed.
