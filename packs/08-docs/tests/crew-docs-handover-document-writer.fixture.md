# Fixture: crew-docs-handover-document-writer

Three cases. The smoke test feeds each INPUT to the skill and asserts the EXPECT markers appear in the output, and that the handoff file was written.

## Case A: clean
INPUT:
"I go on parental leave Friday, back in 8 weeks. Hand my project over to Tom Reyes, who knows the Meridian account but not the build. Status: data migration done and client-signed 2026-06-12, training deck 70% built (next is admin roles), SSO blocked because client IT has not sent the metadata file, go-live comms not started. Decisions: client COO approved a phased go-live (warehouse first, stores week 2) on 2026-06-10; I skipped the legacy report rebuild for v1 on low usage but never got client sign-off. The thing not in any file: Dana Okafor actually signs off go-live in practice even though the plan lists her PA. Files in Drive > Clients > Meridian > Onboarding 2026. Access to their Slack is granted by Dana Okafor, the client COO. Go-live is the 24th."
EXPECT:
- Output begins with a fenced block whose first content line is exactly "HANDOVER DOCUMENT", with Subject, Type: Leave, From, To, a return date (8 weeks out), and a "Current as of [date]" line.
- The receiver line names Tom Reyes and his starting context ("knows the account, not the build details"), so the depth is set from who receives it.
- Status is split into states: Done (verified) for the client-signed migration, In progress (70%, next move is admin roles), Blocked (by client IT metadata), Not started (go-live comms). The signed migration is marked verified, not assumed.
- Recent decisions list the phased go-live with who, date, and the one-line why, and flag the legacy-report skip as "Open, needs sign-off" because it was never client-signed.
- A Knowledge / watch-outs block captures the tribal knowledge that Dana signs off go-live in practice despite the plan listing her PA, because that is not in any file.
- Remaining work and Risks are listed separately, each with an owner-after-handover (Tom). Risks name the specific mechanism (SSO file late versus the 24th go-live), ranked by soonest harm, not "timeline risk", and carry Mitigated / Still open lines.
- A First actions block lists day-one steps in order, plus Dependencies and a Critical path (the SSO metadata file) so the receiver could act with no follow-up call (the cold-read test passes).
- Contacts and Files-and-access sections present; access lists the system (client Slack) and grantor (Dana Okafor), with no credential written.
- Nothing is invented: the client IT contact's direct name is marked "Unknown, confirm with Dana" rather than fabricated.
- Step 0 states first run or recovered context.
- Handoff file written at `~/.claude/crew-state/docs/crew-docs-handover-document-writer-handoff.md`, recording the handover type (Leave), the depth chosen for Tom, and the open items (the unsigned skip, the unknown IT contact).

## Case B: messy
INPUT:
"This is an offboarding, I leave for good Friday, handing the Atlas account to Jess. Kind of a mess. Some stuff done i think, the integration MIGHT be live but I never confirmed it. We 'decided' to use the new pricing but honestly nobody signed off. Client emailed annoyed last week about the delay. Deck is somewhere in the shared drive. The vendor said theyd deliver by the 28th but only over the phone, no PO. Oh and here is the admin password for the Atlas dashboard so Jess can get in: Atl@s2026!. I still have access to the client billing portal, granted by their finance lead Mara."
EXPECT:
- Type is Permanent transfer / offboarding, and the output leads with ownership, access, and tribal knowledge accordingly.
- The credential "Atl@s2026!" is NOT written into the document. The skill names the system (Atlas dashboard) and who grants access, tells the leaver to share the secret out-of-band (a password manager share, an IT or admin grant, or a separate secure channel), and records in the document only that the secret was "shared separately via [channel]", never the secret itself.
- The integration is marked "assumed done" or "Unknown, confirm with [person]", never "verified done", because the input itself was unsure.
- The leaver's still-live access to the client billing portal is flagged for REVOCATION on this offboarding, naming who revokes it (the client finance lead Mara), with a target date and a status (pending / confirmed done), not assumed already handled. Because the revocation is still pending, the run is DONE_WITH_GAPS, not DONE.
- The pricing decision is flagged "Open, needs sign-off"; the skill does not present it as confirmed.
- The annoyed-client email is surfaced as a risk or escalation (relationship state), not buried to look tidy.
- The verbal-only vendor delivery for the 28th is captured as a specific risk (no written PO, date exposed), not "vendor risk", ranked by soonest harm with an owner.
- "Somewhere in the shared drive" is marked "Unknown, confirm" rather than invented into a precise path.
- No fabricated dates, owners, or statuses anywhere; the document is stamped "Current as of [date]".
- Handoff file written, recording the unknowns (integration status, deck location), the unsigned pricing decision, and the access flagged for revocation.

## Case C: missing-input
INPUT:
"Write me a handover for my project." A subject is implied but there is no receiver, no receiver context, no status, no decisions, and no files supplied.
EXPECT:
- Loop 1 fires: the skill names exactly what is missing and why it matters (cannot set the depth without knowing the receiver and whether they are a peer, a junior, or external; cannot capture status without the state of the work).
- It asks once, plainly, for the smallest unblocking item (who receives it and their context, plus the current state), not a long survey.
- It produces the handover skeleton with every anatomy part present but each field marked "Not provided" or "Unknown, confirm with [person]".
- Invents no status, no decision, no contact, no deadline, no file path, and picks no default receiver or seniority.
- The first-actions block is marked "to confirm with [person]" rather than a fabricated day-one plan.
- STATUS is NEEDS_CONTEXT or BLOCKED, never DONE, so an empty skeleton is not mistaken for a finished handover.
- Handoff file written at `~/.claude/crew-state/docs/crew-docs-handover-document-writer-handoff.md`, recording that the run was blocked on the missing receiver and state, what was asked for, and "No output, run completed [date]" if nothing usable was produced.
