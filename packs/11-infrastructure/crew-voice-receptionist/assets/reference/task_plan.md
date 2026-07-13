# task_plan.md - AI Phone Receptionist (Australia)

## Goal

Ship a no-code AI phone receptionist for an Australian small business that answers missed calls on the business's existing number, sounds A-class, answers common questions from a knowledge base, books appointments, takes structured messages, and delivers a transcript plus SMS confirmation after every call. The build must be reproducible by a non-technical operator following this blueprint.

## Phases (B.L.A.S.T.)

1. Blueprint: lock the business inputs, the voice persona, and the data schemas.
2. Link: rent the number, connect the voice platform, verify each external service responds.
3. Architect: build the five SOPs (divert, voice agent, booking, post-call, compliance).
4. Stylize: tune the voice and the script, format the transcript and SMS payloads, get sign-off.
5. Trigger: set the call divert live on the business number, hand over the run and maintenance docs.

## Express Checklist

### Phase 1: Blueprint
- [x] Taste bundle loaded (design direction: clean, trustworthy, brand-matched client doc)
- [x] Memory files initialised (claude.md, task_plan.md, findings.md, progress.md)
- [x] Discovery captured from the business inquiry (see claude.md North Star + worked example)
- [x] Data schema locked in claude.md (call event, booking, message, post-call payload)
- [x] Research logged in findings.md (platforms, costs, divert codes, AU compliance)

### Phase 2: Link
- [ ] Twilio (or Telnyx) AU local number provisioned
- [ ] ElevenLabs Agents connected with the Twilio number imported
- [ ] Booking calendar connected (cal.com or Google Calendar)
- [ ] SMS sender verified (Twilio Send Text tool)
- [ ] Post-call webhook receiver live (Make/Zapier scenario or email endpoint)

### Phase 3: Architect
- [ ] SOP 01 Telephony + Divert written and number pointed at the agent
- [ ] SOP 02 Voice Agent (persona, knowledge base, guardrails) built
- [ ] SOP 03 Booking tool wired and tested end to end
- [ ] SOP 04 Post-call payload (transcript + summary + SMS) delivering
- [ ] SOP 05 Compliance (AI disclosure + recording consent) in the greeting

### Phase 4: Stylize
- [ ] AU-accent voice selected and latency acceptable (< 1 s to first word)
- [ ] Script and knowledge base tuned against 10 test calls
- [ ] Transcript email and SMS templates formatted and approved by the business

### Phase 5: Trigger
- [ ] Conditional call divert set on the business number (no-answer after 15 s)
- [ ] Live proof call passed (answer, FAQ, booking, transcript, SMS)
- [ ] Maintenance log written in claude.md, run + rotate-keys steps documented
