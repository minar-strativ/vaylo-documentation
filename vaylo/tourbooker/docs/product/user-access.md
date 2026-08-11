---
feature: user-access
status: completed
updated: 2026-08-11
review_note: ""
---

# User & Access Management

User & Access Management covers the platform's accounts, roles, and permissions — who can log in, to which portal, and what they can do once they're in.

## What it does

- The platform supports four kinds of accounts: super admin, staff/admin, tour guide, and passenger.
- Each account belongs to one or more roles (groups), and each role carries a set of specific permissions (what admin actions it allows) or portal access (admin site vs. passenger site).
- Staff create and manage accounts, assign roles, reset passwords, and activate/deactivate accounts.
- Every account has a profile holding personal details (contact info, date of birth, passport, emergency contact, and similar).

This capability continues in its own doc:

- [Passenger Impersonation & GDPR Anonymisation](user-access-impersonation-and-privacy.md) — staff viewing the passenger portal as a specific passenger for support purposes, and permanently erasing a passenger's personal data on request.

## Who uses it

| Role | Can do |
|------|--------|
| Super Admin | Everything an Admin can, plus manage roles/permissions themselves and other super admins. |
| Staff/Admin | Create and manage accounts (within their assigned scope), assign roles, reset passwords, activate/deactivate accounts. |
| Tour Guide | Logs into the admin site with a role scoped to tour-guide duties. |
| Passenger | Logs into the passenger portal to manage their own bookings. |

## How it works

1. Staff create an account and choose its type (admin, tour guide, or passenger) and role(s); the account's login access (admin site vs. passenger portal) follows automatically from that choice.
2. A newly created account is emailed a one-time password and prompted to set their own; the account can also request a password reset at any time.
3. Staff can deactivate an account (except their own) to revoke its access without deleting it, and reactivate it later.
4. Roles are managed centrally: each role's name and its set of permissions can be edited, except for the platform's own built-in roles (super admin, admin, passenger, tour guide), whose names are fixed.

## Rules & Edge Cases

- Creating or updating an account requires selecting at least one role — an account with no role is rejected.
- A staff member can't deactivate their own account.
- The platform's four built-in roles (super admin, admin, passenger, tour guide) can have their permissions edited, but their names can never be changed.

## Limitations

- Role and permission management is centralized and platform-wide — there's no per-tenant custom role hierarchy beyond assigning the built-in roles and adjusting their permissions.

## Related Features

- [Passenger Impersonation & GDPR Anonymisation](user-access-impersonation-and-privacy.md) — support and compliance actions built on top of these accounts.
- [Passengers](passengers.md) — the passenger-facing record tied to a passenger account.

## FAQ

**Q: Can a passenger account also access the admin site?**
A: Only if it's also given a role beyond just Passenger — otherwise a passenger account is portal-only.

**Q: Can staff rename the built-in roles like "Admin" or "Passenger"?**
A: No — those names are fixed, though their permissions can still be adjusted.

**Q: What happens if staff try to deactivate their own account?**
A: It's rejected — a staff member can't deactivate their own account.
