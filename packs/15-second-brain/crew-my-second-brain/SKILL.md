---
name: crew-my-second-brain
description: Build a living, visual map of the user's second brain, everything their AI agents know, as an interactive force-directed graph with a cinematic first load, a genesis growth replay, live node births when new memories land, and an Ask-the-Brain box with a lit citation trail. Invoke on "show me my second brain", "map my second brain", "build my brain map", or "visualise what my agents know".
---

# Crew: My Second Brain

One command in, one living map out. You scan everything the person's AI setup knows (memories, skills, packs, projects), assemble it into a graph, and serve it locally with the signature moments built in:

1. **The Awakening.** First load is a 7-second choreography: "scanning your brain...", the owner node pulses in, hubs launch outward on a ring, children stream in with a stagger while the counter ticks up and the camera pulls back.
2. **Profiles and the wheel.** The default and primary view is a light-theme wheel: owner at the center, hubs on a ring, agents and projects fanning outward in their hub's sector. The front chrome stays minimal: title plus active-lens chip, search, a menu button, three "try asking" example questions (from brand.json `examples`, clicking one asks the brain), and a compact replay pill. Everything else (lenses, wheel or galaxy view toggle, filters, legend) lives in the slide-out drawer behind the menu button. Profiles in brand.json are lenses: each has its own theme (light or dark, accent, bg), a group allowlist, and a `hidePaths` presenter-safe flag that strips file paths from the panel so the map is safe to project to clients. Give every user at least an "Everything" profile and a presenter-safe "My Business" profile; add a dark "Personal" one when they keep personal memories.
3. **Genesis replay.** Every node carries a born date. A play button replays months of growth in 15 seconds with month captions.
4. **Ask the Brain.** Enter in the search box sends the question plus a manifest of every node to the claude CLI; the answer lands in the side panel with citation chips and the camera flies the citation trail.
5. **The voice.** The mic button in the search bar listens (Chrome Web Speech, language from brand.json `voiceLang`), transcribes into the box, and asks on release; answers are spoken aloud (best system voice, for example Karen for en-AU) while the center node pulses. Click the mic to interrupt. The "Spoken replies" toggle lives in the drawer. Optional premium voice: put an ElevenLabs key in `ELEVENLABS_API_KEY` (or an `elevenlabs.key` file next to the site) and serve_brain.py streams TTS via /speak; the page auto-detects it from /health.
6. **Live growth.** A watcher pushes new memory files over SSE; nodes are born on screen with a golden ripple and a toast while the map is open.

