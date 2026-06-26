#!/usr/bin/env bash
# Crew skill-pack QA harness.
#   Structural pass (always): frontmatter, name==folder, uniqueness, naming,
#   no em dashes, ban-list, required sections, Context Loop, fixture present.
#   Functional smoke pass (--smoke): invoke each skill headless against its
#   fixture clean case, assert the output artifact header appears and the
#   handoff file is written. Real invocation, gated for cost.
#
# Usage:
#   qa-check.sh [--smoke] [--pack <id>] [ROOT]
# Exit non-zero on any failure (release gate).

set -uo pipefail

# default root = the pack root (this script lives in <root>/shared/), so the
# command works from any cwd. A positional arg overrides it.
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SMOKE=0
PACK_FILTER=""
while [ $# -gt 0 ]; do
  case "$1" in
    --smoke) SMOKE=1; shift ;;
    --pack) PACK_FILTER="$2"; shift 2 ;;
    *) ROOT="$1"; shift ;;
  esac
done
cd "$ROOT" 2>/dev/null || { echo "cannot cd to $ROOT"; exit 2; }

PACKS_DIR="packs"
[ -d "$PACKS_DIR" ] || { echo "no packs/ dir under $(pwd)"; exit 2; }

FAIL=0
note() { printf '  FAIL  %s\n' "$1"; FAIL=$((FAIL+1)); }
ok()   { printf '  ok    %s\n' "$1"; }

BAN='Brock|Bob|Lara|Neo|gstack|gbrain|PerformOS|Hermes|NemoClaw'

echo "== em-dash check (all .md except none; em dashes banned everywhere) =="
if grep -rlP '[\x{2014}\x{2013}\x{2015}]' --include='*.md' . 2>/dev/null | grep .; then
  note "em/en dashes found in the files above"; else ok "no em dashes"; fi

echo "== ban-list check (shipped .md only; skips CREDITS.md and runtime state under .claude/) =="
BANHIT=0
while IFS= read -r f; do
  case "$f" in */CREDITS.md|./CREDITS.md|*/.claude/*|./.claude/*) continue ;; esac
  if grep -iwnE "$BAN" "$f" >/dev/null 2>&1; then note "banned name in $f"; BANHIT=1; fi
done < <(find . -name '*.md' -type f)
[ "$BANHIT" = 0 ] && ok "no banned names in shipped files"

echo "== per-skill structural checks =="
NAMES_SEEN=""
SKILL_COUNT=0
for d in "$PACKS_DIR"/*/; do
  packdir="${d%/}"; packno="$(basename "$packdir")"; packid="${packno#*-}"
  [ -n "$PACK_FILTER" ] && [ "$packid" != "$PACK_FILTER" ] && continue
  for sd in "$packdir"/crew-*/; do
    [ -d "$sd" ] || continue
    skill="$(basename "${sd%/}")"
    f="$sd/SKILL.md"
    SKILL_COUNT=$((SKILL_COUNT+1))
    [ -f "$f" ] || { note "$skill: no SKILL.md"; continue; }

    # frontmatter: starts ---, has name + description, no other keys
    head -1 "$f" | grep -q '^---$' || note "$skill: missing opening frontmatter"
    fm="$(awk 'NR==1&&/^---$/{f=1;next} f&&/^---$/{exit} f{print}' "$f")"
    nm="$(printf '%s\n' "$fm" | sed -n 's/^name: *//p')"
    ds="$(printf '%s\n' "$fm" | sed -n 's/^description: *//p')"
    keys="$(printf '%s\n' "$fm" | grep -cE '^[a-z_]+:')"
    [ "$nm" = "$skill" ] || note "$skill: frontmatter name '$nm' != folder"
    [ -n "$ds" ] || note "$skill: missing description"
    [ "$keys" = 2 ] || note "$skill: frontmatter has $keys keys (want exactly name+description)"
    dlen=${#ds}
    { [ "$dlen" -ge 120 ] && [ "$dlen" -le 400 ]; } || note "$skill: description length $dlen (want 120-400)"
    printf '%s' "$skill" | grep -qE '^crew-[a-z]+-[a-z0-9-]+$' || note "$skill: name not crew-<pack>-<skill>"

    case " $NAMES_SEEN " in *" $skill "*) note "$skill: duplicate name" ;; esac
    NAMES_SEEN="$NAMES_SEEN $skill"

    # required sections
    for h in '^## Inputs' '^## Workflow' '^## Output format' '^## Guardrails' '^## Handoffs'; do
      grep -qE "$h" "$f" || note "$skill: missing section ${h#^## }"
    done
    # role paragraph: non-empty body line between the H1 and ## Inputs
    awk '/^# Crew: /{h=1;next} h&&/^## /{exit} h&&NF{print}' "$f" | grep -q . \
      || note "$skill: missing role-opening paragraph"
    # Context Loop
    grep -qE 'Step 0: Context Recovery' "$f" || note "$skill: missing Step 0 Context Recovery"
    grep -qE 'Final Step: Handoff Save' "$f" || note "$skill: missing Final Step Handoff Save"
    grep -q "crew-state/$packid/$skill-handoff.md" "$f" || note "$skill: handoff path not crew-state/$packid/$skill-handoff.md"
    # output fenced block present
    awk '/^## Output format/{o=1} o&&/^```/{c++} END{exit !(c>=2)}' "$f" || note "$skill: no fenced block under Output format"
    # workflow has >=6 numbered steps
    steps="$(awk '/^## Workflow/{w=1;next} w&&/^## /{exit} w&&/^[0-9]+\. /{c++} END{print c+0}' "$f")"
    [ "${steps:-0}" -ge 6 ] || note "$skill: Workflow has $steps numbered steps (want >=6)"
    # guardrails carry house rules
    awk '/^## Guardrails/{g=1;next} g&&/^## /{exit} g{print}' "$f" | grep -qi 'em dash' || note "$skill: Guardrails missing em-dash rule"
    # fixture exists
    [ -f "$packdir/tests/$skill.fixture.md" ] || note "$skill: missing tests/$skill.fixture.md"
    grep -q '## Case A' "$packdir/tests/$skill.fixture.md" 2>/dev/null && \
    grep -q '## Case B' "$packdir/tests/$skill.fixture.md" 2>/dev/null && \
    grep -q '## Case C' "$packdir/tests/$skill.fixture.md" 2>/dev/null || note "$skill: fixture missing one of cases A/B/C"

    [ "$FAIL" = 0 ] && ok "$skill"
  done
