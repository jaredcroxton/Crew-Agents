# SOP 03 - Booking

## Goal

Turn an intent to book into a real appointment in the business calendar, during the call, with a confirmation the customer can trust.

## Input

- The booking calendar (cal.com free tier, or the business Google Calendar).
- The Booking tool schema (tools/tool-schemas.json, `check_availability` and `create_booking`).
- Service list and trading hours from the business profile.

## Tool logic

1. In the platform, add two tools that call the calendar:
   - `check_availability(service, date_window)` returns real open slots.
   - `create_booking(...)` writes the appointment and returns a confirmation id.
2. Wire the tools to the calendar. cal.com: use its API key and event-type id. Google Calendar: connect via the platform's native Google integration or a Make/Zapier action.
3. In the prompt, the agent may only offer slots returned by `check_availability`. It never invents a time.
4. On confirm, the agent calls `create_booking` with the fields in the Booking record schema, then reads back the day, time and address.
5. The booking triggers the customer SMS confirmation in SOP 04.

## Output

A Booking record (claude.md schema) with status "booked", a real calendar event, and the trigger for the confirmation SMS.

## Edge cases and failure modes

- No slot in the window the customer wants: offer the nearest two real alternatives; if none suit, fall through to a message-take (SOP 02) with urgency and preferred callback.
- Double-booking race: `create_booking` must be the source of truth; if it returns a conflict, re-run `check_availability` and re-offer.
- Wrong service mapping: the `service` field must match business_profile.services. If the caller's words do not map, ask one clarifying question, do not guess.
- Calendar API down: hold the details as a message record marked urgency "Urgent" so the owner books it manually. Never tell the customer it is booked when it is not.
- Address captured wrong: read the address back and confirm before writing.
