---
feature: flights-tickets
status: completed
updated: 2026-08-06
review_note: ""
---

# Flights & Ticketing (PNR)

Flight tickets are managed as PNR records — flight-booking references, either synced automatically from an airline's reservation system or entered manually — that get linked to bookings so passengers can actually travel on them. This capability is split into two areas, covered in their own docs:

- **[PNR & Ticket Records](flights-tickets-pnr-tickets.md)** — creating and maintaining the flight tickets themselves: manual entry, bulk spreadsheet import, automatic airline sync, deadlines and reminders, handling sync failures, and flight arrivals/departures reports.
- **[Booking Flight Assignment](flights-tickets-booking-assignment.md)** — using those tickets on a specific booking: reserving seats, assigning them to named passengers, keeping a booking's flight details in sync with the underlying ticket, and removing a flight from a booking.

## Related Features

- [Bookings](booking.md) — a booking's flight tickets are reserved and assigned here, and flight cost changes feed back into the booking's totals.
- [Passengers](passengers.md) — individual seat assignments are made to a booking's own traveler records.
