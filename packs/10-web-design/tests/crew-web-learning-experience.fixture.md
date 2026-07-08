# Fixture: crew-web-learning-experience

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the behaviour and output, and that the handoff file was written. All businesses are fictional.

## Case A: clean
INPUT:
Roastline Coffee Co., a fictional five-cafe group, hands over the complete training chain for its
barista onboarding programme: a signed-off module outline, a full facilitator guide with a
minute-by-minute run-of-show (scripted say/do/ask segments, activities with setup and debrief,
check questions, timings on every segment), and a learner workbook with page numbers. Five
modules: Bean to Cup, The Machine, Milk Craft, Service Flow, Closing the Bar. Theme metaphor
chosen: the journey of a single coffee order through the cafe. Brand context exists. Media folder
ready at ~/Desktop/roastline-onboarding/media/ with a clip per module. Mode: dual (projector plus
laptop) with the phone remote for the trainer. Deploy: Vercel preview link.
EXPECT:
- Skill runs Step 0 Context Recovery and states recovered context or "No prior context, first run."
- Skill confirms the chain outputs exist before building; it activates the finished programme and writes no training content of its own.
- A course.json manifest is generated on the block spine: programme -> modules -> steps -> blocks[], with the coverage table embedded in the manifest. A step is one screen. Every block is one of the typed EIGHT-type union (heading, text, script, discussion, whiteboard, poll, media, split); each module carries its themed stage name and its verbatim objectives[] rendered in the module opener; each step carries presenter notes (say / do / ask with timings), the guide's named "if it runs over" cut where one exists, and a workbook page cue where the workbook maps one.
- Full-guide coverage is proven: every run-of-show segment in the facilitator guide became a step, every objective appears in its module opener, every timing feeds the presenter clocks, and the coverage table (guide segment -> step) is complete inside the manifest. No segment is dropped; a gap would be a build failure. The whole workshop is mapped, not a highlight reel.
- The visual register holds simple-first: every content step passes the keynote test (generous white space, hierarchy by weight, exactly one accent from the theme tokens, background imagery at zero to 10 percent presence, 65ch measure, no film-poster screens). Module openers are plain typographic title pages by default (display stage name, accent rule, verbatim module title as eyebrow, objectives in an accent-ruled list); because per-module footage exists, cinematic openers (the five-second rAF canvas scrub, skippable, once per unlock, reduced-motion collapse to the arrival still) are wired only as an explicit opt-in where the theme allows (plainOpener false), never as the default.
- The engine matches v3.1: ONE single self-contained monolithic index.html carrying all CSS and JS, no Vite, no React, no framework, no build step; the block renderer switches on the eight-type union with every top-level block wrapped in a tilewrap; the only canvas and the only rAF loop is the opt-in opener scrub; all other motion is CSS transitions and keyframes, transform and opacity only; no GSAP, no Motion, no Locomotive, no animation library anywhere.
- Boot precedence is three-tier and explicit: localStorage <slug>_v1_course wins if present, else the inline courseData script seed, else fetch('course.json'); a redeploy never silently discards edits.
- Four roles ship in the one file: solo (P toggles the drawer), presenter (?role=presenter), audience (?role=audience, a sterile stage set with a real input lock, no arrows, no poll controls, whiteboard read-only, every message SETS state), and remote (?role=remote, the phone clicker: five big buttons, state line, connection dot).
- Same-machine sync runs over a BroadcastChannel named <slug>_v1_present carrying positions and full arrays, never deltas (STEP, CHECKPOINT, ADVANCE, SCRIPT, WHITEBOARD, POLL, ACTIVITY, COURSE on edit commit only, RESTART, and the HELLO -> SYNC handshake), so a late-joining tab converges, including onto committed edits.
- The phone remote runs on serve.py (stdlib only): no-cache headers on everything, an /events SSE fan-out with keepalives that replays the last STATE to a new client, a /cmd POST relay, and /netinfo for the LAN IP so the drawer prints the remote URL and QR. The remote posts REMOTE commands; the PRESENTER tab applies them through its own nextAction()/advanceModule() path, so gate and state authority never leave the presenter; the remote's Advance stays disabled until the checkpoint is done.
- The gate stays the facilitator's clicker: one nextAction() path drives the drawer Next, the edge chevrons, ArrowRight, swipe, and the remote; advanceModule() is the only unlock; at the frontier the next arrow disables with a checkpoint tooltip then relabels to an accent Advance pill; back never re-locks; CHECKPOINT RUN and ADVANCE stay two separate acts; the audience can never move ahead of the trainer.
- The presenter drawer is the instrument: say / do / ask notes, the step clock versus plan and the day clock versus total with a red overrun state, an automatic cut line quoting the step's named cut when the clock goes red, script-to-wall toggles, next-step preview, the controls grid, four theme chips (ink-amber, slate-minimal, warm-serif, bold-brutal as CSS-var token sets), the remote URL plus QR, and a width grip (plain px in the var, min(var,94vw) in the width rules themselves).
- Edit mode ships as a first-class feature, presenter-side only: E opens the teal sidebar (with a collapse tab on its seam) and the banner with the build tag; on screens over 900px the step reflows beside the open sidebar; any text block click-edits in place (contenteditable, blur commits with exactly one COURSE broadcast, zero broadcasts mid-typing); a media block accepts a pasted URL with kind auto-detect; a "+ Add a tile" menu appends any of the block types instantly editable; every tile carries a red x chip on its tilewrap that removes after confirm; steps add, remove, reorder, duplicate in the sidebar (a delete marks the coverage row "removed by owner"); edits persist to localStorage immediately and export/import as course.json with the edited stamp. Edit chrome never appears in the audience role.
- Whiteboard blocks capture live on presenter surfaces (audience read-only), append entries in place, escape every typed string, persist per session, and broadcast the full entries array; poll blocks tally hands with plus/minus on presenter surfaces outside edit mode, bars updating in place, counts persisted and broadcast whole.
- Discussion blocks render the checkpoint question large, facilitator-led, never scored; no quiz, no answer marking, no learner accounts, no per-learner tracking, no backend state anywhere.
- Timing intelligence ships: a per-step timelog accumulates actual seconds, rehearsal mode (?rehearse=1) runs unlocked with zero persistence and ends in a plan-versus-actual report quoting the named cuts on overruns, and the recap export prompts for a cohort label and downloads a styled standalone HTML record (timing table, whiteboard captures, poll results) per session.
- A print handout builds from the manifest on beforeprint or the drawer button: per-module title pages, every step as a bordered card with its notes strip and cut, A4 CSS hiding the app.
- An offline bundle path exists via bundle.py: one double-clickable HTML file with fonts base64-inlined, opener frames inlined as data URIs, and the course as the inline seed, booting from file:// without overriding a machine's edits.
- Presenter notes are lifted from the facilitator guide's scripted sections, not invented.
- Output begins with the literal line "LEARNING EXPERIENCE PLAN".
- The Design review gate is run with a binding verdict from crew-design-quality, and Criticals and Majors are fixed before deploy.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-learning-experience-handoff.md` was written, naming the upstream artifacts consumed (the module outline, the facilitator guide, and the workbook).

## Case B: messy
INPUT:
Fernwood Garden Centres, a fictional plant retail chain, wants its four-module "seasonal team
onboarding" turned into a facilitator-presented deck journey. The module outline and the
facilitator guide both exist and are signed off, but the guide is imperfect: three run-of-show
segments carry no timings, and one module (Winter Care) has scripted say/do/ask sections but no
activities at all. A theme metaphor (a season turning from planting to harvest) and brand context
are supplied. No learner workbook. No footage anywhere.
EXPECT:
- Skill proceeds with what is real: the full block-spine manifest is built from the outline and the guide, with the coverage table embedded in it.
- The coverage table is still complete: every run-of-show segment, including the three without timings, became a step; no segment is dropped or merged to hide the gaps.
- The three timing-less segments carry "Not provided" for their minutes in the manifest and presenter notes; the drawer clocks show no invented plan time for them, and no minutes are fabricated anywhere.
- The activity-less Winter Care module is flagged back to crew-training-facilitator-guide-creator as the named gap; its steps carry no fabricated activity content, since this skill activates finished content and does not write it.
- With no footage anywhere, every module opener is the plain typographic title page (the v3.1 default); no cinematic scrub is wired, no imagery is generated or fabricated to fill the slot, and any step media block with no source renders the honest pending card.
- The build is still the full v3.1 engine: one self-contained index.html (no Vite, no React), the eight-type block union, the four roles, the presenter drawer, edit mode with add-a-tile and x chips, timing intelligence, the print handout, and serve.py for the remote if wired.
- Nothing is fabricated: no say/do/ask line, timing, activity, objective, or fact is invented anywhere; a field with no source reads "Not provided".
- Workbook cues are absent, because no workbook was provided.
- The handoff records the gaps (three missing timings, the activity-less module) and names the facilitator guide skill as the routing target for the next run.
- No em dashes anywhere in the output.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-learning-experience-handoff.md` was written.

## Case C: missing-input
INPUT:
"Make our training an online journey." No module outline, no facilitator guide, no workbook, no
theme, no media, no brand context, nothing.
EXPECT:
- If no brand context exists, the brand hard gate fires first and the skill does not proceed past Step 0 without it.
- Skill follows Loop 1 Missing Input: it does NOT invent modules, objectives, activities, steps, or facts, and does NOT scaffold a deck or an index.html.
- It asks once for the chain outputs (the module outline and facilitator guide, plus the optional learner workbook, or any markdown matching their shape) along with the theme metaphor, the theme preset or register, the opener style (plain by default, cinematic only if footage exists), the presentation setup (solo, dual, phone remote), and the deploy target.
- It routes content creation to the training pack: the programme must be written by crew-training-module-outline-builder and crew-training-facilitator-guide-creator before this skill can activate it.
- The BLOCKED handoff is written BEFORE pausing for the answer, recording the missing chain outputs as the blocker, with nothing assumed.
- No LEARNING EXPERIENCE PLAN report is produced for a build that did not happen.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-learning-experience-handoff.md` was written with STATUS: BLOCKED.
