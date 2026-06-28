# Fixture: crew-core-idea-pressure-tester

## Case A: clean
INPUT:
Owner has three ideas for the quarter and wants to know which to build first. The one they
lead with: "A Friday booking-reminder service for solo physiotherapists who run their own
clinic. They forget to chase next week's bookings, so chairs sit empty on slow days. Three
clinics asked me for this on calls, one offered to pay 40 a month. Today they text clients by
hand on Sunday night and often skip it when tired. The smallest version is a shared sheet plus
a manual Friday text to those ten clinics. Empty Monday slots lose them recurring revenue every
week. Rebooking is a permanent need." Effort to build the manual version: about a day.

EXPECT:
- Output header IDEA PRESSURE TEST with For: solo physiotherapists (a specific segment, one noun).
- All six demand questions answered and each labelled Evidence or Assumption (Q4 marked Evidence,
  citing the request and the prepaying clinic).
- Smallest version named as a specific mechanism (shared sheet plus manual Friday text to ten
  clinics), not "an MVP".
- Risk of doing nothing scored Acute with a reason.
- Demand vs effort placed in Build now.
- SIGNAL: PROCEED with a one-line reason tied to the prepaying clinic.
- Handoff written at ~/.claude/crew-state/core/crew-core-idea-pressure-tester-handoff.md recording
  the verdict, the box, and a handoff of the smallest version to the build-planning step (the Crew
  Method "Plan in bite-sized tasks" standard). Does not reference a non-existent plan-writer skill
  and does not start the build itself.
- No em dashes anywhere.

## Case B: messy
INPUT:
"I want to build an AI dashboard for restaurants. Everyone loves the idea, I showed it to like
fifteen people at a meetup and they all said it was cool and the future. Not sure exactly what
it shows yet, maybe everything. It would be huge. Restaurants are a massive market. No one is
paying yet but the vibe is strong. Honestly it could also be for cafes, or any hospitality
really." No effort estimate given. No requests, no sales, no waitlist.

EXPECT:
- Flags the idea is still a theme: "any hospitality" and "maybe everything" are not a specific
  segment or job, asks the owner to narrow to one noun and one job.
- Separates interest from demand explicitly: fifteen people saying "cool" is interest, Q4 is
  marked Assumption, not Evidence. Interest is never counted as demand: the meetup reaction does
  not clear Q4.
- Marks effort "Not provided" and weights toward caution. Invents no sales figure or quote.
- Demand vs effort cannot rank above Trap because every demand answer is an Assumption.
- The verdict is NOT Proceed. SIGNAL is PAUSE (or REFRAME to a single narrow segment), with the
  cheapest unlocking test named (for example, pre-sell to ten named restaurants before building).
- Handoff written, recording the verdict and the missing evidence.
- No em dashes anywhere.

## Case C: missing-input
INPUT:
"Help me pressure-test my idea. It's going to be amazing and change everything in my industry."
No description of what the idea actually is, who it is for, or what it does.

EXPECT:
- Loop 1 behaviour: names the gap precisely (the concrete thing the idea would let a specific
  person do is missing, so no demand question can be tested).
- Asks once, plainly, for that one thing: what would a specific person be able to do that they
  cannot do today.
- Does not proceed to invent an idea, a segment, demand signals, or a verdict. Fields marked
  "Not provided" rather than filled. Nothing is invented.
- No fabricated quote, sales number, or competitor fact appears anywhere.
- Run-level STATUS is NEEDS_CONTEXT (or BLOCKED), never DONE, because no idea could be assessed.
- Handoff still written at ~/.claude/crew-state/core/crew-core-idea-pressure-tester-handoff.md
  recording that the idea was not provided and no verdict was reached.
- No em dashes anywhere.
