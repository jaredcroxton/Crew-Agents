# Fixture: crew-docs-client-playbook-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Service is the "Brand Refresh" package, a fixed-fee 6-week sprint, written as a client onboarding playbook. Audience is new clients who just signed, plain reading level. Delivery steps confirmed: Week 1 kickoff call (45 min) plus a written brief in 2 business days; Weeks 2 to 3 present three concepts, client picks one; Weeks 4 to 5 one revision round; Week 6 final files plus a brand guide and a 20-minute walkthrough. Client must send brand assets and 3 reference brands by day 3, and give consolidated feedback within 3 business days per round. Deliverables: logo in 3 formats, colour and type system, one-page brand guide PDF. Explicitly out of scope: website build, social media management, and printing or production costs. Communication: weekly written update by email, questions to the account lead, escalation to the studio lead. Pricing is a fixed package fee with extra revision rounds billed per round; the exact fee is set by the account lead. One included revision round.
EXPECT:
- Output begins with a fenced block whose first content line is exactly "CLIENT PLAYBOOK", with a "Service:" line carrying Audience, Type, and Prepared directly beneath it, and "Type: Onboarding".
- The playbook carries Service overview, What is not included, How it works, Timeline, Responsibilities, Communication, What you get, Pricing structure, FAQ, and Next step.
- The process is written in client language with week labels and what the client sees (a 45-minute call, a written brief in 2 business days), not internal phase names.
- A "What is not included" block names the exclusions (website build, social management, printing), so the boundary is on the page as clearly as what is in.
- A distinct "What triggers extra cost / a change request" boundary line names the scope-creep edge (extra revision rounds, work beyond scope, a rush request), separate from the exclusions block.
- A "This service assumes" line surfaces the client-side dependencies (the client sends assets and holds rights to supplied imagery), so an unstated dependency is on the page.
- The Timeline carries the stage-by-stage flow, the dependency is flagged (a stage waits on the client's assets) and the timeline is stated to shift when feedback runs late, with no invented penalty; the most-missed client obligation (send brand assets and 3 reference brands by day 3) appears in the You-do column in bold.
- A "Current as of [date]" line is present so a stale version is not relied on.
- The copy is in the client's market English (Australian English for an AU client: colour, optimise, organise), not US spelling.
- The Communication block names the channels (weekly written update by email), the cadence, the escalation path (to the studio lead), and the point of contact (the account lead), with any response-time commitment marked "To be confirmed" rather than invented.
- Pricing shows the structure (fixed fee, extra rounds billed per round) with the fee marked "To be confirmed by [role]", no invented amount.
- The FAQ has three to six real client questions (revisions included, late feedback, who is my contact) each answered in two sentences, no invented refund or cancellation policy.
- Nothing is invented: no fabricated price, turnaround, guarantee, SLA, or named person; no other client's data appears; reading level matches a new client.
- Step 0 states first run or recovered context.
- Handoff written to `~/.claude/crew-state/docs/crew-docs-client-playbook-builder-handoff.md` recording the type chosen, the section to confirm (the fee), and what `crew-docs-sop-builder` needs to write the matching internal version.

## Case B: messy
INPUT:
"Need a playbook for our SEO retainer to send prospects. Process is discovery, then we do on-page and link building and reporting, ongoing. Timeline whatever, it's monthly. Clients usually drag their feet giving us access to their CMS and Search Console. Pricing tiers are Starter, Growth, Scale but don't put dollar figures, and someone said we guarantee page-one rankings, not sure if that's official." Internal labels used: "tech audit sprint", "GBP optimisation".
EXPECT:
- Type is Service overview (a pre-sale prospect doc), and the skill asks once for the single load-bearing gap if the real monthly process or client obligations are too vague to write, per Loop 1, rather than batching a survey.
- Internal jargon is translated: "tech audit sprint" and "GBP optimisation" are rewritten into what the client sees (a technical review of your site, optimising your Google Business Profile), not leaked verbatim.
- The page-one ranking guarantee is NOT stated as a promise. It is flagged "To confirm / Escalated" to the business owner as an unconfirmed claim, with no fabricated guarantee, and the guardrail on consumer-law representations is respected (no implied guarantee the business did not make).
- Vague timing is handled with "Assumed: monthly cycle" or "To be confirmed", not invented durations.
- Tiers Starter / Growth / Scale are shown as structure with amounts marked "To be confirmed by [role]", no dollar figures invented.
- The most-missed client obligation (CMS and Search Console access) appears in the client "You do" column in bold.
- No invented SLA, refund, cancellation rule, or exclusion is added; any business-owned term is marked to confirm.
- Handoff written, recording the escalated guarantee claim and the loaded-language correction as a "Learned" note, plus the jargon that was translated.

## Case C: missing-input
INPUT:
"Write a client playbook for our consulting package." No delivery steps, no responsibilities, no timeline, no audience, no pricing given.
EXPECT:
- Loop 1 fires. The skill names the single most load-bearing gap (the real delivery steps and what the client must do, by when) and asks once for it, plainly, not a batched survey.
- It does not invent stages, durations, prices, deliverables, exclusions, a communication cadence, or a guarantee.
- If it proceeds at all, the spine (overview, how it works, timeline, responsibilities, communication, what you get, pricing structure, FAQ, next step) is present but bodies read "To be confirmed by [role]", and pricing is not given a number.
- Any section it cannot found is marked "To be confirmed by [role]" or left as a labelled placeholder, never filled with fabricated content.
- Because every core section is unconfirmed, any emitted shell carries a "[DRAFT SHELL, not for client release, N sections to confirm]" header stamp and STATUS DONE_WITH_GAPS or BLOCKED, never DONE, so a hollow placeholder is not mistaken for a publishable deliverable; a "Current as of [date]" or "No output, run completed [date]" stamp is still written.
- Handoff written to `~/.claude/crew-state/docs/crew-docs-client-playbook-builder-handoff.md` recording the missing inputs so the next run does not repeat the ask, with "No output, run completed [date]" if nothing usable was produced.
