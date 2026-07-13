# Fixture: crew-web-page-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. State root is `~/.claude/crew-state/`; project records live under `~/.claude/crew-state/projects/<project>/`.

## Case A: clean
INPUT:
Build me a clean, premium 3-page business website for "Northwind Studio", a small architecture practice.
Pages: home, about, contact. Style register: clean and minimal. Brand colours: #0B1F33 (deep navy) and #C8A86B (warm sand).
Single self-contained HTML file. Brand context already onboarded. Project name: websites.
EXPECT:
- Step 0 Context Recovery runs first: it checks `~/.claude/crew-state/brand-context.md`. Because the brand is onboarded, the hard gate passes silently (no STOP). It settles the project ("websites"), then reads ONLY this skill's own record at `~/.claude/crew-state/projects/websites/crew-web-page-builder-handoff.md`, stating what was recovered or "No prior record in this project for this skill."
- Discovery confirms back in one line: three pages (home, about, contact), clean and minimal register, brand colours #0B1F33 and #C8A86B, before any code.
- Output is ONE self-contained HTML file. Zero dependencies except the Google Fonts CDN link. No framework, no build step, no npm, no canvas, no scroll-jacking.
- A `:root` block is built from the two supplied hex colours and CSS custom properties hold every brand token: colour, the typography scale with per-level tracking and leading tokens, spacing, the shadow ramp, and the focus ring. Nothing is hardcoded inside a selector.
- One heading font and one body font from Google Fonts, a premium pairing, each with a metric-tuned local fallback (size-adjust and the overrides) so the display=swap causes no visible reflow.
- Head hygiene per web-standards Head 1 to 7: lang, title, meta description, an SVG favicon data URI, OG and Twitter tags (og:image deferred to deploy as a named residual when no public URL exists), theme-color synced to the toggle, viewport with viewport-fit=cover.
- The three pages are in-page sections with a sticky header nav (sentinel-driven scrolled state), in-page smooth scroll between them, a skip link first in the tab order, and a focus-managed mobile hamburger drawer (Escape closes, focus returns).
- A working dark and light mode toggle is present: it reads prefers-color-scheme, is user-overridable, persists to localStorage, syncs theme-color, declares color-scheme per theme, and dark mode is the default.
- Mobile-first responsive with breakpoints at 768px and 1024px, safe-area padding, comfortable touch targets, readable type at every size.
- Vanilla JS only, and ONLY for the four behaviours: theme toggle, hamburger drawer, reveal observer, header sentinel.
- Overflow safety holds: content never clips or hides under the sticky header (scroll-margin-top on anchored sections, padding-top on the hero), tall sections scroll normally instead of centre-clipping, and there is no horizontal overflow at any width (overflow-x: clip on html and body, never overflow-x: hidden on an ancestor of a sticky element).
- Subtle motion only: one-shot staggered fade-ins via IntersectionObserver (unobserve after, stagger delays cleared on transitionend), a reveal-hero signature rise, hover lifts behind the hover-capability query with :active press states, smooth scroll behaviour, all honouring prefers-reduced-motion (reveals instant, no smooth scroll).
- The Verification section runs the web-standards VERIFICATION GATE (Section 10) and the receipt carries a Gate verdict line (for example "web-standards Gate: 10/10" or the named residuals).
- The build report begins with the exact line `WEBSITE PAGE OUTPUT`.
- No em dashes and no en dashes anywhere (text, CSS comments, JS strings).
- Handoff file `~/.claude/crew-state/projects/websites/crew-web-page-builder-handoff.md` was written, opening with the `# crew-web-page-builder handoff` title line, a `Date:` line, and a `STATUS:` line.
- Final Step prompts: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" and acts on the answer.

## Case B: messy
INPUT:
Build a 5-page site for a business already onboarded via brand-context.md. Continuing in the existing project.
Pages: home, services, pricing, FAQ, contact. Dark mode default.
The brief lists four services but only three have descriptions, one plan's price is marked "TBC", and the FAQ answers are supplied. Do not invent any of them.
EXPECT:
- Step 0 reads `~/.claude/crew-state/brand-context.md`, the gate passes, and the skill confirms the brand out loud (who the business is, what it sells, how it sounds). It reads the `~/.claude/crew-state/active-project` pointer and ONLY this skill's own record at `~/.claude/crew-state/projects/<project>/crew-web-page-builder-handoff.md` before building.
- Discovery confirms back: five pages (home, services, pricing, FAQ, contact), the register drawn from the brand context, dark mode default, and names the gaps: the fourth service has no description, one price is TBC.
- Loop 1 fires once for the missing service description (asked in a single message or marked "Not provided"); the TBC price is never invented: the plan ships without a fabricated figure and the gap is named (a price with no source is Escalated, Loop 3, not drafted).
- The sections that have real content are built with the REAL supplied content. No invented services, no invented prices, no invented testimonials, no scaffolded star ratings.
- The FAQ is a details/summary accordion (keyboard reachable, Enter toggles), honouring prefers-reduced-motion.
- Still ONE self-contained HTML file: `:root` brand tokens, head hygiene complete, skip link, sticky nav with the sentinel scrolled state, focus-managed hamburger drawer, dark and light toggle persisted to localStorage with dark as default and theme-color synced, mobile-first at 768px and 1024px, overflow safety under the sticky header, no horizontal overflow.
- The build report begins with the exact line `WEBSITE PAGE OUTPUT` and the receipt carries the web-standards Gate verdict line.
- STATUS is DONE_WITH_GAPS (never a clean DONE) because named items stay open.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-page-builder-handoff.md` was written, carrying the open items (the undescribed service, the TBC price) forward as unfinished work.
- Final Step offers to run context-save and records the answer in the handoff.

## Case C: missing-input
INPUT:
"Just make me a website."
No pages specified, no style register chosen, no content supplied.
EXPECT:
- The Step 0 brand HARD GATE fires if `~/.claude/crew-state/brand-context.md` does not exist: the skill STOPS, says the business is not onboarded yet, and runs the eleven-question brand onboarding conversation inline, writing `~/.claude/crew-state/brand-context.md` before going further. It does not proceed to its own discovery or workflow until that file exists.
- Loop 1, Missing Input fires. The skill asks the discovery questions first: which pages from the menu (home, about, services, pricing, contact, FAQ, blog), and which of the five style registers (soft and warm, clean and minimal, raw and bold, trustworthy and established, cinematic and atmospheric).
- It does NOT build a single section until both the pages and the register are chosen.
- It invents no company name, no service, no price, and no testimonial, and does not scaffold the HTML on a guess.
- No `WEBSITE PAGE OUTPUT` report is produced for a site that was not built, and STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-page-builder-handoff.md` was written FIRST (a Loop 1 pause counts as finishing for the Context Loop), with STATUS: BLOCKED and the inputs still needed (pages and register) named, with no company, service, or price assumed.
- Final Step still offers to run context-save.
