---
feature: pricing
status: completed
updated: 2026-08-11
review_note: ""
---

# Pricing & Price Manager

Pricing & Price Manager connects tours to an external dynamic pricing engine that watches demand and suggests price changes. Instead of staff manually re-pricing tours, the system receives price suggestions, queues them for review, and — if the tenant chooses — can apply them automatically. Every suggestion, decision, and change is kept as a record so pricing history stays fully auditable.

## What it does

The feature manages the lifecycle of a price suggestion from an external pricing engine, end to end:

- Receiving notifications ("pricing projects") from the pricing engine when a new pricing run starts or a week's price schedule is ready.
- Fetching the engine's suggested price for each tour in that pricing run.
- Turning each suggestion into a reviewable pricing log that shows the tour's current price next to the new one.
- Letting staff apply or reject suggestions (with an optional note), or — if enabled — applying them automatically without staff review.
- Keeping a full history of every suggestion and the decision made on it.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | View pending price suggestions, apply or reject them (with an optional note), and view a tour's pricing history. Requires the tenant's subscription plan to include the dynamic-pricing add-on. |
| System (pricing engine / scheduler) | Delivers new pricing runs and price schedules via webhook, and — when automatic sync is on — applies eligible suggestions unattended. These are machine-to-machine connections, not something a staff member triggers directly. |

## How it works

### Receiving a price suggestion

1. The external pricing engine notifies the system when a pricing run ("pricing project") becomes active, or when next week's price schedule is ready.
2. For those two notifications, the system immediately asks the scheduler to fetch fresh price recommendations for every tour in that pricing run.
3. For each tour, the engine's suggested price is rounded up to the nearest 50 and saved as a pending pricing log, alongside the tour's price at that moment for comparison.

### Reviewing and applying a suggestion

1. Staff open the pending pricing queue and see, for each tour, its current price next to the newly suggested one.
2. Staff apply the suggestion (optionally with a note) or reject it (optionally with a note). Nothing changes on the tour until one of these actions happens.
3. Applying a suggestion updates the tour's price and automatically recalculates its dependent fees — booking fee, cancellation fee, second/balance payment amount, and travel-insurance fee — to match the new price, within the tour's existing minimum/maximum price limits (see [Tours](tours.md)).
4. Staff can also open a single tour's own pricing history to see every past applied or rejected suggestion for that tour, separate from the tenant-wide pending queue.

### Automatic apply (optional)

If a tenant turns on automatic price synchronization, a scheduled job applies eligible pending suggestions on its own, without waiting for staff review. If this setting is off, every suggestion must be applied or rejected by hand.

## Rules & Edge Cases

- A suggested price is always rounded up to the nearest 50 before it is shown as a pending suggestion.
- A suggestion is only actionable if its price actually differs from the tour's current price, its pricing run is currently active (today falls within that run's start and end date), and the tour has not already departed. Departed tours and unchanged suggestions never appear as pending.
- Automatic apply is further limited to suggestions created in the same scheduling run as today's automatic pass — older pending suggestions are left for staff to review manually, even with automatic sync on.
- Applying or rejecting when there is nothing applicable returns a normal "no applicable pricing logs found" response rather than an error.
- If some, but not all, of a batch of suggestions fail to apply, staff still get the ones that succeeded, plus a message showing how many applied versus how many did not, with a note to contact an administrator for the rest.
- Only suggestions linked to a tour can be applied through this workflow today; a suggestion linked to any other kind of record is reported back as unsupported.
- A price suggestion can never push a tour outside its own configured minimum/maximum price limits — the same limits enforced on a manual price edit (see [Tours](tours.md)).

## Limitations

- Only tours are supported as an applicable target today, even though a suggestion could technically reference other pricing-tracked record types.
- The feature only reacts to notifications and schedules coming from the external pricing engine — it does not generate its own price recommendations.
- Automatic apply only ever considers suggestions from the current scheduling run; it will never silently apply an old, unreviewed suggestion.

## Related Features

- [Tours](tours.md) — the tour whose price and dependent fees this feature updates, and whose minimum/maximum price limits every suggestion must stay within.

## FAQ

**Q: Where do the suggested prices come from?**
A: From an external pricing engine that the tenant connects to. This feature receives the engine's suggestions and manages reviewing, applying, or rejecting them — it does not calculate prices itself.

**Q: Does a price suggestion change a tour immediately?**
A: No, unless automatic price synchronization is turned on for the tenant. Otherwise, a suggestion sits in the pending queue until a staff member applies or rejects it.

**Q: What happens to the tour's fees when a suggestion is applied?**
A: Fees that are set as a percentage of price (booking fee, cancellation fee, second/balance payment, travel-insurance fee) are automatically recalculated to match the tour's new price.

**Q: Can automatic apply push a tour's price above or below its allowed range?**
A: No. Every applied suggestion, automatic or manual, still has to respect the tour's own configured minimum and maximum price limits.

**Q: What if applying a batch of suggestions partly fails?**
A: The suggestions that succeeded are applied, and staff see a message stating how many applied and how many did not, with guidance to contact an administrator about the remainder.

**Q: Can I see what price changes have happened on a specific tour?**
A: Yes — a tour's pricing history shows every past applied or rejected suggestion for that tour.
