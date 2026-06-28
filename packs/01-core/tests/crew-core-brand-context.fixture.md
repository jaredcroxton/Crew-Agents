# Fixture: crew-core-brand-context

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the deliverable and handoff files were written.

## Case A: clean
INPUT:
Onboard my business (Careful mode). We are Driftwood Coffee Roasters, a small-batch roaster that sells single-origin beans direct to home brewers, and it matters because most supermarket coffee is stale and anonymous. Main product: a 250g bag of single-origin beans at 22 dollars; we also do a monthly subscription at 18 dollars. Who buys: Mara, a home barista in her thirties who grinds fresh every morning; her partner orders the gift subscriptions. Why they pick us: we publish the farm, the altitude, and the roast date on every bag; why they leave: a bad grind recommendation or a late delivery. At a dinner party we would be the warm host who arrives early to help, easy and human, never corporate; we always say "roasted to order" and never say "premium" or "gourmet". We always get right: freshness, people compliment how alive the coffee tastes. Where we fall down: we sometimes oversell origin stories we cannot fully verify. We would never claim "best coffee in the world". In six months we want 500 active subscribers. Find us at driftwoodroasters.com, on Instagram @driftwoodroasters, and on our Google reviews page. Must know: we ship within 24 hours of roasting and offer free shipping over 50 dollars.
EXPECT:
- Output begins with "BRAND CONTEXT FILE" and fills the practical fields: Brand, Product (with both prices), Customer (Mara as payer, partner as influencer), Why they pick us / Why they leave (both sides), Voice (warm host, never corporate) with Always say ("roasted to order") and Never say ("premium", "gourmet"), Always get right (freshness), Where we fall short (unverified origin stories), Never claim ("best coffee in the world"), Goals (500 subscribers in six months), Found online (driftwoodroasters.com, Instagram, Google reviews), Must know (24-hour ship, free shipping over 50).
- NO colour, font, or visual-style question was asked anywhere in the conversation; the flow stayed jargon-free.
- No em dashes anywhere in the output.
- The deliverable `~/.claude/crew-state/brand-context.md` was written, and the handoff `~/.claude/crew-state/core/crew-core-brand-context-handoff.md` was written.

## Case B: update-existing
INPUT:
A `~/.claude/crew-state/brand-context.md` already exists for Driftwood Coffee Roasters. The owner says: "Two changes. We have dropped the gift subscription, and we want to sound a bit more playful. Everything else is the same." Run in Governed mode.
EXPECT:
- Step 0 detects the existing brand context, loads it, and states "Working with Driftwood Coffee Roasters" rather than asking the eleven cold.
- It amends the file (removes the gift subscription, shifts the voice toward playful) and notes what changed, rather than overwriting the unchanged fields.
- Governed mode cross-references prior handoffs for consistency and flags any contradiction between the new playful direction and the existing "warm host, never corporate" voice for the owner to resolve.
- The never-say list, the why-they-leave, and the must-know facts are preserved unless explicitly changed.
- Handoff records the update and the changed fields. No em dashes.

## Case C: missing-input
INPUT:
"Set up my brand." No business name, no product, no website, no guide, and no one available to answer the questions right now.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once for either someone who can answer for the brand or a website or guide to read from, because it cannot invent a business.
- It does not fabricate a name, a voice, a customer, a price, or any claim.
- If it emits any partial output, every unanswered field is marked "Not provided" rather than filled.
- It does not reach for colour, font, or visual-style questions to fill the gap; those are not part of this conversation.
- The handoff `~/.claude/crew-state/core/crew-core-brand-context-handoff.md` is written, recording the missing source as the blocker the next run needs.
