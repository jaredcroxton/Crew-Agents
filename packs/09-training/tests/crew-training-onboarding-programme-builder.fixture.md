# Fixture: crew-training-onboarding-programme-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
A complete role profile for an Account Manager. Reports to the Sales Lead. Systems: a CRM, a phone system, and email. Key people: the Sales Lead (manager), another AM as the buddy, one Customer Success contact. Ramp target: owns a named book of 15 accounts solo with a monthly review cadence by day 90. Delivery context: in-person, a desk in the office.
EXPECT:
- Output begins with "ONBOARDING PROGRAMME" and the header carries Role, Reports to, Built date, Delivery (in-person), and the ramp target. The header field for in-person/remote/hybrid is labelled Delivery, not Mode (Mode is reserved for Fast/Careful/Governed).
- A PRE-START block provisions the laptop and requests all accounts (CRM, phone, email) before day one, with the paperwork and a welcome note, a manager-prep line (block the day-one calendar, brief and confirm the buddy is willing, line up the intros), a reasonable-adjustments line (asked, and Escalated to the business if any are needed), and a pre-start ready gate.
- A DAY ONE block has the workspace and the logins confirmed live (access provisioned in pre-start, not first appearing later), the people-map introductions (the Sales Lead, the buddy AM, the Customer Success contact), a baseline health-and-safety or site induction before any work, and one human connection. The day-one gate proves access exists; it does not certify a login that lands in a later phase.
- Phases WEEK ONE, FIRST MONTH, and FIRST QUARTER are each present, in order.
- Every item sits in exactly one phase; no item precedes its prerequisite (CRM read-only access confirmed live on day one then consumed in week one by reading histories and shadowing, CRM edit access in first month, shadow account calls before running them solo). No gate certifies access that has not yet landed.
- Every gate is a yes/no with named evidence, a named confirmer (the Sales Lead), and an if-failed action.
- The ramp target appears as the quarter gate (owns the 15-account book solo with retention held at or above baseline).
- A buddy is named (the buddy AM) with a first-week cadence, and an escalation path is named (blocked hire to manager, failed gate up the line, HR or wellbeing issue to HR).
- The 4 Cs are covered (Compliance, Clarification, Culture, Connection), not all task and no belonging.
- A programme-measures line is present (time-to-productivity against day 90, plus a 90-day retention or new-starter experience check), distinct from the readiness gates.
- Nothing is invented beyond the inputs: no system, no person, no policy, no date the inputs did not supply, and role labels like "the Sales Lead" and "the buddy AM" are used rather than invented proper names.
- Handoff file `~/.claude/crew-state/training/crew-training-onboarding-programme-builder-handoff.md` was written.
- No em dashes anywhere.

## Case B: messy
INPUT:
A safety-critical, partly-remote warehouse operations role with gaps. The tool stack is only partly named ("they use some CRM and a couple of the usual tools"). No ramp target is given. The role needs a mandatory safety induction before any work on the floor. The requester also asks "set the probation criteria too" and, because the hire is remote for the first two weeks, asks how to handle equipment.
EXPECT:
- The unnamed CRM is written "[system not named]" (and any other implied tool the same way), never invented into a specific product.
- The missing ramp target is written "Ramp target: Assumed [the core responsibility]" for the manager to correct, never a fabricated metric (no invented throughput number, defect rate, or volume).
- The mandatory safety induction is placed as a hard DAY ONE gate before any work on the floor, AND its specifics (the legal requirement, the induction content) are Escalated to the business; the skill does not invent the induction content or the legal-requirement detail.
- The probation criteria are Escalated to the business with who owns it (the manager with HR), never set by the skill.
- Because the hire is remote for the first two weeks, equipment shipping is sequenced into PRE-START with lead time and the buddy is made deliberate (a virtual buddy, scheduled contact), not assumed to be a corridor chat or a physical desk.
- Reasonable adjustments are asked about and, if any are needed, sequenced into PRE-START with lead time and Escalated to the business to confirm and arrange, never invented (a duty the employer owns under local law, the jurisdiction set in brand-context.md).
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- Handoff file `~/.claude/crew-state/training/crew-training-onboarding-programme-builder-handoff.md` was written, recording the unnamed system, the assumed ramp target, and the escalated compliance induction and probation decisions.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Build onboarding for the new person." No role profile, no systems, no people, no ramp target. Only that someone is starting.
EXPECT:
- Loop 1 fires. The skill names what is missing (the role profile: title, level, responsibilities, who they report to) and why it matters (every phase derives from what the role actually does).
- It asks once, plainly, for the role profile.
- It invents no role, no system, no person, no ramp target, and no phase content.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file `~/.claude/crew-state/training/crew-training-onboarding-programme-builder-handoff.md` was still written, recording the missing role profile so the next run knows.
- No em dashes anywhere.
