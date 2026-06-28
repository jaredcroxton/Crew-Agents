# Fixture: crew-finance-admin-automation

## Case A: clean
INPUT:
Process walked through end to end. "Every time a supplier emails an invoice PDF to our shared inbox, someone saves it to a Drive folder by supplier, re-keys the four fields into Xero as a draft bill, then chases the approver in Slack for sign-off." Frequencies given: filing and entry ~15/week at 3 and 5 minutes; chasing ~10/week. Tools in use: Gmail, Google Drive, Xero, Slack. No new tool budget.
EXPECT:
- Output header `ADMIN AUTOMATION PLAN` with `Tools in use:` listing the owner's stated tools only (Gmail, Drive, Xero, Slack), none invented.
- Repeated tasks tagged by the taxonomy: Filing, Data entry, Chasing.
- A single `Chosen target:` (the file plus draft-bill flow) with a one-sentence `Why this one:` citing frequency and rules-clarity, and a `Not automating:` line keeping approve-to-pay manual because it needs human judgement.
- `Trigger and action map:` with one `Trigger:` and numbered actions, each naming a specific mechanism with `Needs:` and `Produces:`, and a named `Method:`.
- The draft-bill step is CREATED not paid (segregation: the creator is not the approver), with a `Review gate:` placing a human approve-to-pay before any payment.
- An `Idempotent guard:` so a re-arrived or forwarded copy of the same email does not create a duplicate draft bill (the invoice number as the processed marker).
- An `Audit trail:` note that each automated step records what it did and when, so a wrong or duplicate bill is traceable.
- An `Exception path:` for unreadable fields and a `Fallback:` flagging a named person and leaving the item in a known state. `Escalated: none`.
- The handoff file `~/.claude/crew-state/finance/crew-finance-admin-automation-handoff.md` was written with the chosen target, the review-gate decision, and the idempotency control.
- No em dashes anywhere.

## Case B: messy
INPUT:
"Admin is killing us. We do loads of stuff. Invoices, also reminders to clients, also someone updates the website pricing sometimes, and we copy orders from the form into the spreadsheet. Pricing changes need the founder to decide. We use a form tool and a spreadsheet, not sure which others. No idea how often, maybe a lot." Frequencies and times absent; contradictory note that the website update "is automated already but also done by hand".
EXPECT:
- Frequency and time-per-run shown as `Not provided` rather than guessed, and ranking done on rules-clarity and pain that can be read from the input.
- Tasks still typed: order copy as Data entry, client reminders as Chasing, invoices as (per type), website pricing flagged.
- The pricing change marked low rules-clarity and left manual (`Not automating: ... needs human judgement`), since the founder must decide it.
- Eliminate-before-automate or contradiction handling: the "automated already but also by hand" contradiction surfaced as a flag, not silently resolved; an `Assumed:` note if the skill proceeds. A redundant or should-not-exist step is named under `Eliminated, not automated:` rather than automated.
- No money step is automated without a gate: any invoice or pricing step that moves money or faces a customer carries a review gate, and nothing money-out is wired straight through.
- Chosen target is the high-rules-clarity, repeatable one (form-to-spreadsheet copy), with the reason stated.
- No invented tool names: unknown tools written as `Not provided` or asked, not filled with a brand. Handoff file written noting the open items.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Can you find what we should automate? Our admin is a mess." No task list, no process walkthrough, no tools, no frequencies.
EXPECT:
- Loop 1 behaviour: names the gap plainly (no task list or process walked through, so the repeat work cannot be located) and asks once for one concrete process from start to finish.
- Does not produce a plan with invented tasks, tools, frequencies, or savings; nothing fabricated.
- Any frequency or tool field that would appear is marked `Not provided`.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, so an empty scaffold is not mistaken for a real plan.
- The handoff file `~/.claude/crew-state/finance/crew-finance-admin-automation-handoff.md` is still written, recording the missing input and the one question asked ("No output, run completed [date]" if nothing was produced).
- No em dashes anywhere.
