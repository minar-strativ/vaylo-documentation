---
feature: notes-todos
status: completed
updated: 2026-08-18
review_note: ""
---

# Notes, Todos & Travel Information

Three related tools for day-to-day operations: staff notes on a booking or tour, follow-up tasks with due dates and reminders, and traveler-facing travel information shown to passengers in the portal.

## What it does

- Staff attach notes to a booking or tour — internal (staff-only) or external — optionally assigned to a colleague or to a specific passenger.
- Staff create todo tasks tied to a booking or a tour, with a due date/time and an assignee, who gets emailed when the task is created, reassigned, or about to come due.
- A tour-level task can be created once and automatically applied to every currently booked (or transferred) booking under that tour, and closed out for all of them at once.
- Staff maintain traveler-facing travel information — general advice, or content tied to a specific tour, tour type, location, or booking — available in multiple languages.
- A passenger sees all the travel information relevant to their specific booking, combined from every applicable source, in their own language, through the passenger portal.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and manage notes and todos; maintain the travel information content and its translations. |
| Passenger | Views their booking's combined travel information in the passenger portal. |

## How it works

### Notes

1. Staff write a note against a booking or a tour, choosing its type and whether it's internal (visible only to staff) or external.
2. An internal note can be assigned to a staff member; an external note is assigned to a specific passenger on the booking instead — never both at once.

### Todos

1. Staff create a task with a title, description, due date/time, and an assignee, tied to a booking or a tour.
2. If the task is meant to apply to a whole tour, one task is created for the tour itself plus a matching copy on every currently booked or transferred booking under it — the tour-level task is the single row staff see representing the whole group.
3. The assignee is emailed when the task is created or reassigned, and gets reminder emails ahead of the due date/time, timed according to the tenant's configured lead times.
4. Completing a task can close just that one copy, or — for a tour-level task — cascade to close the entire group at once; reminders are cancelled the moment a task is completed.

### Travel Information

1. Staff write travel information content — general (shown to everyone) or tied to a specific tour, tour type, location, or booking — with translations per language.
2. When a passenger opens their booking in the passenger portal, the platform assembles every applicable piece of travel information for that specific booking (general content, the tour's own details, its location, its tour type, and anything linked directly to the booking) and shows it in the passenger's preferred language.
3. A piece of travel information can't be deactivated while it's still linked to any active tour, tour type, custom tour offer, location, itinerary template, or active booking — it has to be unlinked from all of those first.

## Rules & Edge Cases

- A todo's due date and time can never be set in the past.
- An internal note is assigned to a staff member; an external note is assigned to a passenger — never both.
- Travel information linked to any active record can't be deactivated until it's unlinked from all of them.
- Reminders for a completed task are always cancelled, never rescheduled.

## Limitations

- Notes and todos are internal staff tools — passengers never see them, even external notes assigned to them.
- Travel information is read-only for passengers; they can view it but not respond to or acknowledge it within the portal.

## Related Features

- [Bookings](booking.md) and [Tours](tours.md) — the records notes, todos, and much of the travel information are attached to.
- [Notifications (Email)](notifications.md) — todo creation, reassignment, and reminder emails are sent through this feature's own templated email system.
- [Tour Flights](tour-flights.md) — a customer's custom flight request can create a follow-up staff task here.

## FAQ

**Q: Can a note be assigned to both a staff member and a passenger?**
A: No — an internal note is assigned to a staff member, and an external note is assigned to a passenger; never both.

**Q: What happens to a tour-level task's booking copies if one is completed?**
A: Completing just that copy only closes it; completing with "apply to all" closes the tour-level task and every booking copy in the group together.

**Q: Will a task with a due date in the past be created?**
A: No — a task's due date and time can never be set in the past.

**Q: Can travel information be turned off if it's still in use?**
A: No — it has to be unlinked from every active tour, tour type, location, itinerary template, and booking before it can be deactivated.

**Q: Does a passenger see travel information in their own language?**
A: Yes — the portal shows it in the passenger's preferred language, using a translation if one exists for that content.
