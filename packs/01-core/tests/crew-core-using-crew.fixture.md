# Fixture: crew-core-using-crew

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear, and that the handoff file was written.

## Case A: clean
INPUT:
User says: "Can you prep me for a first call with Northwind Logistics?" Installed skills include crew-sales-lead-research and crew-sales-prospect-brief.
EXPECT:
- Output begins with "CREW USAGE GUIDE".
- Intent named as a sales prep job (the job, not the words).
- Match is Strong and routes to crew-sales-lead-research.
- A "Next in chain" naming crew-sales-prospect-brief.
- Handoff file `.claude/crew-state/core/crew-core-using-crew-handoff.md` was written.
- No em dashes anywhere.

## Case B: messy
INPUT:
User says: "We need more leads, can you sort that out?" (Could touch crew-sales-* and crew-marketing-*.) Installed: crew-sales-* and crew-marketing-*.
EXPECT:
- The intent is named as one job, not left vague.
- A single best-fit skill is chosen, with match strength stated (Strong or Partial), not a tour of every skill.
- If the request genuinely spans two packs, it picks the first concrete step and names the other pack as next in chain, rather than refusing.
- No skill name is invented; only installed skills are named.
- Handoff file written, recording the routing decision.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
User says: "Summarise this PDF for me." No Crew skill covers ad-hoc summarising, and the installed set is only crew-sales-*.
EXPECT:
- Match is None. The skill says plainly that no Crew skill fits and it will proceed with the Crew Method standards.
- It does NOT force an unrelated sales skill onto the task.
- It does not invent a skill name that is not installed.
- Handoff file written, noting "no skill dispatched".
- No em dashes anywhere.
