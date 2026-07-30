---
feature: hotels
status: completed
updated: 2026-07-30
review_note: ""
---

# Hotels & Accommodation

Hotels holds the room-type inventory tours draw from when they sell accommodation as part of a booking, plus a simpler Accommodation record for lodging that doesn't need full inventory tracking. Together they answer "where can passengers stay, and how many rooms are actually available for these dates."

## What it does

A Hotel record holds one or more Room Types (e.g. "Double Room", "Suite"), and each room type has day-by-day inventory: how many rooms/beds are available, how many are already booked, and how many are on hold. A hotel only becomes usable once it has at least one room type and staff explicitly activate it.

For lodging that doesn't need inventory tracking, tours can instead attach a simpler **Accommodation** record — just a name, address, description, and website — directly to the tour.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and manage hotels, room types, and their day-by-day inventory; activate/deactivate hotels and room types |
| System (Tours feature) | Draws on room-type availability when calculating what a tour can sell, and books/releases inventory as passengers book or cancel |

## How it works

**Adding a hotel.** A new hotel is created inactive. Staff add its room types, then activate the hotel — activation is blocked until at least one room type exists.

**Two inventory pools.** Every room type's inventory, for every date, is split into a **Fixed** allotment (rooms contractually committed regardless of demand) and a **Call-off** allotment (extra rooms available on request beyond the fixed commitment). Each pool tracks its own available and booked counts.

**Booking a room.** When a passenger books a room type for a stay, the system fills from the Fixed pool first; only once Fixed is exhausted for those dates does it draw from Call-off. Cancelling or changing a booking releases the rooms back in the same order.

**Holding inventory.** Room-type inventory can also be put on a temporary hold, separate from an actual booking — the same "reserved" concept as the Tours feature's capacity hold — and released the same way.

**Deactivating a hotel.** Blocked while any of its room types is still in active use as tour allotment inventory; the dependency has to be removed first.

## Rules & Edge Cases

- A hotel cannot be activated with zero room types — rejected with "At least one room type should be added to activate hotel."
- A hotel already in use by an active tour cannot be deactivated — rejected with "Hotel is used in a tour. You can't deactivate it."
- A room type's total available rooms (fixed + call-off combined) can never be edited down below what's already booked plus what's on hold for that date; each pool is also checked independently, so you can't set the fixed pool below its own booked count even if the call-off pool has room to spare.
- Bulk inventory edits are validated one date at a time across the whole range — a single date failing the rule above is reported against that specific date, not the whole batch.
- Booking and releasing rooms always recalculates the full date range of a stay in one pass, not date-by-date.

## Limitations

- This feature computes hotel/room-type availability; it doesn't decide pricing — room-type pricing configuration and calculations belong to the Pricing feature.
- Accommodation records are intentionally lightweight: they carry no inventory, availability, or booking logic — they're a reference attached to a tour, not something this feature tracks capacity for.
- Reserving (holding) inventory does not itself expire automatically the way a Tour's capacity hold does — release still needs an explicit trigger.

## Related Features

- [Tours](tours.md) — allotment tours draw their sellable room capacity from this feature's inventory, and release it back here when deactivated.
- Pricing & Price Manager — room-type pricing and its calculation rules live there, not here. (not in this run's scope)
- Suppliers — a hotel can be linked to a supplier that provides it. (not in this run's scope)

## FAQ

**Q: Why can't I activate this hotel?**
A: A hotel needs at least one room type added before it can go active — add a room type first, then activate.

**Q: What's the difference between Fixed and Call-off inventory?**
A: Fixed is the room allotment committed regardless of demand; Call-off is extra rooms available on request once Fixed runs out for those dates. Bookings always use Fixed first.

**Q: Can I reduce a room type's available rooms if some are already booked?**
A: Not below what's already booked or on hold for that date — the system rejects any edit that would leave fewer available rooms than are already spoken for.

**Q: What happens if I try to deactivate a hotel that's still being used?**
A: It's blocked with a message telling you the hotel is in use by a tour — remove that dependency (or wait until the tour no longer needs it) before deactivating.

**Q: Is Accommodation the same thing as a Hotel?**
A: No — Accommodation is a simple named lodging reference with no inventory or booking logic, used when a tour doesn't need the full hotel/room-type/inventory tracking this feature otherwise provides.
