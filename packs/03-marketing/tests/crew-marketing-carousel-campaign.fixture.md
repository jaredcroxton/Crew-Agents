# Fixture: crew-marketing-carousel-campaign

Three cases that exercise the skill end to end. Each EXPECT lists the output markers that must appear and asserts the handoff file was written to `~/.claude/crew-state/projects/<project>/crew-marketing-carousel-campaign-handoff.md`. All businesses named here are fictional.

## Case A: clean

INPUT:
- A `crew-marketing-campaign-plan` record exists in the active project for Saltbrook Ceramics (fictional pottery studio): offer "ONE DAY ON THE WHEEL" on 14.11, $349 opening price, 12 wheels only, angles listed (real finished pieces, not a certificate; make it with your own hands), drip order 1, 6, 2, 3, 4, close with 5.
- Style reference supplied: a described grayscale photoreal look with one acid-lime accent (the Limelight recipe fits).
- KIE key present in the project `.env`.
- After the prompt pack is delivered and the run has stopped, the user returns with six plates at `plates/` (simulate their arrival exactly as a user message: six landscape JPEGs, clean plates, checklist passes).

EXPECT:
- Step 0 consumes the campaign-plan record: the offer, price, scarcity, angles, and drip order are restated from it, not re-asked; only the gaps are asked for, the style reference above all. A "Consumed:" note is recorded.
- The Style DNA prompt pack is delivered FIRST: master block carrying the full-bleed law and the top/bottom-4% clear rule, six hero prompts each with the wording guard line, copy buttons, the Flow workflow, and the plate checklist.
- THEN the run stops for the Flow handoff: explicit wait language, no placeholder plates generated, no stock imagery sourced, no crop or code stage touched before the user returns.
- On plate return the pipeline completes: checklist run against every plate, vertical extension to exact 1080x1350 (no horizontal crop), 18 coded body pages exported at 1080x1350, six heroes animated with the freeze-clause motion formula and frame-checked early/mid/late, captions written to the formula ("tap the link", never DM), kit folder built with numbered files, `0 - CAPTION.txt` per carousel ending in the FIRST COMMENT with the `[BOOKING LINK]` placeholder, and a `READ ME FIRST.txt` with the weekly drip.
- Output header "CAROUSEL CAMPAIGN KIT" with the campaign, offer, plate verdicts, hero animation results, drip order, and spend filled.
- No invented prices, dates, or credentials beyond what the plan record supplied.
- The record lands at `~/.claude/crew-state/projects/<project>/crew-marketing-carousel-campaign-handoff.md` and the run receipt names that path.

## Case B: messy

INPUT:
- Same fictional Saltbrook offer, style reference supplied, KIE key present.
- The user returns plates as 2400x1792 LANDSCAPE files despite the 3:4 request, and only five of six come back.
- One returned plate fails the checklist: the date reads "04.11" instead of "14.11".
- During animation, one hero (a held-out labelled object) fails frame-check twice on Seedance: the object grows and its label garbles both times.

EXPECT:
- No horizontal crop on the landscape plates: the vertical-extension route (`extend_plates.py` behaviour) is named and used to reach exact 1080x1350.
- The wrong-date plate is sent back to the user for a free regen, named specifically; it is not shipped and the date is not silently accepted.
- The missing sixth plate is filled with a KIE nano-banana edit seeded from an approved plate (the one sanctioned exception), not by sending the user back to Flow and not with stock or invented imagery.
- The twice-failed hero triggers the two-strikes rule: its motion is code-built from the still (`hero_motion_codebuild.py` behaviour), and no third Seedance credit is spent on it.
- The kit is still built and named re-runnable (backup-image-only for anything pending, videos folded in later).
- Completion is DONE_WITH_GAPS, never a clean DONE, and the gaps are named (the regenerated plate owed, anything still pending when the kit shipped).
- Handoff file written, recording the landscape rescue, the gap fill, the code-built hero, and the open regen.

## Case C: missing-input

INPUT:
- A request for a carousel campaign for a fictional bakery, with an offer described in rough terms.
- NO style reference and no described look is provided, and nothing in the project supplies one.

EXPECT:
- Loop 1 (Missing Input) fires: the skill names the style reference as the missing hard blocker for step 1 and asks once, plainly, for it.
- No prompt pack is built, no Style DNA is invented from nothing, no placeholder or stock plates are generated, and no downstream stage runs.
- The record is still written at `~/.claude/crew-state/projects/<project>/crew-marketing-carousel-campaign-handoff.md` with STATUS: BLOCKED, recording the gap ("awaiting style reference") so the next run does not repeat the question.
- The chat status is NEEDS_CONTEXT or BLOCKED, never DONE.
