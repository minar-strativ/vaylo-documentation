---
feature: flights-tickets/booking-assignment
status: completed
updated: 2026-08-06
review_note: ""
---

# Booking Flight Assignment

Once a PNR exists, its seats need to be reserved against a specific booking and handed out to the actual travelers. This covers that link — from reserving seats, to assigning individual passengers, to keeping a booking's own flight details in sync if the underlying PNR changes later.

## What it does

A booking reserves a number of seats from a PNR, then assigns each of those seats to one of its traveling passengers. The booking keeps its own copy of the flight details (departure/arrival times, airports, carrier) so its itinerary display and printouts don't depend on the master PNR staying unchanged — but that copy can be re-synced if the PNR is updated later. Removing a PNR from a booking undoes the reservation and cleans up anything that depended on it, unless billing has already been generated from it.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Reserve PNR seats against a booking, assign/reassign/unassign passengers, group-assign all passengers at once, manually re-sync a booking's flight segments, remove a PNR from a booking, download passenger manifests |
| System (scheduled process) | Automatically re-syncs bookings whose flight segments never made it across from their linked PNR |

## How it works

**Reserving seats.** Staff pick a PNR and a quantity of seats to reserve against a booking. This only works while the booking is in Booked status, the PNR is active, and there are enough unreserved seats and transport-needing passengers to justify the request. Reserving seats also copies the PNR's current flight segments onto the booking right away, so the itinerary display is populated immediately.

**Assigning passengers.** Staff assign one reserved seat to a specific traveling passenger on the booking. A passenger can only be assigned once per reservation, and a passenger not on that booking can't be picked. If the numbers line up exactly — the reservation's seat count, the booking's passenger count, and the number of passengers still needing transport are all equal — staff can assign every passenger in one action instead of one at a time.

**Changing or removing an assignment.** Staff can reassign a seat to a different passenger, or unassign it outright; both keep the reservation's assigned-seat count accurate. A seat reservation itself can't be deleted once any passenger has been assigned to it — passengers have to be unassigned first.

**Keeping the booking's flight details current.** If the master PNR's flight details change after the booking has already copied them, staff can trigger a manual re-sync to bring the booking's segments back in line, matching them to the PNR's current segments by flight order. A background process also catches any booking whose segments never synced at all and fixes it automatically. If a segment gets removed during a re-sync but already had billing attached, that billing moves onto another segment rather than being lost; if there's nowhere for it to move, the segment isn't removed.

**Removing a flight from a booking.** Removing a PNR's link to a booking is refused outright if any billing has already been generated from its flight segments — staff need to resolve that billing first. Otherwise, it releases the reserved seats, removes any traveler who only existed because of that PNR, and adjusts the booking's passenger count where relevant.

**Downloading manifests.** Staff can download a passenger list for one specific reservation, or for a chosen date and airport range, listing every assigned traveler's contact and passport details.

## Rules & Edge Cases

- A reservation can't exceed the PNR's remaining seats, nor the number of booking passengers who still need transport.
- Only one seat reservation is allowed per booking-and-PNR pair — reserving the same PNR twice on one booking is rejected.
- Reducing an existing reservation's seat count can't drop it below the number of passengers already assigned, nor exceed the booking's total passenger count.
- Passengers marked as free-travel don't count against a reservation's assigned-seat total on tour and non-tour bookings; on yacht bookings, every assigned passenger always counts — for example, assigning a free-travel infant to a tour booking's reservation doesn't use up one of the reserved seats, but assigning that same passenger type on a yacht booking does.
- One-click group assignment only works when the reservation's seat count, the passengers who need transport, and the booking's total passenger count are all exactly equal; any mismatch — or a reservation that's already fully assigned — blocks the action.
- Removing a PNR from a booking is refused if any billing line exists on its flight segments, whether issued or not; the message is more specific if that billing has already been issued.
- A flight-cost change from a re-sync recalculates the booking's total and balance due automatically, and notifies the accounting system whether the cost went up or down.
- A booking's return date can be filled in automatically from its flight data, but only for bookings made without a tour package, and only if it hasn't already been set manually.

## Limitations

- This covers using a PNR on a booking — creating, importing, or syncing the PNR itself is covered in [PNR & Ticket Records](flights-tickets-pnr-tickets.md).
- Billing tied to flight segments has to be resolved before a PNR can be removed from a booking; this feature doesn't adjust or void that billing itself.
- A booking's copied flight segments only reflect the PNR at the time of the last reservation or re-sync — they don't update live the instant the master PNR changes.

## Related Features

- [PNR & Ticket Records](flights-tickets-pnr-tickets.md) — where the underlying flight ticket is created, imported, or synced before it can be reserved here.
- [Bookings](booking.md) — the booking record whose totals and passenger count this feature reads from and updates.
- [Passengers](passengers.md) — the traveling passenger records that seats get assigned to.

## FAQ

**Q: Can I reserve flight seats on a booking that isn't confirmed yet?**
A: No — the booking has to be in Booked status; reservations aren't allowed on cancelled, transferred, or still-pending bookings.

**Q: What happens if I try to assign a passenger who isn't on this booking?**
A: It's rejected — only passengers already listed as travelers on the same booking can be assigned a seat.

**Q: Can I delete a seat reservation after passengers have been assigned to it?**
A: No — you have to unassign every passenger from that reservation first before it can be removed.

**Q: If the airline changes a flight's time after I've already reserved it, will my booking update automatically?**
A: A background process periodically catches bookings that are out of sync, and staff can also trigger a manual re-sync at any time to pull in the latest flight details immediately.

**Q: Why was I refused when trying to remove a PNR from a booking?**
A: Billing has already been generated from that PNR's flight segments — you'll need to resolve or reassign that billing before the PNR link can be removed.

**Q: Does assigning a free-travel passenger use up one of my reserved seats?**
A: Not on tour or non-tour bookings — free-travel passengers don't count against the reservation's assigned-seat total there. On yacht bookings, every assigned passenger counts regardless.
