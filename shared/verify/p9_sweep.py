#!/usr/bin/env python3
"""P9 sweep: Projects memory model across every SKILL.md plus the template.

Replaces the one-handoff-per-skill Step 0 / Final Step machinery with the
project-scoped model (Loop 4 in shared/crew-method.md):
  A. Step 0: drop the automatic own-handoff read; add the lessons-file read,
     the project question, project-scoped recovery, and project-scoped chain.
  B. Final Step: write the record into the active project; copy-forward scoped
     to the same project; add the Loop 5 lesson offer.
  C. Discovery "continuing" bullet: route through context-restore / a named
     project instead of the fixed handoff path.
  D. Governed-mode cross-reference: prior records in this project, not a pack
     folder scan.
  E. Verification checklist path line.

Idempotent (sentinel: "projects/" in the Final Step write), per-pattern
counters, and a per-file unmatched report so nothing is silently skipped.
Run from the repo root."""
import pathlib, re, sys

ROOT = pathlib.Path("packs")
if not ROOT.is_dir():
    sys.exit("run from the repo root")

targets = sorted(ROOT.glob("*/crew-*/SKILL.md")) + [pathlib.Path("shared/SKILL-TEMPLATE.md")]

# ---------- replacement builders ----------

def step0_block(skill):
    return (
        'Next, read this skill\'s lessons file at `~/.claude/crew-state/lessons/'
        f'{skill}-lessons.md` if it exists, and apply every lesson in it as a standing rule for this run. '
        'Then settle the project (Loop 4): if the request does not already answer it, ask once: '
        '"Is this a new project, or are we continuing an existing one?" For a NEW project, take a short '
        'name from the request or ask for one ("websites", "learnos", a client name all work), create '
        '`~/.claude/crew-state/projects/<project>/`, write the name to `~/.claude/crew-state/active-project`, '
        'and start from zero: the brand context and the lessons file are the whole context, read nothing else. '
        'For CONTINUING, the user runs `crew-core-context-restore` first (or names the project): read the '
        '`~/.claude/crew-state/active-project` pointer, then ONLY this skill\'s own record at '
        f'`~/.claude/crew-state/projects/<project>/{skill}-handoff.md`; state what was recovered and its date, '
        'and if it is older than the artifacts it references, treat it as possibly stale and verify against '
        'the live files before relying on it. If the record does not exist in that project, state "No prior '
        'record in this project for this skill." Records in other projects, and legacy handoffs from before '
        'the Projects model, are never read automatically. (Loop 4, Context Change.) If this run was chained '
        'from an upstream skill, also read only the records of the skills this skill\'s Handoffs section names '
        'as sources, from the same active project, at most two files; state what was inherited, and record '
        '"Consumed: [upstream skill] record dated [date]" in this run\'s own record. If a named upstream record '
        'does not exist in the project, proceed without comment. Never scan outside the active project outside '
        'Governed mode.'
    )

def finalstep_open(skill):
    return (
        'Confirm the active project: read `~/.claude/crew-state/active-project`; if no project was named this '
        'run, ask for a short name now and write the pointer. Run `mkdir -p '
        '~/.claude/crew-state/projects/<project>`, then write '
        f'`~/.claude/crew-state/projects/<project>/{skill}-handoff.md` with:'
    )

LESSON_OFFER = (
    ' If this run captured a durable way-of-working lesson (not a project or brand fact), offer once: '
    '"Want me to save this lesson so it never happens again?" On yes, append one dated bullet (what went '
    'wrong, what to do instead) to `~/.claude/crew-state/lessons/<skill>-lessons.md`, creating the file if '
    'absent; it is read at every Step 0 and never leaves this machine (Loop 5, the lesson offer).'
)

COPYFWD_OLD = ('When rewriting an existing handoff, carry forward every prior Learned note and any unresolved '
               'Escalated or Not-provided item; a rewrite must never erase a lesson or an open flag.')
COPYFWD_NEW = ('When rewriting an existing record in the same project, carry forward every prior Learned note '
               'and any unresolved Escalated or Not-provided item; a rewrite must never erase a lesson or an '
               'open flag. Records in other projects are other work: never merged into this one and never '
               'overwritten by it.')

FRAMECHECK = ('After a successful write, re-read the file and confirm the frame is present (the title line, '
              'the Date line, and a STATUS from the sanctioned list); fix it before finishing if not.')

counts = {k: 0 for k in ["step0", "final_open", "copyfwd", "lesson", "discovery", "governed", "checklist"]}
unmatched = []

