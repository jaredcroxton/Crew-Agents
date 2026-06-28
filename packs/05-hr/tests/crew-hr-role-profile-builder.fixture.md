# Fixture: crew-hr-role-profile-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
New role, Dispatch Coordinator, sitting under the Operations Manager in the Operations team. The team is accountable for getting orders shipped on the promised day across 12 drivers. It exists now because the ops manager is hand-building the dispatch schedule herself and cannot scale. Level is Coordinator. Must-haves the business already knows: experience with a route or dispatch system, spreadsheet fluency. Current ops report shows mis-shipped orders around 2 percent. The role can reassign routes and call standby drivers, but hiring permanent drivers and changing customer SLAs go to the manager.

EXPECT:
- Output begins with the `ROLE PROFILE` block and includes Title, Team, Reports to: Operations Manager, Type: New role, Level: Coordinator, Date.
- Purpose is exactly one sentence in the form "This role exists to [outcome] so that [benefit]", naming the specific mechanism (dispatch schedule accuracy), not "operational excellence".
- Responsibilities are ranked, each starts with a verb and an object, each tagged Core or Supporting; the role is not overloaded (around eight Core or fewer).
- At least three success measures, each with a Type from {Output, Quality, Timeliness, Behaviour} AND a Basis; the 2 percent mis-ship figure is tagged Basis: Evidence (current ops report); manager-set bars tagged Proposed.
- A 30/60/90 ramp is present and is clearly distinct from the ongoing steady-state measures (the day-30 expectation is not the full steady-state bar).
- Capabilities are split into Must-have (route/dispatch system, spreadsheets) and Nice-to-have, with nothing trainable (for example cold-chain awareness) smuggled into Must-have.
- The title is plain and market-recognised (Dispatch Coordinator), and the level is not inflated above Coordinator.
- Decision rights list "can decide" (reassign route, call standby) versus "must escalate" (hire permanent driver, change SLA).
- The pay band and grade are Escalated and jurisdiction-neutral (no named statute, no assumed currency or market figure), not invented.
- Handoff file `~/.claude/crew-state/hr/crew-hr-role-profile-builder-handoff.md` was written, naming what `crew-hr-interview-guide` needs next.
- No em dashes anywhere.

## Case B: messy
INPUT:
"We need a rockstar Office Ninja who can do a bit of everything, basically a Senior Manager but also just sort the post and book travel and run payroll and own our culture and be across all departments. Reports into, hmm, either the COO or the office, not sure. They should obviously have 10 years experience and a CIPA cert I think? It's kind of a backfill but the last person did way less. Make the title sound impressive."

EXPECT:
- Flags the role as overloaded: payroll, travel, culture, post, and cross-department work are not one coherent role; states the purpose cannot be written as one sentence and asks the manager to split or narrow it, or proposes a focused purpose and marks the rest Supporting / out of scope (the two-roles call).
- Classifies the trigger honestly. The brief says backfill but "the last person did way less", so it is a Reshape, not a Backfill, and says why.
- Refuses to inflate the title. Does not ship "Senior Manager" or "Office Ninja" as the level; writes a plain title and marks Level: "Not provided, manager to set" since seniority is contradictory.
- Strips AI-slop: no "rockstar", "ninja", "wear many hats".
- The "10 years experience" and "CIPA cert" are treated as an adverse-impact / pool-narrowing risk: they are marked "Proposed, manager to confirm" or "Not provided, manager to set", the underlying capability is named instead (for example "can run a compliant payroll cycle"), and the pool is not gated on the unjustified credential; the cert name is neither invented nor corrected.
- Reporting line is contradictory, so writes "Reports to: Not provided" rather than picking COO or office.
- Does not fabricate a pay band; marks it Escalated and jurisdiction-neutral.
- No named national statute or agency appears anywhere (the adverse-impact and pay language stays jurisdiction-neutral).
- Handoff written, recording the overload flag and the reshape decision.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Can you write me a role profile for a Marketing Assistant? That's all I've got right now."

EXPECT:
- Loop 1 fires: names the specific gap, the role purpose (why this role exists now) is missing, and explains responsibilities and success measures are guesswork without it.
- Asks once, plainly, for that one thing (the purpose / the gap it fills), not a batch survey.
- Does not invent responsibilities, success measures, a reporting line, a level, a salary, or required certifications. Any field it cannot fill is marked "Not provided" rather than guessed.
- If it produces a partial scaffold, every unconfirmed field reads "Not provided, manager to set"; nothing is fabricated to look complete.
- Handoff file `~/.claude/crew-state/hr/crew-hr-role-profile-builder-handoff.md` still written, recording that the run is blocked on the missing purpose and what is needed to resume.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- No em dashes anywhere.
