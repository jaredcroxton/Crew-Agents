# Build walkthrough (agent-guided, for a non-coder)

This is a driver script. An AI app builder (Claude Code, Antigravity, or any agent) reads it and walks one person through the whole build, one step at a time. The person doing the clicking is not technical. Do not assume anything. Do not batch steps.

## How the agent runs this

- Do ONE numbered step, then STOP and wait for the person to say "done" (or paste what they see) before the next step.
- After each step, run the CHECK. If it fails, use IF STUCK before moving on.
- Never ask the person to write code. Every action is a click, a paste, or a phone keypad code.
- You (the agent) never create an account, never enter a card, never set the divert on their phone. You read the step; they do it. This is a hard rule.
- Read each step in plain language. Expand any term the person questions.
- Keep the filled kit open: system-prompt.md, knowledge-base-template.md, tool-schemas.json, webhook-map.md, divert-codes.md.

Total time for a first build: about 90 minutes. Nine stages.

## Before you start (say this to the person)

You will need: a laptop, your mobile phone, a debit or credit card (for the two accounts), and 90 minutes. Your business phone number does not change. We are adding a helper that answers when you cannot. You can switch it off anytime with one code.

Two paid accounts, both cheap: Twilio (the phone line, a few dollars) and ElevenLabs (the voice and brain, about 22 US dollars a month). You create both. I will tell you exactly what to click.

---

## Stage 0: Accounts

**Step 0.1 Create a Twilio account.**
Go to twilio.com and sign up. Verify your email and your mobile. When asked what you want to do, any option is fine; you can skip the survey.
CHECK: they are looking at the Twilio Console (the dashboard).
IF STUCK: if Twilio asks to "upgrade" to add funds, that is expected; a small top-up (10 to 20 dollars) is enough to buy a number and make test calls.

**Step 0.2 Create an ElevenLabs account.**
Go to elevenlabs.io and sign up. Choose the Creator plan (about 22 US dollars a month, includes 250 minutes). You can start on the free tier to look around, but the phone features need a paid plan.
CHECK: they can see the ElevenLabs dashboard and the left-hand menu.

---

## Stage 1: The phone number (Twilio)

**Step 1.1 Buy an Australian number.**
In the Twilio Console, go to Phone Numbers, then Buy a Number. Set Country to Australia. Tick Voice under capabilities. Buy one Local number (about 2.50 US dollars a month). Confirm the purchase.
CHECK: the number now appears under Phone Numbers, Manage, Active Numbers. Ask them to paste it to you. This is the AI-number.

**Step 1.2 Copy the two keys.**
On the main Console dashboard, find Account Info. Copy the Account SID and the Auth Token (they may need to click "show" on the token).
CHECK: they have both, kept somewhere safe for a moment. Tell them these are like a password: do not post them anywhere.
IF STUCK: the token is hidden by default; there is a reveal or copy icon next to it.

---

## Stage 2: The agent (ElevenLabs)

**Step 2.1 Create the agent.**
In ElevenLabs, open Agents (left menu), then Create Agent. Give it a name like "Reception".
CHECK: they are on the agent's settings page.

**Step 2.2 Pick an Australian voice.**
In the agent settings, open Voice. Browse the voice library and pick an Australian-accent voice. Play the sample. Choose one that sounds like a friendly local.
CHECK: the chosen voice is set on the agent. Ask them if they like how it sounds; reselect if not. This is the single biggest quality lever, so do not rush it.

**Step 2.3 Paste the system prompt.**
Open system-prompt.md from the kit. Together, fill every << >> with their business details (name, hours, area, services, price rule, owner mobile). Then paste the whole thing into the agent's System prompt field.
CHECK: no << >> placeholders remain in the pasted prompt.
IF STUCK: if they are unsure what the agent may quote, use the callout fee and ranges only, never a fixed price for unseen work. Ask them for the callout fee.

**Step 2.4 Set the first message.**
In the agent, set the First message to the greeting line that opens with the disclosure: "You are speaking with an AI assistant, and this call may be recorded for quality and training purposes. You have reached [business], how can I help?"
CHECK: the first message is saved with the disclosure in it. This line is not optional; it keeps them legal in every state.

---

## Stage 3: What the agent knows

**Step 3.1 Fill the knowledge base.**
Open knowledge-base-template.md. Fill it in with their real hours, services, price guidance, FAQs, and emergency triggers.
CHECK: every << >> is replaced with a real answer.

**Step 3.2 Attach it.**
In the agent settings, open Knowledge Base and upload or paste the filled template.
CHECK: the knowledge base shows as attached to the agent. Tell them: this is what stops the agent guessing. A thin one gives robotic, wrong answers.

---

