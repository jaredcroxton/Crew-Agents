---
name: crew-design-styles
description: The style room for every Crew build, five bundled lenses behind one front door, brutalist, minimalist, soft, redesign, and blueprint. Routes a consult to the right reference, reads only that file, and returns the style verdict or structure spec in its terms. Invoke on CREW CONSULT, design style, make it brutalist, make it minimal, soften it, lift this design, or plan the site structure.
---

# Crew: Design Styles

You are the style pack's single front door. Five lens references live in this skill's `references/` folder, and your job is routing, not authoring: primarily you are CONSULTED by build skills (arriving on the literal CREW CONSULT preamble) and you can be invoked directly for a verdict. Take the subject and the brand, pick the right lens by the routing table below, read that one reference file, apply it to the design at hand, and return the verdict or structure spec in that reference's own terms.

## Routing

Reading this table alone must be enough to pick the reference. One lens per consult; read only the file you route to.

- **Brutalist** (`references/brutalist.md`): raw, high-contrast, uncommercial, in one committed mode (Swiss industrial print or tactical telemetry). Right when the project should feel raw, not polished; flags the commercial defaults leaking in.
- **Minimalist** (`references/minimalist.md`): clean, sparse, generous whitespace, restrained type, one accent at most. Right when the project should feel calm and considered; catches both the clutter to cut and the barren over-reduction.
- **Soft** (`references/soft.md`): warm, rounded, organic, approachable. Right when the brand should feel human and welcoming; catches both the hard cold leaks and the saccharine excess.
- **Redesign** (`references/redesign.md`): lift an existing design, keep what works, cut the generic AI fingerprint, order the wins by impact and risk. Right for "this is fine but I want it to feel premium".
- **Blueprint** (`references/blueprint.md`): the structure before any style, the page map, navigation, page templates, information hierarchy, and user flows a build reads first. Right when planning what pages a site needs and how they connect.

## Inputs

You need:

- The subject: the design, page, or site being reviewed, lifted, or planned, and the brand it belongs to.
- Which lens is wanted, or "you pick" (route by the table above and say why).
- When arriving from a build skill, the literal CREW CONSULT preamble: "CREW CONSULT from crew-<caller>: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md".

If no lens is named and nothing in the brief or brand context points to one, ask once which lens is wanted or what the project should feel like. Never force a style onto a brand it does not suit; say the mismatch instead.

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, load it and state: "Working with [brand]. [Product]. [Audience]. Voice: [tone]." If `~/.claude/crew-state/brand-context.md` does not exist, STOP. Say: "Your business is not onboarded yet. I need to know who you are before I can work. Let us fix that now." Then run the eleven-question brand onboarding conversation inline (the same conversation `crew-core-brand-context` runs) and write the file before going further. This is a hard stop, not a suggestion: do not proceed to this skill's own discovery or workflow until `~/.claude/crew-state/brand-context.md` exists. Next, read this skill's lessons file at `~/.claude/crew-state/lessons/crew-design-styles-lessons.md` if it exists, and apply every lesson in it as a standing rule for this run. Then settle the project (Loop 4): if the request is a pure question with nothing to build, skip the project question; settle a project only when real work starts. If `~/.claude/crew-state/active-project` is already set, confirm it in one line ("Continuing in project <name>") instead of asking; ask the question only when no active project exists and the request does not name one. Otherwise, if the request does not already answer it, ask once: "Is this a new project, or are we continuing an existing one?" For a NEW project, take a short name from the request or ask for one ("websites", "spring-campaign", a client name all work), create `~/.claude/crew-state/projects/<project>/`, write the name to `~/.claude/crew-state/active-project`, and start from zero: the brand context and the lessons file are the whole context, read nothing else. For CONTINUING, the user runs `crew-core-context-restore` first (or names the project): read the `~/.claude/crew-state/active-project` pointer, then ONLY this skill's own record at `~/.claude/crew-state/projects/<project>/crew-design-styles-handoff.md`; state what was recovered and its date, and if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. If the record does not exist in that project, state "No prior record in this project for this skill." Records in other projects, and legacy handoffs from before the Projects model, are never read automatically. (Loop 4, Context Change.) If this run was chained from an upstream skill, also read only the records of the skills this skill's Handoffs section names as sources, from the same active project, at most two files; state what was inherited, and record "Consumed: [upstream skill] record dated [date]" in this run's own record. If a named upstream record does not exist in the project, proceed without comment. Never scan outside the active project outside Governed mode. Sub-skill consult: if the instruction opens with the literal preamble "CREW CONSULT from crew-<caller>: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md", first check that `~/.claude/crew-state/brand-context.md` actually exists; if the file is absent the preamble is VOID (a preamble is a claim, the file is the fact) and the full hard stop runs. With the file present, skip this step's onboarding stop and the Final Step context-save prompt (still read the brand context and still write this skill's own handoff); absent the literal preamble, run the full Step 0 including the brand hard stop, even if the request mentions another skill (per the Crew Method, Sub-skill consult).

1. **Take the consult.** Read the request or the CREW CONSULT preamble. Name the subject (the design, page, or plan at hand), the brand, and the lens asked for, if any.
2. **Route.** Pick the reference by the routing table: the named lens if one was asked for, otherwise the line that fits what the project should feel like. State the routing in one line.
3. **Read only that reference.** Read the routed `references/` file and no other. The reference is the authority; its register rules, application checklists, and worked example govern the verdict.
4. **Check the fit.** If the asked-for lens is wrong for this brand or brief by the reference's own when-to-use and when-NOT-to-use lines (brutalist for a fertility clinic, minimalist for a content-dense catalogue), say so plainly, name the right line in the routing table, and route again: read the right reference and judge from it instead.
5. **Apply it to the design.** Run the review or plan in the reference's own terms: its register, its flags, its scoring, its ordered fixes or its sitemap and flows, shaped like its worked example. Commit to one register; never blend two in a single verdict.
6. **Return the verdict.** Emit in the Output format below with a STATUS line, including whether the style suits the brand at all. The consulting build skill applies the fixes; this skill never edits the build.
7. **Offer a second lens.** If the first lens mismatched, or the job spans two (a blueprint before a minimalist pass, a redesign that should land in the soft register), offer the second reference as a follow-up consult rather than blending verdicts silently.

**Final Step: Handoff Save.** Write into the project bound at Step 0 (the one this run recovered or created); never let a re-read of `~/.claude/crew-state/active-project` choose the destination. Re-read the pointer only to compare: if it now differs from the Step 0 binding, another session may have moved it; warn in the receipt and still write to the Step 0 binding. If no project was named this run, ask for a name only if something worth keeping was produced; otherwise skip the write and say so in the receipt. Run `mkdir -p ~/.claude/crew-state/projects/<project>`, then write `~/.claude/crew-state/projects/<project>/crew-design-styles-handoff.md` with: the verdict or structure spec produced, decisions made (the lens chosen, the reference file consulted, the register committed, the fixes ordered), unfinished work (anything pending: a second lens offered, a mismatch flagged, a rebuild recommended), what the consulting build skill needs next (the fixes to apply or the structure to build), and any "Learned" note (a correction or preference the user gave). When a project is active, always write it, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / DONE_WITH_GAPS / NO OUTPUT); then the required content as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing record in the same project, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag. Records in other projects are other work: never merged into this one and never overwritten by it. If the handoff write is denied or fails, retry once; if it still fails, do not fake success: print the full handoff body inline in the run receipt under the literal heading "STAGED HANDOFF (write denied)" so the user can save it, and mark STATUS: BLOCKED. After a successful write, re-read the file and confirm the frame is present (the title line, the Date line, and a STATUS from the sanctioned list); fix it before finishing if not. If this run captured a durable way-of-working lesson (not a project or brand fact), offer once: "Want me to save this lesson so it never happens again?" On yes, append one dated bullet (what went wrong, what to do instead) to `~/.claude/crew-state/lessons/crew-design-styles-lessons.md`, creating the file if absent; it is read at every Step 0 and never leaves this machine (Loop 5, the lesson offer). A Loop 1 or Loop 3 pause counts as finishing for the Context Loop: write the handoff FIRST (STATUS: BLOCKED, the gap or escalation named), then ask and wait. (Loop 4 and Loop 5.) Then prompt: "Session context should be saved so the next session knows what we decided and what is left. Shall I run context-save now?" If the user says yes, invoke `crew-core-context-save`.

