# Fixture: crew-core-plan-reviewer

## Case A: clean
INPUT:
Plan to review: "Website build for Bloom Lane Florist. Pages: home, about, product gallery, contact. Build the gallery first, then home, then contact. Launch in three weeks on a new domain. One developer."
Outcome target: a live marketing site that lets customers send order enquiries.
Constraints: three week deadline, one developer, budget for a new domain only, most visitors are on phones.

EXPECT:
- Restates what the plan builds and the done definition in the first two lines.
- Output is a PLAN REVIEW. The fenced output block's first content line is exactly "PLAN REVIEW".
- All four headings present: Scope, Approach, Implementation, Design.
- Scope flags the contact/enquiry form gap as Class: Missing, Severity: Blocker (the outcome needs enquiries, the plan has only a contact page), with a concrete recommendation (add an enquiry form as a deliverable).
- Scope flags the product gallery as Class: Unbounded, with a concrete cap recommendation and a Severity (Major).
- Approach flags the sequencing or image-source assumption (gallery built before image source decided), with a mechanism named, not "approach is risky".
- Design flags the missing mobile-first decision as a Blocker, given phone traffic, with a concrete recommendation.
- This case carries at least one Blocker AND one Major, each on a specific named plan item.
- Every finding carries a Severity (Blocker/Major/Minor) and a concrete Recommendation, not "consider revisiting".
- No fabricated constraint: only the three week deadline, one developer, domain-only budget, and phone traffic that were stated are used to size findings.
- Verdict line present (Ready after blockers resolved or similar).
- No section is padded: a clean section reads "No issues found".
- The plan is not edited or rewritten, only reviewed.
- No invented skill names in any handoff phrasing: the build is handed to "whoever sequences the build", not to a named writer or breakdown skill that does not exist.
- Handoff file written to .claude/crew-state/core/crew-core-plan-reviewer-handoff.md listing the open decisions the builder must resolve.
- No em dashes anywhere.

## Case B: messy
INPUT:
Plan to review: "Build the app. Make it good. Use the latest stack. Gallery, gallery, plus a gallery of testimonials maybe. Launch ASAP, also it must be done by Friday but also no rush. Reuse the old database (the one from the last project, not sure which). Designer will sort the look later."
Outcome target: not clearly stated, user says "something to show clients".
Constraints: contradictory (Friday vs no rush), the database reference is ambiguous.

EXPECT:
- Flags the contradictory deadline (Friday vs no rush) rather than picking one silently, marks it "Assumed: [the assumption]" or escalates the timeline as a decision the owner must make.
- Flags "make it good" and "use the latest stack" as Unbounded scope. The unbounded-scope finding carries a Severity AND a concrete recommendation (name the missing decisions to make, not "consider revisiting").
- Flags the ambiguous database ("not sure which") as an Implementation Blocker, dependency not confirmed, with a recommendation to identify the database before any build.
- Treats "designer will sort the look later" as a missing design decision that will block week one. The missing-decision finding carries a Severity (Blocker) AND a concrete recommendation naming the specific decisions left open (states, layout, device).
- Does NOT fabricate the missing outcome target. Marks it "Not provided" or "Assumed" and notes findings depend on it.
- Correct taxonomy used (Unbounded, Missing, Blocker). Severity and a concrete recommendation on every finding.
- Does not edit or rewrite the plan, only reviews it.
- No invented skill names in any handoff phrasing: forward handoff goes to "whoever sequences the build", not a named writer or breakdown skill that does not exist.
- Handoff records what was assumed and the contradictions surfaced.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Can you review my plan before I start the build? It's going to be great."
(No plan, brief, or proposal is attached. Outcome and constraints also absent.)

EXPECT:
- Loop 1 (Missing Input) behaviour: names exactly what is missing (the draft plan itself) and why it matters (there is nothing to review without it).
- Asks once, plainly, for the draft plan. Does not batch a survey of every input.
- Does NOT invent a plan, a deadline, a budget, scope items, or findings.
- Produces no PLAN REVIEW body of fabricated findings. If anything is emitted, affected fields read "Not provided".
- Run-level STATUS is NEEDS_CONTEXT or BLOCKED, never DONE (an empty scaffold is not a real review).
- Handoff file still written to .claude/crew-state/core/crew-core-plan-reviewer-handoff.md noting the gap (plan not supplied, awaiting input) so the next run knows.
- No em dashes anywhere.
