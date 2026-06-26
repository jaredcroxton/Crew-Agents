# Fixture: crew-docs-policy-document-generator

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Topic: Remote Work Policy, applies to permanent staff past probation, excludes contractors and field roles, owner is Head of People.
Rules: staff may work remotely up to 3 remote days per week with manager approval; staff must be reachable on the team channel during core hours (core hours means 10am to 3pm local) and must reply within 2 hours; staff must not handle customer records on personal devices; requests beyond 3 days go to the Head of People in writing, who records the decision. Repeated unreachability during core hours is handled under the standard performance process, with a chance to respond first. Reviewed annually.
EXPECT:
- Output begins with a fenced block whose first content line is exactly "POLICY DOCUMENT", with a "POLICY:" line carrying "Status: Draft, pending review" directly beneath it.
- Type is classified correctly as Operational, with an Owner line (Head of People), plus Version and Effective date lines (each captured or "To be set by [owner]").
- Mandatory structure present: Purpose, Scope, Definitions, Rules (numbered), Expectations and process, Exceptions, Consequences of breach, Owner, Review date.
- Normative verbs are used correctly: the remote-days rule reads "may" (optional/permitted), the reachability and customer-records rules read "must" / "must not" (mandatory).
- Scope names the exclusions (contractors and field roles), not just who is covered.
- The disputable term "core hours" is defined once ("10am to 3pm local time"), and the core-hours rule names the 2-hour reply, not "be available".
- The exception path names an approver (Head of People) and a record kept, not a blanket override.
- Consequences keep procedural fairness (a chance to respond before the performance process), and no disciplinary step or penalty beyond the supplied rules is invented.
- Every mandatory (must / must not) rule is tied to a stated consequence or a flagged consequence gap; no must-rule ships with a silent blank.
- Because the policy sets availability conditions, the consultation question (whether award or enterprise-agreement consultation is required and has happened before the effective date) is flagged "To be set by [owner]" and routed to crew-docs-compliance-review-check, not assumed complete.
- An Acknowledgement field is present, capturing how staff acknowledge the policy or marked "To be set by [owner]".
- Owner, version, effective date, and review date are captured or marked "To be set by [owner]"; nothing is invented.
- A "Sign-off required: Escalated" line names HR or Legal review (Loop 3), and the whole document is "Draft, pending review".
- Handoff file `.claude/crew-state/docs/crew-docs-policy-document-generator-handoff.md` was written.

## Case B: messy
INPUT:
"We need some kind of work-from-home rule. People should be online during the day. Maybe two or three days from home? Someone said data needs protecting and there might be privacy or work-health-and-safety stuff we have to follow, I am not sure which. We also want to be able to pull someone's remote days if performance drops, but I have not worked out the exact trigger. Use our line: 'We trust our people to do the right thing.'"
EXPECT:
- Skill does not invent the day count. It flags "two or three days" as a gap, "To be set by [owner]", rather than picking a number (no invented threshold).
- "online during the day" is sharpened into a specific, enforceable rule or flagged as needing a core-hours definition, not left vague.
- The supplied approved line "We trust our people to do the right thing." is used verbatim where it fits, not reworded.
- The possible privacy or work-health-and-safety conflict is flagged and routed to crew-docs-compliance-review-check, with no asserted compliance and no invented statutory citation (the skill does not claim the policy "complies with the Privacy Act" or invent a section number).
- The performance trigger the business "has not worked out" is marked "To be set by [owner]" and Escalated, with no invented disciplinary step, penalty, or termination trigger, and procedural fairness preserved.
- Because pulling remote days for performance changes conditions and carries a consequence, the consultation question is flagged and routed to crew-docs-compliance-review-check, not assumed; and any must-rule with no stated consequence is flagged "To be set by [owner]", not left silently blank.
- No invented threshold, citation, approver name, version history, or effective date. Document still marked "Draft, pending review", sign-off Escalated.
- Handoff file `.claude/crew-state/docs/crew-docs-policy-document-generator-handoff.md` was written, listing the unresolved day count, the routed compliance question, and the unset performance trigger as unfinished work.

## Case C: missing-input
INPUT:
"Write us a code of conduct policy." (No actual rules, prohibited behaviours, or consequences provided.)
EXPECT:
- Skill follows Loop 1: it asks once, plainly, for the real rules (what is expected, what is prohibited, the consequences), because a conduct policy with no rules is just headings. A topic alone is not enough.
- It asks once, not a batched survey, and does not fabricate conduct rules, prohibited behaviours, or disciplinary consequences to fill the template.
- If it proceeds at all, the Rules, Consequences, and Owner sections are marked "Not provided" or "To be set by [owner]", and the document is still "Draft, pending review" with sign-off Escalated.
- No version history, past approval, or effective date is fabricated; each is marked "To be set by [owner]".
- Handoff file `.claude/crew-state/docs/crew-docs-policy-document-generator-handoff.md` was written, recording the missing rule set as the blocker the next run needs.
