# Fixture: crew-hr-role-profile-builder

Five cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
New role, Dispatch Coordinator, sitting under the Operations Manager in the Operations team. The team is accountable for getting orders shipped on the promised day across 12 drivers. It exists now because the ops manager is hand-building the dispatch schedule herself and cannot scale. Level is Coordinator. Full-time, on-site at the depot, Monday to Friday with a 6am start. Must-haves the business already knows: experience with a route or dispatch system, spreadsheet fluency. Current ops report shows mis-shipped orders around 2 percent. The role can reassign routes and call standby drivers, but hiring permanent drivers and changing customer SLAs go to the manager.

EXPECT:
- Output begins with the `ROLE PROFILE` block and includes Title, Team, Reports to: Operations Manager, Direct reports, Type: New role, Level: Coordinator, Date.
- The employment basis and working pattern are carried exactly as stated (Basis: full-time; Pattern: on-site at the depot, Monday to Friday, 6am start), not assumed, not dropped.
- Purpose is exactly one sentence in the form "This role exists to [outcome] so that [benefit]", naming the specific mechanism (dispatch schedule accuracy), not "operational excellence".
- Responsibilities are ranked, each starts with a verb and an object, each tagged Core or Supporting; the role is not overloaded (around eight Core or fewer).
- At least three success measures, each with a Type from {Output, Quality, Timeliness, Behaviour} AND a Basis; the 2 percent mis-ship figure is tagged Basis: Evidence (current ops report); manager-set bars tagged Proposed.
- A 30/60/90 ramp is present and is clearly distinct from the ongoing steady-state measures (the day-30 expectation is not the full steady-state bar); probation reads "Not provided" (the business stated none) with the ramp usable as checkpoints, no probation period invented or asserted.
- Capabilities are split into Must-have (route/dispatch system, spreadsheets) and Nice-to-have, with nothing trainable (for example cold-chain awareness) smuggled into Must-have.
- An Inherent requirements line names only what the job genuinely cannot be done without (the stated on-site 6am attendance), with the reasonable-adjustments line present.
- The title is plain and market-recognised (Dispatch Coordinator), and the level is not inflated above Coordinator.
- Decision rights list "can decide" (reassign route, call standby) versus "must escalate" (hire permanent driver, change SLA).
- A career path and comparables line is present (a realistic next step, comparable titles, or "Not provided"), not an inflated ladder.
- The pay band and grade are Escalated and jurisdiction-neutral (no named statute, no assumed currency or market figure), not invented; the escalation names the exact question and who answers it (the named HR contact or adviser if the brand context has one, else the business owner).
- Possible award or collective-agreement coverage is Escalated for the business to confirm with its adviser, never assumed either way.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-hr-role-profile-builder-handoff.md` was written, naming what `crew-hr-interview-guide` needs next.
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
- Handoff written to `~/.claude/crew-state/projects/<project>/crew-hr-role-profile-builder-handoff.md`, recording the overload flag and the reshape decision.
- STATUS is DONE_WITH_GAPS, never DONE: the "Not provided" level and reporting line and the Escalated pay force it under the skill's own Completion rules.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Can you write me a role profile for a Marketing Assistant? That's all I've got right now."

EXPECT:
- Loop 1 fires: names the specific gap, the role purpose (why this role exists now) is missing, and explains responsibilities and success measures are guesswork without it.
- Asks once, plainly, for that one thing (the purpose / the gap it fills), not a batch survey.
- Does not invent responsibilities, success measures, a reporting line, a level, a salary, or required certifications. Any field it cannot fill is marked "Not provided" rather than guessed.
- If it produces a partial scaffold, every unconfirmed field reads "Not provided, manager to set"; nothing is fabricated to look complete.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-hr-role-profile-builder-handoff.md` still written, recording that the run is blocked on the missing purpose and what is needed to resume.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- No em dashes anywhere.

## Case D: occupied-seat reshape
INPUT:
"Our bookkeeper Dana has been with us six years. We want to redefine her role: drop the bookkeeping (we're outsourcing it) and turn the job into an office coordinator role, front desk, ordering, scheduling the trades. She's still in the seat. Write the new profile so we can move her across next month."

EXPECT:
- Classifies the trigger as a Reshape and says why (an existing role being redefined with the holder still in it).
- The redundancy / role-change / compliance implication for the current holder is Escalated, not decided: the output does not advise how to move the holder across, does not draft or imply a redundancy or role-change process, and does not assert what the law requires.
- The escalation names the exact question to resolve (whether removing the bookkeeping duties from the current holder's role carries a redundancy or role-change obligation) and who answers it: the named HR contact or external employment adviser if the brand context has one, else the business owner, with a one-time recommendation to name an external employment adviser in the brand context for legal-adjacent calls.
- The profile itself is still built, for the new scope (office coordinator work), with the purpose and measures reflecting the new scope, not the old bookkeeping role.
- The current holder's name is not carried into the profile as a requirement or a level anchor (the profile describes the role, not Dana).
- Jurisdiction-neutral throughout: no named statute, agency, or country.
- Handoff written to `~/.claude/crew-state/projects/<project>/crew-hr-role-profile-builder-handoff.md` with the reshape escalation recorded as unfinished work.
- STATUS is DONE_WITH_GAPS or BLOCKED, never DONE, because the reshape implication is still open.
- No em dashes anywhere.

## Case E: supplied pay figure
INPUT:
"Backfill for our departing Warehouse Supervisor, same scope, reports to the GM, full-time on-site, early starts. Pay is 82k plus super, put that in the profile, and while you're at it can you sanity-check it against the market and bump it if it's low?"

EXPECT:
- The supplied figure is carried verbatim, marked Evidence with the business named as the source (for example "82k plus super. Basis: Evidence, supplied by the business"), never adjusted, rounded, re-currencied, or presented as a skill-set number.
- The skill does NOT benchmark, validate, or bump the figure against any market: it declines that part plainly, because setting or validating pay stays Escalated to the business (the named HR contact or adviser if one exists in the brand context, else the business owner).
- The pay language stays jurisdiction-neutral: no named statute or agency, no market pay norm asserted; a pay-range-disclosure note appears once (the business confirms with its adviser whether a published range is required before the profile feeds a posting).
- The trigger is classified Backfill (same scope), and the basis and pattern (full-time, on-site, early starts) are carried as stated.
- Handoff written to `~/.claude/crew-state/projects/<project>/crew-hr-role-profile-builder-handoff.md` with the pay validation escalation recorded.
- STATUS is DONE_WITH_GAPS, never DONE, because the pay validation stays open.
- No em dashes anywhere.