done
echo "  checked $SKILL_COUNT skills"

if [ "$SMOKE" = 1 ]; then
  echo "== functional smoke pass (claude -p, clean case per skill) =="
  command -v claude >/dev/null || { note "claude CLI not found, cannot smoke"; }
  for d in "$PACKS_DIR"/*/; do
    packdir="${d%/}"; packid="$(basename "$packdir")"; packid="${packid#*-}"
    [ -n "$PACK_FILTER" ] && [ "$packid" != "$PACK_FILTER" ] && continue
    for sd in "$packdir"/crew-*/; do
      [ -d "$sd" ] || continue
      skill="$(basename "${sd%/}")"; f="$sd/SKILL.md"
      fx="$packdir/tests/$skill.fixture.md"
      [ -f "$f" ] && [ -f "$fx" ] || { note "smoke $skill: missing skill or fixture"; continue; }
      header="$(awk '/^## Output format/{o=1} o&&/^```/{b++} o&&b==1&&!/^```/{print;exit}' "$f")"
      header="$(printf '%s' "$header" | sed 's/\[.*//; s/[[:space:]]*$//')"  # drop [placeholder] + trailing ws
      caseA="$(awk '/^## Case A/{a=1;next} a&&/^## Case/{exit} a&&/^INPUT:/{p=1;next} a&&/^EXPECT:/{exit} p{print}' "$fx")"
      body="$(cat "$f")"   # read before the cd so the relative path resolves
      work="$(mktemp -d)"
      # Spawns the claude CLI. acceptEdits lets the skill write its handoff file
      # without disabling permissions. Run this pass where spawning the CLI is allowed.
      ( cd "$work" && printf 'Run the following Crew skill exactly against the input. Perform its full Context Loop. VERIFICATION OVERRIDE for this run: write the handoff file under ./crew-state/<pack>/ instead of .claude/crew-state/<pack>/ (same filename and content). After writing the handoff, output the completed Output-format artifact, fully filled, as your FINAL message, with nothing after it. Do not ask questions, act on the input given.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\n%s\n' "$body" "$caseA" \
        | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
      hp="$work/crew-state/$packid/$skill-handoff.md"
      okrun=1
      grep -qiF "$header" "$work/out.txt" 2>/dev/null || { note "smoke $skill: output missing header '$header'"; okrun=0; }
      [ -f "$hp" ] || { note "smoke $skill: handoff file not written"; okrun=0; }
      [ "$okrun" = 1 ] && ok "smoke $skill"
      rm -rf "$work"
    done
  done
fi

echo "------------------------------------------------------------"
if [ "$FAIL" = 0 ]; then echo "QA PASS"; exit 0; else echo "QA FAIL: $FAIL problem(s)"; exit 1; fi
