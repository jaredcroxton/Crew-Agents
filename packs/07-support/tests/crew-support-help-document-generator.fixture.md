# Fixture: crew-support-help-document-generator

## Case A: clean
INPUT:
- Repeated question (three real examples): "How do I stop being charged?", "Where do I cancel auto renew?", "Turn off renewal please".
- Verified answer: confirmed by product owner. Path is Settings (top-right menu), then Billing tab, then the "Auto-Renew" toggle. Plan stays active until the period ends, then no charge. Greyed-out toggle means a non-owner account. Free plans have no toggle.
- Product: Acme, billing handled in the web app.
EXPECT:
- HELP ARTICLE with Title phrased as the customer's question, Type: How-to, Status: Ready.
- Short plain answer before the steps, naming the specific "Auto-Renew" toggle under "Billing" (mechanism, not category).
- Numbered single-action steps per Step-writing rules: imperative voice, one action each, quoting real labels ("Settings", "Billing", "Auto-Renew"), a precondition line up front, and an expected result where it matters ("Renews: Off").
- The article follows the Structure template (Title, Answer, Steps, Example, Troubleshooting, Still stuck, Search terms, Status) with Type set per Document types (How-to).
- A labelled Example with placeholder values, and a Troubleshooting section as "If [symptom], then [fix]" pairs including a "contact support" line for what the customer cannot self-fix.
- Search terms line present.
- Handoff written to `~/.claude/crew-state/support/crew-support-help-document-generator-handoff.md` recording the article, doc type, and what crew-support-faq-builder needs next.

## Case B: messy
INPUT:
- Two questions tangled in one request: "How do I cancel and also get a refund for last month?" plus pasted tickets that contradict each other (one says the toggle is under "Account", one says under "Billing").
- Partial answer: cancel path is confirmed under "Billing". The refund rule is not provided and no source given. Mobile app behaviour is mentioned but unconfirmed.
EXPECT:
- Splits the two issues per Document types (one doc, one issue): writes the cancel How-to now, notes the refund question for its own doc in the handoff (does not blend them).
- Resolves the contradictory path by using the confirmed "Billing" location and not the unverified "Account" one, or marks it "Assumed: confirm before publish" if neither is confirmed.
- Marks the mobile fork "Assumed: [behaviour], confirm before publish" per the Step-writing fork rule, rather than inventing mobile labels or blurring web and mobile into one step.
- Treats the refund as out of scope for the answer: marks it "Escalated: refund rule and who owns it", Status: Draft. Invents no refund amount, window, or policy.
- Correct taxonomy applied (Type: How-to for the cancel path).
- Handoff records the split, the assumed mobile step, and the escalated refund item.

## Case C: missing-input
INPUT:
- Repeated question only: "How do I export my data?"
- No verified answer, no confirmed steps, no product owner source, no screen labels provided.
EXPECT:
- Loop 1: names the gap plainly ("the verified resolution and the real screen labels for data export are not provided") and asks once for the correct steps or their source.
- Does not invent a menu path, a button name, a file format, or an export wait time.
- If it must produce anything, returns the article shell with the Answer and Steps marked "Not provided, awaiting verified resolution" and Status: Draft, inventing nothing.
- Handoff written even with the incomplete output, recording the missing verified answer as unfinished work and what is needed to finish.
