# Fixture: crew-web-page-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A
INPUT:
Build me a clean, premium 3-page business website for "Northwind Studio", a small architecture practice.
Pages: home, about, contact. Style register: clean and minimal. Brand colours: #0B1F33 (deep navy) and #C8A86B (warm sand).
Single self-contained HTML file. Brand context already onboarded.
EXPECT:
- Step 0 Context Recovery runs first: it checks `~/.claude/crew-state/brand-context.md`. Because the brand is onboarded, the hard gate passes silently (no STOP), and the skill states recovered context from `~/.claude/crew-state/web-design/crew-web-page-builder-handoff.md` or "Brand context found but no prior handoffs. First run in this location."
- Discovery confirms back in one line: three pages (home, about, contact), clean and minimal register, brand colours #0B1F33 and #C8A86B, before any code.
- Output is ONE self-contained HTML file. Zero dependencies except the Google Fonts CDN link. No framework, no build step, no npm, no canvas, no scroll-jacking.
- A `:root` block is built from the two supplied hex colours and CSS custom properties hold every brand token: colour, the typography scale, and spacing. Nothing is hardcoded inside a selector.
- One heading font and one body font from Google Fonts, a premium pairing.
- The three pages are in-page sections with a sticky header nav and in-page smooth scroll between them, plus a mobile hamburger menu.
- A working dark and light mode toggle is present: it reads prefers-color-scheme, is user-overridable, persists to localStorage, and dark mode is the default.
- Mobile-first responsive with breakpoints at 768px and 1024px, comfortable touch targets, readable type at every size.
- Vanilla JS only and ONLY for the nav toggle and the theme toggle.
- Overflow safety holds: content never clips or hides under the sticky header (scroll-margin-top on anchored sections, padding-top on the hero), tall sections scroll normally instead of centre-clipping, and there is no horizontal overflow at any width (overflow-x: clip on html and body, never overflow-x: hidden on an ancestor of a sticky element).
- Subtle motion only: fade-in on scroll via IntersectionObserver plus a CSS transition (one-shot, unobserve after), hover transitions, smooth scroll behaviour, all honouring prefers-reduced-motion (reveals instant, no smooth scroll).
- The build report begins with the exact line `WEBSITE PAGE OUTPUT`.
- No em dashes and no en dashes anywhere (text, CSS comments, JS strings).
- Handoff file `~/.claude/crew-state/web-design/crew-web-page-builder-handoff.md` was written.
- Final Step prompts: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" and acts on the answer.

## Case B
INPUT:
Build a 5-page site for a business already onboarded via brand-context.md.
Pages: home, services, pricing, FAQ, contact. Dark mode default.
Services, prices, and FAQ content are supplied in the brand context and the brief. Do not invent any of them.
EXPECT:
- Step 0 reads `~/.claude/crew-state/brand-context.md`, the gate passes, and the skill confirms the brand out loud (who the business is, what it sells, how it sounds) before building.
- Discovery confirms back: five pages (home, services, pricing, FAQ, contact), the register drawn from the brand context, dark mode default.
- All five sections are built with the REAL supplied content. No invented services, no invented prices, no invented testimonials.
- The FAQ is an accordion (vanilla JS only, expand and collapse, keyboard reachable), honouring prefers-reduced-motion.
- Still ONE self-contained HTML file: `:root` brand tokens, sticky nav with in-page smooth scroll and hamburger menu, dark and light toggle persisted to localStorage with dark as default, mobile-first at 768px and 1024px, overflow safety under the sticky header, no horizontal overflow.
- The build report begins with the exact line `WEBSITE PAGE OUTPUT`.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/web-design/crew-web-page-builder-handoff.md` was written.
- Final Step offers to run context-save and records the answer in the handoff.

## Case C
INPUT:
"Just make me a website."
No pages specified, no style register chosen, no content supplied.
EXPECT:
- Loop 1, Missing Input fires. The skill asks the discovery questions first: which pages from the menu (home, about, services, pricing, contact, FAQ, blog), and which of the five style registers (soft and warm, clean and minimal, raw and bold, trustworthy and established, cinematic and atmospheric).
- It does NOT build a single section until both the pages and the register are chosen.
- It invents no company name, no service, no price, and no testimonial, and does not scaffold the HTML on a guess.
- The Step 0 brand HARD GATE fires if `~/.claude/crew-state/brand-context.md` does not exist: the skill STOPS, says the business is not onboarded yet, and runs the eleven-question brand onboarding conversation inline, writing `~/.claude/crew-state/brand-context.md` before going further. It does not proceed to its own discovery or workflow until that file exists.
- No `WEBSITE PAGE OUTPUT` report is produced for a site that was not built.
- No em dashes and no en dashes anywhere.
- Handoff file `~/.claude/crew-state/web-design/crew-web-page-builder-handoff.md` was written, recording the site as not started and the inputs still needed (pages and register), with no company, service, or price assumed.
- Final Step still offers to run context-save.
