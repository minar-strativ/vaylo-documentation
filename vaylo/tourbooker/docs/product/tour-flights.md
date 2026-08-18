---
feature: tour-flights
status: completed
updated: 2026-08-18
review_note: ""
---

# Tour Flights

Tour Flights lets a tour offer one or more flights that customers choose (and pay for) as part of booking the tour itself, instead of arranging flights separately. Staff attach the flights a tour offers, and a booking's price includes whichever flight — or no flight at all — the customer selects.

## What it does

A tour can have any number of flights attached to it, each with its own price per passenger. A flight is backed either by a **Group Flight** — a block of seats staff have already reserved on an airline/GDS booking — or a **Freesale Flight** — a one-off flight staff enter directly for this tour, normally with no fixed seat limit. Customers pick from the tour's active flights when booking; a tour can also let customers take no flight at all in exchange for a transfer fee, and/or submit a **Custom Flight Request** — a free-text note (e.g. "I need to fly from a different airport") — instead of picking a listed one.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Attach, edit and remove a tour's flights; configure the no-flight option, its fee, and custom flight request handling |
| Customer | Choose a flight (or no flight, or request a custom one) when booking a tour, on the public site or widget |
| System (scheduled/background) | Keeps booked seats, price layers, and billing lines in sync as a booking changes (waitlist, cancellation, passenger changes) |

## How it works

**Attaching a flight to a tour.** Staff attach either a Group Flight (picking an existing group PNR and how many of its seats this tour gets) or a Freesale Flight (entering the flight's schedule directly, which creates a dedicated booking record behind the scenes). Each flight gets its own price per passenger, and staff can add a departure location and an external booking link. Adding a tour's very first flight is blocked while the tour has any active booking, since those bookings were priced without a flight in mind; once a tour has at least one flight, more can be added freely.

**Choosing a flight when booking.** How flight choice works depends on the tour: either every passenger on the booking takes the same flight (or all take no flight, if that's allowed), or — on a per-passenger booking — different passenger types can be put on different flights, or a mix of flying and not flying. A customer only pays the tour's current listed price for a flight; the price shown at checkout is always re-checked against what the tour is actually charging.

**Taking no flight.** If a tour allows it, a customer can skip flights entirely and pay a configurable transfer fee instead. This fee is billed per head that isn't flying — for an admin-created booking with a headcount larger than the passengers actually entered, it still charges for every head, not just the passengers on file.

**Requesting a custom flight.** If a tour allows custom flight requests, a customer can submit a free-text request instead of choosing a listed flight. Depending on how the tour is configured, this notifies the tour's admin by email, creates a follow-up staff task (due a few days later), or both.

**Keeping seats and prices in sync.** Whenever a booking's flight choice changes — through the checkout flow, a waitlist being accepted, a passenger being added or removed, or a cancellation — the platform automatically reconciles how many seats the booking holds on each flight (and the no-flight fee, if any) and updates its billing to match. A flight's price can change after a booking was made; existing seats keep the rate they were bought at, and only newly added seats pick up the current price, so one booking can end up billed at more than one rate for the same flight if seats were added at different times.

**Billing.** Flight costs and the no-flight fee appear as their own billing lines, priced at whatever rate each batch of seats was bought at. If a change happens after part of a flight's cost has already been invoiced, the platform doesn't rewrite the issued amount — it adds a correction line for the difference instead, crediting back anything no longer owed.

**Removing a flight.** Staff can detach a flight from a tour as long as no booking still holds seats on it; bookings must be moved off it first. Turning off the tour's no-flight option is blocked the same way while any booking is still carrying that fee.

## Rules & Edge Cases

- A tour's first flight can't be added while it has any active booking; every flight after the first can be added regardless.
- A Group Flight requires an existing group PNR and a seat block; its seat block can never be reduced below the seats already booked on it.
- A Freesale Flight requires its own schedule details and a billing supplier, and has no fixed seat ceiling unless staff set one.
- The same group PNR can't be attached to the same tour twice.
- On a per-passenger booking, the flight seats requested for a passenger type can never exceed that type's headcount; if the tour disallows going without a flight, they must exactly equal it.
- A quoted price for a new flight selection must match the flight's (or the no-flight fee's) current price — a booking can't be created or updated with a stale or altered price.
- An existing price layer's rate can't be changed directly — the only way to reprice already-booked seats is to remove them and rebook at the current price.
- Deleting a tour flight is blocked while any booking still holds seats on it; disabling the no-flight option is blocked while any booking still carries that fee.
- A tour flight only appears to customers while it's marked active; inactive flights stay attached but hidden from the public site/widget.

## Limitations

- This feature covers flights sold as part of a tour booking; general flight/PNR/ticket management (creating PNRs, assigning tickets, itinerary tracking) is handled by [Flights & Ticketing](flights-tickets.md).
- A custom flight request is a free-text note routed to staff — it doesn't book anything automatically; staff arrange it manually.
- There's no way to change an already-booked seat's price directly; a rate change always means removing and re-adding the seat.

## Related Features

- [Tours](tours.md) — flights, the no-flight option, and custom flight requests are all configured at the tour level.
- [Bookings](booking.md) — a booking's flight choice is set and changed as part of the normal booking lifecycle (creation, waitlist, cancellation, passenger changes).
- [Flights & Ticketing (PNR)](flights-tickets.md) — tour flights are backed by the same PNR/ticket records this feature manages; tour-specific PNRs are hidden from its general PNR list.
- [Billing & Invoicing](billing.md) — flight costs and the no-flight fee reach an invoice as billing lines, following the same issue/lock rules as any other charge.
- [Notifications (Email)](notifications.md) — a custom flight request can trigger an admin email through this feature.
- [Notes, Todos & Travel Information](notes-todos.md) — a custom flight request can also create a staff follow-up task.

## FAQ

**Q: Can different passengers on the same booking take different flights?**
A: Yes, if the tour supports per-passenger flight selection — different passenger types can be put on different flights, or a mix of flying and taking no flight, as long as the seats booked for each passenger type add up correctly.

**Q: What happens if a tour's flight price changes after someone has already booked it?**
A: Nothing changes for the seats already booked — they keep the price they were bought at. Only seats added afterward are charged the new price, so a booking can carry more than one rate for the same flight.

**Q: Can staff remove a flight from a tour at any time?**
A: No — a flight can only be detached once no booking still holds seats on it. Affected bookings have to be moved off it first.

**Q: What happens to billing if a flight change happens after part of it was already invoiced?**
A: The issued amount is never rewritten. Instead, a correction line is added for the difference, crediting back whatever is no longer owed.

**Q: What does a customer see if they don't want to fly at all?**
A: If the tour allows it, they can opt out of every flight and instead pay a configured transfer fee, billed per person going without a flight.

**Q: What happens when a customer requests a custom flight instead of picking one from the list?**
A: Their free-text request is routed to staff — by email, as a follow-up task, or both, depending on how the tour is set up — for staff to arrange manually.
