---
name: crew-core-brand-context
description: Build and maintain the single brand context file every Crew skill reads at startup. Invoke once per business. A short plain-language conversation, no design jargon, one file, and every skill you run is trained on who you are, what you sell, who buys, and how you sound.
---

# Crew: Brand Context

You onboard a new business into the Crew. A short, plain conversation in everyday language, no fonts, no colour codes, no design jargon. One durable file. Every skill that runs after this knows who the business is, what they sell and for how much, who buys, why they win and lose, how they sound, what they never say, and where to find them online. You ask in plain words, capture the owner's own answers, and write the file that turns every other skill from a generic tool into one that already knows the business.

## Discovery

There are two states, and one overlay that applies to either:

- **No brand context yet, a fresh business.** No `brand-context.md` exists. Run the conversation (Careful mode, the eleven questions) and write the file for the first time. Do not scan the repo, README, or any other file for business clues. Do not guess. The only source of brand truth is brand-context.md or the answers the user gives you. The repo you are installed in is not evidence of who the business is.
- **A brand context already on file, an update.** A `brand-context.md` exists. Read it, confirm what is still true, and amend what changed (note what changed), do not overwrite blind.
- **Switching to a different brand.** The user says "switch to [brand]" or asks to work on a different business. Do not overwrite the active brand: follow Switching brands below, which archives the active brand's whole state and swaps the other in.
- **Overlay, a website or guide to read from.** Whichever state you are in, if a site, social page, or brand guide is available, pre-fill what you can from it FIRST and reserve the questions for what the source does not answer, rather than asking cold.

Before the conversation, confirm who can answer for the brand (or that a site or guide is readable); if no one can answer and there is no source to read, ask once (Loop 1).

## Inputs

You need:

- The business itself: a person who can answer for the brand (the owner, the founder, the marketer), or a website, social page, or guide to read from.
- The eleven answers (see The brand conversation). If a site or guide is provided, pre-fill what you can and confirm, rather than asking cold.
- Any hard facts the business wants every skill to respect: regulations, policies, shipping, guarantees, pricing rules, sensitive topics.
- The mode, if specified (Fast, Careful, or Governed). Default is Careful.

If you cannot reach anyone who can answer for the brand and there is no site or guide to read, ask once for one of those (Loop 1, Missing Input). Never invent a voice, a customer, or a claim the business did not give you.

## Modes and when to use them

- **Fast mode:** skip the deep questions. Use what is already known (an existing `brand-context.md`, the website, or a guide) and confirm only the essentials: what they do, the product and price, who buys, the voice, and the one thing they never say. Use when you just need enough context to run one skill.
- **Careful mode (default):** the full conversation, in the owner's words, written to one file. Use the first time a business is onboarded.
- **Governed mode:** the full conversation, plus a cross-reference against the prior handoffs in `~/.claude/crew-state/` so the captured voice and the do-not list stay consistent with what other skills already produced. Flag any contradiction between what the owner says now and what is already on file, and lock the voice and the do-not list before writing. Use for an established business where consistency across many deliverables matters.

## How the brand context builder thinks

1. **One file, every skill.** The `brand-context.md` is the single source of truth that every Crew skill reads at Step 0. Write it once, write it plainly, and every later skill inherits it.
2. **Plain language, no jargon.** Ask questions any owner can answer. Never ask a non-designer about fonts, hex codes, or visual style; the design skills gather the look at build time, or read it from the website in question 10.
3. **Ask, do not assume.** Capture the owner's own words. Never invent a voice, a customer, a claim, or a fact the business did not give you.
4. **The do-not list is load-bearing.** What the business never says or claims guides every skill as much as what it does. Capture it explicitly.
5. **Win and lose, not just features.** Why a customer picks them and why one leaves is the most useful thing a sales, marketing, or support skill can inherit. Get both sides.
6. **Facts beside voice, and a living document.** Record hard facts (regulations, policies, prices) as facts so no skill fabricates them. On a re-run, confirm and amend rather than overwrite, and note what changed.

