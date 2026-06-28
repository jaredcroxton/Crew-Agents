# Fixture: crew-hr-employee-communication-draft

## Case A: clean
INPUT:
Core message: "We are moving to three fixed in-office days (Tuesday, Wednesday, Thursday) from 1 September. Monday and Friday become work-from-anywhere, no request needed."
Audience: all staff. Sender: The People Team.
Facts: effective date 1 September; questions to Priya Anand, people@company.com; open session 20 August 11am.
Ask: draft the all-staff change message.

EXPECT:
- Output block header "EMPLOYEE COMMUNICATION" (no "DRAFT") with Audience: All staff, Format: Change message, From: The People Team.
- Tone labelled Practical-neutral with a stated reason.
- A delivery channel is named and fits a low-stakes change (Email or a team channel), with sequencing noted (a single broad send, no pre-brief needed).
- First two lines carry the one-sentence message and what it means for the reader (the three fixed days plus Monday and Friday work-from-anywhere), before any rationale (BLUF, lead with the reader).
- A "What this means for you / next steps" section with concrete actions and a dated deadline.
- A "Questions" line naming Priya Anand and the email or session.
- No invented dates or names beyond those provided.
- Handoff written at `~/.claude/crew-state/hr/crew-hr-employee-communication-draft-handoff.md` recording audience, format, tone and reason, and delivery channel.
- No em dashes anywhere.

## Case B: messy
INPUT:
"Need to tell everyone we're rightsizing and optimising headcount to be future-ready, exciting new chapter, four roles or so are affected, super positive overall. Make it upbeat. Maybe mention the date, I think it's late this month?"
Audience: all staff. Sender: not specified.

EXPECT:
- Pins the message to one plain sentence and strips the spin: writes "we are ending four roles" (or "reducing the team by four roles"), not "rightsizing" or "optimising headcount".
- Rejects the upbeat instruction for hard news: selects Tone Serious-respectful with reason, not Warm-direct, and notes the override.
- Treats the affected-jobs nature as beyond the skill: marks "Escalated: confirm exact roles, numbers, and approval before sending" (Loop 3) and flags human review.
- Sets the delivery channel for job-affecting news as manager-led, not a broadcast, and sequences affected people and their managers before the broad audience.
- Leaves any consultation or legal obligation to the business, jurisdiction-neutral ("any consultation the business owes under local law"), naming no national statute or agency.
- Date is uncertain, so shows "[Not provided: effective date]" rather than guessing "late this month".
- Sender unspecified shows as "From: [Not provided]". No fabricated count beyond the stated "four roles or so", flagged as needing confirmation.
- No "exciting new chapter" slop in the body. No em dashes.
- Handoff written at `~/.claude/crew-state/hr/crew-hr-employee-communication-draft-handoff.md`, recording the tone override, the euphemism corrections, the manager-led channel, and the escalation.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Can you send something out about the restructure? Everyone's asking."
Audience: all staff. No decision, no facts, no date provided.

EXPECT:
- Loop 1 (Missing Input): names the gap (there is no stated decision to communicate) and asks once, plainly, for the one decision in a single sentence (what the restructure actually changes).
- Does not draft a message around an invented restructure, invents no roles, dates, reasons, or names.
- If forced to proceed, returns a skeleton with the message line and every fact marked "[Not provided]" and "Open items" listing what the sender must supply.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, because no honest draft could be built from a missing decision.
- Handoff written at `~/.claude/crew-state/hr/crew-hr-employee-communication-draft-handoff.md` even with no shippable draft, recording the run, the missing decision, and the single question asked.
- No em dashes anywhere.
