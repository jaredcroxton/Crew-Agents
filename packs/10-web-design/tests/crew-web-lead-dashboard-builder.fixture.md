# Fixture: crew-web-lead-dashboard-builder

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear, and that the handoff file was written.

## Case A: clean
INPUT:
Build a lead dashboard. Target: Sunshine Coast firms with 50 to 200 staff (here are 6 with websites). Brand: use default slate-ink-lime. Offer: AI agents that automate repetitive business workflows. Proof: we cut a 12-person team's manual order entry by 70 percent. LinkedIn: yes, person-research is permitted.
EXPECT:
- Output begins with "LEAD DASHBOARD BUILD REPORT" and a summary line with Leads, Hot, Warm, Cool, Decision-makers, Emails, DMs, plus a Design review verdict line and a web-standards Gate verdict line.
- A fit score 0 to 100 per lead with the buckets applied (Hot 80 to 100, Warm 50 to 79, Cool 0 to 49) and the five named sub-scores (size, seniority, signal, industry, timing), tagged Derived, per the Fit scoring model.
- A named decision-maker per lead with role (Confirmed), since LinkedIn runs by default.
- Each decision-maker card has a clickable LinkedIn link with target=_blank and rel="noopener noreferrer" (a direct profile URL, or a LinkedIn people-search link where no direct profile is public). No profile URL is fabricated.
- A one-sentence personalised insight per lead, tagged Inferred or Derived.
- A cold email AND a LinkedIn DM per lead, plus a 3-touch follow-up sequence (day 3, 7, 14, email 3 the breakup). Subjects 2 to 4 words lowercase, no banned openings or jargon, no 30-minute call ask.
- The per-lead records in the report carry every field the dashboard renders: company, website, region, industry, size, fit, decision-maker, insight, signal, channels, outreach status, evidence tags. (The dashboard step needs nothing the report does not already contain.)
- dashboard.html opens sorted by fit score descending (Hot first), and has a search input, a sort control, filter controls for region, quality score, and outreach status, a "Showing n of N leads" count, a fit badge per card with tabular figures, and a Copy button on every draft.
- dashboard.html has zero network dependencies (no CDN, no framework, no external font link); the lead data is inlined, never fetched at runtime.
- The Design review gate ran its browser verification protocol (served, console read, screenshots at desktop and 375px, controls clicked, keyboard walk) before DESIGN REVIEW PASS was emitted.
- Handoff file `~/.claude/crew-state/projects/<project>/crew-web-lead-dashboard-builder-handoff.md` was written.

## Case B: messy
INPUT:
Make me a prospect dashboard. Target: "a few accounting firms around Noosa". Offer: AI agents for back-office work. No proof point yet. LinkedIn: yes, but for two of them you will not find a named person.
EXPECT:
- For the leads with no named person, Backup rule 1 (from the Decision-maker lookup section) fires: a role-target is used ("Head of Operations, name to verify"), tagged Derived, and the email and DM carry a "verify before send" tag.
- Where a name is found, it is Confirmed and cited; where no public profile exists, a LinkedIn people-search link is used, never a guessed profile slug.
- No real person's name is invented, and no guessed email is shown as Confirmed.
- Where the signal is thin, the insight is marked Escalated (Loop 3), not dressed up as specific.
- Proof point recorded as "to be supplied"; emails still work with the placeholder.
- Fit scores still computed (Derived) with sub-scores, so even thin leads are ranked, and the dashboard still opens sorted fit descending.
- Handoff file written into the active project (`~/.claude/crew-state/projects/<project>/crew-web-lead-dashboard-builder-handoff.md`), listing the Derived contacts and escalated insights to verify.

## Case C: missing-input
INPUT:
Build me a lead dashboard.
EXPECT:
- The skill asks once for the scrape target (Loop 1, Missing Input), because there is nothing to score or research.
- It runs the five discovery questions (target, expected lead count, brand, offer, proof) one at a time rather than guessing.
- It does not fit-score, build a dashboard, invent companies or contacts, or draft any email or DM until a target exists.
- It does not create a calendar event at any point; the calendar offer is a question, asked only after a build.
- Handoff file written into the active project (`~/.claude/crew-state/projects/<project>/crew-web-lead-dashboard-builder-handoff.md`), recording the build as not started and the inputs still needed.
