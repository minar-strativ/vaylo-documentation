---
feature: dynamic-forms
status: completed
updated: 2026-08-11
review_note: ""
---

# Dynamic Forms & Custom Fields

Dynamic Forms lets staff add extra questions to a tour's booking form — beyond the standard passenger details — so a booking can collect exactly the information that specific tour needs.

## What it does

- Every tour starts out with the platform's standard passenger fields (name, email, address, and similar) already set up.
- Staff can add custom fields to a tour's form: a label, a field type (text, number, date, dropdown, checkbox, file upload, and others), whether it's required, and validation limits like a maximum length.
- Whichever portal a booking is made through — the public booking widget, the passenger portal, or the admin — can be given its own set of fields for the same tour.
- When a passenger is added to a booking, their answers to that tour's fields are checked against those field definitions before the booking is saved, and stored on their own passenger record.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Add, edit, and reorder a tour's custom fields, per portal. |
| Customer | Fills in the resulting fields when booking a tour, wherever they're booking from. |

## How it works

1. When a tour is created, it's automatically seeded with the platform's standard passenger fields as a starting point.
2. Staff add any extra fields the tour needs — for example, a dietary requirement or an equipment size — choosing the field type, whether it's required, and any length or value limits.
3. Staff can restrict a field to only the primary passenger (the booking's main contact) rather than every passenger, and can target a field at a specific portal (widget, passenger portal, or admin).
4. When someone books that tour and fills in passenger details, their answers are validated against the tour's field definitions — a missing required answer or one that's too long is rejected with a specific message — and the valid answers are saved on that passenger's own record.

## Rules & Edge Cases

- Two custom fields on the same tour can't share the same label.
- A required field must have a value submitted; a field with a maximum length rejects any answer longer than that.
- An answer submitted for a field that isn't actually defined on that tour is silently dropped rather than causing an error.
- A field's internal name can't be changed after it's created — only its label, requirement, order, and other settings can be updated.

## Limitations

- Fields are configured per tour — there's no way to define a field once and reuse it identically across many tours today, even though the data model has an unused "collection"/"group" concept intended for that.
- Some field options (automatically creating a task, sending an email notification, or saving the answer to the customer's own profile when a field is filled) exist as settings but aren't acted on by the platform yet.

## Related Features

- [Tours](tours.md) — the tour whose booking form these fields belong to.
- [Passengers](passengers.md) — the passenger record where a custom field's submitted answer is stored.
- [Bookings](booking.md) — where a passenger's custom-field answers are validated during booking.

## FAQ

**Q: Does every tour start with the same booking form?**
A: Every tour starts with the platform's standard passenger fields, but staff can add extra fields specific to that tour on top of those.

**Q: What happens if a customer leaves a required custom field blank?**
A: The booking is rejected with a message naming the specific field that's required.

**Q: Can a custom field be reused across multiple tours automatically?**
A: Not currently — fields are added per tour, one at a time.

**Q: Can a field be shown only in the passenger portal and not on the public widget?**
A: Yes — each field can be targeted at a specific portal (widget, passenger portal, or admin).
