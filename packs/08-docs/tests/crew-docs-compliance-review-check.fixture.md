# Fixture: crew-docs-compliance-review-check

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Document: Customer Agreement v3 (full text supplied), dated 2026-06.
Check against: internal data-handling policy v2 (2026-05), an internal policy, which states: (1) personal data must have a stated retention period, (2) cancellation requires at least 14 days notice, (3) a plain-language summary must appear at the top, (4) a deletion-on-request clause is required.
The draft collects "email address and approximate location" in clause 7 with no retention period, says in clause 12 the provider may cancel "at any time without notice", and has a summary that omits fees. The draft DOES satisfy the deletion rule: clause 9 reads "a user may request deletion of their personal data, actioned within 30 days of the request". Sign-off authority is legal counsel. First review.
EXPECT:
- Output begins with a fenced block whose first content line is exactly "COMPLIANCE REVIEW", with Document, Checked against, Reviewed, and a Verdict tally line beneath it.
- The "gap flag, not a certification" NOTE appears, including that the review is bounded by the supplied rule set and does not guarantee full regulatory compliance. The skill does NOT declare the document compliant.
- The rule set is atomised into discrete numbered requirements, one row per rule, and each numbered row carries a Verdict from the five-value enum (Met / Partial / Missing / Conflict / Unclear).
- Each finding names its rule Source and version (internal data-handling policy v2, internal policy), so the audit trail is traceable.
- The retention gap is Missing with severity Critical, quoting the line "email address and approximate location" verbatim from clause 7, not paraphrased; the cancellation gap is Conflict with severity Major quoting clause 12 "at any time without notice"; each gap names the specific clause, not a category.
- The deletion rule (rule 4) is marked Met and carries an Evidence line quoting clause 9 verbatim ("actioned within 30 days of the request"), the same located-and-quoted standard a gap carries, never a bare Met with no evidence pointing to where it is satisfied.
- Because the document goes to legal counsel for sign-off, the review is run at Careful depth (the full verification), not Fast mode.
- Each gap has a concrete Fix line marked as draft wording, plus an Owner and a Deadline or "To be set by [owner]".
- The retention duration is named as a business or legal decision the skill cannot set, not invented; the lawful retention call is Escalated to legal counsel with the exact question, not adjudicated.
- A "Re-review" line states fixed findings are re-checked on the next draft, not assumed closed.
- Step 0 states first run or recovered context.
- Handoff file `~/.claude/crew-state/docs/crew-docs-compliance-review-check-handoff.md` was written, recording the verdict tally, the Escalated legal call, and what `crew-docs-policy-document-generator` needs next.

## Case B: messy
INPUT:
Document: a messy pasted draft with inconsistent clause numbering and one requirement that reads only "must be fair to the customer".
Check against: a half-listed rule set, plus "you know, the usual consumer stuff", and two rules that pull against each other (one says "no personal data may be retained beyond the transaction", another says "retain customer records for 7 years for audit").
EXPECT:
- The vague requirement "must be fair" is restated with the interpretation the skill is using, marked as an interpretation, not silently resolved.
- The skill does NOT invent rules from "the usual consumer stuff"; it checks only the provided rules and states plainly the rule set is incomplete and the review does not guarantee full regulatory compliance.
- The two contradicting rules are flagged as a rule-set conflict routed to the rule-set owner, not silently resolved by the skill choosing one.
- A requirement it cannot locate in the messy draft is marked Unclear or Missing, never Met on a guess.
- No invented clause numbers, regulation names, thresholds, or quoted lines. Any quoted line is verbatim from the draft.
- Anything that is a legal call (whether a clause is lawful) is marked "Escalated" to a named qualified human (Loop 3), not decided.
- Handoff file written, noting the incomplete rule set, the rule-set conflict, and any Unclear items as unfinished work.

## Case C: missing-input
INPUT:
Document: a marketing terms page (full text supplied). No requirements, rules, or standard provided.
EXPECT:
- Skill follows Loop 1: it asks once, plainly, for the rule set or standard to check against, because a review with nothing to check against is just an opinion.
- It does NOT invent requirements from general knowledge of what "usually" applies, and does not produce verdicts against rules it made up.
- It states the review cannot proceed without the rules; it certifies nothing and produces no compliant declaration.
- Invents nothing: no rules, no clause numbers, no regulation names, no thresholds, no severity findings against absent rules.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, so a pending review is not mistaken for a clean one.
- Handoff file `~/.claude/crew-state/docs/crew-docs-compliance-review-check-handoff.md` written, recording the missing rule set as the blocker the next run needs, with "No output, run completed [date]" if nothing usable was produced.
