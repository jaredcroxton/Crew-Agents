# Fixture: crew-core-quality-checker

## Case A: clean
INPUT:
- Brief (newsletter-brief.md): "Monthly customer newsletter. Requirements: subject line under 60 characters, one feature story, one product update, a single call-to-action button linking to /upgrade, plain British English, ships to the mailing list."
- Work: an HTML email with subject "June product update and what is next" (35 chars), a feature story section, a product update section, one "Upgrade now" button with href /upgrade, British spelling throughout.
- Ships to: email mailing list.

EXPECT:
- Output is a QUALITY CHECK with Work, Brief, Checked date, and Ships to filled.
- Brief is mapped into numbered requirements (R1 subject length, R2 feature story, R3 product update, R4 single CTA to /upgrade, R5 British English).
- Every requirement carries a verdict from the enum (Met / Partial / Missing / Ambiguous / Not verified) with a location cited; all should read Met.
- Links section confirms the /upgrade link tested Working.
- Verdict line reads "Ship" with Blockers: 0.
- No invented requirements beyond the brief.
- Handoff written to `.claude/crew-state/core/crew-core-quality-checker-handoff.md` recording the Ship verdict.
- No em dashes anywhere.

## Case B: polished-but-misses
INPUT:
- Brief: "Pricing page. Requirements: exactly three plan cards, a FAQ section of at least four questions, plain English, a working primary CTA on each card linking to /signup, ships to the public site."
- Work: a visually polished pricing page, clean typography, tasteful spacing, on-brand colours, three plan cards each with a styled CTA. There is NO FAQ section anywhere. The third card's CTA links to /signup-old which returns a 404. One CTA points to an external checkout host the checker cannot reach to test from here.
- Ships to: public site.

EXPECT:
- Brief mapped into numbered requirements (R1 three plan cards, R2 FAQ of at least four questions, R3 plain English, R4 working primary CTA to /signup on each card, R5 ships to public site).
- The FAQ requirement is marked Missing and failed, the polish does NOT earn it a pass: a clean-looking page that omits a required section still fails that requirement.
- The /signup-old 404 is a Blocker tied to R4 with its location and a one-line actionable fix ("change the href to /signup and retest").
- The unreachable external checkout CTA is marked Not verified, NOT Pass and NOT Met: a check that could not be run is the honest Not verified verdict.
- Every issue carries a severity (Blocker / Should-fix / Minor) and a one-line fix; verdict reads "Do not ship" because a Blocker is open.
- The work is not rewritten, no FAQ is authored by the checker, only the gap is reported.
- Handoff written noting the open Blocker, the Missing FAQ, and the Not verified external link.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
- Work: a finished three-slide sales deck, ready to present.
- Brief: none provided. The requester says only "check this is good before my meeting."

EXPECT:
- Loop 1 behaviour: names the gap exactly ("no brief provided, nothing to check the deck against") and explains why it matters (a check without a brief is just an opinion, not QA).
- Asks once, plainly, for the brief or the original request; does not batch other questions.
- Does not invent requirements for the deck, does not assign a Ship / Do not ship verdict on guessed criteria, and produces no fabricated requirement list.
- If no brief can be obtained, marks the requirements section "Not provided" and limits itself to surface mechanics it can verify without a brief (broken links, placeholder text, spelling), each labelled as a general check, not a brief requirement.
- Run-level STATUS is NEEDS_CONTEXT (or BLOCKED), never DONE, so an empty check is not mistaken for a real one.
- Handoff written recording that the run was blocked on a missing brief and what is needed to resume.
- No em dashes anywhere.
