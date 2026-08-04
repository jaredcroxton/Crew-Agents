# Fixture: crew-web-website-architect

Three cases that exercise the skill: a clean competitor study, a messy inspiration study over a hostile scrape with brand context on file, and a missing-input brief with no URL. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. This is an analysis and extraction skill, not a builder: it returns a design-architecture report plus a fill-in token kit, never a website.

## Case A: clean

INPUT:
Study a competitor for me. We are building a full site. The competitor is Northwind Freight at https://www.northwind-freight-demo.example. Tell me what they do well, what they get wrong, and what we should learn. Then give me a token kit I can hand to the page builder.

EXPECT:
- Step 0: Context Recovery reads `~/.claude/crew-state/brand-context.md`, then this skill's record at `~/.claude/crew-state/projects/<project>/crew-web-website-architect-handoff.md` and states what was recovered, or "No prior record in this project for this skill".
- The brand HARD GATE is honoured: if `~/.claude/crew-state/brand-context.md` is missing the skill STOPS and runs the eleven-question brand onboarding inline before going further; if it exists the skill proceeds.
- The four discovery answers are captured and confirmed back in one line before analysis: this is a competitor study (not inspiration), the target is the Northwind Freight URL, the user is building a full site, and the brand context state is named.
- A JS-rendering scrape tool is VERIFIED before any analysis, walking the fallback chain Firecrawl, then Apify, then Claude in Chrome, then plain curl. If a tool is deferred it is loaded via ToolSearch first. If none are available the skill tells the user what to install and does NOT attempt extraction, because the kit would come back full of nulls.
- The live site is pulled, not described from memory or guessed from the brand name.
- Two viewports are rendered: the desktop pass (~1440px) and the mobile pass (~375px). Both screenshots are saved to `~/.claude/crew-state/projects/<project>/architect-evidence/` and named in the report header. Every clamp() in the kit derives from the measured pair; a fluid slot measured at one width is null.
- All SIX design dimensions are extracted with real depth via the extraction recipes, each pushed to its load-bearing choice: Typography (families, scale and ratio, weights including any between-step weight, variable axes, pairings, tracking and leading), Colour (palette, theme story, ratios, accent strategy, neutral temperature, computed contrast), Spacing (rhythm, density, whitespace system), Layout (hero pattern, section flow, grid strategy, cross-page coherence), Surface and materiality (radius system, elevation and shadow logic, texture), and Motion (easing vocabulary, micro/macro duration ramp, stagger, scroll choreography, what animates, reduced-motion honoured).
- The four cross-cutting blocks are present: RESPONSIVE, PERFORMANCE (with the "beat them by" line under the competitor lens), ACCESSIBILITY (contrast computed with math, never eyeballed), and FINISH READ. The STYLE FAMILY routing line names the pack 13 lens the build inherits.
- The competitor lens is applied: what they do well with specific evidenced examples, what they get wrong (generic patterns, dated choices, accessibility and performance gaps), and what the user should learn (copyable principles). `crew-design-reference` (patterns lens) is consulted (mandatory in Careful mode under the competitor lens) with the literal "CREW CONSULT from crew-web-website-architect:" preamble, so a 2023 tell is dated, not recorded as a strength.
- Any token that cannot be read off the live site is marked null with a one-line reason, and only AFTER that dimension's extraction recipe ran; nothing is guessed or filled with a plausible value.
- The deliverable begins with the exact line `WEBSITE ARCHITECTURE REPORT`.
- A fill-in token kit is produced. Every token name in crew-web-page-builder/page-builder-reference.html :root has a corresponding slot, filled or null, in BOTH theme blocks: the PRIMARY THEME the scraper rendered and the ALTERNATE THEME. The colour set covers --accent, --accent-soft, --accent-ink, --bg, --bg-soft, --surface, --surface-2, --text, --text-soft, --text-faint, --border, --border-soft, --error, and --shadow-1/--shadow-2/--shadow-3; type covers --font-heading, --font-body, the --step-hero/--step-h2/--step-h3/--step-body/--step-small steps and the matching --track-* and --leading-* tokens; spacing covers --space-1 through --space-6 in rem; layout covers --maxw, --gutter, --header-h, --radius, --radius-sm, --border-w, and --focus-ring; motion covers --ease and --dur. Each slot pastes straight into the builder's :root block with no renaming and no unit conversion. The type scale note and the raw spacing scale appear only as derivation notes alongside the concrete tokens, never as the paste value, and the scale note reproduces the observed steps within 1px.
- Every finding is tagged brand-locked or copyable, and the DO NOT COPY block lists the reference's brand-locked assets (logo, proprietary hex, photography, literal copy) so none leak into the copyable structure.
- Verification runs THE VERIFICATION GATE in study form against the reference, and the receipt carries the verdict line (for example "web-standards Gate (study form): 10/10" or the named residuals).
- All three modes run silent by default: progress, confirmation, and status lines are suppressed; only the report, the kit, the three-line receipt, and any genuine blocker reach the user.
- No em dashes and no en dashes anywhere in the output.
- Final Step: Record Save writes `~/.claude/crew-state/projects/<project>/crew-web-website-architect-handoff.md` (naming the URL studied, the lens, the evidence paths, the load-bearing choices, and the kit slots filled versus null), then prompts whether to run context-save.

