# Fixture: crew-web-fly-through-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written.

## Case A: clean
INPUT:
Journey: deep space, down through the cloud deck, past a glass tower, into a penthouse interior.
Arrival: expands into a six-room luxury listing. Asset route: KIE API key attached (KIE_API_KEY set).
Brand: minimal-luxe, ink and ivory with one warm accent. Stages: Orbit, Stratosphere, Sanctuary.
Delivery context: presented on a screen, desktop-first. Deploy: Vercel project "vantage".
EXPECT:
- Skill runs Step 0 Context Recovery and states recovered context or "No prior record in this project for this skill."
- Step 1 confirms the journey, arrival shape, asset route, and delivery context back in one line before any tool call.
- Route A path taken: `--handshake` is run before any video generation (cost confirmed first).
- Reference build cloned (fly-through-reference.html), not rebuilt from scratch; FRAME_COUNT set from to_webp.py output; the locked head block, accessibility kit, and SRI script tags are not stripped.
- Output is a "FLY-THROUGH BUILD REPORT" with Journey, Arrival, Asset route, Frames (with per-set MB weights), Verified, Gate, Review gate, Deploy checks.
- Both frame sets are produced under a single FRAME_COUNT: a desktop set (frames/d, 16MB budget) and a portrait-mobile set (frames/m, 8MB budget), the count derived by to_webp.py, not asked of the user.
- Verification adopts the web-standards Gate roster: the report carries a "web-standards Gate:" verdict line, and a Safari (or named-residual static-check) pass plus a reduced-motion twin check appear in Verified.
- Deploy checks report the status-code matrix: index 200, a frame from frames/d and frames/m 200, listing images 200, og.webp 200, and raw assets/video 404 (excluded).
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-fly-through-builder-handoff.md` was written.

## Case B: messy
INPUT:
"Make me one of those falling-through-the-sky cinematic scroll-descent sites, ocean down to a reef, and at the bottom
show my dive resort. I think I can get drone clips off my GoPro? Not sure how many. No idea what a frame count is."
EXPECT:
- Skill restates the journey (ocean surface to reef floor) and arrival (resort) for the user to correct (Step 1).
- Asset route resolved to B (own footage) and the unknown clip count handled: ingest_footage.sh accepts one or many.
- Skill does not ask the user for a frame count. It is derived by the pipeline and set automatically (Step 5).
- For a real resort, "Concept demonstration only" footer is kept until sign-off, and resort specs are not invented; any price or claim the owner has not supplied is Escalated (Loop 3), not written.
- Locked engineering, the continuous-flow arrival, and the accessibility kit are not redesigned away to "simplify" for a non-technical user.
- Handoff file written to `~/.claude/crew-state/projects/<project>/crew-web-fly-through-builder-handoff.md`, noting the footage as user-supplied and any clip-count uncertainty as unfinished work.

## Case C: missing-input
INPUT:
Journey: city street up to a rooftop product reveal. Arrival: ambient endpoint, no expansion.
Asset route: no KIE key, and no footage yet. "Can you just make the video?"
EXPECT:
- Skill follows Loop 1: it does NOT fabricate footage and does NOT fake the motion with CSS.
- Route C taken: the four keyframe prompts and the clip prompts (three gaps plus the settle clip when the arrival payoff matters) are handed over as paste-ready text, with named third-party apps (Runway, Kling, Sora, Pika, Veo, Luma) and the 1080p MP4 export instruction.
- Skill pauses and states it will resume as route B when the MP4s arrive.
- Arrival is built as an ambient endpoint (no #listing expansion, skip link pointed at #enter), per the brief.
- Handoff file written FIRST (STATUS: BLOCKED, the missing footage named as the blocker), recording that prompts were handed over and the next run resumes as route B.
