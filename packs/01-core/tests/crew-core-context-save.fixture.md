# Fixture: crew-core-context-save

## Case A: clean
INPUT:
Project "Northwind billing", pack "core". End of an evening session. Active task: adding idempotency keys to the POST /charges handler so retries do not double-charge. Status: work begun, not finished. Decisions made this session: use the client-sent Idempotency-Key header rather than a server-generated key (the client already sends one on retry), and store keys in the existing charges table rather than a new one (avoids a migration this week). Remaining: a new test test_duplicate_charge_is_ignored returns 500 instead of 200 and must pass, then add a 24h expiry sweep (blocked on confirming retention with finance). Files touched: billing/charges.py (added the key check, conflict path not handled yet), tests/test_charges.py (new failing test). Known risk: no index on the idempotency_key column yet. The handler reads a database URL from an environment variable.

EXPECT:
- Output is a CONTEXT SAVE block with Project, Pack, Saved date, and a "Most important next" line naming the half-done idempotency change.
- Active task stated specifically; Status set to IN PROGRESS from the enum.
- Both decisions captured as one-liners with their Why.
- Remaining work listed in order, with item 2 marked "Blocked on: ... finance" retention.
- Known risk recorded as the no-index point, Type TECH DEBT; the 24h assumption labelled ASSUMPTION.
- Key files listed with state markers (partial, new).
- No secret or credential is written into the note. The database URL is referenced only by where it lives (the environment variable), never as a value.
- Step 0 states first-run or recovered; Final Step appends (does not overwrite) to ~/.claude/crew-state/core/crew-core-context-save-handoff.md and the file is written.
- No em dashes anywhere.

## Case B: messy
INPUT:
Long rambling session. User says "we did a bunch of stuff, save it". The diff shows changes in auth/login.py and a deleted file utils/old_token.py, but the user also said earlier "do not delete old_token yet, I am not sure". They mention they "decided to use JWTs" but two messages later say "actually maybe sessions, we will see". No clear project name given; the repo folder is "atlas-portal". One TODO comment in login.py reads "FIXME refresh path untested".

EXPECT:
- Project inferred as "atlas-portal" and labelled "Inferred from repo folder", not asserted as confirmed.
- The JWT-vs-sessions item is NOT recorded as a decision (it was reopened); it goes under Remaining work as an open question, with a note that the choice is unresolved.
- The deleted utils/old_token.py is flagged against the user's "do not delete yet", surfaced as a risk or do-not-touch conflict, not silently accepted.
- The untested refresh path captured as a risk, Type UNTESTED, citing the FIXME comment as source.
- Provenance is labelled: the project name and the inferred status are marked "Inferred from diff" or "Inferred from repo folder", while items the user stated are Given.
- No invented decisions or next steps; status reflects the genuine uncertainty (IN PROGRESS or BLOCKED, with the blocker named).
- Files reconciled against the diff (login.py edited, old_token.py deletion flagged). Handoff appended, not overwritten.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
User says only "save the context" in a fresh session. No transcript of prior work, no diff available, no stated task, no project or pack named.

EXPECT:
- Loop 1 behaviour: names the gap ("I cannot see what was being worked on, no task, diff, or transcript") and asks once, plainly, for "what were you working on".
- If still unavailable, writes the CONTEXT SAVE with Active task, Status, Decisions, Remaining work, Risks, and Key files all marked "Not provided".
- Invents nothing: no fabricated task, decision, file, or next step.
- Pack defaults to core only because it is named in the path, project marked "Not provided".
- Final Step still APPENDS a note (does not overwrite) to ~/.claude/crew-state/core/crew-core-context-save-handoff.md, recording the missing-input gap (for example "No output, inputs not provided, run completed [date]"); the file is written.
- No em dashes anywhere.
