---
feature: tour-guides
status: completed
updated: 2026-08-06
review_note: ""
---

# Tour Guides

A Tour Guide is a staff member (or contractor) who can be assigned to lead a tour. Staff maintain a roster of guides, each with a type, define when each guide is available, and assign available guides — and optionally a specific vehicle — to individual tours.

## What it does

This covers the guide roster itself (personal details, license, documents, guide type), each guide's stated availability windows, and the process of matching an available guide to a tour, optionally alongside a vehicle. It also covers reviewing who's assigned where, and producing the passenger manifest a guide needs before departure.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and manage guides and guide types, define availability, assign/remove guides on tours, review the assignment board, download passenger manifests |
| Tour Guide | View and edit their own profile and documents, view their own assigned tours |

## How it works

**Setting up guide types.** Staff first define the categories guides fall under (for example, a driver-guide versus a local guide) before guides can be categorized.

**Onboarding a guide.** Staff create a guide record with personal, contact, and document details. This automatically gives the guide a login they can use to manage their own profile, upload their contract, flight ticket, and photo, and see their own assigned tours.

**Defining availability.** Staff or the guide themselves add windows of dates the guide is free to be assigned — each at least 5 days long, never starting in the past, and never overlapping another window for the same guide.

**Assigning a guide to a tour.** When staffing a tour, staff search for guides of the needed type who have an availability window that fully covers the tour's dates, then assign one — optionally linking them to one of the tour's vehicles at the same time.

**Reviewing assignments.** Staff can see a consolidated board of every tour's guide assignments, grouped by guide type and vehicle, or drill into one specific guide's full workload across tours.

**Removing an assignment.** Staff can remove a guide from a tour, which frees their availability back up and detaches any vehicle link, as long as the tour hasn't already returned.

**Preparing for departure.** Staff download a passenger manifest for a tour or a specific vehicle on it — listing every traveling passenger's contact, passport, pickup location, and allergy details for the assigned guide to use.

**Retiring a guide.** Staff deactivate a guide when they're no longer available, which also disables their login unless they hold an admin role.

## Rules & Edge Cases

- An availability window must be at least 5 days long, can't start in the past, and its start date can't come after its end date.
- A guide's availability windows can't overlap each other.
- An availability window can't be shrunk to cut out a tour already assigned within it.
- Only one guide of a given type can be assigned to a specific vehicle on a tour, and a guide can only be linked to one vehicle per tour — for example, if a driver-guide is already assigned to Vehicle A, a second driver-guide can't also be assigned to Vehicle A on the same tour.
- Guides can't be assigned to or removed from a tour once its return date has already passed.
- A guide can't be deactivated while still assigned to an active tour.
- An availability window can't be deactivated or removed while it has an active tour attached to it.
- Downloading a passenger manifest for a tour with no traveling passengers returns a clear "no passengers found" result rather than an empty file.

## Limitations

- Guide types, licenses, and other classification values are free text configured by staff — there's no fixed built-in list of guide categories or license types.
- This covers guide staffing and availability — the tour and vehicle records guides are assigned to are covered in their own docs.

## Related Features

- [Tours](tours.md) — the tours guides are assigned to, and whose vehicles a guide can be linked to.
- [Passengers](passengers.md) — the traveler details that appear on a guide's passenger manifest.

## FAQ

**Q: Can two guides of the same type be assigned to the same vehicle on a tour?**
A: No — only one guide of a given type can be assigned to a specific vehicle on a tour.

**Q: Can I assign a guide to a tour they're not actually free for?**
A: No — a guide can only be assigned if they have an availability window that fully covers the tour's departure-to-return dates.

**Q: What happens if I try to deactivate a guide who's still assigned to a tour?**
A: It's refused — a guide can't be deactivated while still assigned to any active tour.

**Q: Does deactivating a guide also disable their login?**
A: Yes, unless they hold an admin role, in which case their login is left as-is.

**Q: Can I remove a guide from a tour after it's already returned?**
A: No — guide assignment and removal are both blocked once a tour's return date has passed.

**Q: What's in the passenger manifest I download for a guide?**
A: Every traveling passenger's contact details, passport information, pickup location, and allergy details for that tour or vehicle.
