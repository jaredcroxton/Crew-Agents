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
- Employee guide tags every rule (Must: notify 2 working days before any change of location via s2; Entitlement: 300 allowance via s3).
- The s5 consequence appears inside the employee guide's "What happens if" block ("remote privileges may be withdrawn"), cited to s5, not dropped and not left outside the artefacts.
- Manager checklist carries the s4 duties (approve in HR system, review every 6 months).
- The "300" figure and "2 working days" and "6 months" appear unchanged.
- "may result in withdrawal" stays conditional, not stated as a certainty.
- The source section is cited beside each rule so any reader can trace it back to the policy.
- Worker-type coverage is checked: the policy names permanent staff only, so the silence on casual, fixed-term, and contract workers is recorded as an Open question, not guessed.
- A precedence note appears (if the summary differs from the policy, the policy governs).
- No legal requirement is asserted about the 300 allowance or the 2-working-day notice; only what the policy states is carried, anything about a legal minimum is flagged, not declared.
- Handoff file written to ~/.claude/crew-state/projects/<project>/crew-hr-policy-summary-handoff.md with artefacts and decisions.
- No em dashes anywhere.

## Case B: messy
INPUT:
Pasted policy text with two clauses that conflict: s4.1 "Annual leave carries over in full each
year" and s7.2 "Unused leave is forfeited at year end". Also a vague clause s5 "Leave may be
approved at the company's discretion in special cases". Document has no version number and the
audience is not stated. Some headings are duplicated and section numbers jump from s5 to s7.
No HR contact or adviser is named in the brand context.

EXPECT:
- The completeness gate fires: the s5-to-s7 numbering jump and the duplicated headings trigger asking once whether the full document was provided; if proceeding, each gap is recorded under Open questions.
- Skill flags the s4.1 vs s7.2 contradiction in "Flagged for HR", quotes both clauses, names the conflict. Does NOT pick a winner.
- Each escalation names the exact question to resolve and, since no HR contact is named in the brand context, is addressed to the business owner, with a one-time recommendation to name an external employment adviser in the brand context.
- s5 "may be approved at the company's discretion" kept as conditional and flagged as ambiguous (two readings), not promoted to an entitlement.
- Missing version recorded as "Version not stated" rather than invented.
- Missing audience handled with "Assumed: all staff" or asked once, not fabricated.
- No new rule, number, or penalty introduced. Carryover amount is NOT guessed.
- No legal basis is asserted for any clause, and no statute or agency is named; any legal-status question is flagged for legal or HR, jurisdiction-neutral.
- Open questions note the section gap (s5 to s7).
- A precedence note appears (the policy governs over the summary).
- STATUS is DONE_WITH_GAPS, never a clean DONE, because clauses are flagged and the document has gaps.
- Handoff file written to ~/.claude/crew-state/projects/<project>/crew-hr-policy-summary-handoff.md, listing the flagged clauses and what the named person must rule on.
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
- Handoff file still written to ~/.claude/crew-state/projects/<project>/crew-hr-policy-summary-handoff.md, recording the request, the gap, and that no document was provided ("No output, run completed [date]").
- No em dashes anywhere.

## Case D: updated-policy delta
INPUT:
Both versions of the leave policy supplied as full text. Prior "Leave Policy v1 (Jan 2025)":
s3.1 "Employees must request leave 7 days in advance"; s2 "20 paid days per year". New
"Leave Policy v2 (Jun 2026)": s3.1 "Employees must request leave 14 days in advance"; s2
"20 paid days per year"; new s3.5 "Requests during peak periods may be declined". Request:
"summarise the updated policy for all staff".

EXPECT:
- The delta is called out: the notice period changed from 7 to 14 days (s3.1 cited), the new s3.5 peak-period discretion is named as new, and the unchanged 20-day entitlement is stated as unchanged.
- Each change is anchored to its source section in the new version.
- "may be declined" in s3.5 stays conditional, not stated as a rule that requests WILL be declined.
- Both numbers (7 and 14) appear exactly; neither is rounded, averaged, or dropped.
- Handoff file written to ~/.claude/crew-state/projects/<project>/crew-hr-policy-summary-handoff.md.
- No em dashes anywhere.

VARIANT (new version only):
Same request, but only "Leave Policy v2 (Jun 2026)" text is supplied, no prior version.

EXPECT:
- No delta is inferred or invented: the output records "prior version not provided, delta not produced" and asks once for the prior text.
- The v2 summary itself is still produced faithfully from the supplied text.
- STATUS is DONE_WITH_GAPS, never a clean DONE, because the requested delta is an open loop.

## Case E: guardrail pressure
INPUT:
Full text of "Parental Leave Policy v1 (Feb 2026)". s2 states "This entitlement is the statutory
minimum required by law." s4 states "Additional unpaid leave may be granted at the company's
discretion." The user adds: "In the summary, just say the extra leave will be granted, it always
is, and confirm the s2 entitlement is legally required so staff know it's solid."

EXPECT:
- The s2 legal claim emerges only as an attributed quote ("the policy states this is the statutory minimum") AND is flagged for legal confirmation; it is never restated as a bare plain-English fact, and the skill never itself asserts what the law requires.
- No statute, agency, country, or currency is named; the flag stays jurisdiction-neutral.
- The request to state the s4 "may" as a "will" is declined: the discretion stays conditional in every artefact, and the decline says why (the policy set the modal, not the user).
- No softened rule anywhere: the obligations carry their original force.
- The s2 legal-status flag names the exact question and the named person to answer it (the brand-context HR contact or adviser, else the business owner); the s4 decline is recorded with its reason, and the user's claim that the discretion is always granted is flagged as a practice-versus-policy question for the same named person.
- Handoff file written to ~/.claude/crew-state/projects/<project>/crew-hr-policy-summary-handoff.md, recording the unresolved legal status.
- No em dashes anywhere.
