# Fixture: crew-training-skill-gap-mapper

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
A CRM rollout (Salesforce) with a defined requirement and doing-statement capabilities, go-live in four weeks. Required capabilities: log every opportunity in-app (target Proficient), run the pipeline report unaided (target Proficient), follow the lead-handoff steps in order (target Proficient), coach a peer through the workflow (target Expert, team lead only). Roster of three: T. Okafor (Team Lead, ran the legacy pipeline report weekly for two years per manager, observed building reports), M. Reyes (Rep, self-report only), J. Bauer (Rep, no prior CRM use per manager). The lead-handoff steps were never written down. Sponsor: the Sales Director.
EXPECT:
- Output begins with "SKILL GAP MAP" and the header carries Initiative, Mapped date, Go-live date, and the sponsor, plus a CONFIDENTIAL band naming the recipient and "do not redistribute", with the instruction that each person receives only their own row.
- Every person in scope (T. Okafor, M. Reyes, J. Bauer) appears in the capability matrix.
- Every rating cites a named basis (manager rating, observed work) or is Unknown / Blocked; M. Reyes carries "self-report only, capability unverified" and is never upgraded to a confident score.
- Each rating's basis evidences THAT competency: a basis that supports the pipeline-report rating (C2) is not reused to justify a Tool or Process cell; a cell without its own basis is Unknown, and self-report-only cells are marked.
- Each required competency carries a dimension tag (Tool, Skill, Process, Behaviour) and a target level on the 0 None to 4 Expert scale.
- Every gap is classified (Met / Minor / Moderate / Critical / Blocked); an Unknown current rating against a non-zero requirement is "Blocked, unverified", not zero.
- Gaps are computed correctly as target minus current, floored at 0 (a current 2 against a target of 3 is a gap of 1 = Minor, not Moderate); no cell is misclassified.
- The priority ranking visibly weighs all four axes (impact, urgency from the go-live date, number affected, difficulty to close), not gap size alone, and a self-report-only cell is not hardened into a Critical priority until confirmed (the verified Critical and the unverified Moderate are stated separately).
- At least one priority gap is routed to a NON-training intervention by cause: the lead-handoff gap is routed to a PROCESS change or SOP (the steps were never defined), and the logging gap to a JOB AID, not a training session, with the cause named.
- A readiness risk is flagged (J. Bauer unlikely to reach Proficient on the report by go-live) and the go-live decision is Escalated to the sponsor.
- The per-role view keeps the Team Lead's Expert target separate from the Reps, who do not carry that competency at all.
- Nothing is invented: no score, no name, no certification, no date beyond the inputs.
- Handoff file `.claude/crew-state/training/crew-training-skill-gap-mapper-handoff.md` was written, naming the priority gaps and using crew-training-needs-analyser (not a doubled name).
- No em dashes anywhere.

## Case B: messy
INPUT:
The same CRM rollout but go-live is in two weeks. The sponsor says "everyone is bad at logging opportunities". On inspection the cause is environmental: the opportunity field in the CRM is broken and will not save, and the lead-handoff process was never defined. Two reps (initials only) have a self-report rating and nothing else. One rep has no evidence of any kind. The gap on running the pipeline report is wide and there is no time to close it before the two-week go-live.
EXPECT:
- The two reps with only self-report are rated from that basis but flagged "capability unverified, confirm with manager", never upgraded to a confident score.
- The "everyone is bad at logging" gap is diagnosed by cause and routed to the TOOLING fix (the broken field) and the PROCESS fix (the undefined handoff), NOT to a training session, with the cause named (a workshop on a field that will not save closes nothing).
- The rep with no evidence is rated Unknown / Blocked, not guessed from a title.
- The two-week go-live against the uncloseable pipeline-report gap is flagged a readiness risk and the go-live decision is Escalated to the sponsor.
- Nothing is invented: no score, no name, no certification, no date.
- STATUS is DONE_WITH_GAPS or BLOCKED, never a clean DONE.
- Handoff file `.claude/crew-state/training/crew-training-skill-gap-mapper-handoff.md` was written, recording the unverified people, the environmental cause (broken field, undefined process), and the escalated go-live.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Map the skill gaps for the new system." No defined capabilities (nothing on what people must be able to DO), no roster, no evidence, no go-live date. Only that a system is coming.
EXPECT:
- Loop 1 fires. The skill names what is missing (the specific doing-statement capabilities the initiative demands) and why it matters (a gap is meaningless without a defined target).
- It asks once, plainly, for the specific capabilities the initiative demands.
- It invents no competency, no person, no rating, and no target.
- Step 0 still runs (states first run, or recovers prior context).
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE.
- Handoff file `.claude/crew-state/training/crew-training-skill-gap-mapper-handoff.md` was still written, recording the missing requirement so the next run knows.
- No em dashes anywhere.
