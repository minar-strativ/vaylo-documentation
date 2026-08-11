---
feature: accounting
status: completed
updated: 2026-08-11
review_note: ""
---

# Accounting Integration

Accounting Integration connects the platform to the tenant's external bookkeeping software, so that business activity — bookings, gift card sales, payments, and more — is automatically recorded in the tenant's own books instead of needing manual entry.

## What it does

The platform can connect to one external accounting system at a time — currently Fortnox or PowerOffice. Once connected, it automatically turns tracked business events into accounting entries in that system and keeps a record of every attempt, whether it succeeded or not.

This capability splits into two areas, covered in their own docs:

- [Accounting Provider Setup & Reference Data](accounting-provider-setup.md) — connecting to a provider, and mapping its projects, cost centers, tax codes, and accounts.
- [Accounting Vouchers & Logs](accounting-vouchers-and-logs.md) — how business events automatically post to the connected provider, and how staff review or resend failed postings.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Connect and configure an accounting provider, sync its reference data, and review or resend accounting activity. |
| System | Automatically posts accounting entries when tracked business events occur, and keeps credentials refreshed. |

There is no customer-facing role — this is purely a back-office integration between the platform and the tenant's own accounting software.

## Related Features

- [Billing & Invoicing](billing.md) — invoices and billing lines are among the business activity this feature can record in the connected accounting system.
- [Gift Cards](gift-cards.md) — gift card sales, redemptions, and expiry are recorded as accounting entries through this feature.

## FAQ

**Q: Can a tenant connect to more than one accounting system at once?**
A: No — only one accounting provider connection is active at a time.

**Q: What happens if a posting to the accounting system fails?**
A: It's recorded as a failed log entry that staff can review and resend. See [Accounting Vouchers & Logs](accounting-vouchers-and-logs.md).

**Q: Do customers ever interact with this feature?**
A: No — it's entirely a staff/back-office integration between the platform and the tenant's own bookkeeping software.
