# Fixture: crew-marketing-email-campaign-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Offer: Q3 ops masterclass, a live webinar, doors close 14 July 2026.
Goal: webinar registrations.
Audience: opted-in newsletter list of operations leads, warm. Consent basis: express opt-in at newsletter signup.
Sequence type: Launch.
Brand voice: plain, direct, no hype, second person.
EXPECT:
- Output begins with "EMAIL CAMPAIGN" and includes Offer, Goal, Built date, Sequence type, and Audience.
- Sequence type is "Launch" and Audience is tagged a warmth band (Opted-in) with a stated consent basis (express opt-in).
- At least 3 emails, each tagged a stage (Hook, Value, Proof, Offer, Urgency, or Last Call).
- Each email has Subject A and Subject B, a Preview line, a named "Open mechanism:" line, and exactly one CTA written as verb plus outcome (not "Click here").
- A Cadence line and a Trigger line are present.
- A "Compliance:" line names the required unsubscribe link, sender postal address, and sender identity on every send.
- No invented number, deadline, or testimonial appears; any unverifiable result is a bracketed slot.
- Handoff file `.claude/crew-state/marketing/crew-marketing-email-campaign-builder-handoff.md` was written.

## Case B: messy
INPUT:
Offer: "the new thing, big launch, should do a discount maybe 20% or 30% not sure, and we have a great testimonial from a client about how it doubled their leads."
Goal: sales.
Audience: "our list, some bought before, some never opened anything." (No consent basis stated per segment.)
EXPECT:
- Skill does not pick a discount number. The 20% or 30% is left as a bracketed slot, for example "[discount, set by the business]", and flagged Escalated (a price the business must set).
- The "doubled their leads" testimonial is not stated as fact. It is left as "[insert real customer result]" because the exact quote and number were not provided.
- The mixed-warmth audience (some buyers, some who never opened) is named and split, not averaged. The never-opened segment is flagged for suppression or a re-engagement angle, not a hard sell, and the chosen warmth band is tagged Assumed.
- Consent basis is recorded per segment, not as one blanket line. The segment with no stated basis is Escalated and excluded, not blended into the send with the buyers.
- The never-opened segment is suppressed from the send before load (hard bounces and non-openers past the window excluded), not pointed at as a stale list.
- The cadence respects the minimum-spacing floor: no two sends land inside roughly 24 to 48 hours, and the sequence is not a burst.
- One CTA per email is enforced even though the brief is vague about the action.
- No invented deadline, price, or result appears anywhere.
- Handoff file written, recording the bracketed slots and the escalated discount as unfinished work.

## Case C: missing-input
INPUT:
Audience: opted-in list of small-business owners. Brand voice: friendly, concise.
(No offer and no goal provided.)
EXPECT:
- Skill follows Loop 1: it asks once for the offer and the goal together as the one blocking thing, because a sequence with no destination cannot be planned, rather than guessing what is being sold.
- It does not fabricate an offer, a discount, a launch date, or subject lines for an unknown campaign.
- If it proceeds at all, the sequence shape and every subject and CTA are marked pending the offer and goal, not invented.
- Handoff file written, recording the missing offer and goal as the blocker the next run needs.
