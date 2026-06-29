# Fixture: crew-web-website-architect

Three cases that exercise the skill: a competitor study, an inspiration study with brand context on file, and a vague brief missing the URL. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. This is an analysis and extraction skill, not a builder: it returns a design-architecture report plus a fill-in token kit, never a website.

## Case A: competitor study

INPUT:
Study a competitor for me. We are building a full site. The competitor is Northwind Freight at https://www.northwind-freight-demo.example. Tell me what they do well, what they get wrong, and what we should learn. Then give me a token kit I can hand to the page builder.

EXPECT:
- Step 0: Context Recovery reads `~/.claude/crew-state/web-design/crew-web-website-architect-handoff.md` and states what was recovered, or "No prior context, first run".
- The brand HARD GATE is honoured: if `~/.claude/crew-state/brand-context.md` is missing the skill STOPS and runs the eleven-question brand onboarding inline before going further; if it exists the skill proceeds.
- The four discovery answers are captured and confirmed back in one line before analysis: this is a competitor study (not inspiration), the target is the Northwind Freight URL, the user is building a full site, and the brand context state is named.
- A JS-rendering scrape tool is VERIFIED before any analysis, walking the fallback chain Firecrawl, then Apify, then Claude in Chrome, then plain curl. If a tool is deferred it is loaded via ToolSearch first. If none are available the skill tells the user what to install and does NOT attempt extraction, because the kit would come back full of nulls.
- The live site is pulled, not described from memory or guessed from the brand name.
- All five design dimensions are extracted with real depth: Typography (fonts, scale, weights, pairings), Colour (palette, ratios, accent strategy), Spacing (rhythm, density, whitespace system), Layout (hero pattern, section flow, grid strategy), and Motion (transitions, scroll behaviour, hover states).
- The competitor lens is applied: what they do well with specific examples, what they get wrong (generic patterns, dated choices, accessibility gaps), and what the user should learn (copyable principles).
- Any token that cannot be read off the live site is marked null, not guessed or filled with a plausible value.
- The deliverable begins with the exact line `WEBSITE ARCHITECTURE REPORT`.
- A fill-in token kit is produced, a design-token template ready for crew-web-page-builder or any design skill, with slots for colour, type, spacing, and motion. The token names match crew-web-page-builder/page-builder-reference.html :root verbatim (--accent, --accent-soft, --accent-ink, --bg, --bg-soft, --surface, --surface-2, --text, --text-soft, --border for colour; --font-heading, --font-body and the --step-hero/--step-h2/--step-h3/--step-body/--step-small type steps; --space-1 through --space-6 in rem; --ease and --dur for motion), so a builder pastes each slot straight into its :root block with no renaming and no unit conversion. The type scale and the raw spacing scale appear only as derivation notes alongside the concrete step tokens, never as the paste value.
- All three modes run silent by default: progress, confirmation, and status lines are suppressed; only the report, the kit, and any genuine blocker reach the user.
- No em dashes and no en dashes anywhere in the output.
- Final Step: Handoff Save writes `~/.claude/crew-state/web-design/crew-web-website-architect-handoff.md`, then prompts whether to run context-save.

## Case B: inspiration study with brand on file

INPUT:
I found a site I love and want to borrow from it for our own brand. It is inspiration, not a competitor. The site is Lumen Studio at https://lumen-studio-demo.example. We have brand-context.md on file already. I am redesigning our single landing page. Show me the load-bearing choices and frame the kit for us.

EXPECT:
- Step 0: Context Recovery runs and reports the handoff state.
- The brand HARD GATE passes because brand context exists; the skill reads `~/.claude/crew-state/brand-context.md` and matches the analysis against the known brand.
- The four discovery answers are confirmed: this is an inspiration study (not a competitor teardown), the target is the Lumen Studio URL, the user is building a single page, and brand context is on file.
- A JS-rendering scrape tool is verified down the fallback chain before analysis, and the live site is pulled.
- All five design dimensions are extracted (Typography, Colour, Spacing, Layout, Motion) with real depth.
- The inspiration lens is applied, not the competitor lens: the load-bearing choices (the decisions that define the feel), adaptation notes (how to apply them to a different product), and what NOT to copy (elements tied to Lumen Studio's specific brand).
- The fill-in kit is framed for the user's own brand, reconciling the borrowed choices against the brand context rather than cloning the source palette and type wholesale. Its token names still match crew-web-page-builder/page-builder-reference.html :root verbatim (the --accent / --bg / --surface / --text / --border colour set, the --step-* type tokens, --space-1 through --space-6 in rem, --ease and --dur), so the adapted kit pastes straight into the builder's :root block with no renaming.
- Unreadable tokens are marked null rather than guessed.
- The deliverable begins with the exact line `WEBSITE ARCHITECTURE REPORT`.
- Silent by default: only the report, the kit, and genuine blockers surface.
- No em dashes and no en dashes anywhere.
- Final Step: Handoff Save writes `~/.claude/crew-state/web-design/crew-web-website-architect-handoff.md`, recording the inspiration source and the adapted kit, then offers context-save.

## Case C: missing-input

INPUT:
Can you do a design architecture report for me?

EXPECT:
- Loop 1, Missing Input fires: the skill asks once for the URL, because there is no site to pull and nothing to extract.
- It does NOT invent a site, does NOT fabricate any of the five design dimensions, and does NOT fill the token kit with plausible-looking values.
- It does not run a scrape, since there is no target to scrape and no verified tool can rescue a missing URL.
- The brand HARD GATE fires if `~/.claude/crew-state/brand-context.md` does not exist: the skill STOPS and runs the eleven-question brand onboarding inline before continuing.
- It also asks the remaining discovery answers it needs (competitor or inspiration, what the user is building) one at a time rather than guessing.
- No `WEBSITE ARCHITECTURE REPORT` is produced for an analysis that was never run.
- No em dashes and no en dashes anywhere.
- Final Step: Handoff Save writes `~/.claude/crew-state/web-design/crew-web-website-architect-handoff.md`, recording the analysis as not started and the inputs still needed (the URL and the unanswered discovery questions).
