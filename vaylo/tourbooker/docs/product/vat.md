---
feature: vat
status: completed
updated: 2026-08-11
review_note: ""
---

# VAT & Tax Classes

VAT & Tax Classes is where staff set up the tax rates the business charges, and connect each one to the tenant's accounting setup. Once configured, staff simply pick the right VAT class when pricing a tour, supplement, or other sellable item — customers never see or interact with this feature directly.

## What it does

- Staff define VAT classes: a name, a tax percentage, whether the tax line shows on invoices, and which broader tax category (VAT type) it belongs to.
- Staff define VAT types — the broader tax categories VAT classes are grouped under (for example, standard vs. reduced rate).
- Staff maintain VAT accounts and cost accounts, which link a VAT class to where its tax gets recorded in the tenant's accounting system.
- Staff can turn any of these on or off, and browse VAT classes filtered by VAT type.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create, edit, and activate/deactivate VAT classes, VAT types, VAT accounts, and cost accounts. |

There is no customer-facing role for this feature — customers only ever see the resulting tax rate on a tour, supplement, or invoice, never the VAT class configuration itself.

## How it works

1. Staff set up VAT types to represent the tenant's tax categories.
2. Staff create VAT classes under those types, each with its own tax percentage, whether it appears on invoices, and the accounting accounts its tax should post to.
3. Elsewhere in the system, staff pick the appropriate VAT class when configuring a tour or supplement's price, so the right tax rate is applied and recorded automatically.
4. Staff can deactivate a VAT class, VAT account, or cost account once it's no longer needed — as long as the VAT class isn't still selected on any active tour or supplement.

## Rules & Edge Cases

- A VAT type can only have one VAT class at any given tax percentage — creating or editing a class into a percentage already used by another class of the same type is rejected.
- A VAT class's tax percentage must be between 0 and 100.
- Every VAT class name must be unique.
- The built-in "No VAT" class is permanent: its name and percentage can never be changed, and its active/inactive status can never be changed either.
- A VAT class currently selected on any active tour or active supplement can't have its status changed — it has to be removed from all of them first before it can be deactivated or reactivated.
- "Will show in invoice" only controls whether the tax line is visible on the invoice — it doesn't control whether the tax itself is applied.

## Limitations

- This feature only defines tax rates and where they post in the accounting system — it doesn't calculate or apply tax to a specific sale; that happens wherever a VAT class is used (tours, supplements, billing).
- There's no customer-facing view of VAT classes — tax only shows up indirectly, as a line on pricing or an invoice.

## Related Features

- [Tours](tours.md) and [Supplements & Add-ons](supplements.md) — where a VAT class is actually selected and applied to a sellable item's price.
- [Billing & Invoicing](billing.md) — where a VAT class's rate and invoice visibility setting take effect on a customer's invoice.

## FAQ

**Q: Can I delete or deactivate a VAT class that's currently in use?**
A: No. A VAT class selected on any active tour or supplement can't be deactivated until it's removed from all of them.

**Q: Can two VAT classes have the same tax percentage?**
A: Not within the same VAT type — each tax percentage can only be used once per VAT type.

**Q: What does "Will show in invoice" mean if it's turned off?**
A: The tax is still applied and recorded as usual; the customer just won't see a separate tax line for it on their invoice.

**Q: Can I edit the "No VAT" class?**
A: No — its name, tax percentage, and active status are all fixed and can never be changed.

**Q: Do customers ever see or choose a VAT class directly?**
A: No — customers only see the resulting tax rate reflected in a tour's price or on an invoice; the VAT class setup itself is staff-only.