## Case B: messy

INPUT:
I found a site I love and want to borrow from it for our own brand. It is inspiration, not a competitor. The site is Lumen Studio at https://lumen-studio-demo.example. We have brand-context.md on file already. I am redesigning our single landing page. Show me the load-bearing choices and frame the kit for us. (The site turns out to be a client-rendered single-page app sitting behind a cookie-consent wall, its fonts are served by a font network under hashed family names, and it ships a single dark theme only.)

EXPECT:
- Step 0 runs and reports the handoff state. The brand HARD GATE passes because brand context exists; the skill reads `~/.claude/crew-state/brand-context.md` and matches the read against the known brand.
- The four discovery answers are confirmed: this is an inspiration study (not a competitor teardown), the target is the Lumen Studio URL, the user is redesigning a single landing page, and brand context is on file.
- The scrape traps are DETECTED and handled, not ignored: the cookie-consent overlay is dismissed (most privacy-preserving option) and the page re-screenshotted before any colour is sampled, so the dim scrim never enters the palette; a thin first render from Firecrawl (an interstitial or an empty SPA shell) triggers walking further down the fallback chain to Claude in Chrome rather than shipping a kit of nulls; the hashed font family names are resolved from the @font-face src or the licence comment, and if still unresolvable the family is recorded null with reason "obfuscated by the font service" plus the classification (a grotesque, a high-contrast serif) so the read still transfers.
- The single-theme reality is handled correctly: the PRIMARY THEME block is filled from the dark theme the scraper rendered, and the ALTERNATE THEME block is marked null on every slot with reason "reference is single-theme", carrying the note that the builder derives the second theme per web-standards Color 3 (a sanctioned derivation, not a fabrication).
- Values that genuinely could not be read after the recipes ran are marked null with a reason (not guessed), and any load-bearing null that matters to the build is surfaced in NULLS / ESCALATED; the run is flagged partial where the scrape stayed thin.
- All six design dimensions are still attempted with the recipes, and each clamp() is emitted only where both viewports were measured; the rest are null.
- The inspiration lens is applied, not the competitor lens: the load-bearing choices (the decisions that define the feel), adaptation notes (how to apply them to the user's different product), and what NOT to copy (elements tied to Lumen Studio's specific brand).
- The fill-in kit is reconciled against the brand context rather than cloning the source palette and type wholesale; its token names still match page-builder-reference.html :root verbatim so the adapted kit pastes straight into the builder's :root block.
- The deliverable begins with the exact line `WEBSITE ARCHITECTURE REPORT`.
- Silent by default: only the report, the kit, the receipt, and genuine blockers surface.
- No em dashes and no en dashes anywhere.
- Completion is DONE_WITH_GAPS, never a clean DONE, because the read shipped with named nulls open (the derived alternate theme, any obfuscated or thin-scrape values).
- Final Step: Record Save writes `~/.claude/crew-state/projects/<project>/crew-web-website-architect-handoff.md`, recording the inspiration source, the traps handled, the adapted kit, and the open nulls, then offers context-save.

## Case C: missing-input

INPUT:
Can you do a design architecture report for me?

EXPECT:
- Loop 1, Missing Input fires: the skill asks once for the URL, because there is no site to pull and nothing to extract.
- It does NOT invent a site, does NOT fabricate any of the six design dimensions, and does NOT fill the token kit with plausible-looking values.
- It does not run a scrape, since there is no target to scrape and no verified tool can rescue a missing URL.
- The brand HARD GATE fires if `~/.claude/crew-state/brand-context.md` does not exist: the skill STOPS and runs the eleven-question brand onboarding inline before continuing.
- It also asks the remaining discovery answers it needs (competitor or inspiration, what the user is building) one at a time rather than guessing.
- No `WEBSITE ARCHITECTURE REPORT` is produced for an analysis that was never run.
- No em dashes and no en dashes anywhere.
- Final Step: Record Save writes `~/.claude/crew-state/projects/<project>/crew-web-website-architect-handoff.md` with STATUS BLOCKED (the Loop 1 pause counts as finishing for the Context Loop, handoff written first), recording the analysis as not started and the inputs still needed (the URL and the unanswered discovery questions).
