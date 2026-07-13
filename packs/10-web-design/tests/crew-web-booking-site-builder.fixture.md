# Fixture: crew-web-booking-site-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. State root is `~/.claude/crew-state/`; project records live under `~/.claude/crew-state/projects/<project>/`.

## Case A: clean
INPUT:
Build me a booking site for "Harbourline Plumbing", a licensed Brisbane plumber, as one self-contained HTML file.
The one action: call or request a callout (no online scheduler yet). Phone 07 3111 2222, email book@harbourline.example.
Services: blocked drains (from $199), hot water systems (quote on request), leak detection (quote on request).
Service area: Nundah, Clayfield, Ascot, Hamilton, Northgate. Hours: Mon to Fri 7 to 5, plus 24/7 emergencies.
Trust: 12 years in the trade, licence no. QBCC 000000. No reviews yet. Register: trustworthy and established.
Brand colours: deep teal accent on off-white. Brand context already onboarded. Project name: websites.
EXPECT:
- Step 0 Context Recovery runs first: it checks `~/.claude/crew-state/brand-context.md`. Because the brand is onboarded, the hard gate passes silently (no STOP). It settles the project ("websites"), then reads ONLY this skill's own record at `~/.claude/crew-state/projects/websites/crew-web-booking-site-builder-handoff.md`, stating what was recovered or "No prior record in this project for this skill."
- Discovery confirms back in one line: the one action (call or request a callout), the three services with their pricing posture, the service area and hours, the trust signals (12 years, licence), no reviews, register trustworthy and established, before any code.
- Output is ONE self-contained HTML file. Zero dependencies except the Google Fonts CDN link. No framework, no build step, no npm, no canvas. The file works from a double-click on disk.
- Every phone number is a real `tel:` link formatted with the country code (`tel:+61...`), present in the header call button, the hero secondary CTA, the contact block, and the fixed mobile action bar. Every `mailto:` (the booking fallback) carries a prefilled subject and body.
- The booking section ships the always-working tel/mailto fallback (no scheduler supplied), never a dead embed-only slot; it functions with no network and no JavaScript.
- The services grid shows exactly three services with the REAL pricing posture: blocked drains "from $199" (the supplied figure), hot water and leak detection "quote on request". No invented figure fills a card.
- The DELETE-UNLESS-REAL blocks behave: the Google rating stat is removed (no verified rating supplied) and the reviews section is deleted (no reviews yet), not scaffolded with fake stars or quotes.
- The service area lists only the five supplied suburbs (not padded), and the hours table shows Mon to Fri 7 to 5 plus 24/7 emergencies exactly as supplied.
- A `LocalBusiness` JSON-LD block typed `Plumber` is built ONLY from the supplied facts (name, phone, email, area, hours, licence), shipped commented pending a confirmed address and deploy URL, and never carries an invented rating.
- A `:root` block is built with oklch brand colour plus a `color-mix` ramp; CSS custom properties hold every brand token (colour, the type scale with per-level tracking and leading, spacing, the shadow ramp, the focus ring). Nothing hardcoded in a selector.
- Head hygiene per web-standards Head 1 to 7: lang, title, meta description, an SVG favicon data URI, OG and Twitter tags (og:image deferred to deploy as a named residual with no public URL), theme-color synced to the toggle, viewport with viewport-fit=cover.
- A sticky header nav (sentinel-driven scrolled state), a native Popover API mobile menu (Escape closes, light dismiss), a skip link first in the tab order, a fixed mobile action bar (Call and Book) padded with `env(safe-area-inset-bottom)`, and the footer reserves bottom space so the bar never covers content.
- A working dark and light mode toggle: reads prefers-color-scheme, user-overridable, persists to localStorage, syncs theme-color, declares color-scheme per theme; light is the sensible default for this trade.
- Mobile-first responsive with breakpoints at 768px and 1024px, safe-area padding, 44px touch targets, readable type at every size, no horizontal overflow at any width.
- Subtle motion only: one-shot staggered fade-ins via IntersectionObserver (unobserve after, delays cleared on transitionend), guarded hover lifts with :active press states, all honouring prefers-reduced-motion (reveals instant, no smooth scroll).
- Overflow safety holds: content never clips under the sticky header (scroll-margin-top on anchored sections, padding-top on the hero), and overflow-x: clip on html and body, never overflow-x: hidden on an ancestor of a sticky element.
- The Verification section runs the web-standards VERIFICATION GATE (Section 10) and the receipt carries a Gate verdict line (for example "web-standards Gate: 10/10"). The Design review gate includes crew-marketing-landing-page-review as the conversion leg.
- The build report begins with the exact line `BOOKING SITE OUTPUT`.
- No em dashes and no en dashes anywhere (text, CSS comments, JS strings).
- Handoff file `~/.claude/crew-state/projects/websites/crew-web-booking-site-builder-handoff.md` was written, opening with the `# crew-web-booking-site-builder handoff` title line, a `Date:` line, and a `STATUS:` line.
- Final Step prompts: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" and acts on the answer.

