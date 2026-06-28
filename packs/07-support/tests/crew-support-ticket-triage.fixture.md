# Fixture: crew-support-ticket-triage

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear, and that the handoff file was written.

## Case A: clean
INPUT:
Triage this ticket (Careful mode). Channel: email. Customer: J. Okafor.
Subject: "charged twice this month"
Body: "Your system billed my card twice for the May subscription. I want one charge refunded. This is the second time I have had to email about it."
EXPECT:
- Output is a "TRIAGE CARD" with Mode, Reported issue, Emotional register, Category, Priority, Missing information, Recommended owner, Next action, Escalation, and Pattern flag fields.
- Category names the specific trigger ("Billing: ..."), not just the bucket, and uses the customer's own framing.
- Priority is P2 High with a one-line basis (money at risk, paying account, no workaround), not softened.
- Missing information lists the second invoice or transaction ID and the account email as "Missing", not invented.
- Recommended owner is a finance or billing queue, marked "Suggested, confirm routing" since no routing map was given.
- Next action is one concrete step that does not promise a refund amount; the refund value is marked Escalated (who decides).
- The repeated contact is noted as a priority or pattern signal, not auto-escalated by volume alone.
- Handoff file `~/.claude/crew-state/support/crew-support-ticket-triage-handoff.md` was written.

## Case B: messy
INPUT:
Triage this. "I have called four times and no one fixes it. The app logs me out every hour, I lost two hours of work, and honestly if this is not sorted I am going to my lawyer and posting this everywhere. Also why is your pricing so confusing?"
EXPECT:
- The bundled issues are separated: a product defect (frequent logout, data loss), a legal threat, and a pricing or policy question. The card names each rather than forcing one topic.
- The legal threat drives Escalation = Yes with the specific reason; severity is the higher of the candidates (P1), not averaged down or under-triaged to P3.
- Because severity or topic is genuinely contested, a short decision brief is produced before the card commits.
- No customer name, account, or fact is invented; unknowns are marked Missing or Not provided.
- The pricing question is recorded as a secondary topic or a pattern signal, not escalated.
- Handoff file written, recording the escalation and the contested classification.

## Case C: missing-input
INPUT:
Can you triage my support inbox?
EXPECT:
- The skill asks once for the ticket content (Loop 1, Missing Input), because there is nothing to read or classify.
- It does not invent a ticket, a customer, a severity, or a pattern.
- It does not run the severity ladder or emit a card until ticket text exists.
- If the request were a single obvious ticket or an already-triaged queue, it would say so rather than running the full ceremony.
- Handoff file written, recording the run as not started and the input still needed.
