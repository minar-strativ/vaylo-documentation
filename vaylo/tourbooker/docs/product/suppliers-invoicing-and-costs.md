---
feature: suppliers/invoicing-and-costs
status: completed
updated: 2026-08-11
review_note: ""
---

# Supplier Invoices & Cost Registration

This closes the loop between what the platform estimates a supplier will cost for a booking and what that supplier actually invoices — recording the invoice, splitting it across accounts, and reconciling it booking by booking.

## What it does

- Staff record a supplier invoice: the amount, its VAT, a due date, and which cost and VAT accounts it should post against.
- Staff (or the supplier's own system, via a company access token) register what the supplier actually charged for specific bookings, against what the platform estimated for the rooms, extras, or flights it supplied.
- Staff can see an invoice's financial summary (total, VAT, what's been allocated vs. what's left), and a status summary across all invoices.
- A supplier invoice can be sent to the tenant's connected accounting system, where it's automatically marked once accepted.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Record supplier invoices, register their costs against bookings, view financial/status summaries, send an invoice to accounting. |
| Supplier's own system | With a company-level access token, list its own invoices and register its own costs against bookings. |

## How it works

### Recording a supplier invoice

1. Staff enter the invoice's amount, VAT, invoice date, and (optionally) a due date — if none is given, it defaults to the invoice date plus the supplier's own configured credit period.
2. The invoice amount is automatically split into a cost-account entry and a VAT-account entry, so it reconciles against those two accounts from the start.
3. If the invoice covers specific bookings, staff can attach the amount billed for each one directly when creating it.

### Reconciling costs against bookings

1. For each booking a supplier is involved in, staff (or the supplier's own system) register what the supplier actually charged — split by currency and by whether it was for a room, an extra, or a flight itinerary.
2. Registering a cost the second time for the same booking, supplier, currency, and invoice adds to what was already registered, rather than creating a duplicate — unless that combination isn't allowed to be updated, in which case it's rejected.
3. Registering a cost marks the underlying booking cost line(s) as invoiced, so staff can see at a glance which supplier costs still need an invoice and which are already covered.

### Reviewing and sending to accounting

- Staff can pull a financial summary for any invoice: its total, VAT, how much has been allocated to accounts and bookings, and how much remains.
- Staff can see a status summary across all supplier invoices — how much is pending, paid, and overdue.
- If an invoice is marked to send to accounting, the platform automatically builds and sends it to the tenant's connected accounting system, then marks the invoice "Sent to Accounting" once accepted.

## Rules & Edge Cases

- A supplier invoice's due date defaults to invoice date plus the supplier's own credit period, if not set explicitly.
- Re-registering a cost for the same booking, supplier, currency, and invoice combination adds to the existing amount rather than duplicating it — unless updates aren't allowed for that combination, in which case it's rejected as a duplicate.
- An invoice's cost and VAT amounts are always split into separate account entries automatically when it's created.

## Limitations

- Cost reconciliation only covers rooms, extras, and flight itineraries as the sources of a supplier's booking-level cost — not every possible cost type on a booking.
- Sending an invoice to accounting depends on the tenant already having an accounting provider connected (see [Accounting Integration](accounting.md)); it can't be sent otherwise.

## Related Features

- [Suppliers](suppliers.md) — the supplier directory and default accounts this invoicing draws from.
- [Bookings](booking.md) — the bookings whose room/extra/flight costs get reconciled against a supplier's actual invoice here.
- [Accounting Integration](accounting.md) — where a supplier invoice is posted once sent.

## FAQ

**Q: What happens if I register the same supplier cost twice for a booking?**
A: It adds to what was already registered rather than duplicating it — unless that combination isn't allowed to be updated, in which case it's rejected.

**Q: Can a supplier see their own invoices without a staff login?**
A: Yes — with a company-level access token, a supplier's own system can list its invoices and register its own costs.

**Q: What's the difference between "estimate cost" and "invoice cost"?**
A: Estimate cost is what the platform expected the supplier to charge, based on its own pricing for the room/extra/flight; invoice cost is what the supplier actually billed. Staff reconcile the difference.

**Q: Does sending a supplier invoice to accounting require anything extra?**
A: Yes — the tenant needs an accounting provider already connected; otherwise the invoice can't be sent.
