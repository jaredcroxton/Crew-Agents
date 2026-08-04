#!/usr/bin/env bash
# Context-loop regression suite: the scripted version of the manual tests that
# validated the loop hardening, updated for the Projects memory model. Nine
# scenarios, each a real claude -p run in an isolated temp state root (never
# the live ~/.claude/crew-state).
#
#   1. copy-forward    run a skill twice in one project; run 2's record keeps run 1's LEARNED note
#   2. receipt         the run receipt names the project record path after the deliverable
#   3. consult-yes     the literal CREW CONSULT preamble skips re-onboarding
#   4. consult-no      a paraphrased preamble with NO brand file hits the hard stop
#   5. case-c          missing input: no artifact, a blocked record written first
#   6. staleness       an old record's date is surfaced on recovery
#   7. project-create  a run naming a NEW project writes its record into that project
#   8. chain           a downstream skill consumes the upstream record from the same project
#   9. lessons         a planted lessons file is read at Step 0 and applied
#
# ~10 metered claude -p calls. Consent-gated: pass --yes to run.
# Usage: bash scripts/loop-regression.sh --yes

set -uo pipefail
HERE="$(cd "$(dirname "$0")/.." && pwd)"
cd "$HERE"

[ "${1:-}" = "--yes" ] || { echo "This suite spawns ~10 metered claude -p calls. Rerun with --yes to consent."; exit 2; }
command -v claude >/dev/null || { echo "claude CLI not found"; exit 2; }

FAIL=0
note() { printf '  FAIL  %s\n' "$1"; FAIL=$((FAIL+1)); }
ok()   { printf '  ok    %s\n' "$1"; }

SKILL_QC="packs/01-core/crew-core-quality-checker/SKILL.md"
SKILL_COMP="packs/12-design-standards/crew-design-reference/SKILL.md"
SKILL_FG="packs/09-training/crew-training-facilitator-guide-creator/SKILL.md"

