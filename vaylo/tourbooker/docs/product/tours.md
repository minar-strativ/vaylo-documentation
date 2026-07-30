---
feature: tours
status: completed
updated: 2026-07-30
review_note: ""
---

# Tours

A Tour is the catalog listing customers browse and book — a specific departure with its own dates, capacity, pricing, and add-ons. Staff create and manage tours from the admin; customers see them on the public website and booking widget, filtered to only the brands each tour is meant to appear on.

## What it does

A tour brings together everything needed to sell a departure: dates and capacity, pricing (including transport cost, booking fee, and an optional cancellation/discount structure), the room types and supplements available on it, pickup locations, and which vehicles and tour guides are assigned. A tour can be created from scratch or as a repeat of a previous one, carrying over its images and translations so staff don't re-enter the same details for a recurring departure.

Until a tour is ready to sell, staff can leave it as a **Draft** — invisible to customers and inactive — and publish it later by clearing draft status.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create, update, activate/deactivate, and repeat tours; manage pricing, capacity, drafts, and attached room types/supplements/pickup locations |
| Customer | Browse and view published tours on the public site or booking widget — no login required |
| System (scheduled jobs) | Automatically mark tours as departed once their date passes, and automatically release expired capacity holds |

## How it works

**Creating a tour.** Staff enter the tour's dates, capacity, and price. The price a customer pays can never be set below the tour's transport cost. Creating the tour also sets up its passenger-type options, applies the location's default pickup point (and a "pickup on request" option, if the tenant allows it), sets local currency prices, and sends an internal notification email that a new tour was added.

**Repeating a tour.** Instead of building a new tour from scratch, staff can create it as a repeat of an existing one. The repeat copies the original's images and translations and, unless a different one is chosen, keeps the same default brand/office assignment.

**Publishing and unpublishing.** A tour marked as Draft is always inactive and hidden from customers; taking it out of Draft always makes it active and visible. This coupling is enforced everywhere a tour's draft status can change.

**Activating and deactivating.** Staff can also toggle a tour active/inactive directly, independent of Draft. This is blocked if the tour currently has an active booking, an active waitlist booking, any inactive supplement attached, or an assigned tour guide — staff see exactly which of those is blocking the change. Deactivating a tour releases any room-type inventory it was holding back into the shared pool.

**Automatic departure.** Once a tour's departure date has passed, a scheduled process marks the tour and its booked passengers as departed and applies the tour's tag to those passengers — no manual step needed.

**Capacity holds.** A tour can be placed on a temporary capacity hold (for example, while a booking is being completed), reducing what's shown as available. If the hold isn't confirmed by its expiry date, a scheduled process automatically releases it and restores the tour's available capacity.

**Public visibility.** On the public site and widget, a tour only appears on brands it's allowed to appear on: if it has no brand restriction it's visible everywhere, otherwise it only shows on the specific brand domains it's been assigned to.

## Rules & Edge Cases

- A tour's price can never be set lower than its transport cost — attempting to save one is rejected with "Tour Standard price must be greater than or equal to transport cost."
- Tenants with the advanced pricing add-on enabled must keep both the base price and the sale price within the tour's configured minimum/maximum price range; each of the four possible boundary violations (base too low, base too high, price too low, price too high) is rejected with its own specific message.
- Setting a tour to Draft always makes it inactive; taking it out of Draft always makes it active — there is no state where a tour is both a Draft and active, or both published and inactive.
- A tour cannot be activated or deactivated while it has an active booking, an active waitlist booking, an inactive supplement attached, or an assigned tour guide. Each blocking condition surfaces its own message (e.g. "This tour has active booking.", "Remove tour guides before update tour status.") so staff know exactly what to resolve first.
- The default booking fee is 40% of the tour price unless configured otherwise; a tour can charge this fee as a percentage or a fixed amount, and can define a separate second/balance payment.
- Cancellation pricing is either a fixed fee/percentage set on the tour, or — if the tour opts into dynamic cancellation — calculated by the Bookings feature's own cancellation rules rather than a flat value on the tour.
- Every price and discount change to a tour is kept in a history log, giving a full audit trail of how a tour's pricing changed over time.

## Limitations

- A tour's cancellation *fee value* lives on the tour, but the dynamic cancellation calculation itself is part of the Booking feature, not something this feature computes on its own.
- This feature does not manage room-type inventory directly — allotment/room-type stock is shared with and released back to the Hotels & Accommodation feature.
- Draft/publish and active/inactive are two related but separate switches; toggling one does not always leave the other in the same place a first-time user might expect (see Rules above).

## Related Features

- Bookings — a tour's active/waitlist bookings block certain tour changes, and dynamic cancellation pricing is calculated there. (link pending — not yet documented in this run)
- [Hotels & Accommodation](hotels.md) — room-type inventory reserved by a tour is released back here when the tour is deactivated.
- Tour Types — a tour can be based on a reusable tour type, from which it inherits its default images. (not in this run's scope)
- Pricing & Price Manager — the minimum/maximum price bounds enforced on a tour come from this feature's configuration. (not in this run's scope)

## FAQ

**Q: Can a tour's price ever be lower than what it costs to transport passengers?**
A: No — the sale price must always be greater than or equal to the transport cost; the system rejects any save that would set it lower.

**Q: What's the difference between a Draft tour and an inactive tour?**
A: They're linked but not identical. Draft is a separate "not ready yet" flag that always forces the tour inactive when turned on. A tour can also be made inactive directly (without being a Draft) — for example, after it fills up bookings and staff temporarily suspend it — but a Draft tour can never be active until it's taken out of Draft.

**Q: Why can't I deactivate this tour?**
A: The system blocks deactivation while the tour has an active booking, an active waitlist booking, an inactive supplement still attached, or a tour guide assigned. Resolve whichever one applies, then try again — the error message names the specific blocker.

**Q: Does a customer see a tour that hasn't been assigned to their brand yet?**
A: Only if the tour has no brand restriction at all. If specific brands have been assigned, the tour is only visible on those brand domains.

**Q: What happens automatically when a tour's departure date arrives?**
A: A scheduled process marks the tour and its booked passengers as departed and tags those passengers accordingly — staff don't need to do this by hand.
