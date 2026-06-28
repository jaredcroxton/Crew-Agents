# Fixture: crew-support-faq-builder

## Case A: clean
INPUT:
Product: an online store's Returns page, audience is paying customers.
Question source (last 30 days of tickets, with tallies):
- "can I get a refund if I changed my mind" (asked 14 times)
- "my item arrived damaged what do I do" (asked 9 times)
- "how do I track my order" (asked 6 times)
Confirmed answers available in returns-policy.md (live 2026-06-17): 30-day unused window, refund to original card in 5 to 7 business days, damaged items replaced free with a photo sent within 48 hours, tracking link is in the order confirmation email.

EXPECT:
- Header line with "FAQ: Returns", "Audience: paying customer", "Drafted:" a date, and "Status: Draft for approval".
- Three FAQ entries, each following the FAQ structure anatomy: an intent tag in brackets ([Billing] for refund, [Problem] for damaged, [Setup] or [Using] for tracking), the question in the customer's own words, a one to three sentence answer that leads with the answer (Tone and clarity), "Source: returns-policy.md", and a "Next:" action.
- Most-asked question (refund, 14) appears first, per Organisation logic (ordered by the tally, not by taste).
- "Cut (not real questions): none" (or no marketing entries kept).
- A handoff file is written at `~/.claude/crew-state/support/crew-support-faq-builder-handoff.md` recording the FAQ produced and the ordering decision.

## Case B: messy
INPUT:
Product: a SaaS billing page, audience unclear (mix of prospects and customers).
Question source is a noisy chat export:
- "how much is it???" (asked many times)
- "How much does it cost" (same question, different phrasing)
- "is my card info safe"
- "Why should I choose you over competitors" (this came from a sales chat, not support)
- "can i pay yearly" (no pricing doc provided, no one has confirmed annual pricing exists)
The only doc provided is a security page stating cards are processed by a PCI-compliant provider. No pricing doc.

EXPECT:
- The two pricing questions ("how much is it???" and "How much does it cost") are merged per Organisation logic into one canonical [Buying] entry, with the duplicate phrasing kept as a search-phrasing note, not two separate entries.
- The price answer is NOT invented: it reads "Needs answer: confirm current price with the owner" because no pricing doc was provided, and it is listed under "Open items for approval".
- The annual-pay question is marked "Escalated: needs owner sign-off" or "Needs answer" because annual pricing has not been confirmed; no plausible price or discount is fabricated.
- The card-safety question gets a [Trust] tag and a real answer sourced to the security page.
- The competitor question is moved to "Cut (not real questions)" as marketing, not a real support ticket, with a one-line reason.
- Audience ambiguity is surfaced with an "Assumed:" note (for example, "Assumed: audience is prospects and customers; confirm"), not silently chosen.
- The handoff file is written and lists every "Needs answer" and "Escalated" entry.

## Case C: missing-input
INPUT:
"Build us an FAQ for our product." No question source is provided (no tickets, no chats, no search logs, no written list), only the product name.

EXPECT:
- Loop 1 (Missing Input) behaviour: the skill names the gap plainly (there are no real questions to build from) and asks once for the question source (tickets, chats, search queries, or a written list).
- It does NOT invent customer questions or write a generic made-up FAQ.
- If told to proceed anyway, it marks the deliverable "Not provided: no real question source" rather than fabricating entries, and produces nothing it cannot source.
- The handoff file is still written at `~/.claude/crew-state/support/crew-support-faq-builder-handoff.md`, recording that the question source was missing and the run is blocked pending it ("No output, run completed [date]" if nothing was produced).
