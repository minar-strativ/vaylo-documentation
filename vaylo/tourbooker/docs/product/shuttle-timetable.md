---
feature: shuttle-timetable
status: completed
updated: 2026-08-18
review_note: ""
---

# Shuttle Timetable

Shuttle Timetable is a reference library of shuttle/transfer schedules staff maintain — for example, an airport shuttle that runs on set weekdays with a fixed route of pickup and drop-off stops. Each timetable records when it runs, how many seats it has, and the ordered list of stops along its route.

## What it does

Staff create a **Timetable** with a name, an active date range, the weekdays it runs on, its seat capacity, and the airport(s) it serves. Each timetable has an ordered list of **Stoppages** — named pickup/drop-off points with a time and an optional connection fee. Timetables and their stoppages can be entered one at a time or bulk-imported from a spreadsheet, and an entire timetable (with its stops and translations) can be duplicated to quickly create a variant.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create, edit, activate/deactivate, duplicate, and delete timetables; manage and reorder their stoppages; import timetables and stoppages from a spreadsheet |

## How it works

**Creating a timetable.** Staff enter a name, the date range it's active for, which weekdays it runs on, its seat capacity, and which airport location(s) it serves. Only locations actually set up as an airport can be attached. If staff don't set how many days before travel passengers should get transfer information, the tenant's configured default is used instead.

**Adding stops.** Each timetable has its own ordered list of stoppages — a location name, an address, a pickup/drop-off time, and an optional connection fee. Stops are automatically numbered in the order they're added, and staff can reorder them afterward, as long as no two stops on the same timetable end up sharing the same position.

**Importing from a spreadsheet.** Staff can download a template and bulk-import a timetable, or a timetable's stoppages, from a spreadsheet instead of entering them one at a time. Importing stoppages can either add to the existing list or fully replace it.

**Duplicating a timetable.** Staff can duplicate an existing timetable to quickly create a variant — the copy carries over its airport locations, its full list of stoppages, and its translated names, ready for staff to adjust.

**Activating and deactivating.** Staff can turn a timetable on or off; an inactive timetable is kept for reference but no longer represents a currently running schedule.

## Rules & Edge Cases

- A location can only be attached to a timetable as one of its airports if it's actually set up as an airport-type location; anything else is rejected.
- Two stoppages on the same timetable can never share the same position — reordering stops that would create a duplicate position is rejected.
- Bulk-importing stoppages can either add the new stops to what's already there or fully replace the existing list, staff's choice at import time.
- A spreadsheet import is rejected outright if its required sheet or columns are missing, or if a row's dates, weekdays, or times can't be parsed — nothing partial is created from a bad file.
- Duplicating a timetable copies its stops and translations but not its active/inactive status changes — the duplicate always starts active.

## Limitations

- This feature only maintains timetables as reference data — it doesn't yet connect a timetable to bookings, passengers, or actual transfer assignments.
- A timetable's schedule is fixed weekdays and a date range; it doesn't support one-off exceptions (e.g. a single date it doesn't run).

## Related Features

- [Vehicles, Carriers & Stations](transport.md) — separately manages the vehicles and pickup/drop-off stations used for tour transport; not currently linked to this feature's timetables.

## FAQ

**Q: Can a timetable serve more than one airport?**
A: Yes — a timetable can have several airport locations attached to it, as long as each one is actually set up as an airport.

**Q: What happens if I import a spreadsheet with a missing column?**
A: The import is rejected with a message naming the missing column or sheet — nothing is created until the file is fixed.

**Q: Does importing stoppages always add to the existing list?**
A: No — staff choose at import time whether to add the new stops or fully replace the timetable's existing stoppages.

**Q: What does duplicating a timetable actually copy?**
A: Its airport locations, its full ordered list of stoppages, and its translated names. The duplicate always starts active regardless of the original's status.

**Q: Can two stops on the same timetable have the same position?**
A: No — creating or reordering a stop into a position another stop on the same timetable already holds is rejected.
