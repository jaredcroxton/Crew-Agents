# Fixture: crew-marketing-social-post-pack

Three cases that exercise the skill end to end. Each EXPECT lists the output markers that must appear and asserts the handoff file was written to `.claude/crew-state/marketing/crew-marketing-social-post-pack-handoff.md`.

## Case A: clean

INPUT:
- Core idea: a free "month-end close checklist" lead magnet for finance teams, timely because quarter close is coming up.
- Target reader: finance managers at 50 to 200 person companies who dread close week.
- Platforms: LinkedIn and Instagram caption only (real accounts on both).
- Brand voice: direct, no jargon, lowercase openers allowed, banned word "synergy". Two example posts provided, plus a written tone line.
- Goal of the week: get the checklist downloaded.
- Audience timezone given: US Eastern.

EXPECT:
- Restates the core idea, the reader, the platforms, the voice, and the goal in a line each before writing.
- Output header "SOCIAL POST PACK" with Campaign, Goal "download the checklist", Platforms "LinkedIn, Instagram caption", Voice "confirmed".
- A "Posting plan:" line sequencing days with an order note that value precedes the Offer ask.
- At least three posts, each with a "Hook:", a "Body:", a single "CTA:", and a "Visual:" spec line.
- Hooks are written as deliverables and drawn from named families (curiosity, contrarian, story-led, stat-led, question-led), never a generic "In today's fast-paced world".
- Platform-correct character budgets respected: the LinkedIn hook sits above the ~1300 to 1500 "see more" fold, the Instagram hook is the first line before the ~125-character caption truncation.
- Link handling is platform-correct: the LinkedIn link is routed to the first comment (an external link in the body suppresses reach), the Instagram link is routed to link-in-bio (no clickable caption link); each post notes its "Link:" handling.
- Each post carries a "Visual:" spec (for example 1080x1350 portrait 4:5 for Instagram, 1200x1500 portrait for LinkedIn, or "none").
- Angle mix uses distinct labels from the taxonomy (for example Problem, How-to, Offer), not the same angle repeated, with the Offer earned by value posts before it.
- No invented statistics, prices, results, or testimonials. Times of day may be set because the timezone was given.
- Copy is in the audience's market English (matching the brand-context audience loaded at Step 0).
- Handoff file written at `.claude/crew-state/marketing/crew-marketing-social-post-pack-handoff.md` recording the angle mix, platform set, and chosen CTAs.

## Case B: messy

INPUT:
- Core idea pasted as a noisy block: "new pricing??? also the webinar maybe, and we got '3x more leads' from a client (cant name them), post everywhere, make it pop. also we are doing a paid partnership shout-out for a partner tool this week". No goal stated clearly.
- Platforms: "all of them" (vague), but handles only given for LinkedIn and TikTok.
- Brand voice: no written rules, just a link to one old post that reads formal and corporate.
- Contradiction: idea says "post everywhere" but only two handles exist.

EXPECT:
- The skill narrows scope: writes only for LinkedIn and TikTok (the platforms with handles), and states the others are out of scope rather than inventing accounts.
- The "3x more leads" claim is flagged as an unsubstantiated results claim, a compliance risk under the Australian Consumer Law (ss18 and 29), and routed for substantiation or removal, not shipped as fact; the client name is never invented (marked "client not named").
- The paid-partnership shout-out is treated as a sponsored post and required to carry a clear disclosure (#ad or the platform's paid-partnership label) per the ACCC and AANA guidance; the post is not shipped without the disclosure ("Disclosure:" line present).
- New pricing handled with restraint: no specific price is written, the price line is marked "Escalated: exact price to quote, business decides" (Loop 3).
- Voice is labelled "Assumed voice: [one-line read]" with a note to confirm before publishing, because only an example post exists.
- The unclear goal is resolved by asking once or by stating the assumed goal explicitly ("Assumed goal: ...").
- Angle taxonomy applied correctly (Proof for the result if substantiated, Offer for pricing) and the week is not repetitive.
- Platform specs and link handling correct for LinkedIn and TikTok (TikTok caption is not clickable, route to link-in-bio; spoken hook in the first ~2 seconds); any spec the skill is unsure of is marked "spec to confirm", never a guessed number.
- Handoff file written, listing the escalation (price), the results-claim compliance flag, the required disclosure, the voice assumption, and out-of-scope platforms.

## Case C: missing-input

INPUT:
- Platforms: LinkedIn.
- Brand voice: NOT provided (no tone rules and no example posts).
- No core idea or offer is given. No goal is given.

EXPECT:
- Loop 1 (Missing Input) fires: the skill names exactly what is missing ("no core idea or offer, and no goal, both are required before posts can be written") and asks once, plainly, for that one thing.
- The skill does NOT write posts and does NOT invent an offer, a statistic, a result, or a goal.
- If it cannot get the input, affected fields are marked "Not provided" rather than filled.
- Because voice was not provided, the voice line is labelled "Assumed voice: neutral, confirm before publishing" rather than fabricated.
- Handoff file still written at `.claude/crew-state/marketing/crew-marketing-social-post-pack-handoff.md`, recording the gap ("blocked: awaiting core idea and goal") so the next run does not repeat the question.