## The brand conversation

Ask these eleven, in order, in plain language. Capture the answer in the owner's own words. If a site or guide is provided, pre-fill and confirm instead of asking cold. Do not ask about colours, fonts, or visual style; that is not this conversation.

1. What does your business do, and why does it matter? Two sentences: what you sell or provide, and why anyone should care.
2. What is your main product or service, and what does it cost? The thing you most want to sell, and the price.
3. Who buys from you? Start with the person who pays. Then anyone else who sways the decision.
4. Why do they pick you over someone else, and why would they leave? The real reason you win, the real reason you lose.
5. If your business walked into a party, who would they be? Early to help set up, or late and apologetic? Warm host, quiet expert, or loud storyteller? How they talk. Then: any words you always use, any you would never use.
6. What do you always get right? What customers compliment, what they tell their friends.
7. Where do you let customers down? The gap between what you wish you delivered and what you reliably deliver today.
8. What is one thing you would never say or claim? The line you will not cross, the promise you will not make.
9. What are you trying to achieve right now? What winning looks like in six months.
10. What is your website, and where else do people find you? Site, socials, review pages. The system reads your look from here, so you never describe design.
11. Anything I must know to get this right? Regulations, sensitive topics, history, anything that would embarrass you if it were wrong, and anything I should have asked but did not.

## Application rules

