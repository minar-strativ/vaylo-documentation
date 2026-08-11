---
feature: organizations
status: completed
updated: 2026-08-11
review_note: ""
---

# Organizations

Organizations lets staff group customers and bookings under a company, travel agent, or other entity — giving a consolidated view of everyone and everything associated with it, rather than treating every booking as a one-off from an individual.

## What it does

- Staff create an organization record with contact details, address, VAT/organization number, and its own default currency and language.
- A passenger can be linked to one or more organizations, and a booking can be tagged as belonging to a specific organization.
- Staff can view every passenger linked to a given organization.
- Staff can activate or deactivate an organization, as long as it isn't currently attached to any active booking.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create, edit, and activate/deactivate organizations; view an organization's linked passengers. |

## How it works

1. Staff create an organization, choosing its type (Individual, Company, Agent, or Agent Direct) and entering its contact and address details.
2. Passengers can be linked to the organization, and bookings can be tagged as made on its behalf.
3. Staff can pull up the full list of passengers linked to an organization at any time.
4. When an organization is no longer needed, staff can deactivate it — as long as it isn't attached to any currently active booking.

## Rules & Edge Cases

- An organization's active/inactive status can't be changed while it's still attached to any active booking.

## Limitations

- This feature only groups passengers and bookings under an organization — it doesn't itself manage billing, contracts, or agreements with that organization.

## Related Features

- [Passengers](passengers.md) — the passenger records that can be linked to an organization.
- [Bookings](booking.md) — the bookings that can be tagged as belonging to a specific organization.

## FAQ

**Q: Can an organization be deactivated at any time?**
A: Only if it isn't currently attached to any active booking — otherwise the status change is rejected.

**Q: What are the different organization types for?**
A: They distinguish ordinary individual customers from corporate accounts (Company) and travel agents (Agent, Agent Direct).

**Q: Can one passenger belong to more than one organization?**
A: Yes — a passenger can be linked to multiple organizations at once.
