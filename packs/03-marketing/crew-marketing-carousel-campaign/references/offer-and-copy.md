# Offer, Copy Structure & Brand Rules

## The locked offer (fill this in at discovery, use everywhere)

Collect these once at the start and thread them through every hero, slide, and caption. When a campaign-plan record exists in the project, most of this is already decided; pull it from there. Fill the SHAPE below per campaign; the worked example that follows is fully fictional.

- **What / when:** [the event or offer name], [exact date as it will print on the plates]. [Duration.]
- **Price + scarcity:** [$price] [scarcity line: opening price, limited seats, N spots only].
- **The payoff (what they walk out with):** [the concrete, countable outcome].
- **The reassurance:** [what removes the fear: no experience needed, everything provided, small group].
- **The authority:** [why this person or business has the right to teach or sell this].
- **The two big angles:** [angle 1] and [angle 2]. These become carousels 4 and 6.

### Worked example (FICTIONAL: Saltbrook Ceramics, invented for this reference)

- **What / when:** ONE DAY ON THE WHEEL, 14.11. One day, 6 hours.
- **Price + scarcity:** $349 opening price, the lowest it will ever be, 12 wheels only.
- **The payoff:** you throw, trim, and glaze six real pieces at your own wheel; the studio fires the lot and you collect a finished, food-safe set two weeks later.
- **The reassurance:** no experience needed. Clay, tools, aprons, glazes, and firing all included. Built for absolute beginners.
- **The authority:** taught by a production potter with 20 years at the wheel, work stocked in three galleries, more than 400 beginners taught.
- **The two big angles:** (1) you leave with real finished pieces, not a certificate; (2) everything you own was made by someone else, stop scrolling maker videos and make the next one with your own hands.

## Banned (hard rules: apply to every asset and caption)

- NEVER "works while you sleep", "your next hire isn't human", or any humans-replaced framing.
- NO em-dashes anywhere (copy, HTML, code comments, captions). Use commas, periods, or parentheses.
- Carry the brand's exact capitalisation from brand-context onto every plate, slide, and caption. If the brand writes its name a particular way, that exact form appears everywhere, never lower-cased or shouted in body copy.
- CTA is always "tap the link" (booking link in bio / ad button), NEVER "DM".
- The brand's own banned-words list lives in `~/.claude/crew-state/brand-context.md` ("Never say"); read it and honour it in every caption.

## The 6-carousel structure (default)

Six carousels, each a distinct angle, each 4 slides. This maps 1:1 to the six hero devices in any style recipe.

| # | Carousel | Job |
|---|----------|-----|
| 1 | The Announcement | Stop the scroll, state the offer |
| 2 | The Differentiator | Not another [whatever the tired default is] |
| 3 | The Credentials | Who is teaching or selling this |
| 4 | The Mechanism | How it works, what you actually get |
| 5 | The Close | No experience needed, the floor price |
| 6 | The Signature Angle | The big ownership or identity idea |

For the fictional Saltbrook example: 1 The Announcement, 2 The Differentiator (not another tutorial), 3 The Credentials (a potter who teaches), 4 The Mechanism (throw, trim, glaze, we fire), 5 The Close (no experience needed), 6 The Keepsake (made by your hands).

### Each carousel = 4 slides

- **Slide 1, HERO** (the AI plate + its animated video). Hook only. Big display type.
- **Slide 2, payoff A** (one idea). Coded page.
- **Slide 3, payoff B** (one idea). Coded page.
- **Slide 4, CTA** (the close). Coded page: price + date + "tap the link". Inverted/dark treatment.

One idea per payoff slide. Never two. The body copy for all 24 slides of the fictional worked example is already written in the bundled `body-pages-engine.html` PAGES array; adapt the wording per campaign, keep the one-idea-per-slide discipline.

## Weekly drip order (default)

Build to the event, one carousel per week:
1. Week 1, Carousel 1 (Announcement)
2. Week 2, Carousel 6 (Signature Angle)
3. Week 3, Carousel 2 (Differentiator)
4. Week 4, Carousel 3 (Credentials)
5. Week 5, Carousel 4 (Mechanism)
6. Launch week, Carousel 5 (Close), plus re-run the best performer.

If two style campaigns exist for the same offer, the READ ME says: run ONE campaign per channel, or alternate campaigns per week for variety; never post both versions of the same concept in the same week.

## Caption formula (per carousel `0 - CAPTION.txt`)

1. One-line hook that echoes the hero headline.
2. `[OFFER NAME]. [date].`
3. Two or three short lines of the payoff for THIS carousel's angle.
4. Reassurance line (no experience / everything provided / whatever fits the angle).
5. `[$price] [scarcity line].`
6. `Tap the link in bio to [lock your seat / see open seats / book / own your seat].`
7. Hashtag block: five or six tags mixing the offer's category with the brand tag (+ angle-specific ones per carousel).
8. `---` then `FIRST COMMENT (post right after publishing):` then `Seats are limited for [date]. Book here: [BOOKING LINK]`.

Six fully written example captions (fictional Saltbrook wording) are in `build_kit.py`'s CAROUSELS list; adapt per campaign.
