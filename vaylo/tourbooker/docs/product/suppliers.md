---
feature: suppliers
status: completed
updated: 2026-08-11
review_note: ""
---

# Suppliers

Suppliers is the directory of vendors the business works with — transport operators, flight ticket sources, accommodation providers, and others — along with their contact details, financial defaults, and accounting settings.

## What it does

- Staff maintain supplier records: contact details, currency and language, address, bank/payment details (IBAN, SWIFT, giro), default cost/VAT accounts, and a credit period for invoices.
- Suppliers are grouped by supplier type (for example, transport or flights), and can carry file attachments and tags.
- A supplier's own system can be given a company-level access token to fetch its own invoices and register the costs it's billed for, without needing a staff login.

This capability continues in its own doc:

- [Supplier Invoices & Cost Registration](suppliers-invoicing-and-costs.md) — recording what a supplier invoices, reconciling it against booking costs, and sending it to the tenant's accounting system.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create, edit, and manage suppliers, supplier types, and attachments. |
| Supplier's own system | With a company-level access token, list its own invoices and register its own costs against bookings. |

## Related Features

- [Supplier Invoices & Cost Registration](suppliers-invoicing-and-costs.md) — invoicing and cost reconciliation for the suppliers set up here.
- [VAT & Tax Classes](vat.md) — the cost and VAT accounts a supplier's defaults point to.
- [Accounting Integration](accounting.md) — where a supplier invoice can be sent once recorded.

## FAQ

**Q: Can a supplier belong to more than one supplier type?**
A: Yes — a supplier can be tagged with multiple supplier types at once.

**Q: Can a supplier's own system access their invoices directly?**
A: Yes — a supplier can be given a company-level access token that lets their own system list invoices and register costs, separate from staff logins.

**Q: Where do a supplier's default cost and VAT accounts come from?**
A: They're set directly on the supplier record and used as defaults when recording that supplier's invoices.
