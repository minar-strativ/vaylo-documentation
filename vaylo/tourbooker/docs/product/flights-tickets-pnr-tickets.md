---
feature: flights-tickets/pnr-tickets
status: completed
updated: 2026-08-06
review_note: ""
---

# PNR & Ticket Records

A PNR is a flight-ticket booking record — a fixed number of seats bought under one airline reference — that can later be reserved and assigned to passengers on one or more bookings. PNRs can arrive automatically from an airline's reservation system, be entered by hand, or be bulk-imported from a spreadsheet.

## What it does

This is the master catalog of flight tickets: every PNR's reference code, its flight segments (departure/arrival airports, dates, times, carrier), its named passengers, and its individual issued ticket lines. It tracks how many seats a PNR has in total and how many are already reserved, keeps deadline reminders on track, and surfaces any PNR that failed to sync automatically so staff can follow up.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and edit PNRs manually, bulk-import PNRs from a spreadsheet, download the import template, view the error-PNR list, manage ticket suppliers, run flight arrivals/departures reports |
| System (automated sync) | Creates and updates PNRs from the airline/GDS reservation feed; records a failure as an error PNR if the sync doesn't succeed |

## How it works

**Entering a PNR by hand.** Staff fill in the PNR reference, flight segments, named passengers, and ticket details directly. If the new or updated PNR turns out to duplicate another PNR with the same reference and identical flight segments, the two are merged automatically — ticket counts are combined and any booking that had reserved seats on the duplicate is quietly repointed to the surviving PNR, so no booking loses its reservation and no duplicate record is left behind.

**Bulk-importing PNRs.** Staff download a spreadsheet template first, which includes example data and an instructions sheet, fill it in, and upload it. The file is checked before anything is read from it — file size, required columns, and consistent data within each PNR's rows all have to pass — and a specific error names exactly what's wrong if something doesn't. Once past those checks, PNRs and their flight segments are created or updated, and deadline reminders are scheduled automatically wherever a PNR has reminder settings.

**PNRs synced automatically from an airline.** A PNR that arrived through an automatic sync can only have its deadline and flight-segment remarks edited by staff — every other detail stays under the airline feed's control, since edits there could conflict with the source of truth. If the automatic sync itself fails, the attempt is recorded as an error PNR instead of a ticket, so staff can see what didn't come through.

**Reviewing sync failures.** Staff look at the error-PNR list to catch flights that didn't sync properly. By default only unresolved failures are shown; filtering the list by any status (including resolved) switches to showing every error PNR regardless of status — worth knowing, since it means a plain unfiltered view and a status-filtered view don't behave the same way.

**Deadline reminders.** A PNR with a deadline, a number of reminder-days, and a reminder email address set will have a reminder scheduled that many days before the deadline; if that date has already passed by the time the PNR is saved, the reminder is sent on the deadline date itself instead.

**Flight arrivals/departures reports.** Staff pick one or more airports and a date range and download an Excel report listing every passenger affected — combining PNR-synced flights and manually-added flight segments so nothing is double-counted or missed.

**Ticket suppliers.** Staff maintain the list of ticket suppliers (airlines) tickets are bought through. A supplier can be deactivated, but not while it's still tied to an active flight segment on an active ticket.

## Rules & Edge Cases

- Bulk-import files must be under 5 MB.
- A bulk-import row must have the PNR reference, a group-PNR flag, passenger count, departure and destination, departure/arrival dates and times, and the supplier — all are required.
- Within one PNR's uploaded rows, the group-PNR flag, passenger count, supplier, and deadline-days value must all match across every row for that PNR — a spreadsheet with 3 rows for the same PNR where one row lists a different supplier is rejected entirely, naming the inconsistency.
- A ticket line can be Issued, Void, or Refunded. Voiding a line only changes its status; refunding one line automatically marks every other line sharing the same PNR and ticket number as Refunded too — for example, refunding one traveler's ticket on a shared multi-passenger ticket number marks all of them refunded, not just the one requested.
- Seat/ticket counts never go negative — a reduction that would drop a count below zero is floored at zero instead of erroring.
- A ticket supplier's name must be unique, and it can't be deactivated while an active flight segment on an active ticket still uses it.
- An error PNR is tracked separately per combination of PNR reference, source system, and status — the same PNR reference can appear as more than one open error entry if it fails for different reasons or from different source systems.
- Setting a reminder requires a deadline to already be set on the PNR, and the reminder date it computes can't fall in the past.

## Limitations

- This is the ticket/PNR catalog itself — reserving a PNR's seats against a specific booking and assigning them to named travelers is covered in [Booking Flight Assignment](flights-tickets-booking-assignment.md), not here.
- Organizations/suppliers referenced during bulk import that don't already exist for billing purposes will block the import rather than being created automatically for you.
- There's no manual "mark as resolved" action visible for an error PNR in this feature — resolving a sync failure happens through whatever process re-attempts the sync, not through a direct staff action here.

## Related Features

- [Booking Flight Assignment](flights-tickets-booking-assignment.md) — where a PNR's seats are actually reserved and assigned to passengers on a booking.
- [Bookings](booking.md) — the booking record a PNR's flight ultimately gets attached to.

## FAQ

**Q: Can I edit a PNR that came from the airline's automatic sync?**
A: Only its deadline and flight-segment remarks — everything else is locked because the airline feed is the source of truth for that data.

**Q: What happens if I accidentally create two PNRs for the same flight?**
A: If they share the same reference code and identical flight segments, they're merged automatically — you'll only ever see the surviving one, and any booking that had reserved the duplicate keeps its reservation.

**Q: What happens if my bulk-import file has a mistake in it?**
A: The whole file is checked before anything is imported. If a required column is missing, a value is invalid, or one PNR's rows disagree with each other, the upload is rejected with a message pointing at the exact problem — nothing partial gets saved.

**Q: Why do I see fewer error PNRs when I don't filter the list at all?**
A: The unfiltered view only shows unresolved failures by default. Adding any filter (even by a resolved status) switches to showing every error PNR, resolved or not.

**Q: Does refunding one ticket line refund the whole PNR?**
A: It refunds every ticket line that shares the same PNR and ticket number, not the entire PNR — other ticket numbers on the same PNR are unaffected.

**Q: Can I remove a ticket supplier once it's been used?**
A: Not while it's still tied to an active flight segment on an active ticket — you'd need to reassign or deactivate those first.
