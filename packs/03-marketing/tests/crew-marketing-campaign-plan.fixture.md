# Fixture: crew-marketing-campaign-plan

## Case A: clean
INPUT:
Goal: "Book 40 demo calls for our new invoicing tool by 31 August."
Offer: "Cloud invoicing app for tradies, 29 dollars a month, 14-day free trial."
Audience we reach: "Warm email list of 2,100 tradies who downloaded our free quote template, plus an active Instagram following. We email weekly."
Budget: "Up to 1,500 dollars if we need to boost posts."
EXPECT:
- Output begins "CAMPAIGN PLAN".
- Goal restated as one measurable dated outcome ("40 demo calls by 31 August") and Offer with the real price (29 dollars a month, 14-day trial), no invented number.
- Audience named by segment from the taxonomy (Warm list) with its one fit trait (downloaded the template, consented to weekly email) and one objection ("I can find a free invoice template").
- Message pillars: exactly one Core sentence plus two or three distinct Support pillars, each naming a specific mechanism, not "saves time".
- Channel plan tags each channel Owned/Earned/Paid with a Drive/Nurture/Close role and a "why this audience is here" line, only channels the business already reaches them on (email, Instagram); no pathless channel listed.
- Each chosen channel names its effort and its budget (the email and organic posts near-zero; any post boost charged against the 1,500-dollar cap, with spend beyond the cap Escalated to the owner).
- The email channel names the consent basis of the Warm list (the tradies downloaded the template and opted into weekly email), with a working unsubscribe and sender identity assumed mandatory; an email to a non-consented segment would be Escalated.
- Any quantified mechanism in a pillar without a business-supplied source (for example a "saves X hours" claim with no figure given) is flagged "unverified, owner must substantiate before launch", not shipped as fact.
- A pivot signal is named (if a leading measure such as page visits is flat through Sustain, change the message or channel before a stated date).
- A finite, ordered asset list, each mapped to a sibling builder (crew-marketing-seo-page-builder, crew-marketing-social-post-pack, crew-marketing-email-campaign-builder) and sequenced across the Pre-launch / Launch / Sustain / Close timeline phases.
- A Budget line carrying the 1,500-dollar figure (or "not set, owner decides" if it had been absent).
- Success measures: a primary (demo calls, target 40, tracked via a unique demo-booking link) and leading measures, each naming a tracking method (a UTM, the page analytics, the email open report); targets only where a baseline exists, else "set with owner (no baseline)".
- Escalations named where the business must decide (the boost spend within the stated cap is set; anything beyond it is escalated).
- Handoff file written at `~/.claude/crew-state/marketing/crew-marketing-campaign-plan-handoff.md` naming what the social and email skills need next.

## Case B: messy
INPUT:
Goal: "We want to grow. Maybe more signups, maybe brand awareness, big push in spring."
Offer: "The membership. Pricing is changing, not locked yet."
Audience we reach: "Some old customers, a Facebook group that went quiet, and we ran ads once that did okay (no numbers kept)."
EXPECT:
- Loop 1 fires on the goal: asks once for the one outcome and the date, or restates it as a single measurable target and marks the rest "Assumed", does not plan toward two goals at once.
- Offer price recorded as "price not set", carried into the output, never a guessed number.
- Audience split into the segment taxonomy (old customers as Existing and/or Lapsed, flagged "Assumed" if unclear), not "everyone"; the quiet Facebook group named as an Owned-but-cold channel needing reactivation or dropped; the past ads as Cold-paid.
- "Did okay" past ad result is NOT inverted into a conversion rate or a baseline; success measures say "set with owner (no baseline provided)" and still name a tracking method.
- Message pillar still committed to one sentence; if proof is thin, the output says the message is weak and names the missing proof rather than shipping a generic line.
- Timeline still phased (Pre-launch / Launch / Sustain / Close) against whatever spring deadline is set once the goal is pinned.
- Budget line reads "not set, owner decides" (none given).
- Price-not-set surfaces under Open decisions (escalated) per Loop 3, naming the owner as the decider.
- Handoff file written, recording the assumed segments and the open price decision.

## Case C: missing-input
INPUT:
Offer: "A new online course on bookkeeping for cafes."
Audience we reach: "About 800 newsletter subscribers."
(No business goal or deadline provided at all.)
EXPECT:
- Loop 1 (Missing Input) fires plainly: names the gap ("no measurable goal or deadline provided"), asks once for the one outcome this campaign must move and by when.
- If no answer is obtainable, marks Goal as "Not provided" and does not invent a target number, a deadline, or a sales figure.
- Invents nothing: the list size is used as given (800), no fabricated open rate, price, or past result; the offer price is marked "price not set" because none was given; Budget reads "not set, owner decides".
- Produces the parts it can (audience segment from the 800-subscriber Warm list with its fit trait and objection, a candidate one-sentence message, the owned email channel) so the owner picks up a prepared draft, with the goal field clearly blank and the measures marked "set with owner".
- Handoff file written at `~/.claude/crew-state/marketing/crew-marketing-campaign-plan-handoff.md` recording the missing goal as the blocker so the next run knows it is still open.
