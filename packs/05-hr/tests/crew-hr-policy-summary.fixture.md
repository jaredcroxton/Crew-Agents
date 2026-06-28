# Fixture: crew-hr-policy-summary

## Case A: clean
INPUT:
Full text of "Remote Work Policy v2 (Mar 2026)", applies to all permanent staff.
Key clauses: s1 purpose; s2 "Employees must work from a registered home address and must
notify their manager 2 working days before any change of location"; s3 "Staff are entitled to
a one-time 300 home-office allowance"; s4 "Managers must approve remote days in the HR system
and must review each arrangement every 6 months"; s5 "Repeated unapproved location changes may
result in withdrawal of remote privileges". Audience: all staff. House style: plain, second person.

EXPECT:
- Output header "POLICY SUMMARY" with Policy name/version, Applies to, Source.
- One-page summary in plain English, second person, source sections cited (s2, s3).
- Employee guide tags every rule (Must: notify 2 days ahead via s2; Entitlement: 300 allowance via s3; Consequence: privileges may be withdrawn via s5).
- Manager checklist carries the s4 duties (approve in HR system, review every 6 months).
- The "300" figure and "2 working days" and "6 months" appear unchanged.
- "may result in withdrawal" stays conditional, not stated as a certainty.
- The source section is cited beside each rule so any reader can trace it back to the policy.
- A precedence note appears (if the summary differs from the policy, the policy governs).
- No legal requirement is asserted about the 300 allowance or the 2-working-day notice; only what the policy states is carried, anything about a legal minimum is flagged, not declared.
- Handoff file written to ~/.claude/crew-state/hr/crew-hr-policy-summary-handoff.md with artefacts and decisions.
- No em dashes anywhere.

## Case B: messy
INPUT:
Pasted policy text with two clauses that conflict: s4.1 "Annual leave carries over in full each
year" and s7.2 "Unused leave is forfeited at year end". Also a vague clause s5 "Leave may be
approved at the company's discretion in special cases". Document has no version number and the
audience is not stated. Some headings are duplicated and section numbers jump from s5 to s7.

EXPECT:
- Skill flags the s4.1 vs s7.2 contradiction in "Flagged for HR", quotes both clauses, names the conflict, marks "Escalated: HR to rule". Does NOT pick a winner.
- s5 "may be approved at the company's discretion" kept as conditional and flagged as ambiguous (two readings), not promoted to an entitlement.
- Missing version recorded as "Version not stated" rather than invented.
- Missing audience handled with "Assumed: all staff" or asked once, not fabricated.
- No new rule, number, or penalty introduced. Carryover amount is NOT guessed.
- No legal basis is asserted for any clause, and no statute or agency is named; any legal-status question is flagged for legal or HR, jurisdiction-neutral.
- Open questions note the section gap (s5 to s7).
- A precedence note appears (the policy governs over the summary).
- Handoff file written, listing the flagged clauses and what HR must rule on.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Can you summarise our new disciplinary policy into a one-pager? It's the standard kind."
No policy document text is attached, only the request and a name.

EXPECT:
- Loop 1 (Missing Input) fires: names the gap ("the full policy text is missing, only a name was given").
- Asks once, plainly, for the actual policy document, because rules cannot be reworded from a title.
- Invents no rule, no deadline, no penalty, no entitlement, and no manager duty from a generic "standard" disciplinary policy.
- Does not produce a fabricated summary in place of the real one.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, because no honest summary could be built.
- Handoff file still written, recording the request, the gap, and that no document was provided ("No output, run completed [date]").
- No em dashes anywhere.
