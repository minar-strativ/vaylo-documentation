---
feature: transport
status: completed
updated: 2026-08-07
review_note: ""
---

# Vehicles, Carriers & Stations

The reference data behind tour transport and flight logistics: the vehicles used to move passengers on tours, the home bases they operate from, the carriers (airlines) flights are booked with, and the stations used as flight departure/destination points.

## What it does

This feature covers three related pieces of transport reference data:

- **Vehicles** — the buses, vans, or other vehicles tours use to move passengers, each with a type, a seating capacity, and an optional home base.
- **Carriers** — the airlines flight tickets are booked through, mostly kept up to date automatically from a central feed.
- **Stations** — the departure and destination points recorded on flight tickets, combining a synced list of airports with locally-added points.

None of these are booked directly by customers — they're setup data that other features (tours, tour types, and flight ticketing) draw on.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and edit vehicle types, home bases, and vehicles; view and rename carriers; create, edit, and view stations and station types |
| System (automated sync) | Creates and updates carriers, stations, and station types from a central source |

## How it works

**Setting up vehicles.** Staff first define vehicle types (e.g. a category like "Minibus") and, optionally, home bases — a depot described by name, city, country, address, and optional map coordinates. A vehicle is then created against one type and, optionally, one home base, with its own name, seating capacity, and an optional external reference id linking it to another system. Once set up, a vehicle can be assigned to tours and tour types elsewhere in the system.

**Retiring a vehicle.** Deactivating a vehicle is blocked while it's still assigned to a tour that is active and hasn't departed yet — staff have to remove or reassign that tour assignment first.

**Carriers arriving from sync.** Carriers mostly appear automatically: an automated feed pushes carrier data matched by a unique signature key, creating a new carrier the first time a signature key is seen and updating the IATA code, ICAO code, and active status on repeat syncs. The carrier's name is set only when it's first created — sync never overwrites it afterwards, so staff can safely correct a carrier's display name without it being reverted on the next sync.

**Correcting a carrier.** Staff can look up a carrier and update its name directly; the IATA code, ICAO code, and active status stay under sync control and aren't editable this way.

**Setting up stations.** Staff can add their own stations for pickup/drop points that aren't part of the synced airport list — these are automatically filed under the "Other" station type. Every new station is checked against existing ones sharing the same name and type, and rejected as a duplicate if one already exists.

**Editing or retiring a station.** A station can only be edited, or deactivated, while its type is "Other" — synced, system-managed stations (any type other than "Other") can't be changed here at all; staff attempting to do so are told to contact the BookingSystem admin instead. A station also can't be deactivated while it's currently set as the departure or destination point on any flight ticket.

## Rules & Edge Cases

- A vehicle's external reference id, if provided, must be unique across every vehicle.
- A carrier's IATA code is at most 2 characters and unique; its optional ICAO code is at most 4 characters and unique.
- A carrier's signature key — the identifier the sync feed uses to recognize it on repeat syncs — is unique.
- Carrier sync never updates the carrier's name, only its IATA code, ICAO code, and active status.
- Deactivating a vehicle assigned to an active, undeparted tour is rejected with a message that the vehicle has an active tour assignment.
- A vehicle type's name and a station type's name must each be unique.
- Two stations are treated as duplicates when they share the same name and the same station type — for example, adding a second "Main Square" pickup point of type "Other" when one already exists is rejected with "Same station exists."
- Editing a station whose current type — or the type it's being changed to — isn't "Other" is rejected outright, directing staff to contact the BookingSystem admin.
- Deactivating a station is rejected if its type isn't "Other", or if it's still referenced as a departure or destination station on any ticket, even if its type is "Other."
- None of vehicles, vehicle types, home bases, stations, or station types can be deleted through these screens — only deactivated.

## Limitations

- Vehicles, carriers, and stations are pure reference data here — booking a vehicle onto a specific tour departure, or a carrier/station onto a specific flight ticket, happens in the Tours, Tour Types, and Flights & Ticketing features, not in this one.
- There's no way to reactivate or otherwise change a synced (non-"Other") station from these screens; that data is owned by the central sync source.
- Carrier records can't be created or deleted by staff directly — new carriers only appear through the sync feed.

## Related Features

- [Tours](tours.md) and [Tour Types](tour-types.md) — where vehicles set up here get assigned to specific tour departures and templates, each with their own seat capacity for that assignment.
- [Flights & Ticketing (PNR)](flights-tickets.md) — where carriers and stations set up here are referenced on flight segments as the airline and the departure/destination points.

## FAQ

**Q: Can I delete a vehicle, carrier, or station I no longer need?**
A: No — these can only be deactivated, never deleted, so historical tours and tickets that reference them stay intact.

**Q: Why can't I edit or deactivate a station I see in the list?**
A: Only stations of type "Other" (the ones staff added locally) can be edited or deactivated here. Any other station came from the central sync feed and is system-managed — contact the BookingSystem admin to change it.

**Q: I renamed a carrier, but will the sync feed change it back?**
A: No — the sync feed only ever creates a carrier's name once, the first time it's seen. After that, only the IATA code, ICAO code, and active status get updated by sync; the name is left as staff set it.

**Q: Why was my new station rejected?**
A: Either it duplicates an existing station with the same name and type, or one of the required fields didn't validate — the response names exactly what's wrong.

**Q: Can I deactivate a station that's still used on a flight ticket?**
A: No — a station can't be deactivated while it's set as the departure or destination station on any ticket, even if it's an "Other"-type station you added yourself.
