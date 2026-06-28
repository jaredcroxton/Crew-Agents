# Fixture: crew-sales-crm-cleanup

## Case A: clean
INPUT:
A 5-row contacts-and-deals export with all column names visible and a provided canonical stage set.
```
Records: contacts and deals. Stage set (canonical, provided): Discovery, Proposal, Negotiation, Closed Won, Closed Lost.
Row 1: Dana Vogel, dana@northwind.com, Northwind, owner=R.Lee, deal "Cold-chain pilot", stage Negotiation, value 24000, close 2026-07-15
Row 2: Sam Ortiz, sam@harborfreight.io, Harbor Freight, owner=R.Lee, deal "Warehouse SaaS", stage Discovery, value 8000, close 2026-08-01
Row 3: Dana Vogel, dana@northwind.com, Northwind Inc, owner=R.Lee, deal "Cold-chain pilot", stage Negotiation, value 24000, close 2026-07-15
Row 4: Priya Nair, priya@lumenworks.com, Lumenworks, owner=K.Adeyemi, deal "Analytics seat", stage Proposal, value 12000, close 2026-07-30
Row 5: Tom Reilly, (no email), Reilly Logistics, (no owner), deal "Fleet add-on", stage (blank), value (blank), close (blank)
```
EXPECT:
- Output begins "CRM CLEANUP PLAN" with Records (contacts and deals), Rows (5), Reviewed (date), and Stage set marked "provided".
- Missing data by severity: Row 5 named with its row and field, no owner, no email, and no stage classed Critical (breaks routing or reporting); no value and no close date classed Important. The Critical / Important / Cosmetic taxonomy is used, never "some records are incomplete".
- A duplicate pair matched on a named signal: Rows 1 and 3 matched on exact email cited with the value masked (for example "exact email (masked)" or "d***@northwind.com"), not the raw address, Confidence High, labelled "to review" not merged, with a suggested survivor named (these are contact pairs, so a survivor is appropriate).
- A proposed rename shown as a "from -> to" before and after, not applied: company "Northwind Inc" -> "Northwind" on Row 3.
- The prioritised checkbox checklist opens with item 1: export a timestamped snapshot of the affected records as the rollback point before any fix is applied, ahead of the Critical fixes. The remaining items are ordered Critical gaps and the High-confidence duplicate first and cosmetic standardisation last, each line a checkbox with the row, the action, and the reason it matters.
- Each action names an owner; an ownerless record is flagged to a named triage role (for example sales ops) to assign an owner, not just dropped in an unassigned queue. A short baseline summary gives counts (gaps by severity, duplicate pairs flagged, renames proposed) that a re-run audit measures the delta against after the fixes are applied.
- No record is deleted or merged. The handoff file `~/.claude/crew-state/sales/crew-sales-crm-cleanup-handoff.md` was written.

## Case B: messy
INPUT:
A noisy export, inconsistent casing, suffix chaos, contradictory stage labels, no canonical stage list provided, and a record that looks stale or past a retention window.
```
Records: mixed companies. (No stage set provided. No field policy provided.)
Row 1: ACME corp, acme.com, owner=jbrooks, stage "negotiating", last activity 2026-06-01
Row 2: Acme Corporation, acme.com, owner=J Brooks, stage "Negotiation", last activity 2026-06-03
Row 3: acme, (no domain), owner=jbrooks, stage "in negotiation", last activity 2026-05-30
Row 4: Bright Path Ltd, brightpath.co, owner=, stage "PROPOSAL", last activity 2026-06-10
Row 5: BrightPath, brightpath.co, owner=t.ng, stage "proposal sent", last activity 2026-06-11
Row 6: Dunder Mifflin, (no domain), owner=m.scott, stage "won?", last activity 2022-01-09
```
EXPECT:
- Stage set marked "Assumed from data" because none was provided, with each assumed canonical value labelled "Assumed: [value]" and no standard invented that the team never stated.
- Duplicate pairs flagged with named signals: Rows 1, 2, 3 matched on normalised company name "Acme" plus same domain (acme.com) where present, Confidence High where the domain matches, Medium for Row 3 (normalised name only, no domain). Rows 4 and 5 matched on same domain (brightpath.co). All "to review", none merged. A survivor is suggested where these are contact-level matches; for the Medium normalised-company-name-only match (Row 3) no survivor is suggested and the legal-entity escalation is carried until the "one legal entity" question is answered.
- Standardisation collapses the stage variants "negotiating", "Negotiation", "in negotiation" to one assumed canonical stage shown as a before and after, and normalises "ACME corp" / "Acme Corporation" / "acme" casing and the "Ltd" suffix consistently, all as "from -> to" pairs.
- Owner blank (Row 4) flagged Critical (breaks routing). Missing domains (Rows 3, 6) flagged and not invented.
- Row 6 stage "won?" flagged as ambiguous and Escalated as a question to the owner, not silently coerced to a stage. Row 6 (last activity 2022) is raised in a dedicated personal-data retention flag with its row and last-activity date; since no retention policy was provided it is marked "Assumed: no retention policy provided, flag for the owner to set one", and deletion is left to the owner, not performed.
- Any duplicate match that cites an email cites it masked (for example "(masked)" or "d***@domain"), never the raw address, in line with the personal-data minimisation rule.
- No fabricated domain, owner, or stage. The handoff file records the assumed stage set so the next run does not relitigate it.

## Case C: missing-input
INPUT:
```
"Clean up our CRM, it's a mess."
(No export, no rows, no field names, no record type provided.)
```
EXPECT:
- Loop 1 behaviour: names the gaps plainly, that no record export or list, no rows, no field names, and no record type were provided and the cleanup cannot run without rows to review.
- Asks once for the export (or paste of rows) and the record type, as a single plain request, not a survey.
- Invents no records, no duplicates, and no missing-data findings, and produces no checklist of fabricated rows.
- Marks the run as blocked on input rather than emitting a plan. The handoff file is still written noting "No output, blocked on missing export, run completed [date]".
