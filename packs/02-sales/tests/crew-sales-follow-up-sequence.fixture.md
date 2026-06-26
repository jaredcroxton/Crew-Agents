# Fixture: crew-sales-follow-up-sequence

## Case A: clean
INPUT:
Last contact: demo on 2026-06-02 with Lena Hart, Ops Director at Atwell Freight. She asked for an onboarding timeline and we never sent it. Quiet since 2026-06-05.
Offer: fractional ops support. Value she cared about: how fast a fractional ops lead ramps.
Channel mix: default (three emails, one SMS, one call script).
SMS opt-in: on record (Lena opted in to texts during the demo). Timezone: prospect is US Eastern.
Real comparable available: Cedar Lane (rep confirmed the result, OK to cite).
Upstream: built from a `crew-sales-outreach-draft` handoff (hook: the owed onboarding timeline; outcome: onboarding does not stall during the hiring push).

EXPECT:
- Output begins exactly "FOLLOW-UP SEQUENCE" with Prospect, Deal, Quiet since (2026-06-05), and Reason to follow up tied to the owed onboarding timeline (an open loop in her interest, not the rep's), consistent with the upstream hook and outcome.
- Exactly 5 touches: 3 emails, 1 SMS, 1 call script, with days spaced roughly 2, 5, 8, 11, 15.
- Each touch carries a distinct Angle label, no angle repeated. The SMS is the Pattern interrupt. The final touch is Angle: Close-out.
- Close-out is a graceful break-up: acknowledges silence, gives permission to pass, leaves one easy door back in. No threat, no list of what she is missing.
- The phrases "just checking in" and "just bumping this" appear nowhere. No em dashes.
- Cedar Lane cited as the social-proof comparable, no fabricated quote from Lena.
- The opt-out check is noted clear (no opt-out, unsubscribe, do-not-contact, or "stop" signal in the thread, the upstream handoff, or crew-state).
- SMS opt-in is confirmed on record, so the SMS touch is kept; its body carries sender identity and a STOP keyword (for example "Reply STOP to opt out").
- A timezone / quiet-hours note is present: touches are scheduled in the prospect's local timezone (US Eastern) within business hours, and the SMS and call sit inside the quiet-hours window.
- Flags line present (here: none).
- Handoff written to .claude/crew-state/sales/crew-sales-follow-up-sequence-handoff.md with the sequence, cadence, angle-per-touch, the eligibility result, and the next-skill note (crew-sales-prospect-brief if she replies with a concern, crew-sales-proposal-builder if she re-engages toward buying).

## Case B: messy
INPUT:
"they went dark after the pricing chat, send some follow ups. think we talked maybe 2 weeks ago? could be 3. they liked the reporting thing i think. oh and mention that other client we did, the big retail one, you know the one. want like 4 touches not 5."

EXPECT:
- Quiet-since marked "Assumed: about 2 to 3 weeks ago, exact date not provided" rather than inventing a date.
- Value the prospect cared about recorded as "Assumed: the reporting feature" since the rep was unsure ("i think").
- The "big retail client" is NOT named or quoted. Marked "Escalated: rep must confirm which client and that it is OK to cite" with a placeholder, no invented company name or result.
- Cadence honors the rep's request: 4 touches, not the default 5, still ending in a Close-out touch.
- 4 distinct angles, no repeat, still includes the graceful close-out.
- Post-pricing silence handled with a value or proof angle (a result, a comparable, a resource), never an unapproved discount. Any discount is marked "Escalated", not invented.
- SMS opt-in is not on record (the rep gave no opt-in signal), so the SMS touch is dropped and replaced with an email or a call, not texted by default.
- Reason-to-follow-up names a real open loop or, if none is clear from the noise, flags that the hook is thin and asks the rep for one (Loop 1 / Loop 2 surfaced, not silently padded).
- No fabricated price from the "pricing chat". No em dashes. No "just checking in".
- Handoff written, listing the Assumed and Escalated items as unfinished work.

## Case C: missing-input
INPUT:
"draft me a follow-up sequence for the Bennett deal."
(No last-contact context: no record of what was discussed, when, what the next step was, or what value Bennett cared about. Offer not stated either.)

EXPECT:
- Loop 1 behaviour: names the specific gap ("I have no last-contact context for Bennett: what was discussed, the agreed next step, how long it has been quiet, and what you are selling them"). States why it matters (a follow-up with no thread is just a mistimed cold email, every angle would be generic).
- Asks once, plainly, for that context. Does not batch a long survey.
- Invents nothing: no made-up discussion, no fabricated quiet-since date, no assumed offer, no comparable customer.
- If told to proceed regardless, marks the reference line and reason "Not provided" and produces only what is genuinely possible, clearly flagged, rather than a confident fabricated sequence.
- Eligibility note: if any input later shows Bennett opted out, unsubscribed, or asked to stop, the sequence must not be built. Say so and stop, even if the rest of the context arrives.
- Handoff written noting the run was blocked on missing context ("No output, run completed [date], blocked on missing last-contact context for Bennett").
