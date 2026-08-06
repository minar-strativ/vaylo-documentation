---
feature: yacht-booking/booking-and-reservation
status: completed
updated: 2026-08-06
review_note: ""
---

# Yacht Search, Booking & Reservation

Once a yacht exists in the catalog, customers can search for it, price out a charter, and book it directly — with the actual reservation held and confirmed with the external charter provider behind the scenes, right through to departure.

## What it does

This covers the customer-facing search and booking flow for yacht charters, and everything that happens after: opening and confirming the reservation with the external charter provider, keeping the booking and the provider's records in sync, and the automated steps that run as a booking approaches and passes its departure date.

## Who uses it

| Role | Can do |
|------|--------|
| Customer | Search for yachts, preview cost, and submit a booking directly, with no account required |
| Staff/Admin | Create or edit a booking internally (including for manually-added yachts), confirm a pending booking, manage cancellations |
| System (automated) | Cancels overdue pending bookings, marks departed bookings, sends departed bookings to accounting, assigns crew ahead of departure |

## How it works

**Searching and pricing.** A customer searches yachts by destination, date, and currency, views full details of one, and requests a cost preview showing the price breakdown, discount, tax, and total due before committing to anything.

**Booking.** The customer submits the booking themselves on the public site, with no account needed. Before the booking is placed, the system checks live availability with the charter provider for the exact requested dates; if the yacht isn't actually available, the booking is rejected. Once placed, the booking starts out Pending and a reservation is opened with the charter provider; if that reservation can't be opened, the booking is automatically cancelled rather than left in limbo.

**Confirming.** Staff review a Pending booking and explicitly confirm it, which locks in the reservation with the charter provider and moves the booking to Booked.

**Editing and cancelling.** Staff can edit an existing booking's passengers, add-ons, and pricing. Cancelling a booking also cancels the reservation held with the charter provider, unless the booking was entered manually.

**Automatic housekeeping.** If a customer misses the first payment deadline, their Pending booking is automatically cancelled. Once a booking's departure date arrives, it's marked as departed and a financial record is sent to accounting automatically. For crewed yachts, crew is assigned to the booking automatically shortly before departure.

**Manual bookings.** Staff can book a yacht that was added manually (outside the normal provider catalog) using a staff-entered price; this skips the live availability check and the external reservation step entirely, since there's no provider record to check against.

## Rules & Edge Cases

- A booking can't be placed unless the exact requested dates are confirmed available with the charter provider — except for manually-entered bookings, which skip this check and use a staff-set price instead.
- A booking must include at least one passenger, no more passengers than the declared total, and each passenger's email must be unique within the booking.
- A booking submitted by a customer directly must have exactly one passenger marked as the primary contact, and that passenger must have a valid email.
- Only currently-active supplements can be added to a booking.
- A booking's passenger count can never be reduced below the number of passengers already registered on it.
- A booking moves from Pending to Booked only once staff explicitly confirm it with the charter provider; it moves to Cancelled if the reservation fails to open, the payment deadline passes, or it's cancelled outright.
- Payment due dates for a booking come directly from the charter provider's own payment schedule for that reservation — for example, a provider offering a two-installment plan sets both a deposit deadline and a separate balance deadline on the booking.
- If a booking's total price changes after an edit, both the customer and the accounting system are notified of the increase or decrease.

## Limitations

- This covers searching, booking, and managing the reservation lifecycle — the underlying yacht catalog and its pricing are covered in [Yacht Catalog & Pricing](yacht-booking-catalog-and-pricing.md).
- A manually-entered booking bypasses live availability checking entirely, since there's no external provider record to check it against — staff are responsible for confirming the yacht is actually free.

## Related Features

- [Yacht Catalog & Pricing](yacht-booking-catalog-and-pricing.md) — the yacht listings and pricing this booking flow searches and books against.
- [Bookings](booking.md) — a yacht booking shares the same underlying booking record used for tour and hotel bookings.
- [Passengers](passengers.md) — travelers on a yacht booking are recorded the same way as on any other booking.

## FAQ

**Q: Does a customer need an account to book a yacht?**
A: No — customers can search, preview cost, and submit a booking directly without creating an account first.

**Q: What happens if the yacht turns out not to be available when I try to book it?**
A: The booking is rejected outright — the system checks live availability with the charter provider for the exact dates before placing the booking.

**Q: What happens if the reservation with the charter provider fails after I've submitted a booking?**
A: The booking is automatically cancelled rather than left in an unclear state.

**Q: Does a booking need to be manually confirmed by staff before it's finalized?**
A: Yes — a booking stays Pending until staff explicitly confirm it, which is what locks in the reservation with the charter provider.

**Q: What happens if a customer misses their deposit deadline?**
A: The Pending booking is automatically cancelled without staff needing to intervene.

**Q: Can I book a yacht that isn't part of the synced catalog?**
A: Yes — for a manually-added yacht, staff can book it with a price they set themselves, skipping the live availability check since there's no provider record to check against.
