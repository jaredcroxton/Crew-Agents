# Fixture: crew-support-escalation-review

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Ticket 4821. Issue text: customer ordered a paid same-day delivery on 2026-06-05, promised within 3 days, it arrived day 11. They write "this is a clear breach of clause 4.2 and my lawyer will be in touch", and demand a full refund plus compensation. Context: account is mid-tier, second contact on this issue, agent has apologised and paused the account but offered no money. Escalation rules supplied: Legal owns contract and breach calls; Finance owns refunds; the agent's refund limit is 100.
EXPECT:
- Output begins with "ESCALATION REVIEW" and includes an "Issue:" line, a "Customer asks:" line, a "Reviewed:" date, and "Ticket: 4821".
- A "Triggers fired:" block naming at least the Legal or compliance trigger (contract breach, lawyer named) and the Financial trigger (demand above the agent's limit), each tagged with its family.
- A "Risk level:" line set to High or Critical with a "Reason:" given.
- A "Decision needed:" line that states the call and that it is above the agent's authority.
- An "Owner:" line naming the role per Routing logic (Legal or Finance per the supplied rules, no "Assumed: confirm" since rules were given), and the size of the call (not the customer's volume) drives who owns it.
- An "Exact question for the owner:" line phrased as one yes/no or number question.
- An "Escalation note" block following the Response framework (acknowledge what happened and the ask, assess the trigger and risk and what is already done, action the decision needed, timeline), with any inference labelled.
- A "Pattern:" line classifying the issue one-off or systemic.
- A "Next step:" line that says escalate now.
- Handoff file `.claude/crew-state/support/crew-support-escalation-review-handoff.md` was written.

## Case B: messy
INPUT:
"Big angry customer, sounds important, maybe wants money back? They mentioned going on Twitter. Not sure how much they paid. Think they've emailed before." No ticket id. No escalation rules supplied. No exact refund figure. No SLA or contract clause quoted.
EXPECT:
- Skill restates the complaint and the ask separately, marking the demand "Not stated" where the input does not give a clear number rather than inventing one.
- Triggers are named from the default taxonomy (Reputation for the public-threat signal, Relationship for the repeat contact), not "it seems serious".
- Because no escalation rules were supplied, each owner is marked "Assumed: confirm".
- Threshold is marked "Threshold not provided: confirm limit"; no refund figure, SLA, or clause is fabricated, and Ticket shows "not provided".
- Borderline signals push the risk level up rather than down, with the reason stated (under-escalating costs more), per Severity classification.
- The repeat contact ("emailed before") is read through Pattern recognition: the Relationship trigger fires and the Pattern line considers whether this is one-off or a systemic repeat, rather than only escalating the single instance.
- Handoff file written, noting the assumed owners and the missing threshold as unfinished work.

## Case C: missing-input
INPUT:
"Please run an escalation review on the Henderson account." (No issue text, no ticket, no customer words, no context provided.)
EXPECT:
- Skill follows Loop 1 (Missing Input): it asks once, plainly, for the issue text, because risk cannot be judged on an account label alone.
- It does not fabricate a complaint, a customer quote, a refund amount, a trigger, or a risk level against an unknown issue.
- If it emits any partial output, the issue, triggers, and risk fields are marked "Not provided" rather than filled.
- Handoff file written, recording the missing issue text as the blocker the next run needs.
