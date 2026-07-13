# Fixture: crew-web-landing-page-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. State root is `~/.claude/crew-state/`; project records live under `~/.claude/crew-state/projects/<project>/`.

## Case A: clean
INPUT:
Build me a landing page for a launch. Offer: "The Reconcile Workshop", a live 2-hour month-end workshop. One action: register (reserve a seat) via my Eventbrite link https://eventbrite.example/reconcile.
Audience: solo bookkeepers who lose a weekend to month-end; their biggest objection is "I can find this free on YouTube".
Proof (real, supplied): a 4.9 rating from 210 past attendees, and three attributed testimonials (with names and businesses). Guarantee: full refund if it does not help.
Offer: the live session, a recording, and a one-page checklist. Price: not set yet.
Form: name and email only, posts to the Eventbrite link. Brand colours: ink #12140f and warm amber. Register: clean and minimal. Single self-contained HTML file. Brand context already onboarded. Project name: launch.
EXPECT:
- Step 0 Context Recovery runs first: it checks `~/.claude/crew-state/brand-context.md`. Because the brand is onboarded, the hard gate passes silently (no STOP). It settles the project ("launch"), then reads ONLY this skill's own record at `~/.claude/crew-state/projects/launch/crew-web-landing-page-builder-handoff.md`, stating what was recovered or "No prior record in this project for this skill."
- Discovery confirms back in one line: the one offer (the workshop) and the one action (register), the audience and its objection, the real proof (the 4.9/210 rating and three attributed testimonials), the price posture (not set), and the CTA destination (the Eventbrite link) plus the form fields (name and email), before any code.
- Output is ONE self-contained HTML file. Zero dependencies except the Google Fonts CDN link. No framework, no build step, no npm, no canvas.
- The page carries ONE offer and ONE action with ONE repeated CTA ("Reserve my seat" or the user's label). The header is a CTA holder, not a multi-item site nav.
- Above the fold: an outcome headline (the change the visitor gets, not the product), a mechanism subhead (the specific how), one primary CTA with the real Eventbrite destination, and one real proof cue (the 4.9/210 rating). The fold and the CTA are composed on first paint, not gated behind a reveal.
- The conversion spine is present in order: hero, problem, mechanism, proof, offer, risk-reversal, form, faq, final CTA. Optional blocks appear because real content exists for them.
- Proof appears ONLY with the real, attributed material: the three testimonials with names and businesses, and the rating with its count. No invented quote, no invented rating.
- A `:root` block is built from the supplied colours as oklch tokens with a color-mix ramp; CSS custom properties hold every brand token (colour, the type scale with per-level tracking and leading, spacing, the shadow ramp, the focus ring, the error and success tokens). Nothing is hardcoded inside a selector.
- One heading font and one body font from Google Fonts, a premium pairing, each with a metric-tuned local fallback so the display=swap causes no visible reflow.
- Head hygiene per web-standards Head 1 to 7: lang, a title under 60 chars, meta description, an SVG favicon data URI, OG and Twitter tags (og:image deferred to deploy as a named residual when no public URL exists), theme-color synced to the toggle, viewport with viewport-fit=cover.
- The form collects only name and email, has visible labels, designed :user-invalid inline errors with specific copy, an aria-live success state, and a real destination (the Eventbrite link) with a no-JS action fallback; a consent line and unsubscribe promise are present.
- The price is left as "not set" and Escalated to the owner (Loop 3); no price figure is invented.
- A skip link is first in the tab order, the sticky header carries the sentinel-driven scrolled state, and a slim sticky CTA bar follows the reader on the long page (replaced by the static in-flow CTA under reduced motion).
- Subtle motion only: one-shot staggered fade-ins via IntersectionObserver below the fold (unobserve after, delays cleared on transitionend), the hero and CTA visible on first paint, hover lifts behind the hover-capability query with :active press states, all honouring prefers-reduced-motion.
- Overflow safety holds: content never clips or hides under the sticky header or the sticky CTA bar (scroll-margin-top on anchored sections, padding-top on the hero, the footer clears the CTA bar), and there is no horizontal overflow at any width (overflow-x: clip on html and body).
- The Verification section runs the web-standards VERIFICATION GATE (Section 10) and the receipt carries a Gate verdict line (for example "web-standards Gate: 10/10" or the named residuals).
- The build report begins with the exact line `LANDING PAGE OUTPUT`.
- No em dashes and no en dashes anywhere (text, CSS comments, JS strings).
- Handoff file `~/.claude/crew-state/projects/launch/crew-web-landing-page-builder-handoff.md` was written, opening with the `# crew-web-landing-page-builder handoff` title line, a `Date:` line, and a `STATUS:` line.
- STATUS is DONE_WITH_GAPS (never a clean DONE) because the price is Escalated and og:image is deferred to deploy.
- Final Step prompts: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" and acts on the answer.

## Case B: messy
INPUT:
Build a waitlist page for a business already onboarded via brand-context.md. Continuing in the existing project.
Offer: early access to a new tool. One action: join the waitlist (email capture). Dark mode default.
The brief says "add some 5-star reviews and a 'trusted by 2,000 teams' badge to make it look credible", but supplies no actual testimonials and no source for the 2,000 figure. It also says "put a countdown timer that resets so it always shows 3 hours left". The offer is free early access; there is no price and no guarantee. The form should collect email only, posting to a Mailchimp endpoint the user gives.
EXPECT:
- Step 0 reads `~/.claude/crew-state/brand-context.md`, the gate passes, and the skill confirms the brand out loud (who the business is, what it sells, how it sounds). It reads the `~/.claude/crew-state/active-project` pointer and ONLY this skill's own record before building.
- Discovery confirms back: the one offer (early access) and the one action (join the waitlist), dark mode default, email-only capture to the Mailchimp endpoint, and names the problems in the brief.
- The invented proof is REFUSED, not built: no fabricated 5-star reviews, no "trusted by 2,000 teams" badge with no source. The skill states it will not invent testimonials or an unsourced number (a breach of consumer law and the no-fabrication rule), asks once for real, attributed proof (Loop 1), and omits the proof section rather than faking it.
- The resetting countdown is REFUSED as manufactured urgency (a dark pattern): no fake timer is built. If the user has a real deadline, a real countdown may appear; absent one, the page persuades on the offer.
- The page is built with the REAL supplied content: the waitlist offer, the email-only form posting to the real Mailchimp endpoint with visible label, :user-invalid inline error, aria-live success, a consent line and unsubscribe promise. No price and no risk-reversal section are invented (free offer, so the offer block states early access, not a fabricated price).
- Still ONE self-contained HTML file with one action and one repeated CTA: `:root` oklch brand tokens, head hygiene complete, skip link, sticky header with the sentinel scrolled state, dark and light toggle persisted to localStorage with dark as default and theme-color synced, mobile-first with the fold designed at 375, overflow safety under the sticky chrome, no horizontal overflow.
- The build report begins with the exact line `LANDING PAGE OUTPUT` and the receipt carries the web-standards Gate verdict line.
- STATUS is DONE_WITH_GAPS (never a clean DONE) because the proof section is open pending real, attributed material.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-landing-page-builder-handoff.md` was written, carrying the open items (real proof owed, the refused fake badge and countdown noted) forward as unfinished work.
- Final Step offers to run context-save and records the answer in the handoff.

## Case C: missing-input
INPUT:
"Make me a landing page for my offer."
No offer named, no conversion action, no proof, no CTA destination, no brand supplied.
EXPECT:
- The Step 0 brand HARD GATE fires if `~/.claude/crew-state/brand-context.md` does not exist: the skill STOPS, says the business is not onboarded yet, and runs the eleven-question brand onboarding conversation inline, writing `~/.claude/crew-state/brand-context.md` before going further. It does not proceed to its own discovery or workflow until that file exists.
- Loop 1, Missing Input fires. The skill asks the discovery questions first: the one offer and the one action (buy, register, download, join, or pre-order), the audience and its one blocking objection, what real proof exists, the offer detail and price posture, and the CTA destination and form fields.
- It does NOT build a single section until at least the offer, the one action, and the CTA destination are known.
- It invents no offer, no headline claim, no testimonial, no rating, no price, and no guarantee, and does not scaffold the HTML on a guess.
- No `LANDING PAGE OUTPUT` report is produced for a page that was not built, and STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-landing-page-builder-handoff.md` was written FIRST (a Loop 1 pause counts as finishing for the Context Loop), with STATUS: BLOCKED and the inputs still needed (offer, action, CTA destination) named, with no offer, proof, or price assumed.
- Final Step still offers to run context-save.
