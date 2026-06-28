# Fixture: crew-support-feedback-summary

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Source: app store reviews, 36 items, range 2026-05-10 to 2026-06-14, about the mobile checkout flow.
A clear cluster: 19 items say the card is declined on the final tap and the cart empties, forcing a full re-entry, and several say they gave up. 7 items say the promo code box is buried below the pay button so they miss the discount. 6 items praise the fast guest checkout with no forced account. 4 are neutral questions about refund timing.
EXPECT:
- Output begins with "FEEDBACK SUMMARY" and includes a Source line carrying Items, Range, About, and Mode.
- A Sentiment line in the form "Positive n / Negative n / Mixed n / Neutral n" whose counts add up to the stated item count (36).
- Themes ranked by item count, loudest first, each theme named as a concrete behaviour (not a one-word abstraction), each with a real "(n items)" count and a "Confidence: High / Medium / Low" tag and a "Pain:" line.
- A "Positive signals (protect these):" block naming the guest-checkout strength with its item count.
- A "Likely root cause (top theme):" stated as a process or policy mechanism (not a frontline person), tagged with a "Type:" (Process / Policy / Expectation / System / Training) and "Basis: Evidence: n items" or "Inference".
- A "Recommendations:" block where at least one action carries an "Action type:" from the taxonomy, an "Owner: [role]", and a conservative "Estimated impact:" line (items per month and a realistic reduction, not a claim of elimination).
- A "Top recommended action:" line and a "Pattern summary:" paragraph distinguishing systematic from one-off.
- An "Open questions:" line.
- Handoff file `~/.claude/crew-state/support/crew-support-feedback-summary-handoff.md` was written.

## Case B: messy
INPUT:
A pile of mixed feedback with no clean labels. Source given only as "some reviews and a couple of tickets, not sure how many, maybe pulled last month". One review says "the app is broken and the staff are useless". Two contradict each other: one says delivery was too slow, one says it arrived early. A handful complain the order took longer than the 2-day quote. Someone pasted a paraphrase: customer "basically said the checkout sucks" (no verbatim words).
EXPECT:
- Confidence is honest about the thin or mixed sample: themes carry "Confidence: Low" or "Medium" where the sample is small or contradictory, and a tiny cluster is not called a "trend".
- The slow-vs-early delivery contradiction is flagged, not silently averaged into one theme.
- Taxonomy holds: the loud "staff are useless" item is not made the root cause. The root cause is named as a process or policy mechanism (for example the dispatch quote versus the warehouse cut-off), and "Assumed" or "Inference" is used where it reasoned from a pattern rather than counted evidence.
- No fabrication: no invented percentage, count, sentiment score, customer name, or quote. The paraphrase is not placed in quotation marks as if verbatim.
- Because the source and count are vague, it marks "Source: not provided" or "Sample size: unknown, confidence low" rather than inventing a precise count.
- Any impact estimate stays conservative and is omitted or marked "outcome unknown" where the sample cannot support a number; no fix is claimed to eliminate a pattern.
- Handoff file written, noting the Low-confidence themes and the unresolved contradiction as unfinished work.

## Case C: missing-input
INPUT:
A batch of 14 negative reviews about late delivery is pasted, but the source channel and date range are both absent (no idea where they came from or when).
EXPECT:
- Skill follows Loop 1 (Missing Input): it names the gap and asks once for the source and rough date range, because confidence depends on both, rather than guessing.
- If it proceeds without an answer, it marks "Source: not provided" and "Sample size: unknown" or "Range: unknown", and sets confidence accordingly, inventing nothing.
- It does not fabricate a channel, a date range, a percentage, or any quote it did not see.
- The 14 real items are still counted and themed honestly against what is present.
- Handoff file `~/.claude/crew-state/support/crew-support-feedback-summary-handoff.md` written, recording the missing source and range as the gap the next run needs to close.
