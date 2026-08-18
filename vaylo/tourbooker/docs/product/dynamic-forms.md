---
feature: dynamic-forms
status: completed
updated: 2026-08-18
review_note: ""
---

# Dynamic Forms & Custom Fields

Dynamic Forms lets staff add extra questions to booking and passenger forms — beyond the standard passenger details — and reuse the same set of questions across many tours instead of configuring each one from scratch.

## What it does

- Every tour starts out with the platform's standard passenger fields (name, email, address, and similar) already set up.
- Staff group reusable custom fields into named Collections — one form (Booking, or Booking Passenger) and, for passenger collections, one booking type (Tour or FIT) per collection — with fields inside a passenger collection further organized into display Groups.
- A tour, or the tour type it's built from, can each be given a booking-level and a passenger-level collection; if none is picked, the tenant's default collection for that combination is used automatically.
- Creating a tour clones its collection's fields onto the tour; editing which collections a tour uses re-syncs its fields to match, without disturbing tour-specific fields added by hand.
- Editing a field on a collection's master copy can be pushed out to every tour or tour type using that collection in one action.
- When a customer or staff member submits answers, each one is saved as its own response, snapshotting the field's details at that moment — and a field can be set to automatically create a follow-up task, email the admin, or save the answer to the customer's own profile.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and manage collections, groups, and a tour's custom fields; push a collection edit out to every tour using it. |
| Customer | Fills in the resulting fields when booking, wherever they're booking from. |

## How it works

### Building a reusable field set

1. Staff create a Collection for a specific form (Booking or Booking Passenger) and, for passenger collections, a specific booking type (Tour or FIT), then add fields to it — a label, field type, whether it's required, and validation limits.
2. Passenger fields can be organized into named Groups so they display together on the form.
3. One collection per form/booking-type combination can be marked as the tenant's default, used automatically whenever a tour or tour type doesn't pick one explicitly.

### Attaching a collection to a tour

1. Staff attach a booking-level and/or passenger-level collection to a tour type; every tour built from it inherits those collections (or the tenant's defaults, if none were picked).
2. Creating a tour clones every field from its attached collection(s) directly onto that tour.
3. If staff later change which collections a tour uses, its fields are re-synced: fields from a newly attached collection are added, fields from a detached collection are removed, and anything the tour already has from a collection that's still attached, or added to the tour by hand, is left alone.
4. Editing a field's definition on the collection itself can be pushed out to every tour and tour type currently using that collection — updating the matching field wherever it was cloned, and adding it anywhere it's missing. A tour that has already departed is always skipped, so completed tours are never changed retroactively.

### Submitting and answering

1. A booking-passenger field is automatically created for the public widget, the passenger portal, and the admin in one step; a booking-level field is created for the widget only.
2. When a passenger or booking submits its answers, each one is saved as its own response, recording a snapshot of that field's label, type, and options at the moment of submission — so a later edit to the field doesn't rewrite what was actually asked and answered.
3. If a field is flagged for it, submitting a response can automatically create a follow-up task for the admin, send the admin an email notification, and/or save the answer onto the customer's own profile.
4. Staff viewing a passenger's own detail page can see that passenger's submitted custom field answers.

### Getting started

A new tenant is automatically seeded with a starter set of passenger-field groups and three default collections (one for booking-level fields, one for tour passengers, one for FIT/custom-tour passengers), so custom fields work out of the box before any staff configuration.

## Rules & Edge Cases

- Two custom fields can't share the same label on the same tour, booking, or collection.
- A booking-level field can never be assigned to a display group — grouping only applies to passenger fields.
- Resyncing a tour's fields after its collections change never wipes fields added directly to the tour by hand, and never duplicates fields from a collection that's still attached.
- A departed tour is always skipped when pushing a collection-wide field edit out, so a tour that's already run never changes retroactively.
- A required field must have a value submitted; a field with a maximum length rejects any answer longer than that.
- An answer submitted for a field that isn't actually defined for that tour or booking is silently dropped rather than causing an error.
- Editing an already-submitted answer can't clear a field that was required when it was first answered, even if the field's own definition has since changed.
- Some fields are built into the platform rather than staff-created; editing one of these only lets staff change its label and display group (and, for a field that isn't otherwise mandatory, whether it's required or restricted to the primary passenger) — its underlying type and behavior can't be changed.

## Limitations

- Fields are still configured through collections and tours specifically — there's no way to define a field once and reuse it outside the collection/tour-type mechanism.

## Related Features

- [Tours](tours.md) — the tour whose booking form these fields and collections belong to.
- [Tour Types](tour-types.md) — where a tour's default collections are usually picked, inherited by every tour built from that type.
- [Passengers](passengers.md) — where a passenger's submitted custom field answers are visible to staff, and where "save to profile" answers land.
- [Notes, Todos & Travel Information](notes-todos.md) and [Notifications (Email)](notifications.md) — a flagged field's response can create a follow-up task or send an admin email through these features.
- [Bookings](booking.md) — where a passenger's custom-field answers are validated during booking.

## FAQ

**Q: Does every tour start with the same booking form?**
A: Every tour starts with the platform's standard passenger fields, plus whatever collection(s) it or its tour type has attached — staff can also add tour-specific fields on top of those.

**Q: What happens if a customer leaves a required custom field blank?**
A: The booking is rejected with a message naming the specific field that's required.

**Q: Can a custom field be reused across multiple tours automatically?**
A: Yes — build it once on a Collection and attach that collection to a tour type; every tour built from it inherits the same fields, and a later edit to the collection can be pushed out to all of them at once.

**Q: If I edit a field on a collection, does that change tours that already used the old version?**
A: Yes, for tours still attached to that collection and not yet departed — pushing the edit updates the matching field on every one of them. Departed tours are always left untouched.

**Q: Does editing a custom field's definition change answers customers already submitted?**
A: No — each submitted answer keeps its own snapshot of the field's label, type, and options from the moment it was submitted, so later edits don't rewrite history.

**Q: Can submitting a custom field trigger anything automatically?**
A: Yes, if the field is configured for it — a follow-up task for the admin, an email notification to the admin, and/or saving the answer onto the customer's own profile.
