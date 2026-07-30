---
feature: booking
status: completed
updated: 2026-07-30
review_note: ""
---

# Bookings

A Booking is a customer's actual reservation — a specific tour, hotel room, or yacht, for one or more named passengers, with its own pricing, payment status, and cancellation terms. It's the record everything else (payments, tickets, invoices) hangs off of.

## What it does

A booking ties together a departure (tour, hotel room, or yacht), the passengers travelling on it, and one designated **booking client** — the primary contact for the reservation. It tracks what's owed, what's been paid, and what happens if it's cancelled. If the departure is full, a booking can sit on a **Waitlist** until a spot frees up.

## Who uses it

| Role | Can do |
|------|--------|
| Customer | Create and manage their own bookings from the public site or widget — no account required |
| Staff/Admin | Create, update, cancel, and transfer bookings; manage payment deadlines and coupon application |
| External partner (B2B) | Create bookings via a dedicated integration, authenticated separately from staff logins |
| System | Automatically moves a booking from Pending to Booked once payment arrives |

## How it works

**Creating a booking.** Exactly one traveling passenger must be marked as the booking client — the primary contact. At least one passenger must actually be travelling, and the departure and return locations must differ. Customers book directly on the public site with no login; staff book from the admin; approved external partners book through a separate B2B integration.

**Waitlisting.** If a tour or room is full, the booking goes on the Waitlist instead of being confirmed. Accepting a waitlisted booking re-checks that inventory is still actually available — if it isn't, acceptance is rejected — then reserves the room/seats, applies any coupon, and confirms the booking exactly like a normal one, including sending the confirmation email and voucher. Rejecting a waitlisted booking cancels it outright.

**Paying.** A payment is only accepted while there's still a balance due, for a positive amount that doesn't exceed that balance. Once a payment fully covers what's owed, a Pending booking automatically becomes Booked — no manual confirmation step needed. For a yacht booking, this also confirms the reservation with the external yacht provider the tour/booking uses.

**Cancelling.** Cancelling a booking is a single action that unwinds several things at once: it gives back the tour's booked capacity, releases any held hotel room-type inventory, frees the pickup-location seat and vehicle assignment, removes any assigned tickets, and — if the booking used a yacht from an external source — cancels that reservation there too. Whatever was paid, minus the cancellation fee, is automatically queued for refund. Both the customer and staff get notified by email.

## Rules & Edge Cases

- A booking must have exactly one passenger marked as the booking client — more than one is rejected with "Multiple booking clients found. Only one client is allowed."; none is rejected with "Client not found in booking."
- A booking needs at least one actually-traveling passenger, or it's rejected with "At least one traveling passenger is required."
- A payment is rejected if there's nothing left to pay ("The booking fee has already been paid."), if it's more than what's owed ("The amount exceeds the total cost of the tour."), or if it's zero or negative.
- Marking a booking as fully paid is rejected if it's already fully paid, or if only part of the balance has been paid so far — a partial payment has to be recorded as a partial payment, not force-marked as complete.
- A refund is rejected if the booking has no payment on record at all, the requested amount is more than what was actually paid, or the amount is zero or negative.
- A booking can carry its own booking fee percentage, second/balance payment split, and cancellation fee — separate from (and able to override) the tour's defaults for that specific booking.
- A booking can opt into dynamic cancellation pricing instead of a flat cancellation fee, the same option available on the tour itself.

## Limitations

- This feature handles the booking record, payment validation, and cancellation orchestration — it doesn't calculate dynamic cancellation pricing itself when that option is on; nor does it own hotel/room inventory or tour capacity, only adjusts them.
- A booking's ticketing (PNR/flight) data is managed by the Flights & Ticketing feature, not tracked here beyond deleting ticket assignments on cancellation.
- External-partner booking access is a separate integration path from staff and customer access; it isn't a role a human logs into.

## Related Features

- [Tours](tours.md) — a booking reserves tour capacity and can inherit its cancellation/fee defaults from the tour.
- [Hotels & Accommodation](hotels.md) — a booking reserves and releases room-type inventory here.
- Payments — booking payment/refund processing happens there; this feature only validates whether an amount is allowed. (link pending — not yet documented in this run)
- [Billing & Invoicing](billing.md) — invoices are generated from booking financial lines.

## FAQ

**Q: Can two passengers both be the main contact on a booking?**
A: No — exactly one passenger must be marked as the booking client. Marking more than one, or none, is rejected when the booking is created.

**Q: What happens if I try to pay more than what's owed?**
A: The payment is rejected — the amount can't exceed the booking's remaining balance.

**Q: Does cancelling a booking automatically refund the customer?**
A: Yes, whatever they paid (minus any cancellation fee) is automatically queued for refund as part of cancelling — no separate manual refund step is required.

**Q: What happens when a waitlisted booking is accepted but the room has since been booked by someone else?**
A: Acceptance is rejected — the system re-checks real inventory availability at the moment of acceptance, not just at the time the booking was waitlisted.

**Q: Does a Pending booking need to be manually confirmed once payment comes in?**
A: No — once payment is received, a Pending booking is automatically moved to Booked.
