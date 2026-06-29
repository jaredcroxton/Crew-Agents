# Fixture: crew-design-kit

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
I run a small law firm and I want the site to feel trustworthy and established. Light mode. What colours and fonts should I use?
EXPECT:
- Output begins with "DESIGN KIT" and includes a "Feeling:" line that names the feeling back (trustworthy and established), with light mode noted.
- A filled `:root` CSS block uses all eight token names exactly: `--bg`, `--surface`, `--text`, `--text-muted`, `--border`, `--primary`, `--primary-hover`, `--accent`. Every value is a concrete hex (for example `--bg: #FBFAF8;`), no placeholders left.
- The palette fits the feeling: a near-white background, an ink text near `#1A2233`, and a restrained navy or deep green `--primary` rather than a saturated blue, with a one-line reason tied to the feeling (navy reads as institutional and stable for a legal audience).
- A real Google Fonts pairing is named (for example Libre Baskerville for headings, Inter for body) with a working `https://fonts.googleapis.com/css2?...` link that lists both families.
- A "Contrast:" line states the body text on background ratio as a number and confirms it clears 4.5:1 for AA.
- No invented or unhosted fonts: every family named resolves on Google Fonts.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-kit-handoff.md` was written, recording the chosen feeling, palette, and pairing.

## Case B: by-business-no-feeling-word
INPUT:
I have a yoga studio. What colours and fonts should I use?
EXPECT:
- The user named a business but no feeling word, so the skill maps the business to a feeling first: it states a "Feeling:" line picking soft and warm or earthy and organic, with a one-line reason (a yoga studio reads as calm and grounded, so the kit leans soft and warm).
- It does not ask the user to pick a feeling and does not stall; it infers, names the inference, then returns the full kit.
- A filled `:root` block uses all eight token names with concrete hex values that match the inferred feeling: muted warm neutrals, a sage or terracotta `--primary`, no high-saturation or neon values.
- A real Google Fonts pairing is named with a working `https://fonts.googleapis.com/css2?...` link, and no font is invented.
- A "Contrast:" line confirms body text on background clears 4.5:1, with the ratio stated; if the first soft palette fell short, the text or background hex was adjusted so it passes rather than shipping a failing pair.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-kit-handoff.md` was written, recording the inferred feeling and the kit.

## Case C: missing-input
INPUT:
"Make it look good." No business, no feeling, no colours, no mode, nothing else.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once which of the ten feelings the result should feel like, because a kit needs a target feeling to map colours and fonts against.
- It lists the ten feeling options as the single question rather than guessing a feeling, inventing a business, or dumping the whole token library.
- It does NOT emit a filled `:root` block or a font pairing against an unknown feeling; any partial output marks "Feeling:" as "Not provided".
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-kit-handoff.md` was written, recording the missing feeling as the blocker the next run needs.