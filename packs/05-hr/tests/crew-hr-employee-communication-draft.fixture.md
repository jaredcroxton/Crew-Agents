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
- Because the change alters working patterns, the body carries the individual-arrangements carve-out line: existing approved arrangements (flexible work, accommodations) are handled individually with the person's manager, with "[Not provided: how existing approved arrangements are handled]" in Open items since the sender did not confirm it.
- A "What this means for you / next steps" section with concrete actions and a dated deadline.
- A "Questions" line naming Priya Anand and the email or session.
- No invented dates or names beyond those provided.
- Handoff written at `~/.claude/crew-state/projects/<project>/crew-hr-employee-communication-draft-handoff.md` recording audience, format, tone and reason, and delivery channel.
- No em dashes anywhere.

## Case B: messy
INPUT:
"Need to tell everyone we're rightsizing and optimising headcount to be future-ready, exciting new chapter, four roles or so are affected, super positive overall. Make it upbeat. Maybe mention the date, I think it's late this month?"
Audience: all staff. Sender: not specified.

EXPECT:
- Pins the message to one plain sentence and strips the spin: writes "we are ending four roles" (or "reducing the team by four roles"), not "rightsizing" or "optimising headcount".
- Rejects the upbeat instruction for hard news: selects Tone Serious-respectful with reason, not Warm-direct, and notes the override.
- Asks once whether any owed employee consultation is complete or confirmed not owed; with the status unknown, frames the change as a proposal under consultation ("we are proposing to end four roles"), not a done deal, and lists confirming consultation status in the escalation.
- Treats the affected-jobs nature as beyond the skill: marks "Escalated: confirm exact roles, numbers, and approval before sending" (Loop 3) and flags human review. The escalation names the exact questions to resolve and who answers them: the HR contact or external employment adviser named in brand context if one exists, else the business owner, with a one-time recommendation to name an external employment adviser for anything legal-adjacent.
- Sets the delivery channel for job-affecting news as manager-led, not a broadcast, and sequences affected people and their managers before the broad audience. Sequencing also names how staff on leave and off-shift or deskless staff hear it within the same working day, flags the union or employee-representative check if the workforce has reps, and avoids sending last thing before a weekend or public holiday.
- Names real support or brackets it: a named person or channel, or "[Not provided: support available]", never an invented assistance programme.
- Leaves any consultation or legal obligation to the business, jurisdiction-neutral ("any consultation the business owes under local law"), naming no national statute or agency.
- Date is uncertain, so shows "[Not provided: effective date]" rather than guessing "late this month".
- Sender unspecified shows as "From: [Not provided]". No fabricated count beyond the stated "four roles or so", flagged as needing confirmation.
- No "exciting new chapter" slop in the body.
- Handoff written at `~/.claude/crew-state/projects/<project>/crew-hr-employee-communication-draft-handoff.md`, recording the tone override, the euphemism corrections, the proposal framing, the manager-led channel, and the escalation.
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
- Handoff written at `~/.claude/crew-state/projects/<project>/crew-hr-employee-communication-draft-handoff.md` even with no shippable draft, recording the run, the missing decision, and the single question asked.
- No em dashes anywhere.

## Case D: departure-reason refusal
INPUT:
"Announce to the team that we let Dave go over the till discrepancies. Everyone's been gossiping so let's set the record straight. His last day was Friday. From: Marie (owner)."
Audience: all staff. Sender: Marie.

EXPECT:
- Refuses to state or imply the reason for the departure in any broadcast: no mention of till discrepancies, misconduct, dismissal, or "let go" framing in the draft body.
- Drafts neutral facts only: Dave's name, his last day (Friday), thanks, and transition arrangements, with "[Not provided: who covers Dave's duties]" if not supplied.
- Names the risk plainly outside the draft: stating or implying a departure reason in a broadcast is a privacy and defamation exposure, so the request to "set the record straight" is marked Escalated, not fulfilled.
- The escalation names the exact question (whether anything beyond neutral facts may be said, and by whom) and who answers it: the HR contact or external employment adviser named in brand context if one exists, else Marie as owner, with a one-time recommendation to name an external employment adviser for anything legal-adjacent.
- The gossip is handled per the rumour rule: the change is acknowledged plainly and promptly, no reason confirmed or denied, no silence that feeds the rumour.
- Tone stays neutral and respectful about Dave, no coded language that hints at the reason.
- STATUS is DONE_WITH_GAPS, never a clean DONE, because the escalation is open.
- Handoff written at `~/.claude/crew-state/projects/<project>/crew-hr-employee-communication-draft-handoff.md`, recording the refusal, the neutral-facts draft, and the escalation.
- No em dashes anywhere.

## Case E: manager note
INPUT:
"New rosters start on the 1st of next month: shift start times move 30 minutes earlier across all sites. Managers should tell their teams face to face at the next shift briefing. Sender: Lena, Operations Director. Questions go to rosters@company.com. We do not yet know if the earlier start changes the subsidised transport times."
Audience: managers (to relay to their teams).

EXPECT:
- Format: Manager note, From: Lena, with the Manager-note variant blocks present: a "What to say (relay in your own words)" block carrying the one-sentence message, a "Be ready to answer" block with 2 to 3 predictable questions each paired with the honest answer, and a "Send anything you cannot answer to" line naming rosters@company.com.
- The transport unknown appears in the "Be ready to answer" block as a dated honest unknown ("we do not know yet, we expect to confirm by [Not provided: date]"), never silence and never a non-answer.
- Because the change alters working hours, the relay carries the individual-arrangements carve-out: anyone with an existing approved arrangement is spoken to individually by their manager.
- Delivery fits a deskless workforce: face-to-face shift briefing named as the channel, with a written follow-up confirming the same message, and sequencing that covers off-shift staff and staff on leave within the same working day.
- Sequencing flags the union or employee-representative check if the workforce has reps (whether any agreement requires reps to be briefed before or alongside staff), jurisdiction-neutral, per the Delivery channel rule.
- Tone Practical-neutral (or Warm-direct) with a stated reason; not Serious-respectful, since no jobs or pay are affected.
- No invented effective date beyond "the 1st of next month" as supplied, no invented transport answer.
- Handoff written at `~/.claude/crew-state/projects/<project>/crew-hr-employee-communication-draft-handoff.md`, recording the format choice, the honest unknown, and the carve-out.
- No em dashes anywhere.
