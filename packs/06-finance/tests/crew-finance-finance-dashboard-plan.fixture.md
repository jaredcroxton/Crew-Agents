# Fixture: crew-finance-finance-dashboard-plan

## Case A: clean
INPUT: A two-van plumbing business. Owner's decisions, stated plainly: "I need to know if I can afford a third van and whether customers are paying me on time." Data lives in Xero (sales, payroll, expenses) with a connected bank feed. Owner reads the dashboard, no other staff see it.
EXPECT:
- Output header FINANCE DASHBOARD PLAN with Business, Planned date, and For: owner.
- The two decisions restated as the spine, each mapped to exactly one metric.
- "Can I afford a third van" maps to a Position or Timing metric (cash on hand and/or weeks of runway), "paying on time" maps to a Timing metric (average days to get paid / debtors outstanding), each typed (Position/Flow/Timing/Ratio).
- Each metric is tagged leading or lagging, and the dashboard carries a mix (a leading signal like weeks of runway or days-to-pay trending, not only lagging confirmation), not a pure rear-view mirror.
- Each metric names its source as Xero or the bank feed and marks it Confirmed, with a reliability note (the reconciled feed is strong) and a refresh owner.
- A specific mechanism, not a category (for example "average days to get paid, because the owner suspects invoices sit unpaid", not "track receivables").
- A profit or net read is kept separate from the cash position, never collapsed into one tile.
- Layout orders the most-asked question top-left, grouped by decision, capped at a handful of tiles, with drill-down and alert-threshold slots noted.
- Update frequency per metric tied to the source (bank feed daily, manually keyed weekly or monthly).
- Access notes owner sees all, single owner, with sensitive fields restricted if a wider reader ever appears.
- Targets (runway floor, acceptable days to pay) left "Open for the owner to set" / Escalated, the slot named but the value never invented.
- The handoff file `~/.claude/crew-state/finance/crew-finance-finance-dashboard-plan-handoff.md` was written.
- No em dashes anywhere.

## Case B: messy
INPUT: "We sell candles online and at two market stalls. I kind of want to see everything, revenue, profit, traffic, followers, stock, all of it." Some sales are in Shopify, market-stall takings get keyed into a spreadsheet "when I remember", and there is no record of cost per candle anywhere. Owner mentions a "good margin" but gives no number.
EXPECT:
- Does NOT build a twenty-tile wall. Caps to the few numbers that drive a decision and says so, drops the non-finance vanity metrics (traffic, followers) or routes them out of scope as wall ornaments that drive no decision.
- Forces the decision question, because "see everything" is not a decision, and surfaces the real ones (is the business making money per candle, is online or market more profitable).
- Margin metric flagged "No source, capture needed" because cost per candle exists nowhere, does not invent a margin or a feed.
- Market-stall spreadsheet marked Assumed, its reliability flagged (manually keyed, goes stale silently) with a named refresh owner, and its update frequency tied to reality (not daily on a source keyed "when I remember").
- The "good margin" comment is NOT turned into a target number. Margin target left "Open for the owner to set" / Escalated.
- A profit or margin tile is kept separate from the cash position, net is not read as cash.
- Mixed sources (Shopify Confirmed, the spreadsheet Assumed) labelled per metric with one canonical source each, no source invented.
- The handoff file was written, recording the missing cost data as unfinished work.
- No em dashes anywhere.

## Case C: missing-input
INPUT: "Set up a finance dashboard for my business." No decisions, no questions, no statement of what the business sells, no data sources named.
EXPECT:
- Loop 1 fires. Names the gap: there is no decision behind the dashboard, so there is nothing to scope metrics around.
- Asks the single forcing question once ("What is the one money question you ask yourself most weeks?"), plainly, not a batched survey.
- Does NOT emit a finished outline of invented metrics, targets, or data sources.
- If it proceeds at all, it proceeds only on clearly labelled "Assumed: [common owner questions]" placeholders and marks every source and figure as Not provided / "No source, capture needed", inventing no actual numbers, no tool names, no access levels.
- The handoff file `~/.claude/crew-state/finance/crew-finance-finance-dashboard-plan-handoff.md` was still written, recording that decisions and sources were Not provided and the forcing question is outstanding.
- STATUS is NEEDS_CONTEXT or BLOCKED, not DONE, so an empty scaffold is not mistaken for a real plan.
- No em dashes anywhere.