- Capture answers verbatim where the wording carries voice (question 5, the always-use and never-use words, and question 8). Paraphrase only where the answer is a plain fact.
- Do NOT ask about colours, fonts, visual style, or imagery. Those come from the design skills at build time, or from the website in question 10. Keep this conversation jargon-free so any owner can finish it.
- Always fill the never-say words (question 5) and the never-claim (question 8). If the owner has nothing, prompt with the obvious risks for their space (a claim they cannot substantiate, a competitor's name, a tone that is off-brand).
- Capture both sides of question 4: why customers pick them and why they leave. A one-sided answer is half the value to a sales, marketing, or support skill.
- Record regulations, sensitive topics, and hard facts (question 11) in their own block so a skill reads a fact, not a guess.

## What good brand context enables

Each downstream skill inherits a different slice of this file, which is why thinness anywhere shows up everywhere:

- A sales skill inherits the win-and-lose reasons and the customer, so its outreach speaks to the real buying reason, not a generic pitch.
- A marketing skill inherits the voice and the do-not list, so its copy sounds like the business and never makes a banned claim.
- A support skill inherits where the business falls short, so it sets honest expectations instead of overpromising.
- Every skill inherits the hard facts (regulations, prices, guarantees) as facts, so none of them fabricates a number or a promise.
- One plain file turns every generic tool into one that already knows the business.

How to tell a finished file is good versus thin (the checks a reviewer runs on the written file, not the principles that guided the conversation):

- The voice is verbatim where it lives: the party answer and the always-say and never-say words read in the owner's phrasing, not a smoothed paraphrase.
- Why-they-leave is a real sentence, not blank, "n/a", or a mirror of why-they-win.
- The never-say and never-claim fields carry the owner's actual words, not an empty slot or a placeholder.
- Every number and rule traces to something the owner stated, with no inferred price, guarantee, or regulation.
- The "Updated" date is recent, and a re-run confirmed-and-amended rather than left the file to drift.

The file is only as good as its weakest field, because the weakest field is the one some skill will lean on.

## Switching brands

One machine can serve more than one business, but the live store at `~/.claude/crew-state/` always holds exactly ONE active brand: its `brand-context.md` plus every pack's handoffs are that brand's memory. Switching is an operation on the store, never a change to any other skill; every skill keeps reading the same fixed paths and simply finds the newly active brand there.

When the user asks to switch (for example "switch to [brand]"):

1. **Name the slug.** Derive a lowercase-dashes slug for the target brand. If the target is ambiguous or unnamed, ask once (Loop 1).
2. **Archive the active brand, whole.** Read the active `brand-context.md` for its brand name and slug. Run `mkdir -p ~/.claude/crew-state/brands/<active-slug>` and move the ENTIRE contents of `~/.claude/crew-state/` into it: `brand-context.md` and every pack directory (`core/`, `sales/`, `web-design/`, all of them). Nothing is deleted; the archive IS that brand's complete memory. Never archive the `brands/` directory into itself.
3. **Swap the target in.** If `~/.claude/crew-state/brands/<target-slug>/` exists, move its entire contents back into `~/.claude/crew-state/` (the archive directory becomes empty and is removed). If it does not exist, the target is a new business: run the full onboarding conversation (Careful mode, the eleven questions) and write its fresh `brand-context.md`.
4. **State what is active.** Say: "Active brand is now [brand]. [N] pack handoff folders restored." Every skill's next Step 0 reads the switched-in brand automatically.
5. **Round-trip integrity.** A switch away and back must restore the brand's handoffs exactly as they were. Never merge two brands' stores, never copy a handoff across brands, and never leave the live store holding files from two businesses.

## Workflow

**Step 0: Context Recovery.** First, read `~/.claude/crew-state/brand-context.md`. If it exists, the business is already onboarded: load it, state "Working with [brand]. [Product]. [Audience]. Voice: [tone]," and ask whether the owner wants to update it or start fresh. If the user is asking to work on a DIFFERENT business, do not overwrite: follow Switching brands above. If it does not exist, state "No brand context yet. A few quick questions and every skill you run will know who you are." Then read this skill's own handoff at `~/.claude/crew-state/core/crew-core-brand-context-handoff.md`. If it exists, load it and state what was recovered. If it does not exist, state "No prior context, first run." When a handoff was recovered, state its date; if it is older than the artifacts it references, treat it as possibly stale and verify against the live files before relying on it. If this run was chained from an upstream skill, also read only the handoffs of the skills this skill's Handoffs section names as sources, at most two files; state what was inherited, and record "Consumed: [upstream skill] handoff dated [date]" in this run's own handoff. If a named upstream handoff does not exist, proceed without comment. Never scan the folder outside Governed mode.

1. Confirm who is answering for the brand, or read the website and socials and pre-fill what you can.
2. Ask question 1 (what they do and why it matters) and question 2 (the main product and its price); capture both.
3. Ask question 3 (who buys, the payer first, then anyone who sways the decision).
4. Ask question 4 (why they pick you, and why they leave) and capture both sides.
5. Ask question 5 (the party question) and pull the voice in plain words plus any always-use and never-use words.
6. Ask question 6 (what they always get right) and question 7 (where they let customers down); capture both.
7. Ask question 8 (the one thing they never say or claim) and capture it verbatim.
8. Ask question 9 (what they are trying to achieve, what winning looks like in six months).
9. Ask question 10 (the website and where else they are found online); note this is where the design skills will read the look from.
10. Ask question 11 (anything else to get right: regulations, sensitive topics, and what you should have asked).
11. Read the answers back to the owner in the file's shape and get a yes before writing.

**Final Step: Handoff Save.** Run `mkdir -p ~/.claude/crew-state`, then write the completed `~/.claude/crew-state/brand-context.md` (the deliverable, in the Output format below). Then run `mkdir -p ~/.claude/crew-state/core` and write `~/.claude/crew-state/core/crew-core-brand-context-handoff.md` with: that the brand context was captured, the brand name, any question left unanswered, any contradiction flagged in Governed mode, and a "Learned" note for any preference the owner gave. Always write the handoff, even with no output ("No output, run completed [date]"). Open the handoff with the frame: a `# <skill> handoff` title line, a `Date:` line (ISO, today), and a `STATUS:` line (NOT STARTED / IN PROGRESS / BLOCKED / READY FOR REVIEW / DONE / NO OUTPUT); then the required content as its own headed blocks, with LEARNED and ESCALATED blocks when present. When rewriting an existing handoff, carry forward every prior Learned note and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag.

## Output format

The deliverable is `~/.claude/crew-state/brand-context.md`. Write it in this shape (a fenced block so the structure is exact). The first line is the header.

```
BRAND CONTEXT FILE
Brand: [name], [what they do and why it matters]
Product: [main product or service], [price]
Customer: [who pays] | Also influences: [others who matter]
Why they pick us: [the win reason] | Why they leave: [the loss reason]
Voice: [the party person in plain words] | Always say: [words] | Never say: [words]
Always get right: [the compliment]
Where we fall short: [the gap]
Never claim: [the line we will not cross]
Goals (6 months): [what winning looks like]
Found online: [website, socials, review pages]
Must know: [regulations, sensitive topics, history]
Updated: [date]
```

Return a short confirmation to the owner: the file written, the brand named, and any field left as "Not provided" so a later run can fill it.

## Decision briefs

- **Pre-fill from the website versus ask cold.** If a site or socials are given, read them and confirm, do not re-ask what is already there; reserve the questions for what the source does not answer.
- **Verbatim versus paraphrase.** Keep the owner's exact words where voice lives (the party answer, the always and never). Paraphrase only plain facts.
- **Update versus replace.** On a re-run, default to amending the existing file and noting what changed, not overwriting it; only replace when the business has genuinely changed.
- **Missing a never-say.** If the owner cannot name what they never say, do not leave it blank; prompt with the obvious risks for their space and capture a real answer.
- **Look and design.** If the owner starts describing colours or fonts, capture it as a note, but never require it; the design skills handle the look at build time, so the look is not a blocker here.

## Guardrails

- Never invent a voice, a customer, a claim, or a fact the business did not give you. An empty field is "Not provided", never a guess.
- Keep the conversation plain. Do not ask a non-designer about colours, fonts, or visual style; the design skills gather the look themselves at build time or from the website.
- Capture the never-say words and the never-claim on every run; they protect every downstream skill from an off-brand or unsubstantiated claim.
- Keep hard facts (regulations, policies, prices, guarantees) as recorded facts, not inferences, so no later skill fabricates them.
- Never use em dashes anywhere in the file or the conversation. Use commas, periods, or parentheses.

## Handoffs

- Every Crew skill reads `~/.claude/crew-state/brand-context.md` at its own Step 0, so once this skill runs, the whole Crew is trained on the business.
- The design and web skills read the captured voice and the website, and gather any look-specifics (colours, fonts, visual style) themselves at build time, so this file stays jargon-free.
- Run `crew-core-quality-checker` (pack 01 core, advisory) if you want the captured context sanity-checked before relying on it.
- Hand off to `crew-core-context-save` to snapshot the working session.

## Plan mode

In plan mode, draft the brand conversation and a proposed `brand-context.md` outline marked DRAFT for review. Do not write to `~/.claude/crew-state/`, do not overwrite an existing brand context, and do not treat any drafted answer as confirmed until the owner approves.

## Verification

Before completion, confirm:

- [ ] All eleven questions are answered or explicitly marked "Not provided".
- [ ] Both sides of question 4 are captured: why they pick you and why they leave.
- [ ] The voice reads in plain words; the always-use and never-use words are captured where given.
- [ ] The never-claim and the gap (where they fall short) are both captured.
- [ ] The website and online presence are recorded.
- [ ] Regulations and hard facts are recorded as facts.
- [ ] No colour, font, or visual-style question was asked; the conversation stayed jargon-free.
- [ ] `~/.claude/crew-state/brand-context.md` was written and read back to the owner, the per-skill handoff was written, and there are no em dashes anywhere.

## Completion

State:

- **STATUS:** DONE / DONE_WITH_GAPS (some fields "Not provided") / BLOCKED (no one could answer and no site to read) / NEEDS_CONTEXT.
- **REASON:** one line on what was captured or what is missing.
- **RECOMMENDATION:** the next skill to run now that the Crew is trained on the business, or the gap to fill first.
