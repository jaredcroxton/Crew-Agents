# Fixture: crew-my-second-brain

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the record was written into the active project. All businesses are fictional. The build and serve steps run real local tools only; nothing leaves the machine.

## Case A: clean
INPUT:
Continuing the project. Brand context exists (Harbourline Studio, a fictional design
consultancy). The owner's first name is Mel. The machine has a healthy Crew estate:
memories across two projects, installed skills, a skill-pack repo, and a Desktop of
project folders. "Show me my second brain."
EXPECT:
- Skill runs Step 0 Context Recovery and settles the project; the missing-brand hard stop does NOT apply to this skill (a map can be built pre-onboarding), but here the brand exists and hubs are renamed to Harbourline's world.
- The workspace ~/Desktop/my-second-brain/ is created and the four bundled files are copied in.
- brand.json carries the real owner name Mel; a placeholder name is never used.
- Parallel scanner agents return nodes against the locked schema (memory, gskills, pskills, packs, projects), groups assigned from the brand.json hub taxonomy, unknown groups falling through to "other", no invented hubs.
- The map is built with build_map.py and served from a /tmp copy (never straight from Desktop), on port 4880 or a named fallback.
- Verification happens before hand-over: the Awakening plays, console clean, /health ok, one real /ask answered with citations.
- Output is a "SECOND BRAIN MAP" report with Owner, Workspace, Serving, Nodes, Edges, Profiles, Features, Verified.
- The user is handed the running localhost URL and the three party tricks.
- No em dashes anywhere in the output.
- The record was written to ~/.claude/crew-state/projects/<project>/crew-my-second-brain-handoff.md with the frame intact.

## Case B: messy
INPUT:
Fresh start, day-one user. Brand context exists but the estate is nearly empty: 4
memories, no packs repo, port 4880 is already taken by another process, and the claude
CLI is not on the server's PATH so /ask cannot work.
EXPECT:
- The cold-start gate fires: under 25 nodes, so the brain is seeded from the real brand context facts and the really-installed skills into the extra array, at least 30 nodes before building; nothing is invented beyond the sanctioned seeds.
- The port conflict is handled by picking another port and saying so.
- The missing claude CLI is reported honestly via the troubleshooting rule; Ask-the-Brain is named as disabled rather than pretended working.
- STATUS is DONE_WITH_GAPS with the disabled ask feature and the port fallback named.

## Case C: missing input
INPUT:
"Build my brain map." No owner name is derivable, and the user does not answer which
folder holds their work; the estate scan cannot start.
EXPECT:
- The skill asks once, plainly, for the owner's first name and the work folder (Loop 1) and stops; no map is fabricated and no placeholder identity is used.
- The record is still written into the active project first, STATUS: BLOCKED, naming the missing inputs as the blocker.
- The chat Completion status is NEEDS_CONTEXT or BLOCKED, never DONE.
