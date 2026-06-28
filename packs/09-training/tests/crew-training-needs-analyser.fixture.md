# Fixture: crew-training-needs-analyser

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
Team: 5 SDRs, all individual contributors. Goal: lift meetings-booked per 100 calls from 4 to 7 this quarter (baseline 4, target 7).
Current capability: manager reviewed 12 call recordings. SDRs pitch the new product tier before qualifying need, so calls end at "send me an email". They also cannot state the three-line value prop for the new tier. Two SDRs miss daily call quota.
EXPECT:
- Output begins with "TRAINING NEEDS ANALYSIS" and includes Team/Role, Analysed date, and Goal.
- A "Desired state (what good looks like)" line and a "Baseline metric" line both appear, with the baseline 4 and target 7 named, not invented.
- The current state and the desired state are both named (no one-ended gap).
- Exactly three ranked gaps, each with a "Type:" of Knowledge or Skill, an "Intervention:" tag, and a specific Recommended topic.
- The two-SDRs-miss-quota item is classified as a Motivation gap, given a non-training intervention (comp), and placed under "Not a training problem", not in the top three.
- At least one gap ties its expected impact to the meetings-booked metric.
- Capability claims are labelled Evidence (the 12 recordings), Manager view, or Assumed; no capability score or headcount is invented.
- An "Open questions for the manager" line appears.
- Handoff file `~/.claude/crew-state/training/crew-training-needs-analyser-handoff.md` was written.

## Case B: messy (manager pre-decided the training)
INPUT:
Team: "the support crew, maybe 8 of them, some seniors some not." Goal: "just make them better, fewer complaints." Manager: "Look, I already know what they need, book them all in for objection-handling training, that's the fix."
Current capability: "they're weak, especially on the phones. I think one of them used to be a trainer? Honestly the new ticketing system is a nightmare and slows everyone down, and half the team stopped caring after we cut the bonus."
EXPECT:
- Output begins with "TRAINING NEEDS ANALYSIS".
- The pre-decided objection-handling training is NOT rubber-stamped: the skill diagnoses the real cause first and states whether the chosen training fits the gap, rather than commissioning it on the manager's say-so.
- The environmental and motivation causes are diagnosed: the new ticketing system slowdown is typed as a Process or tooling gap, and the "stopped caring after the bonus cut" is typed as a Motivation gap. Both are named and routed/Escalated under "Not a training problem", not turned into training topics.
- The bonus-cut motivation item is Escalated and names who decides (a comp or target decision), not prescribed as a course.
- The opinion "they're weak on the phones" is marked "Manager view, unverified", never converted into an invented score (no "3 out of 10").
- Before typing the "weak on the phones" shortfall as trainable, the skill applies the information-and-feedback check (was the standard of good ever set, do they get call feedback); if the standard was never communicated or no feedback loop exists, it is routed as an environmental (feedback or expectations) fix, not made a training topic.
- The skill does not invent a headcount precision or a per-person skill level: "maybe 8" and the unclear seniorities are restated for the manager to confirm; the "used to be a trainer" individual read is flagged unverified and routed to crew-training-skill-gap-mapper, not recorded as fact.
- The vague goal ("just make them better") is sharpened or flagged: any gap with no metric tie is marked "impact unquantified, manager to confirm", not given an invented metric.
- Mixed seniority is surfaced because a senior and a junior have different "good" for the same task; the report does not blend them into one undifferentiated level silently.
- Handoff file `~/.claude/crew-state/training/crew-training-needs-analyser-handoff.md` was written, noting the unconfirmed headcount, levels, and goal, and the escalated motivation gap as unfinished work.

## Case C: missing-input
INPUT:
Team: 6 account managers, mid-level. Current capability: renewal rate sits at 70 percent, churn concentrated in accounts under 12 months old.
(No desired outcome or goal provided.)
EXPECT:
- Skill follows Loop 1: it asks once for the desired outcome, because a gap is the distance between current and desired and the desired state is the missing end. It does not guess the target renewal rate.
- It does not fabricate a goal metric (no invented "lift to 85 percent") or invent a gap to fill the blank.
- If it proceeds at all, the ranking and "expected impact" fields are marked pending the goal, not invented, and the report states it cannot rank by business impact without the desired state.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, so an empty scaffold is not mistaken for a finished analysis.
- Handoff file `~/.claude/crew-state/training/crew-training-needs-analyser-handoff.md` was written, recording the missing desired outcome as the blocker the next run needs.
