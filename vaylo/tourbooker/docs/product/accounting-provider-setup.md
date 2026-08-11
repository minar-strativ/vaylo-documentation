---
feature: accounting/provider-setup
status: completed
updated: 2026-08-11
review_note: ""
---

# Accounting Provider Setup & Reference Data

Before any business activity can be recorded automatically, staff connect the platform to their accounting software and tell it where postings should land. This covers connecting a provider, syncing its reference data, and mapping accounts for each type of business event.

## What it does

- Staff choose and connect one accounting provider — Fortnox or PowerOffice — by authorizing that connection.
- The platform keeps that connection's access credentials refreshed automatically so it doesn't silently stop working.
- Staff sync the provider's projects, cost centers, and tax codes into the platform, and sync customer records to the provider.
- Staff map each business event and scenario to the specific accounts in the connected system that it should post to, optionally per currency.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Connect, configure, and switch accounting providers; sync reference data; map accounts for business events. |
| System | Refreshes connection credentials on schedule, and runs some reference-data syncs automatically. |

## How it works

### Connecting a provider

1. A staff member chooses a provider (Fortnox or PowerOffice) and authorizes the connection through that provider's own sign-in flow.
2. The platform stores the resulting access credentials and keeps refreshing them automatically ahead of expiry, so the connection stays live without staff intervention.
3. Connecting a new provider automatically disconnects and deactivates whichever provider was previously configured — only one can be active for the tenant at a time.

### Syncing reference data

- Staff sync the connected provider's projects and cost centers into the platform — the provider's own way of tagging where revenue or cost belongs (for example, by department or initiative).
- Staff sync the provider's tax codes so the right rate can be referenced when posting.
- Customer records are synced to the provider so postings can reference the right customer.

### Mapping accounts

- For each tracked business event (like a new booking or a gift card sale) and each scenario under it, staff pick which debit and credit accounts in the connected provider it should post to — optionally with a different account per currency.
- This mapping is what lets the same event post correctly no matter which accounting provider is connected.

## Rules & Edge Cases

- Only one accounting provider connection can be active for a tenant at any time; connecting or activating one automatically deactivates all others.
- Connection credentials are refreshed automatically on their own schedule so the connection doesn't expire unexpectedly.

## Limitations

- Only Fortnox and PowerOffice are supported as accounting providers today.
- This area only sets up *where* postings go — it doesn't itself create any accounting entries; see [Accounting Vouchers & Logs](accounting-vouchers-and-logs.md) for that.

## Related Features

- [Accounting Vouchers & Logs](accounting-vouchers-and-logs.md) — uses the provider connection and account mapping set up here to actually post business events.
- [VAT & Tax Classes](vat.md) — the tenant's own tax setup, separate from the tax codes synced in from the accounting provider here.

## FAQ

**Q: What happens to the old provider's connection when we connect a new one?**
A: It's automatically disconnected and deactivated — only one provider can be active at a time.

**Q: Do we need to re-authorize the connection regularly?**
A: No — the platform refreshes the connection's credentials automatically ahead of expiry.

**Q: What are "projects" and "cost centers" in this context?**
A: They're the accounting provider's own categories for tagging where revenue or cost belongs (for example, by department). This feature just mirrors them in so staff can assign postings to the right one.

**Q: Why would the same business event need different account mappings?**
A: Because a "scenario" under an event can represent different specific situations (for example, different payment types), and each may need to post to different accounts — and a mapping can also vary by currency.