for f in targets:
    t = f.read_text()
    orig = t
    skill = f.parent.name if f.name == "SKILL.md" else "<skill>"
    hits = {}

    # A. Step 0 span: from the "handoff directory is empty" sentence through "Never scan the folder outside Governed mode."
    a = re.compile(
        r'If the brand context exists but this skill\'s handoff directory is empty.*?'
        r'Never scan the folder outside Governed mode\.',
        re.S)
    t, n = a.subn(step0_block(skill), t, count=1)
    hits["step0"] = n

    # B1. Final Step opener (mkdir + write path), preserving the per-skill content list after "with:"
    b1 = re.compile(
        r'Run `mkdir -p ~/\.claude/crew-state/[a-z0-9-]+`, then write '
        r'`~/\.claude/crew-state/[a-z0-9-]+/[a-z0-9-]+-handoff\.md` with:')
    t, n = b1.subn(finalstep_open(skill), t, count=1)
    # template variant
    if n == 0:
        b1t = re.compile(r'Write `~/\.claude/crew-state/<pack>/<skill>-handoff\.md` \(mkdir -p first\) with:')
        t, n = b1t.subn(finalstep_open(skill).replace('Run `mkdir -p', 'Write (mkdir -p first) `').replace('`, then write ', ' -> '), t, count=1) if False else (t, n)
        # keep template handled by the plain-path pass below instead
    hits["final_open"] = n

    # B2. copy-forward scoping
    t, n = (t.replace(COPYFWD_OLD, COPYFWD_NEW, 1), 1 if COPYFWD_OLD in t else 0)
    hits["copyfwd"] = n

    # B3. lesson offer, inserted right after the frame self-check sentence
    if FRAMECHECK in t and "save this lesson so it never happens again" not in t:
        t = t.replace(FRAMECHECK, FRAMECHECK + LESSON_OFFER.replace("<skill>", skill), 1)
        hits["lesson"] = 1
    else:
        hits["lesson"] = 0

    # C. Discovery continuing bullet: fixed-path read -> restore/named project
    c = re.compile(
        r'Read this skill\'s own handoff at `~/\.claude/crew-state/[a-z0-9-]+/[a-z0-9-]+-handoff\.md`')
    t, n = c.subn('Run `crew-core-context-restore` (or name the project) and read this skill\'s record in that project', t)
    hits["discovery"] = n

    # D. Governed cross-reference: pack-folder scan -> this project
    d = re.compile(
        r'cross-reference against prior ([a-z-]+ )?handoffs in `~/\.claude/crew-state/[a-z0-9-]+/`')
    t, n = d.subn('cross-reference against prior records in this project (`~/.claude/crew-state/projects/<project>/`)', t)
    hits["governed"] = n

    # E. Verification checklist path line
    e = re.compile(r'handoff was written to ~/\.claude/crew-state/[a-z0-9-]+/[a-z0-9-]+-handoff\.md')
    t, n = e.subn(f'record was written into the active project (~/.claude/crew-state/projects/<project>/{skill}-handoff.md)', t)
    hits["checklist"] = n

    # any leftover fixed-path handoff references (report, do not auto-edit)
    leftover = re.findall(r'~/\.claude/crew-state/(?!brand-context|projects|lessons|active-project|brands)[a-z0-9-]+/[a-z0-9-]+-handoff\.md', t)

    if t != orig:
        f.write_text(t)
    for k, v in hits.items():
        counts[k] += v
    if hits["step0"] == 0 or hits["final_open"] == 0 or leftover:
        unmatched.append((str(f), hits, leftover[:3]))

print("targets:", len(targets))
for k, v in counts.items():
    print(f"  {k:11} {v}")
print("files needing manual attention:", len(unmatched))
for path, h, left in unmatched:
    print(f"  {path}  hits={h}  leftover={left}")

# ---------- pass 2: Handoffs-section paths + generic Discovery bullet ----------
# (appended after first run; idempotent, run the file again)

# ---------------------------------------------------------------------------
# Passes 2-4, run after the main loop above (all idempotent). Recorded here
# because they were applied as part of the same P9 sweep:
#
# PASS 2 (applied to every non-cabinet skill; cabinet = brand-context,
# context-save, context-restore, using-crew, which are hand-authored):
#   F. re.sub(r'~/\.claude/crew-state/(?!brand-context|projects|lessons|'
#             r'active-project|brands)[a-z0-9-]+/([a-z0-9-]+)-handoff\.md',
#             r'~/.claude/crew-state/projects/<project>/\1-handoff.md', t)
#      -> Handoffs-section and cross-skill path references, 45 hits.
#   G. "I read this skill's handoff and pick up where we left off." ->
#      "run `crew-core-context-restore` (or name the project) and I read this
#       skill's record in that project, picking up where we left off."
#      -> generic Discovery continuing bullets, 43 hits.
#
# PASS 3: r'The handoff was written to ~/\.claude/crew-state/(?!projects)'
#         r'[a-z0-9-]+/' -> 'The record was written into the active project
#         (~/.claude/crew-state/projects/<project>/)' -> 71 checklist lines.
#
# PASS 4: any remaining bare '~/.claude/crew-state/<pack>/' directory
#         reference -> '~/.claude/crew-state/projects/<project>/' with
#         'prior handoffs in' tidied to 'prior records in this project',
#         10 files (plan-mode reads, Governed prose variants).
#
# Final state: zero references to the old per-pack record locations outside
# the four cabinet skills and the method's own Legacy rule.