## Case B: messy
INPUT:
Build a booking site for a salon already onboarded via brand-context.md. Continuing in the existing project.
They book through Square, but I do not have the Square link handy yet. Phone 02 9000 0000.
Five services listed but only three have prices; one service ("balayage") is marked price "TBC".
They say "rated Brisbane's number one salon" but have no Google rating or reviews to show. Dark mode, please.
EXPECT:
- Step 0 reads `~/.claude/crew-state/brand-context.md`, the gate passes, and the skill confirms the brand out loud (who they are, what they sell, how they sound). It reads the `~/.claude/crew-state/active-project` pointer and ONLY this skill's own record before building.
- Discovery confirms back: the one action (book via Square), the five services with their pricing posture, dark mode, and names the gaps: the Square link is not supplied, one price is TBC, and the "number one salon" superlative has no proof.
- Loop 1 fires once for the missing Square link; the site ships the tel/mailto booking fallback now (a working path offline) with a clearly marked embed slot to wire when the link arrives, rather than blocking on the missing link.
- The "balayage" price is never invented: the card ships "quote on request" or with the price line deleted, and the TBC gap is named (a price the business must set is Escalated, Loop 3, not drafted).
- The superlative "Brisbane's number one salon" is NOT shipped as fact: it is flagged as an unsubstantiated claim (Australian Consumer Law), dropped or replaced with a specific true statement, and Escalated for the business to substantiate.
- The rating stat and the reviews section are DELETED (no verified rating, no reviews), never scaffolded with fake stars.
- The sections that have real content are built with the REAL supplied content: three real prices, "quote on request" for the rest, real phone as a tel: link.
- Still ONE self-contained HTML file: oklch `:root` tokens, head hygiene complete, skip link, sticky nav with the sentinel scrolled state, native Popover mobile menu, fixed mobile action bar above the safe area, dark and light toggle persisted to localStorage with dark as the requested default and theme-color synced, mobile-first at 768px and 1024px, overflow safety, no horizontal overflow.
- The build report begins with the exact line `BOOKING SITE OUTPUT` and the receipt carries the web-standards Gate verdict line.
- STATUS is DONE_WITH_GAPS (never a clean DONE) because named items stay open (the Square link, the TBC price, the superlative to substantiate).
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-booking-site-builder-handoff.md` was written, carrying the open items forward as unfinished work (the Square embed to wire, the TBC price, the Escalated superlative).
- Final Step offers to run context-save and records the answer in the handoff.

## Case C: missing-input
INPUT:
"Make me a booking website for my business."
No business name, no phone, no services, no service area, no style register, no brand context on file.
EXPECT:
- The Step 0 brand HARD GATE fires because `~/.claude/crew-state/brand-context.md` does not exist: the skill STOPS, says the business is not onboarded yet, and runs the eleven-question brand onboarding conversation inline, writing `~/.claude/crew-state/brand-context.md` before going further. It does not proceed to its own discovery or workflow until that file exists.
- Loop 1, Missing Input fires. The skill asks the discovery questions first: the one action (book, call, or quote), the phone number for the tel: link, the real services and pricing posture, the service area and hours, and the trust signals it can show, before building anything.
- It does NOT build a single section on a guess: no invented business name, no invented phone number, no invented service, no invented price, no invented review, rating, licence, or service area.
- No booking path is fabricated: without a real phone or email there is nothing to wire a tel: or mailto: to, so the skill asks rather than shipping a dead link.
- No `BOOKING SITE OUTPUT` report is produced for a site that was not built, and STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-booking-site-builder-handoff.md` was written FIRST (a Loop 1 pause counts as finishing for the Context Loop), with STATUS: BLOCKED and the inputs still needed (name, phone, services, area, register) named, with nothing assumed.
- Final Step still offers to run context-save.
