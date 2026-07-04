# Fixture: crew-design-documents

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
SPEC mode (Careful). Halloran & Reyes Accounting, a fictional two-partner accounting firm, needs its client onboarding guide delivered as a branded PDF. Content is supplied: a welcome letter, a 5-step onboarding checklist, a fee schedule table (12 rows, 4 columns, one column holds engagement descriptions up to 140 characters), and a contacts page. Brand tokens supplied: ink navy #1B2A41, warm paper #FAF7F0, one brass accent #B08D57, a serif display face with a system fallback, a sans body face. Page size A4. Audience: new clients, printed and emailed.
EXPECT:
- Output contains a fenced block whose FIRST line is "DOCUMENT RENDER SPEC", with the mode recorded as SPEC.
- The spec names the HTML-first pipeline: author a styled HTML document with the brand tokens as CSS variables, then print to PDF via headless Chrome with the --headless, --no-pdf-header-footer, and --print-to-pdf flags. No raw text-drawing library route is proposed.
- Page geometry is explicit: an @page rule with A4 size and stated margins (the 16mm/18mm default or a justified variant), and a declared modular type scale (display, h1, h2, body, caption) with exact sizes and line-heights, body measure inside 60 to 75 characters.
- The fee schedule table gets fixed table-layout with explicit column widths that sum correctly inside the text column, and the 140-character engagement description column is planned against the LONGEST real value, with overflow-wrap: break-word, never clipping.
- The render verification loop is named as a required build step, not optional: image every page after render (pdftoppm with poppler as the page-per-image route, or a direct page-range read of the PDF; qlmanage or sips only as a first-page smoke check, and no Chrome screenshot route), inspect for overhang, truncation, orphan headings, split tables, and runt pages, plus a pdftotext content check and a page count sanity check, before handover. "No document ships unseen" appears as the governing rule.
- Brand application uses the supplied tokens with the brass accent used sparingly; no second accent invented.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-documents-handoff.md` was written.

## Case B: messy
INPUT:
CHECK mode. A rendered PDF is supplied at a given path: a 6-page services proposal. Page 3 has a fee table split mid-row across the page break, the heading "Engagement Terms" sits orphaned at the very bottom of page 3 with its body on page 4, and the rightmost table column is visibly truncated, ending in an ellipsis on two cells.
EXPECT:
- Output contains a fenced block whose FIRST line is "DOCUMENT RENDER SPEC", with the mode recorded as CHECK and the rendered file path echoed.
- Verdict: Fix before handover. Not Ship.
- All three defects are found and ranked with severities: the ellipsis truncation is Critical (an ellipsis in a print document is data loss), the mid-row table split and the orphan heading are ranked as Major or Critical, never Minor.
- Each fix names the exact CSS rule: page-break-inside: avoid on the table rows or row groups for the split, break-after: avoid on the heading for the orphan, and overflow-wrap: break-word plus a corrected explicit column width (or a landscape restructure) for the truncated column. No vague "adjust the layout" fixes.
- The checker states the pages were imaged or re-read as its verification evidence; it does not claim the fixes are applied or the document re-rendered until that actually happens, and it requires a re-render plus a fresh page-image pass before the verdict can move to Ship.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/design-standards/crew-design-documents-handoff.md` written, recording the verdict and the ranked fix list.

## Case C: missing-input
INPUT:
"Make my document beautiful." No content, no file, no audience, no page size, and no brand context is provided.
EXPECT:
- The skill follows Loop 1 (Missing Input): it asks once, plainly, for the content source and the audience, because there is nothing to spec or check without them.
- The brand hard gate fires: with no brand-context file and no supplied tokens, the skill flags the missing Visual identity line rather than inventing colours or faces.
- It does not invent content, fabricate a pipeline verdict, or emit a filled spec; if any partial output appears, the content, audience, and verdict fields read "Not provided".
- A BLOCKED handoff is written BEFORE the skill pauses for the answer: handoff file `~/.claude/crew-state/design-standards/crew-design-documents-handoff.md` written with STATUS: BLOCKED and the missing content source and audience recorded as the blockers the next run needs.
- No em dashes anywhere in the output.
