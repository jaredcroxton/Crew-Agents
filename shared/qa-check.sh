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
# perl, not grep -P: BSD/macOS grep has no -P, which made the old check a silent
# no-op that never matched anything.
DASHED="$(find . -name '*.md' -type f ! -path './.git/*' ! -path './.tmp/*' ! -path './dist/*' ! -path './plugins/*' -exec perl -ne 'if (/[\x{2014}\x{2013}\x{2015}]/) { print "$ARGV\n"; last }' {} \; 2>/dev/null | sort -u)"
if [ -n "$DASHED" ]; then
  echo "$DASHED"; note "em/en dashes found in the files above"
else ok "no em dashes"; fi

# LICENSE is deliberately exempt from the ban list: a licence naming the licensor
# is normal commercial practice, not a white-label leak.
echo "== ban-list check (shipped .md only; skips CREDITS.md, README.md, LICENSE, and runtime state under .claude/) =="
BANHIT=0
while IFS= read -r f; do
  case "$f" in */CREDITS.md|./CREDITS.md|*/README.md|./README.md|*/LICENSE|./LICENSE|*/.claude/*|./.claude/*) continue ;; esac
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
    # crew-web-app-builder is the BLAST-protocol mirror, a deliberate exception to the
    # gold-standard structural gates (its own SKILL.md plus assets/templates/, ported whole).
    # Skip the per-skill structural check here; the global em-dash and ban-list checks above
    # still cover it.
    case "$skill" in crew-web-app-builder) continue ;; esac
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
    grep -qF "~/.claude/crew-state/$packid/$skill-handoff.md" "$f" || note "$skill: handoff path not ~/.claude/crew-state/$packid/$skill-handoff.md"
    # the state root is home-global; a bare relative .claude/crew-state forks the memory
    perl -ne 'exit 1 if /(?<!~\/)\.claude\/crew-state/' "$f" || note "$skill: bare relative .claude/crew-state path (must be ~/.claude/crew-state)"
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
    # cross-skill reference integrity: every backticked crew-* token must exist as a pack folder.
    # A phantom skill name in a routing rule or Handoffs section is a broken chain link.
    for tok in $(grep -o '`crew-[a-z0-9-]*`' "$f" | tr -d '`' | sed 's/-handoff$//' | sort -u); do
      case "$tok" in crew-state|crew-method|crew-|crew) continue ;; esac
      # a token may name a skill folder or a pack (`crew-core`, `crew-web-design`, ...)
      ls -d "$PACKS_DIR"/*/"$tok" >/dev/null 2>&1 && continue
      ls -d "$PACKS_DIR"/*-"${tok#crew-}" >/dev/null 2>&1 && continue
      note "$skill: references \`$tok\` which exists in no pack"
    done

    [ "$FAIL" = 0 ] && ok "$skill"
  done
done
echo "  checked $SKILL_COUNT skills"

# full-run-only checks (skipped under --pack so per-pack QA stays fast)
if [ -z "$PACK_FILTER" ]; then
  # README truth: the headline skill count must equal the disk count
  DISK_COUNT=$(find "$PACKS_DIR" -mindepth 2 -maxdepth 2 -type d -name 'crew-*' | wc -l | tr -d ' ')
  if [ -f README.md ]; then
    grep -q "SKILLS-$DISK_COUNT-" README.md \
      && ok "README skill count matches disk ($DISK_COUNT)" \
      || note "README badge count does not match disk count ($DISK_COUNT skills on disk)"
  fi
  # parity: the plugin route must ship byte-identical skills. Generate a fresh
  # comparison copy to .tmp (never touching ./plugins in place), hash-compare
  # every crew-full skill against its packs/ source, then delete the temp copy.
  if [ -f build-plugins.sh ]; then
    echo "== plugin parity check (generated to .tmp, packs/ is the source of truth) =="
    PARITY_OUT=".tmp/parity-plugins"
    bash build-plugins.sh --out "$PARITY_OUT" >/dev/null 2>&1
    PARITY_FAIL=0
    for sd in "$PACKS_DIR"/*/crew-*/; do
      s="$(basename "${sd%/}")"
      src="$sd/SKILL.md"; gen="$PARITY_OUT/crew-full/skills/$s/SKILL.md"
      if [ ! -f "$gen" ]; then note "parity: $s missing from generated crew-full"; PARITY_FAIL=1; continue; fi
      if ! cmp -s "$src" "$gen"; then note "parity: $s differs between packs/ and the generated plugin"; PARITY_FAIL=1; fi
    done
    rm -rf "$PARITY_OUT"
    [ "$PARITY_FAIL" = 0 ] && ok "plugin parity: all skills byte-identical to packs/"
  fi
fi

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
      # Sanctioned test seam: a SYNTHETIC brand fixture so the brand hard gate passes
      # honestly (never bypassed, never the real brand file), plus an explicit state
      # root for the test run. Spawns the claude CLI; acceptEdits lets the skill write
      # its handoff without disabling permissions.
      mkdir -p "$work/crew-state"
      cat > "$work/crew-state/brand-context.md" <<'FIXTURE'
# Brand Context: Harbourline Studio (synthetic QA fixture)
- Name: Harbourline Studio
- What they do: a small fictional design consultancy that exists only inside the Crew QA harness.
- Main product: fixed-scope brand refresh projects (fictional).
- Audience: fictional small businesses.
- Voice: plain, direct, warm.
- Never say: guaranteed results.
- Note: synthetic fixture, not a real business. Invent nothing beyond this file.
FIXTURE
      ( cd "$work" && printf 'Run the following Crew skill exactly against the input. Perform its full Context Loop. For this test run the crew-state root is ./crew-state/ (read and write every crew-state file there; the brand context already sits at ./crew-state/brand-context.md). Print the three-line run receipt, then the completed Output-format artifact, fully filled, as your final message.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\n%s\n' "$body" "$caseA" \
        | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
      hp="$work/crew-state/$packid/$skill-handoff.md"
      okrun=1
      grep -qiF "$header" "$work/out.txt" 2>/dev/null || { note "smoke $skill: output missing header '$header'"; okrun=0; }
      [ -f "$hp" ] || { note "smoke $skill: handoff file not written"; okrun=0; }
      [ "$okrun" = 1 ] && ok "smoke $skill"
      rm -rf "$work"
    done
  done
  # Negative case: with NO brand-context seeded, the brand hard gate must HOLD.
  # A pass here proves the gate survives a plain run instruction; the harness never
  # instructs around it.
  nf="$PACKS_DIR/01-core/crew-core-quality-checker/SKILL.md"
  if [ -f "$nf" ] && command -v claude >/dev/null; then
    work="$(mktemp -d)"; body="$(cat "$nf")"
    ( cd "$work" && printf 'Run the following Crew skill against the input. For this test run the crew-state root is ./crew-state/.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\nCheck this one-line summary for quality: "We ship fast."\n' "$body" \
      | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
    grep -qF "Your business is not onboarded yet" "$work/out.txt" 2>/dev/null \
      && ok "smoke negative: brand hard gate holds without brand-context" \
      || note "smoke negative: gate did not fire without brand-context"
    rm -rf "$work"
  fi
fi

echo "------------------------------------------------------------"
if [ "$FAIL" = 0 ]; then echo "QA PASS"; exit 0; else echo "QA FAIL: $FAIL problem(s)"; exit 1; fi