## Stage 4: Connect the number to the agent

**Step 4.1 Import the Twilio number into ElevenLabs.**
In ElevenLabs, open the Phone Numbers tab, then add a number. Fill: Label (e.g. "Reception line"), Phone Number (the AI-number from Step 1.1), Twilio SID and Twilio Token (from Step 1.2).
CHECK: the number imports without an error. ElevenLabs detects it as inbound-capable.
IF STUCK: a "credentials invalid" error means the SID or token was pasted with a space or is from the wrong Twilio project. Re-copy both.

**Step 4.2 Assign the agent.**
On the same screen, in the agent dropdown, choose the "Reception" agent to handle incoming calls.
CHECK: the number shows the agent assigned for inbound.

---

## Stage 5: First test call

**Step 5.1 Ring the AI-number directly.**
Have the person call the AI-number from their mobile (not their business number yet).
CHECK: the agent answers within two rings, speaks the disclosure and greeting in the AU voice, and holds a basic conversation. Ask them three FAQ questions from the knowledge base and confirm the answers are right.
IF STUCK: no answer means the number is not assigned to the agent (redo Stage 4). Robotic or slow voice means the wrong voice or region (redo Step 2.2). Watch the call under Calls History in ElevenLabs.

---

## Stage 6: Booking

**Step 6.1 Set up the calendar.**
If they use cal.com: create a free cal.com account and one event type (e.g. "Site visit, 60 min"). Get the cal.com API key and the event-type id. If they use Google Calendar: note which calendar to book into.
CHECK: they have a calendar the agent can write to.

**Step 6.2 Add the booking tools.**
In the agent, click Add Tool, choose Webhook. Add two tools using the definitions in tool-schemas.json: check_availability and create_booking. Fill Name, Description, Method and URL (the cal.com endpoint or a Make/Zapier webhook that talks to cal.com), and the parameters from the schema.
CHECK: both tools are saved and attached to the agent.
IF STUCK: the simplest no-code path is to point each tool at a Make or Zapier webhook that does the cal.com step, rather than calling cal.com directly. Use whichever the person is comfortable with.

**Step 6.3 Test a booking.**
Call the AI-number and ask to book. The agent should offer real times and confirm one.
CHECK: the appointment appears in the calendar. The agent read the day, time and address back before ending.

---

## Stage 7: The confirmation text

**Step 7.1 Add the SMS tool.**
In the agent, Add Tool, Webhook, add send_sms from tool-schemas.json, pointed at a Twilio Send SMS action (via Make or Zapier, using the Twilio SID and token). It texts the customer after a booking or a promised callback.
CHECK: a test booking triggers a text to the caller's mobile.
IF STUCK: skip the SMS for a landline caller; email the owner to call back instead.

---

## Stage 8: You get told about every call

**Step 8.1 Turn on the post-call webhook.**
In the agent settings, enable the Post-call webhook. Point it at a free Make or Zapier scenario.
CHECK: the webhook URL is saved in ElevenLabs.

**Step 8.2 Build the delivery scenario.**
In Make or Zapier, build the scenario from webhook-map.md: receive the webhook, then email the owner the summary and full transcript, and add a row to a Google Sheet log. Route by outcome (booking, message, answered-only).
CHECK: after a test call, an email with the transcript arrives within a minute.

---

## Stage 9: Go live

**Step 9.1 Set the divert on the business phone.**
On the business handset, from divert-codes.md, dial: `**61*<AI-number>**15#` and press call. This forwards calls you do not answer within 15 seconds to the agent.
CHECK: they see a confirmation on the handset. Verify with `*#61#`.
IF STUCK: if voicemail grabs the call first, lower the delay to 10 seconds, or ask the carrier to raise the voicemail timer. Cancel everything with `##002#` if needed.

**Step 9.2 The live proof call.**
From a second phone, call the business number and do not answer. After about 15 seconds the agent should pick up. Run one booking through end to end.
CHECK, all six must pass:
- The agent answered the diverted call.
- The disclosure was spoken.
- An FAQ was answered correctly.
- A booking landed in the calendar.
- The transcript email arrived.
- The customer got a confirmation text.

When all six pass, it is live. Tell the person how to switch it off (`##002#`) and back on (`**61*<AI-number>**15#`), and where to read call transcripts (their email and ElevenLabs Calls History).

---

## Handover note (leave with the person)

- Your number is unchanged. The agent only answers calls you miss.
- Turn it off: dial `##002#`. Turn it on: dial `**61*<AI-number>**15#`.
- Every call is emailed to you with a summary and full transcript.
- To change what it says, edit the knowledge base and the system prompt in ElevenLabs, Agents.
- Monthly cost sits around 80 AUD for a normal call load.
