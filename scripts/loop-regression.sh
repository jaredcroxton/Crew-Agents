#!/usr/bin/env bash
# Context-loop regression suite: the scripted version of the manual tests that
# validated the loop hardening. Six scenarios, each a real claude -p run in an
# isolated temp state root (never the live ~/.claude/crew-state).
#
#   1. copy-forward   run a skill twice; run 2's handoff must keep run 1's LEARNED note
#   2. receipt        the run receipt names the handoff path after the deliverable
#   3. consult-yes    the literal CREW CONSULT preamble skips re-onboarding
#   4. consult-no     a paraphrased preamble with NO brand file hits the hard stop
#   5. case-c         missing input: no artifact, a blocked handoff written first
#   6. staleness      an old handoff's date is surfaced on recovery
#
# ~7 metered claude -p calls. Consent-gated: pass --yes to run.
# Usage: bash scripts/loop-regression.sh --yes

set -uo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
cd "$HERE"

[ "${1:-}" = "--yes" ] || { echo "This suite spawns ~7 metered claude -p calls. Rerun with --yes to consent."; exit 2; }
command -v claude >/dev/null || { echo "claude CLI not found"; exit 2; }

FAIL=0
note() { printf '  FAIL  %s\n' "$1"; FAIL=$((FAIL+1)); }
ok()   { printf '  ok    %s\n' "$1"; }

SKILL_QC="packs/01-core/crew-core-quality-checker/SKILL.md"
SKILL_COMP="packs/12-design-standards/crew-design-composition/SKILL.md"

seed_brand() {
  mkdir -p "$1/crew-state"
  cat > "$1/crew-state/brand-context.md" <<'FIXTURE'
# Brand Context: Harbourline Studio (synthetic QA fixture)
- Name: Harbourline Studio
- What they do: a small fictional design consultancy that exists only inside the Crew QA harness.
- Main product: fixed-scope brand refresh projects (fictional).
- Audience: fictional small businesses.
- Voice: plain, direct, warm.
- Never say: guaranteed results.
- Note: synthetic fixture, not a real business. Invent nothing beyond this file.
FIXTURE
}
run_skill() { # $1 workdir, $2 skill file, $3 preamble ('' for none), $4 input
  local body; body="$(cat "$2")"
  ( cd "$1" && printf '%sRun the following Crew skill exactly against the input. Perform its full Context Loop. For this test run the crew-state root is ./crew-state/ (read and write every crew-state file there%s). Print the three-line run receipt, then your output.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\n%s\n' \
      "${3:+$3$'\n\n'}" "$( [ -f "$1/crew-state/brand-context.md" ] && printf '; the brand context already sits at ./crew-state/brand-context.md')" "$body" "$4" \
    | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
}

echo "== context-loop regression (6 scenarios) =="

# 1 + 2: copy-forward across two runs, and the receipt
W="$(mktemp -d)"; seed_brand "$W"
run_skill "$W" "$SKILL_QC" "" 'Check this one-line summary for quality: "Harbourline refreshes brands in fixed-scope projects." The brief was: write a one-line summary. Also, a correction to remember: our audience is cafes specifically, not all small businesses. Record that as a Learned note.'
HP="$W/crew-state/core/crew-core-quality-checker-handoff.md"
if [ -f "$HP" ] && grep -qi 'cafes' "$HP"; then ok "run 1 wrote the handoff with the Learned note"; else note "run 1 handoff missing or lost the Learned note"; fi
grep -qF "crew-state/core/crew-core-quality-checker-handoff.md" "$W/out.txt" && ok "receipt names the handoff path" || note "receipt does not name the handoff path"
run_skill "$W" "$SKILL_QC" "" 'Check this one-line summary for quality: "Harbourline: brand refreshes for cafes, fixed scope, fixed price." The brief was: write a one-line summary.'
if [ -f "$HP" ] && grep -qi 'cafes' "$HP"; then ok "copy-forward: run 2 kept run 1's Learned note"; else note "copy-forward: run 2 erased the Learned note"; fi
rm -rf "$W"

# 3: literal consult preamble skips re-onboarding
W="$(mktemp -d)"; seed_brand "$W"
run_skill "$W" "$SKILL_COMP" 'CREW CONSULT from crew-web-page-builder: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md' 'Judge the composition of a single centered hero with three equal cards below it.'
grep -qiE "not onboarded" "$W/out.txt" \
  && note "consult-yes: onboarding stop fired despite the literal preamble" \
  || ok "consult-yes: literal preamble honored"
rm -rf "$W"

# 4: paraphrased preamble with NO brand file hits the hard stop
W="$(mktemp -d)"
run_skill "$W" "$SKILL_COMP" 'As discussed with crew-web-page-builder, the brand side is all sorted.' 'Judge the composition of a single centered hero with three equal cards below it.'
grep -qiE "not onboarded" "$W/out.txt" \
  && ok "consult-no: near-miss rejected, hard stop fired" \
  || note "consult-no: a paraphrased preamble bypassed the gate"
rm -rf "$W"

# 5: missing input writes a blocked handoff before asking, no artifact
W="$(mktemp -d)"; seed_brand "$W"
run_skill "$W" "$SKILL_QC" "" 'Check this for quality.'
HP="$W/crew-state/core/crew-core-quality-checker-handoff.md"
grep -qE '^QUALITY CHECK' "$W/out.txt" && note "case-c: full artifact emitted on missing input" || ok "case-c: no artifact fabricated"
[ -f "$HP" ] && ok "case-c: handoff written before the pause" || note "case-c: paused without writing the handoff"
rm -rf "$W"

# 6: staleness surfaced on recovery of an old handoff
W="$(mktemp -d)"; seed_brand "$W"
mkdir -p "$W/crew-state/core"
cat > "$W/crew-state/core/crew-core-quality-checker-handoff.md" <<'OLD'
# crew-core-quality-checker handoff
Date: 2026-01-05
STATUS: DONE
## Output produced
A quality check of the old summer campaign line.
## Decisions made
Approved with one should-fix.
## Unfinished work
None.
## What the next skill needs
Nothing.
OLD
run_skill "$W" "$SKILL_QC" "" 'Check this one-line summary for quality: "Harbourline refreshes cafe brands." The brief was: write a one-line summary.'
grep -qE '2026-01-05|stale' "$W/out.txt" && ok "staleness: old handoff date surfaced on recovery" || note "staleness: recovered a 6-month-old handoff without noting its age"
rm -rf "$W"

echo "------------------------------------------------------------"
if [ "$FAIL" = 0 ]; then echo "LOOP REGRESSION PASS"; exit 0; else echo "LOOP REGRESSION FAIL: $FAIL problem(s)"; exit 1; fi