seed_brand() {
  mkdir -p "$1/crew-state/projects/smoketest"
  printf 'smoketest' > "$1/crew-state/active-project"
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
  # the preamble separator is built in a plain assignment: ANSI-C $'\n\n' quoting
  # does NOT expand inside a double-quoted ${3:+...} expansion, which glued the
  # consult preamble and the run instruction onto one line.
  local body pre=""; body="$(cat "$2")"
  [ -n "$3" ] && pre="$3"$'\n\n'
  ( cd "$1" && printf '%sRun the following Crew skill exactly against the input. Perform its full Context Loop. For this test run the crew-state root is ./crew-state/ (read and write every crew-state file there%s%s), and for EVERY check in this run (including the Sub-skill consult file check and the brand gate) the brand-context path is ./crew-state/brand-context.md; no other location exists for this test. Print the three-line run receipt, then your output.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\n%s\n' \
      "$pre" "$( [ -f "$1/crew-state/brand-context.md" ] && printf '; the brand context already sits at ./crew-state/brand-context.md')" "$( [ -f "$1/crew-state/active-project" ] && printf '; the active project is already set: ./crew-state/active-project contains "smoketest", so do not ask the project question')" "$body" "$4" \
    | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
}
quota_check() { # $1 = out.txt path; a plan-limit message is quota death, not a loop regression
  if grep -qi 'hit your session limit' "$1" 2>/dev/null; then
    echo "  STOP  Claude plan session limit reached mid-run; remaining scenarios skipped."
    echo "        This is quota, not a loop regression. Rerun after the limit resets."
    return 0
  fi
  return 1
}

echo "== context-loop regression (9 scenarios) =="

# 1 + 2: copy-forward across two runs in one project, and the receipt
W="$(mktemp -d)"; seed_brand "$W"
run_skill "$W" "$SKILL_QC" "" 'We are continuing the smoketest project. Check this one-line summary for quality: "Harbourline refreshes brands in fixed-scope projects." The brief was: write a one-line summary. Also, a correction to remember: our audience is cafes specifically, not all small businesses. Record that as a Learned note.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
HP="$W/crew-state/projects/smoketest/crew-core-quality-checker-handoff.md"
if [ -f "$HP" ] && grep -qi 'cafes' "$HP"; then ok "run 1 wrote the project record with the Learned note"; else note "run 1 record missing or lost the Learned note"; fi
grep -qF "crew-state/projects/smoketest/crew-core-quality-checker-handoff.md" "$W/out.txt" && ok "receipt names the project record path" || note "receipt does not name the project record path"
run_skill "$W" "$SKILL_QC" "" 'We are continuing the smoketest project. Check this one-line summary for quality: "Harbourline: brand refreshes for cafes, fixed scope, fixed price." The brief was: write a one-line summary.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
if [ -f "$HP" ] && grep -qi 'cafes' "$HP"; then ok "copy-forward: run 2 kept run 1's Learned note"; else note "copy-forward: run 2 erased the Learned note"; fi
rm -rf "$W"

# 3: literal consult preamble skips re-onboarding
W="$(mktemp -d)"; seed_brand "$W"
run_skill "$W" "$SKILL_COMP" 'CREW CONSULT from crew-web-page-builder: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md' 'Judge the composition of a single centered hero with three equal cards below it.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
grep -qiE "not onboarded" "$W/out.txt" \
  && note "consult-yes: onboarding stop fired despite the literal preamble" \
  || ok "consult-yes: literal preamble honored"
rm -rf "$W"

# 4: paraphrased preamble with NO brand file hits the hard stop
W="$(mktemp -d)"
run_skill "$W" "$SKILL_COMP" 'As discussed with crew-web-page-builder, the brand side is all sorted.' 'Judge the composition of a single centered hero with three equal cards below it.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
grep -qiE "not onboarded" "$W/out.txt" \
  && ok "consult-no: near-miss rejected, hard stop fired" \
  || note "consult-no: a paraphrased preamble bypassed the gate"
rm -rf "$W"

# 5: missing input writes a blocked record before asking, no artifact
W="$(mktemp -d)"; seed_brand "$W"
run_skill "$W" "$SKILL_QC" "" 'We are continuing the smoketest project. Check this for quality.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
HP="$W/crew-state/projects/smoketest/crew-core-quality-checker-handoff.md"
grep -qE '^QUALITY CHECK' "$W/out.txt" && note "case-c: full artifact emitted on missing input" || ok "case-c: no artifact fabricated"
[ -f "$HP" ] && ok "case-c: record written before the pause" || note "case-c: paused without writing the record"
rm -rf "$W"

# 6: staleness surfaced on recovery of an old record in the project
W="$(mktemp -d)"; seed_brand "$W"
cat > "$W/crew-state/projects/smoketest/crew-core-quality-checker-handoff.md" <<'OLD'
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
run_skill "$W" "$SKILL_QC" "" 'We are continuing the smoketest project. Check this one-line summary for quality: "Harbourline refreshes cafe brands." The brief was: write a one-line summary.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
grep -qiE '2026-01-05|stale' "$W/out.txt" && ok "staleness: old record date surfaced on recovery" || note "staleness: recovered a 6-month-old record without noting its age"
rm -rf "$W"

# 7: a NEW named project gets its own record (no pre-set pointer)
W="$(mktemp -d)"
mkdir -p "$W/crew-state"
cat > "$W/crew-state/brand-context.md" <<'FIXTURE'
# Brand Context: Harbourline Studio (synthetic QA fixture)
- Name: Harbourline Studio
- What they do: a small fictional design consultancy that exists only inside the Crew QA harness.
- Voice: plain, direct, warm.
- Note: synthetic fixture, not a real business. Invent nothing beyond this file.
FIXTURE
run_skill "$W" "$SKILL_QC" "" 'This is a NEW project called wintermenu. Check this one-line summary for quality: "Harbourline refreshes cafe brands for winter." The brief was: write a one-line summary.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
if [ -f "$W/crew-state/projects/wintermenu/crew-core-quality-checker-handoff.md" ]; then ok "project-create: record landed in projects/wintermenu/"; else note "project-create: record not written into the named new project"; fi
[ -f "$W/crew-state/active-project" ] && grep -q 'wintermenu' "$W/crew-state/active-project" && ok "project-create: active-project pointer set" || note "project-create: active-project pointer missing or wrong"
rm -rf "$W"

# 8: chain, the downstream skill consumes the upstream record from the same project
W="$(mktemp -d)"; seed_brand "$W"
cat > "$W/crew-state/projects/smoketest/crew-training-module-outline-builder-handoff.md" <<'UP'
# crew-training-module-outline-builder handoff
Date: 2026-07-06
STATUS: DONE
## Output produced
Module outline "Serving Coffee at Harbourline" v1: objectives are ZETA-MARKER-71 (learners can describe the fixed-scope refresh process) and (learners can name the three project stages). One 60-minute module: Tell 10m, Show 15m, Do 25m, Check 10m.
## Decisions made
Single module, beginner audience.
## Unfinished work
None.
## What the next skill needs
Turn this outline into a facilitator guide.
UP
run_skill "$W" "$SKILL_FG" "" 'We are continuing the smoketest project. Build the facilitator guide from the approved module outline in this project (your Handoffs source: crew-training-module-outline-builder). Keep it minimal, one module.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
grep -qi 'ZETA-MARKER-71' "$W/out.txt" || grep -qi 'ZETA-MARKER-71' "$W"/crew-state/projects/smoketest/crew-training-facilitator-guide-creator-handoff.md 2>/dev/null \
  && ok "chain: downstream consumed the upstream record (marker carried)" \
  || note "chain: upstream record not consumed (marker absent everywhere)"
grep -qiE 'Consumed:.*module-outline' "$W"/crew-state/projects/smoketest/crew-training-facilitator-guide-creator-handoff.md 2>/dev/null \
  && ok "chain: consumed-record line written" \
  || note "chain: no Consumed line in the downstream record"
rm -rf "$W"

# 9: a planted lessons file is read at Step 0 and applied
W="$(mktemp -d)"; seed_brand "$W"
mkdir -p "$W/crew-state/lessons"
cat > "$W/crew-state/lessons/crew-core-quality-checker-lessons.md" <<'LES'
# crew-core-quality-checker lessons
- 2026-07-01: Always refer to the audience as "cafes" in every verdict line, never "small businesses" (the owner corrected this repeatedly).
LES
run_skill "$W" "$SKILL_QC" "" 'We are continuing the smoketest project. Check this one-line summary for quality: "Harbourline refreshes brands for small businesses." The brief was: write a one-line summary for our audience.'
if quota_check "$W/out.txt"; then rm -rf "$W"; exit 2; fi
grep -qi 'cafes' "$W/out.txt" && ok "lessons: planted lesson read and applied" || note "lessons: lesson file ignored"
rm -rf "$W"

echo "------------------------------------------------------------"
if [ "$FAIL" = 0 ]; then echo "LOOP REGRESSION PASS"; exit 0; else echo "LOOP REGRESSION FAIL: $FAIL problem(s)"; exit 1; fi