Bundled files (this skill's directory): `template.html` (viewer), `build_map.py` (assembler), `serve_brain.py` (server), `brand.json` (default theme plus hub taxonomy).

## Inputs

- **The owner's first name.** Asked for, or inferred from context. Names the map; a placeholder name is forbidden, use the real one.
- **Brand context (optional but powerful).** The `crew-core-brand-context` file, when it exists, renames the hubs to the owner's world and seeds the cold-start gate.
- **The work folder.** Which folder holds their projects (default `~/Desktop` plus the current working directory).
- **A port** (default 4880) and, optionally, an ElevenLabs key for premium voice. Neither blocks the build.

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, do NOT hard-stop for this skill: the brain map can be built for someone who is not yet onboarded (the map itself shows them why onboarding matters); note "No brand context yet" and continue, offering `crew-core-brand-context` at hand-over. Next, read this skill's lessons file at `~/.claude/crew-state/lessons/crew-my-second-brain-lessons.md` if it exists, and apply every lesson in it as a standing rule for this run. Then settle the project (Loop 4): if the request is a pure question with nothing to build, skip the project question; settle a project only when real work starts. If `~/.claude/crew-state/active-project` is already set, confirm it in one line ("Continuing in project <name>") instead of asking; ask the question only when no active project exists and the request does not name one. For a NEW project, take a short name from the request or ask for one, create `~/.claude/crew-state/projects/<project>/`, write the name to `~/.claude/crew-state/active-project`, and start from zero. For CONTINUING, read the `~/.claude/crew-state/active-project` pointer, then ONLY this skill's own record at `~/.claude/crew-state/projects/<project>/crew-my-second-brain-handoff.md`; state what was recovered and its date, and if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. Records in other projects, and legacy handoffs from before the Projects model, are never read automatically. (Loop 4, Context Change.)

1. **Workspace.** Create the output folder `~/Desktop/my-second-brain/` (or reuse if present). Copy the four bundled files into it. Everything below happens in that folder.

2. **Personalise brand.json.** Ask for (or infer from context) the owner's first name. Set `owner` and `title`; an invented placeholder name is FORBIDDEN, use the real name. Look for a Crew brand context file (`crew-core-brand-context` output): Glob for `**/brand-context.md` under `~` two levels deep, `~/.claude/`, and the current project. If found, read it and rename hubs to their world: their business name on `hub-brand`, their actual client type on `hub-clients`. Keep the default hub taxonomy unless their work obviously needs different hubs. Hubs are data, never hardcode.

3. **Scan (parallel agents).** Launch parallel scanner agents (Explore or general-purpose). Each returns node arrays against the LOCKED schema below. Sources: (1) **Memory**: every `*.md` in every `~/.claude/projects/*/memory/` dir (skip `MEMORY.md`); id = filename stem, kind = "memory"; extract frontmatter description, any live URL in the body, and links = every `[[wiki-link]]` plus every folder or skill name mentioned. (2) **Global skills**: every folder in `~/.claude/skills/`; kind = "skill"; description from SKILL.md frontmatter, first sentence, max 140 chars. (3) **Project skills**: every folder in `<project>/.claude/skills/` for the current project; id prefixed `proj-`. (4) **Packs**: if a Crew skill-pack repo exists (folders like `packs/01-core`), one node per pack, id = `pack-<folder>`, kind = "pack"; skills whose group matches a pack tail (group "sales" and pack-02-sales) auto-wire to the pack. (5) **Projects**: top-level folders of the user's main work directory (ask which folder holds their work; default `~/Desktop` plus cwd); kind = "project"; peek at README or index.html title only, never read whole files; include a live URL when a `.vercel/project.json` or README names one. Each scanner assigns `group` from the brand.json hub taxonomy (the `group` values). Unknown groups fall through to "other" at build time, so never invent hubs.

   **Locked nodes.json schema** (build_map.py depends on it; do not deviate):

   ```json
   {
     "memory":   [ { "id", "label", "kind", "description", "path", "url", "group", "links": [] } ],
     "gskills":  [ "... same node shape ..." ],
     "pskills":  [ "..." ],
     "packs":    [ "..." ],
     "projects": [ "..." ],
     "extra":    [ "... optional: plugin-synced or hand-added nodes ..." ]
   }
   ```

   All fields are strings except `links` (array of strings). `id` must be unique kebab or snake case. Write the merged result to `nodes.json` in the workspace.

4. **Cold-start gate (critical for a fresh install).** Count total nodes. If under 25 (a day-one user), seed the brain so nobody sees an embarrassing empty map: from the brand context file, one memory-kind node per fact (business name, what they sell, who buys, tone, goals), group "brand", path pointing at the brand context file, 5 to 10 nodes; one skill node per Crew pack or skill installed that day (they exist, scan again with fresh eyes if step 3 found none); one project node for today's session ("Crew Workshop, <today's date>", group "crew"). Add these to the `extra` array. Target: at least 30 nodes before building.

5. **Build.** Run `cd ~/Desktop/my-second-brain && python3 build_map.py`. It emits `index.html`, `scan_config.json` (memory dirs for the watcher), and `manifest.txt` (for /ask). Check the printed counts: nodes, edges, resolved memory links.

6. **Serve.** macOS TCC blocks preview servers reading `~/Desktop`, so serve from a /tmp copy: `rm -rf /tmp/my-second-brain && cp -r ~/Desktop/my-second-brain /tmp/my-second-brain`, then `python3 /tmp/my-second-brain/serve_brain.py 4880 /tmp/my-second-brain`. Run it in the background (or via a launch.json entry named `my-second-brain`). `serve_brain.py` is the full experience (static plus /ask plus /events). A plain `http.server` also works but Ask-the-Brain and live growth silently disable themselves (the page feature-detects `/health`).

7. **Verify, then hand over.** Load the page fresh and confirm the Awakening plays (screenshot mid-stream if you can). Confirm zero console errors. Confirm the replay bar appears (born dates present) and `/health` returns ok. Test /ask once with a question about something actually in their brain. Hand the user the URL, `http://localhost:4880`, and tell them the three party tricks: press Enter in the search box to ask their brain a question, hit the replay button to watch it grow, and say "remember that ..." to Claude in another terminal to watch a node get born live.

**Final Step: Handoff Save.** Write into the project bound at Step 0 (the one this run recovered or created); never let a re-read of `~/.claude/crew-state/active-project` choose the destination. Re-read the pointer only to compare: if it now differs from the Step 0 binding, another session may have moved it; warn in the receipt and still write to the Step 0 binding. If no project was named this run, ask for a name only if something worth keeping was produced; otherwise skip the write and say so. Run `mkdir -p ~/.claude/crew-state/projects/<project>`, then write `~/.claude/crew-state/projects/<project>/crew-my-second-brain-handoff.md` with: the map produced (node and edge counts, the workspace path, the serving URL and port), decisions made (owner name, hub renames, profiles configured, voice on or off), unfinished work (a thin brain below target, a port conflict, an ElevenLabs key pending), what the next session needs (rebuild after new memories, or re-serve), and any "Learned" note (a correction or preference the user gave). When a project is active, always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the required content as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing record in the same project, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. If the handoff write is denied or fails, retry once; if it still fails, do not fake success: print the full handoff body inline in the run receipt under the literal heading "STAGED HANDOFF (write denied)" so the user can save it, and mark STATUS: BLOCKED. After a successful write, re-read the file and confirm the frame is present (the title line, the Date line, and a STATUS from the sanctioned list); fix it before finishing if not. If this run captured a durable way-of-working lesson (not a project or brand fact), offer once: "Want me to save this lesson so it never happens again?" On yes, append one dated bullet (what went wrong, what to do instead) to `~/.claude/crew-state/lessons/crew-my-second-brain-lessons.md`, creating the file if absent; it is read at every Step 0 and never leaves this machine (Loop 5, the lesson offer). A Loop 1 pause counts as finishing for the Context Loop: write the handoff FIRST (STATUS: BLOCKED, the gap named), then ask and wait. (Loop 4 and Loop 5.)

## Troubleshooting

- **Ask returns "claude CLI not found"**: `which claude` must resolve for the server process.
- **Ask is slow**: normal, the CLI call takes 10 to 30 seconds. The "your brain is thinking" state covers it.
- **No live births**: the watcher only tracks the memory dirs listed in `scan_config.json`; new memories must land there as `.md` files. Rebuild if the user's memory dir was created after the scan.
- **Blank page on macOS**: you served from Desktop. Copy to /tmp and serve from there.
- **Port busy**: pick another port; pass it as argv 1.
- **Skip the intro**: append `?nointro` (also honours prefers-reduced-motion).

## Output format

```
SECOND BRAIN MAP
Owner: [first name]   Workspace: [path]   Serving: [url] (port [n])

Nodes: [n] ([memory] memories, [skills] skills, [packs] packs, [projects] projects, [extra] seeded)
Edges: [n]   Resolved memory links: [n]
Profiles: [list, with the presenter-safe one named]
Features: Awakening [on/off] / Replay [on, N months] / Ask [on/off] / Voice [system or premium] / Live growth [on/off]
Verified: [awakening played / console clean / health ok / ask answered with citations]
Party tricks handed over: [ask, replay, live birth]
```

Example (filled):

```
SECOND BRAIN MAP
Owner: Priya   Workspace: ~/Desktop/my-second-brain   Serving: http://localhost:4880 (port 4880)

Nodes: 87 (41 memories, 22 skills, 9 packs, 12 projects, 3 seeded)
Edges: 214   Resolved memory links: 63
Profiles: Everything, My Business (presenter-safe, paths hidden)
Features: Awakening on / Replay on, 6 months / Ask on / Voice system (en-AU) / Live growth on
Verified: awakening played, console clean, health ok, ask answered "what do my agents know about invoicing" with 4 citations
Party tricks handed over: ask, replay, live birth
```

## Guardrails

- Never use em dashes anywhere. Use commas, periods, or parentheses.
- Never ship a map with under 25 nodes. Work the cold-start gate.
- Never hardcode hub taxonomy, colors, or the owner's name in template or build files; brand.json is the only place identity lives.
- The nodes.json schema is locked. Extend via `extra`, never by new top-level keys.
- Privacy is the product: the map contains the owner's real memory titles and paths. Serve on localhost only, never expose the port beyond the machine, and use the presenter-safe profile (paths hidden) whenever the map is projected to anyone else. Data leaves the machine in exactly one case: /ask sends the question plus the node manifest to the local claude CLI, and optional premium voice sends answer text to ElevenLabs when the user supplies their own key.
- Never invent nodes about the owner's business beyond the sanctioned cold-start seeds, which come only from their real brand context and their real installed skills.
- Always finish by giving the user the running localhost URL.

## Handoffs

Upstream: `crew-core-brand-context` (renames the hubs to the owner's world and feeds the cold-start seeds; the map is also the best advertisement for onboarding when it is missing). The scan reads the whole Crew estate read-only: memories, installed skills, packs, projects. Downstream: nothing consumes the map; it is a living deliverable the owner keeps running. Pairs with `crew-core-context-save` to close a session.

## Completion

STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT
REASON: [why this status, specific: thin brain seeded, port fallback, voice pending, or clean]
RECOMMENDATION: [what should happen next]

A map served below 25 nodes is never DONE (the cold-start gate failed; fix it). A map serving without /ask or live growth (plain http.server fallback) is DONE_WITH_GAPS with the disabled features named. If no owner name and no scannable estate existed, no map is built: the record is written STATUS: BLOCKED and the chat status is NEEDS_CONTEXT or BLOCKED, never DONE.
