# Post-call webhook field map

Maps the voice platform's end-of-call webhook onto the Post-call payload schema (claude.md). Build this as a Make or Zapier scenario, or your platform's native webhook.

## Trigger

The ElevenLabs post-call webhook fires on hang-up (enable it in the agent settings). ElevenLabs sends a POST with the conversation transcript, an analysis summary, and the tool-call results.

## Field mapping

| Payload field   | Source in the webhook body                                  |
| --------------- | ----------------------------------------------------------- |
| call_id         | body.conversation_id                                        |
| summary         | body.analysis.summary (or generate one line from transcript)|
| outcome         | derive: booking tool called -> "booking"; message captured -> "message"; only FAQ -> "answered_only"; hang-up early -> "abandoned" |
| transcript      | body.transcript (full turn-by-turn text)                    |
| record          | booking or message fields captured by the tools             |
| sms_sent        | true if send_sms tool fired                                 |
| delivered_to    | ["owner_email", "owner_sms"] as configured                  |

## Scenario steps (no-code)

1. Webhook trigger (paste the URL into the platform's webhook setting).
2. Optional 5 second delay (lets tool results settle).
3. Router by `outcome`:
   - booking: email owner + add calendar/CRM row + send customer SMS (booking details).
   - message: email owner (mark Urgent/Emergency in the subject) + optional CRM row + send customer SMS (callback promise) if a callback was agreed.
   - answered_only: log only.
   - abandoned: log only, optional owner heads-up if a number was captured.
4. Dedupe on `call_id` so retries do not double-send.
5. Append one row to the weekly log: date, from_number, outcome, booked_value_estimate.

## Owner email template

Subject: [<<Business>>] <<outcome>> - <<summary>>

Body:
- Outcome: <<outcome>>
- Customer: <<name>> <<number>>
- Detail: <<reason or service + slot>>
- Urgency: <<urgency>>
- Full transcript below.