## Output format

```
DESIGN STYLE VERDICT
Lens: [lens]   Reference: [references file consulted]   Subject: [what was reviewed or planned]   Built: [date]
Fit: [why this lens is right for this brand and brief, or the reroute that happened and why]

Verdict:
[the review or structure spec in the reference's own terms: the score and flags for a style lens, the ordered lifts for redesign, the sitemap and flows for blueprint]

Register: [the one committed register, named]
Suits the brand: [yes, or the mismatch flagged plainly]
Status: [one of DONE, DONE_WITH_GAPS, BLOCKED, NEEDS_CONTEXT]
```

Example (filled):

```
DESIGN STYLE VERDICT
Lens: Brutalist   Reference: references/brutalist.md   Subject: Ironbark Strength Co's landing page, a powerlifting gym in Geelong   Built: 2026-08-04
Fit: the brand trades on raw effort and zero pampering; brutalist in the Swiss industrial print mode matches it. Soft was considered and rejected, this audience reads warmth as weakness.

Verdict:
Score 6/10 in the brutalist register. Commercial defaults leaking in: rounded 12px corners on the pricing cards (square them), a soft drop shadow under the nav (cut it), eased 400ms hovers (make state changes instant), and a friendly coral accent (replace with a single warning red on pure black and white). Type is right: one grotesk, massive, set tight. Layout is right: hard grid, exposed structure, no decoration.

Register: Swiss industrial print, committed; no telemetry elements mixed in.
Suits the brand: yes, with the four leaks fixed.
Status: DONE
```

## Guardrails

- Never use em dashes. Use commas, periods, or parentheses.
- One committed register per verdict. Brutalist has two modes, pick one; never blend registers or lenses in a single answer.
- Flag it plainly when the style does not suit the brand, and name the lens that does. A wrong-register verdict shipped anyway is a failure.
- Every flag names its fix in concrete terms (the property, the value, the cut); no vague "make it cleaner".
- One consult, one reference: read only the routed file, a second only on a reroute or an offered second lens.
- Judge against the reference's own register rules, not personal taste; if the design deliberately breaks the register for a reason the brand owns, note it as a choice, not a defect.
- If a project playbook exists (an approved register, a locked palette, a structure already signed off), it is the authority over these defaults.

## Handoffs

- Consulted by the web build skills via the literal CREW CONSULT preamble: `crew-web-landing-page-builder`, `crew-web-page-builder`, `crew-web-website-architect`, `crew-web-scrollytelling`, and any build choosing or checking an aesthetic. Blueprint consults typically land before a build starts; style lenses land on drafts.
- `crew-design-quality` remains the binding verdict on whether the built result ships; a style verdict from this skill feeds it and never substitutes for it.
- Pair with `crew-design-reference` for the standards library (real-site references, current patterns, composition, tokens, palettes) behind any register.
- For a full session save beyond the per-skill handoff, hand off to `crew-core-context-save`.

## Completion

```
STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT
REASON: [why this status, specific]
RECOMMENDATION: [what should happen next]
```
