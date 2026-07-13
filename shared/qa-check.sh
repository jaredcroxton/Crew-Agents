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
SMOKE_YES=0
SMOKE_CASES="A"
PACK_FILTER=""
while [ $# -gt 0 ]; do
  case "$1" in
    --smoke) SMOKE=1; shift ;;
    --yes) SMOKE_YES=1; shift ;;
    --cases) SMOKE_CASES="$2"; shift 2 ;;   # A (default) or AC (also run the missing-input case)
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
# no-op that never matched anything. -CSD is load-bearing: without it perl reads
# raw bytes and \x{2014} never matches the three UTF-8 bytes of an em dash, the
# same silent-no-op failure all over again.
DASHED="$(find . -name '*.md' -type f ! -path './.git/*' ! -path './.tmp/*' ! -path './dist/*' ! -path './plugins/*' -exec perl -CSD -ne 'if (/[\x{2014}\x{2013}\x{2015}]/) { print "$ARGV\n"; last }' {} \; 2>/dev/null | sort -u)"
if [ -n "$DASHED" ]; then
  echo "$DASHED"; note "em/en dashes found in the files above"
else ok "no em dashes"; fi

# LICENSE is deliberately exempt from the ban list: a licence naming the licensor
# is normal commercial practice, not a white-label leak. This script's own BAN
# definition line is likewise exempt.
echo "== ban-list check (all shipped text files; skips CREDITS.md, README.md, LICENSE, this script, and runtime state) =="
BANHIT=0
while IFS= read -r f; do
  case "$f" in
    */CREDITS.md|./CREDITS.md|*/README.md|./README.md|*/LICENSE|./LICENSE) continue ;;
    */qa-check.sh|./shared/qa-check.sh) continue ;;
    */.claude/*|./.claude/*|./.git/*|./.tmp/*|./dist/*|./plugins/*) continue ;;
    *.png|*.jpg|*.jpeg|*.gif|*.zip|*.db) continue ;;
  esac
  if grep -iwnE "$BAN" "$f" >/dev/null 2>&1; then note "banned name in $f"; BANHIT=1; fi
done < <(find . -type f \( -name '*.md' -o -name '*.sh' -o -name '*.json' -o -name '*.py' -o -name '*.html' -o -name '*.txt' -o -name '*.yml' -o -name '*.yaml' \) ! -path './.git/*' ! -path './.tmp/*' ! -path './dist/*' ! -path './plugins/*' ! -path './.claude/*')
[ "$BANHIT" = 0 ] && ok "no banned names in shipped files"

echo "== stray binary check (no databases or unexpected binaries in the tree) =="
STRAYBIN="$(find . -type f \( -name '*.db' -o -name '*.sqlite' -o -name '*.sqlite3' \) ! -path './.git/*' ! -path './.tmp/*' 2>/dev/null)"
if [ -n "$STRAYBIN" ]; then echo "$STRAYBIN"; note "stray database files found (never ship a state store)"; else ok "no stray database files"; fi

echo "== per-skill structural checks =="
NAMES_SEEN=""
SKILL_COUNT=0
for d in "$PACKS_DIR"/*/; do
  packdir="${d%/}"; packno="$(basename "$packdir")"; packid="${packno#*-}"
  [ -n "$PACK_FILTER" ] && [ "$packid" != "$PACK_FILTER" ] && continue
  for sd in "$packdir"/crew-*/; do
    [ -d "$sd" ] || continue
    skill="$(basename "${sd%/}")"
    # crew-web-app-builder is the Express-protocol mirror, a deliberate exception to the
    # gold-standard structural gates (its own SKILL.md plus assets/templates/, ported whole).
    # Skip the per-skill structural check here; the global em-dash and ban-list checks above
    # still cover it.
    case "$skill" in crew-web-app-builder) continue ;; esac
    f="$sd/SKILL.md"
    SKILL_COUNT=$((SKILL_COUNT+1))
    SKILL_FAIL_BASE=$FAIL
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
    grep -qE 'Final Step: (Handoff|Record) Save' "$f" || note "$skill: missing Final Step (Handoff|Record) Save"
    if [ "$skill" = "crew-core-brand-context" ]; then
      grep -qF "~/.claude/crew-state/crew-core-brand-context-handoff.md" "$f" || note "$skill: cabinet record path missing"
    else
      grep -qF "~/.claude/crew-state/projects/<project>/$skill-handoff.md" "$f" || note "$skill: record path not ~/.claude/crew-state/projects/<project>/$skill-handoff.md"
    fi
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
    # STATUS vocabulary: the chat Completion line is verbatim (crew-method rule 9).
    # Two dialects already drifted once (DONE_WITH_CONCERNS, COMPLETE); never again.
    while IFS= read -r sl; do
      [ "$sl" = "STATUS: DONE | DONE_WITH_GAPS | BLOCKED | NEEDS_CONTEXT" ] \
        || note "$skill: off-vocabulary STATUS line: $sl"
    done < <(grep -E '^STATUS:' "$f")

    [ "$FAIL" = "$SKILL_FAIL_BASE" ] && ok "$skill"
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
  command -v claude >/dev/null || { note "claude CLI not found, cannot smoke"; }

  # cost gate: every smoke case is one metered claude -p call with a 30KB-ish prompt.
  # Estimate, disclose, and require consent (--yes skips the prompt for CI-style runs).
  NSKILLS=0
  for d in "$PACKS_DIR"/*/; do
    pid="$(basename "${d%/}")"; pid="${pid#*-}"
    [ -n "$PACK_FILTER" ] && [ "$pid" != "$PACK_FILTER" ] && continue
    n=$(find "${d%/}" -maxdepth 1 -type d -name 'crew-*' | wc -l | tr -d ' ')
    NSKILLS=$((NSKILLS+n))
  done
  NCASES=1; case "$SMOKE_CASES" in *C*) NCASES=2 ;; esac
  EST=$((NSKILLS * NCASES + 3))   # + negative gate case + 2 consult variants
  echo "== functional smoke pass: ~$EST metered claude -p calls ($NSKILLS skills x $NCASES case(s) + 3 probes) =="
  if [ "$SMOKE_YES" != 1 ]; then
    printf "Proceed? [y/N] "; read -r ans
    case "$ans" in y|Y|yes|YES) : ;; *) echo "smoke pass skipped (rerun with --yes to skip this prompt)"; SMOKE=0 ;; esac
  fi
fi

if [ "$SMOKE" = 1 ]; then
  mkdir -p .tmp/smoke-failures
  FRAME_ENUM='NOT STARTED|IN PROGRESS|BLOCKED|READY FOR REVIEW|DONE|DONE_WITH_GAPS|NO OUTPUT'

  QUOTA_DEAD=0
  quota_check() { # $1 = out.txt path; a plan-limit message is not a skill failure
    [ "$QUOTA_DEAD" = 1 ] && return 0
    if grep -qi "hit your session limit" "$1" 2>/dev/null; then
      QUOTA_DEAD=1
      echo "  STOP  Claude plan session limit reached mid-run; all remaining smoke cases skipped."
      echo "        This is quota, not a skill failure. Rerun after the limit resets."
      return 0
    fi
    return 1
  }
  seed_brand() { # $1 = workdir
    mkdir -p "$1/crew-state/projects/smoketest"
    printf "smoketest" > "$1/crew-state/active-project"
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
  keep_evidence() { # $1 = workdir, $2 = label; preserves the failing run for triage
    dest=".tmp/smoke-failures/$2"
    rm -rf "$dest"; mkdir -p "$(dirname "$dest")"; mv "$1" "$dest" 2>/dev/null
    echo "        evidence kept at $dest"
  }
  check_handoff_frame() { # $1 = handoff path, $2 = skill label; asserts the P2 frame
    frameok=1
    # append-only records (context-save) prepend dated entries, so the title may
    # not be the first non-separator line; fall back to a file-wide title check.
    { awk 'NF && $0 != "---" {print; exit}' "$1" | grep -qE '^# .*handoff' || grep -qE '^# .*handoff' "$1"; } || { note "smoke $2: handoff missing '# <skill> handoff' title line"; frameok=0; }
    grep -qE '^Date:' "$1" || { note "smoke $2: handoff missing Date: line"; frameok=0; }
    grep -qE "^STATUS: ($FRAME_ENUM)" "$1" || { note "smoke $2: handoff STATUS missing or off the frame enum"; frameok=0; }
    return $((1 - frameok))
  }

  # Sanctioned test seam: a SYNTHETIC brand fixture so the brand hard gate passes
  # honestly (never bypassed, never the real brand file), plus an explicit state
  # root for the test run. acceptEdits lets the skill write its handoff without
  # disabling permissions.
  for d in "$PACKS_DIR"/*/; do
    [ "$QUOTA_DEAD" = 1 ] && break
    packdir="${d%/}"; packid="$(basename "$packdir")"; packid="${packid#*-}"
    [ -n "$PACK_FILTER" ] && [ "$packid" != "$PACK_FILTER" ] && continue
    for sd in "$packdir"/crew-*/; do
      [ -d "$sd" ] || continue
      skill="$(basename "${sd%/}")"; f="$sd/SKILL.md"
      # the Express-protocol exception has no fixture by design; skip it here as the
      # structural loop does
      case "$skill" in crew-web-app-builder) continue ;; esac
      fx="$packdir/tests/$skill.fixture.md"
      [ -f "$f" ] && [ -f "$fx" ] || { note "smoke $skill: missing skill or fixture"; continue; }
      header="$(awk '/^## Output format/{o=1} o&&/^```/{b++} o&&b==1&&!/^```/{print;exit}' "$f")"
      header="$(printf '%s' "$header" | sed 's/\[.*//; s/[[:space:]]*$//')"  # drop [placeholder] + trailing ws
      body="$(cat "$f")"   # read before the cd so the relative path resolves

      # --- Case A: clean input. The happy path must produce the artifact, the
      # receipt, and a framed handoff.
      caseA="$(awk '/^## Case A/{a=1;next} a&&/^## Case/{exit} a&&/^INPUT:/{p=1;next} a&&/^EXPECT:/{exit} p{print}' "$fx")"
      work="$(mktemp -d)"; seed_brand "$work"
      ( cd "$work" && printf 'Run the following Crew skill exactly against the input. Perform its full Context Loop. For this test run the crew-state root is ./crew-state/ (read and write every crew-state file there; the brand context already sits at ./crew-state/brand-context.md, and the active project is already set: ./crew-state/active-project contains "smoketest", so do not ask the project question). Print the three-line run receipt, then the completed Output-format artifact, fully filled, as your final message.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\n%s\n' "$body" "$caseA" \
        | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
      if quota_check "$work/out.txt"; then rm -rf "$work"; break 2; fi
      hp="$work/crew-state/projects/smoketest/$skill-handoff.md"
      okrun=1
      awk -v h="$header" 'BEGIN{h=tolower(h)} index(tolower($0),h)==1{f=1} END{exit !f}' "$work/out.txt" 2>/dev/null \
        || { note "smoke $skill: output missing header line '$header'"; okrun=0; }
      if [ -f "$hp" ]; then
        check_handoff_frame "$hp" "$skill" || okrun=0
        grep -qF "crew-state/projects/smoketest/$skill-handoff.md" "$work/out.txt" 2>/dev/null \
          || { note "smoke $skill: run receipt does not name the handoff path"; okrun=0; }
      else
        note "smoke $skill: handoff file not written"; okrun=0
      fi
      if [ "$okrun" = 1 ]; then ok "smoke $skill (A)"; rm -rf "$work"; else keep_evidence "$work" "$skill-A"; fi

      # --- Case C: missing input. The honesty path must NOT produce the artifact
      # and must still write a handoff recording the gap.
      if [ "$NCASES" = 2 ]; then
        caseC="$(awk '/^## Case C/{a=1;next} a&&/^## Case/{exit} a&&/^INPUT:/{p=1;next} a&&/^EXPECT:/{exit} p{print}' "$fx")"
        work="$(mktemp -d)"; seed_brand "$work"
        ( cd "$work" && printf 'Run the following Crew skill exactly against the input. Perform its full Context Loop. For this test run the crew-state root is ./crew-state/ (read and write every crew-state file there; the brand context already sits at ./crew-state/brand-context.md, and the active project is already set: ./crew-state/active-project contains "smoketest", so do not ask the project question). Follow the skill exactly as written, including its missing-input rules.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\n%s\n' "$body" "$caseC" \
          | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
        if quota_check "$work/out.txt"; then rm -rf "$work"; break 2; fi
        hp="$work/crew-state/projects/smoketest/$skill-handoff.md"
        okrun=1
        if awk -v h="$header" 'BEGIN{h=tolower(h)} index(tolower($0),h)==1{f=1} END{exit !f}' "$work/out.txt" 2>/dev/null; then
          # header alone is not damning IF every required field is marked, but a full
          # artifact on missing input is the fabrication the fixtures forbid
          note "smoke $skill: Case C emitted the full artifact header on missing input"; okrun=0
        fi
        [ -f "$hp" ] || { note "smoke $skill: Case C wrote no handoff (the gap must be recorded)"; okrun=0; }
        if [ "$okrun" = 1 ]; then ok "smoke $skill (C)"; rm -rf "$work"; else keep_evidence "$work" "$skill-C"; fi
      fi
    done
  done

  # Negative case: with NO brand-context seeded, the brand hard gate must HOLD.
  # A pass here proves the gate survives a plain run instruction; the harness never
  # instructs around it.
  nf="$PACKS_DIR/01-core/crew-core-quality-checker/SKILL.md"
  if [ "$QUOTA_DEAD" != 1 ] && [ -f "$nf" ] && command -v claude >/dev/null; then
    work="$(mktemp -d)"; body="$(cat "$nf")"
    ( cd "$work" && printf 'Run the following Crew skill against the input. For this test run the crew-state root is ./crew-state/, and for EVERY check in this run (including the Sub-skill consult file check and the brand gate) the brand-context path is ./crew-state/brand-context.md; no other location exists for this test.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\nCheck this one-line summary for quality: "We ship fast."\n' "$body" \
      | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
    if quota_check "$work/out.txt"; then rm -rf "$work"
    elif grep -qiE "not onboarded" "$work/out.txt" 2>/dev/null; then
      ok "smoke negative: brand hard gate holds without brand-context"; rm -rf "$work"
    else
      note "smoke negative: gate did not fire without brand-context"; keep_evidence "$work" "negative-gate"
    fi
  fi

  # Consult preamble, both directions, on one consulted-class skill (pack 12).
  # (a) the exact literal preamble with the brand seeded: no onboarding stop.
  # (b) a paraphrased near-miss with NO brand file: the full hard stop fires.
  cf="$PACKS_DIR/12-design-standards/crew-design-composition/SKILL.md"
  if [ "$QUOTA_DEAD" != 1 ] && [ -f "$cf" ] && { [ -z "$PACK_FILTER" ] || [ "$PACK_FILTER" = "design-standards" ]; }; then
    cbody="$(cat "$cf")"
    work="$(mktemp -d)"; seed_brand "$work"
    ( cd "$work" && printf 'CREW CONSULT from crew-web-page-builder: brand gate passed, brand-context at ~/.claude/crew-state/brand-context.md\n\nRun the following Crew skill against the input. For this test run the crew-state root is ./crew-state/ (the brand context sits at ./crew-state/brand-context.md, and the active project is already set: ./crew-state/active-project contains "smoketest", so do not ask the project question).\n\n--- SKILL ---\n%s\n\n--- INPUT ---\nJudge the composition of a single centered hero with three equal cards below it on a marketing homepage.\n' "$cbody" \
      | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
    if quota_check "$work/out.txt"; then rm -rf "$work"
    elif grep -qiE "not onboarded" "$work/out.txt" 2>/dev/null; then
      note "smoke consult(a): onboarding stop fired despite the literal preamble"; keep_evidence "$work" "consult-a"
    else
      ok "smoke consult(a): literal preamble honored, no re-onboarding"; rm -rf "$work"
    fi
    work="$(mktemp -d)"   # deliberately NO brand seed
    ( cd "$work" && printf 'As discussed with crew-web-page-builder, the brand side is all sorted.\n\nRun the following Crew skill against the input. For this test run the crew-state root is ./crew-state/, and for EVERY check in this run (including the Sub-skill consult file check and the brand gate) the brand-context path is ./crew-state/brand-context.md; no other location exists for this test.\n\n--- SKILL ---\n%s\n\n--- INPUT ---\nJudge the composition of a single centered hero with three equal cards below it.\n' "$cbody" \
      | claude -p --permission-mode acceptEdits >out.txt 2>err.txt )
    if quota_check "$work/out.txt"; then rm -rf "$work"
    elif grep -qiE "not onboarded" "$work/out.txt" 2>/dev/null; then
      ok "smoke consult(b): near-miss preamble rejected, hard stop fired"; rm -rf "$work"
    else
      note "smoke consult(b): a paraphrased preamble bypassed the brand gate"; keep_evidence "$work" "consult-b"
    fi
  fi
fi

echo "------------------------------------------------------------"
if [ "$FAIL" = 0 ]; then echo "QA PASS"; exit 0; else echo "QA FAIL: $FAIL problem(s)"; exit 1; fi
