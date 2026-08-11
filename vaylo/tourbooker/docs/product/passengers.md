---
feature: passengers
status: completed
updated: 2026-08-06
review_note: ""
---

# Passengers

A Passenger is a client record — a person's contact, identity, and travel details, kept as one record across every booking they've ever made. Staff can create passengers one at a time or bring in many at once with a spreadsheet import, and the same email keeps a client as a single record instead of a new one per booking.

## What it does

Passenger records store the details needed to book and travel: name, contact information, address, passport details, allergy and emergency-contact information, preferred language and currency, and any organizations or tags the client is associated with. Whenever a client is added to a booking, the system matches them by email to their existing passenger record rather than creating a duplicate — so a repeat customer stays as one client across every trip they book.

Staff can add passengers individually through a form, or bring in a whole list at once using a spreadsheet upload — useful when onboarding a group, an agency's client list, or historical data.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create, view, edit, deactivate, and export passenger records; download the import template and bulk-import passengers from a spreadsheet |
| Customer | Not managed directly here — a customer's own passenger record is created/matched automatically when they appear on a booking |

## How it works

**Adding one passenger.** Staff open the new-passenger form and fill in at least First Name and Last Name — everything else (address, passport, allergy info, emergency contact, preferred language/currency, organizations, tags) is optional. If the email entered is already used by another passenger, the record isn't saved and staff see an error asking for a different email.

**Bulk-importing passengers.** Staff download a ready-made spreadsheet template first. It has an English header row, a Swedish translation row underneath it that must be left in place, and one filled-in example row to be deleted before real data is entered — plus a separate instructions sheet spelling out expected formats (dates as YYYY-MM-DD, salutation as Mr/Mrs/Ms, and a note that any organization or tag referenced must already exist in the system). Staff fill in their data starting from the third row and upload the completed file.

The uploaded file is checked before anything is read from it: it must be an Excel (.xlsx) file no larger than 10 MB, and it must contain the First Name and Last Name columns. If either check fails, the whole upload is rejected with a specific message and nothing is imported.

Once past those checks, each row is processed on its own — a problem with one row never stops the rest of the file from being imported. After the file finishes processing, staff see a summary: how many rows were imported successfully, how many were skipped because the email already belonged to an existing passenger, and how many failed, each with its own error message.

**Editing a passenger.** Staff open a passenger's record and update any field. Changing the email re-runs the same duplicate check used when creating a new passenger.

**Removing a passenger.** There's no outright delete — passengers are deactivated instead, keeping their history intact. Staff can't deactivate or reactivate the passenger record linked to their own account. If the passenger being deactivated also has portal login access, that login is deactivated in the same action (and reactivated if the passenger is reactivated).

**Exporting the client list.** Staff can export the currently filtered passenger list to a spreadsheet with a fixed set of columns covering identity, contact, passport, allergy, and emergency-contact details.

**Custom field answers.** When staff open a passenger's own record, they can also see that passenger's submitted custom field answers — for example, any "save to profile" fields carried over from a booking (see [Dynamic Forms & Custom Fields](dynamic-forms.md)).

**Co-passengers.** When a booking includes travelers besides the lead passenger, each of those travelers is automatically saved to the lead passenger's own list of known travel companions. This is separate from the main Passenger client record — it's a personal, reusable contact book tied to one customer's account, meant to speed up adding the same companions to future bookings rather than serving as the master client record.

## Rules & Edge Cases

- A passenger's email must be unique across the whole system when one is set; any number of passengers may have no email at all.
- Bulk import only requires First Name and Last Name — around 29 other columns are optional.
- Import files must be .xlsx format and no larger than 10 MB, or the upload is rejected outright.
- In the import template, row 1 is the English header, row 2 is a Swedish translation row that must stay in place, and actual data starts at row 3.
- Salutation accepts only Mr, Mrs, or Ms; Gender accepts only Male or Female. During import, an unrecognized value in either field is simply left blank rather than rejecting the row — for example, entering "Miss" leaves the salutation empty instead of erroring.
- Import dates should be entered as YYYY-MM-DD (a few common alternates like DD/MM/YYYY are also accepted); anything else actually entered is rejected with an "invalid format" error naming the field and the value that failed.
- Organizations or tags referenced in an import must already exist in the system — an unrecognized name is silently skipped rather than created or flagged as an error.
- Passengers created through bulk import are always given the "Standard" passenger type.
- A row whose email matches an existing passenger is skipped, not treated as a failure — for example, importing a spreadsheet where 3 of 50 rows share an email with existing clients results in 47 successful imports and 3 skipped rows, not an error.
- Leaving email blank is always valid, whether creating a passenger directly or importing one.
- The combined "Address" shown to staff is built from two underlying address lines; editing it splits the value back across those two lines.
- A staff member can never deactivate or reactivate the passenger record linked to their own login.

## Limitations

- Passenger records don't support permanent deletion — only deactivation, which preserves the record and its history.
- Bulk import can create new passengers but does not update existing ones — a row matching an existing passenger's email is skipped rather than merged.
- Organizations and tags referenced during import must already exist; the import does not create new organizations or tags on the fly.
- A co-passenger's saved contact details are a personal copy taken from a booking at the time it was created — later edits to the main passenger record don't automatically update matching co-passenger entries.

## Related Features

- [Bookings](booking.md) — a booking's travelers are matched or created here by email; the lead traveler's companions are saved back as co-passengers.
- [Tours](tours.md) — passengers on a tour are drawn from and linked back to their passenger records.
- [Dynamic Forms & Custom Fields](dynamic-forms.md) — the source of a passenger's own submitted custom field answers, shown on their record.

## FAQ

**Q: What happens if I try to create a passenger with an email that's already in use?**
A: The record isn't saved — you'll see an error asking you to use a different email, since email must be unique across all passengers.

**Q: Can I bulk-import passengers with duplicate emails?**
A: Rows with an email that already belongs to an existing passenger are skipped, not imported and not treated as an error — the rest of the file still imports normally.

**Q: What format does the import spreadsheet need to be in?**
A: An .xlsx file under 10 MB, using the downloadable template — keep the Swedish translation row on row 2, delete the example row, and start entering your data on row 3.

**Q: Can I delete a passenger record?**
A: No — passengers are deactivated instead of deleted, which keeps their booking history intact. You also can't deactivate the passenger record linked to your own login.

**Q: What's the difference between a passenger and a co-passenger?**
A: A passenger is the main client record used across all bookings. A co-passenger is a personal, reusable "known traveler" entry saved under one customer's account, automatically created from their past booking companions to speed up future bookings.

**Q: Does deactivating a passenger affect their portal login?**
A: Yes — if that passenger has login access, deactivating the passenger record also deactivates the login, and reactivating the passenger reactivates the login too.
