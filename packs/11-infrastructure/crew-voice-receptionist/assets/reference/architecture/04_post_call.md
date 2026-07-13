# SOP 04 - Post-call Payload

## Goal

Within 60 seconds of hang-up, put a one-line summary, the outcome, the full transcript and the captured record in the owner's inbox, and send the customer a confirmation SMS when a booking or callback was promised.

## Input

- The ElevenLabs post-call webhook (enabled in the agent settings).
- A webhook receiver: a Make or Zapier scenario, or a simple email endpoint.
- The Twilio Send Text tool for the customer SMS.
- The Post-call payload schema (claude.md).

## Tool logic

1. Turn on the ElevenLabs post-call webhook in the agent settings. It POSTs the transcript, an analysis summary and any tool-call results on hang-up.
2. Map the webhook fields onto the Post-call payload schema (tools/webhook-map.md).
3. Route the payload:
   - Email the owner the summary, outcome, record and transcript.
   - Optionally push the record into the CRM (HubSpot, a Google Sheet, or the business's existing system) as a new row or contact.
4. Fire the customer SMS via the Twilio Send Text tool when outcome is "booking" (booking details) or when a callback was promised ("Thanks, <<business>> will call you back <<window>>").
5. Log the call outcome for the weekly owner report (calls answered, booked, messages, missed-to-saved).

## Output

Owner receives the payload in under 60 seconds. Customer receives an SMS confirmation when relevant. One row added to the running log.

## Write path

Platform webhook -> Make/Zapier scenario -> (a) owner email, (b) CRM/Sheet row, (c) Twilio SMS to customer. All three are no-code steps in the scenario builder.

## Edge cases and failure modes

- Webhook fires before a tool result is ready: add a 5 s delay step in the scenario, or read the booking id from the final transcript.
- SMS to a landline caller: skip the SMS, email the owner to call back instead.
- Duplicate webhooks (platform retries): dedupe on call_id in the scenario.
- PII in transcripts: store securely, limit retention, do not forward to any address not owned by the business. See SOP 05.
- Owner email in spam: send from an authenticated domain, or deliver to a dedicated inbox / Slack channel.
