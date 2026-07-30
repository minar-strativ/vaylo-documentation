---
feature: billing
status: completed
updated: 2026-07-30
review_note: ""
---

# Billing & Invoicing

Billing turns a booking's charges — the tour price, supplements, extras, and fees — into a formal invoice the customer can be billed against, and keeps that invoice's lifecycle (draft, issued, voided, or credited) consistent.

## What it does

Every chargeable item on a booking becomes a **Billing Line** — one line per charge, each with its own price and VAT. These lines are grouped onto an **Account Invoice** for that booking. An invoice starts as an editable Draft; issuing it locks the content, assigns it its final invoice number and payment reference, and — where the tenant has accounting integration enabled — sends it there automatically.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | View billing lines, create and issue invoices, void or credit an issued invoice, download and email invoices |

## How it works

**Building an invoice.** As a booking accumulates charges, each one is recorded as its own billing line. Staff review the accumulated lines for a booking and generate a draft invoice from them — the draft can still be edited.

**Issuing.** Issuing an invoice locks it: no further edits, a permanent invoice number and payment reference are assigned, and if the booking was still a Quote, issuing the invoice also accepts that quote in the same step. If the tenant has accounting integration turned on, the invoice is sent there as part of issuing.

**Voiding.** If an issued invoice turns out to be wrong and nothing has been paid against it yet, staff void it — its billing lines are unlinked and a snapshot of what it contained is kept on the invoice record. Voiding is blocked once any payment has been recorded, or once the invoice is already booked in the connected accounting system.

**Crediting.** Once an invoice has been paid, it can no longer be voided — instead, staff issue a credit note against it, which reverses its billing lines rather than deleting them.

## Rules & Edge Cases

- An invoice can't be issued twice, and can't be issued with zero billing lines on it.
- Voiding only applies to an Issued invoice that hasn't been paid or partially paid yet; a paid invoice must be credited instead.
- Voiding is also blocked if the invoice has already been booked in the connected accounting system, since it can no longer be undone there.
- Crediting only applies to an invoice that's actually Issued.
- An invoice's status (Draft / Issued / Void) and its payment status (Unpaid / Partially Paid / Paid) are tracked separately — an invoice can be Issued and still fully Unpaid, for example.
- Every billing line calculates its own VAT individually, rather than the invoice calculating VAT once as a whole.

## Limitations

- This feature manages the invoice document and its lifecycle; it doesn't calculate booking prices, discounts, or fees itself — those come from whichever feature (Tours, Bookings, Coupons) generated the charge as a billing line.
- Payment collection and refund processing happen in Payments, not here — this feature only reflects an invoice's resulting payment status.
- Sending invoices to an external accounting system is a configuration toggle per tenant, not something every invoice does.

## Related Features

- [Bookings](booking.md) — a booking's charges become this feature's billing lines.
- [Tours](tours.md) — tour pricing feeds into a booking's billing lines.
- Payments — payments recorded against a booking are what move an invoice from Unpaid toward Paid. (link pending — not yet documented in this run)
- Coupons — coupon discounts appear as adjustments on billing lines. (not in this run's scope)

## FAQ

**Q: Can I edit an invoice after it's been issued?**
A: No — issuing locks the invoice completely. If something's wrong and nothing's been paid, void it and create a new draft; if it's been paid, issue a credit note instead.

**Q: What's the difference between voiding and crediting an invoice?**
A: Voiding only works on an unpaid, issued invoice and unlinks its billing lines outright. Crediting works on an invoice that's been paid and generates a credit note that reverses the charges instead of removing them.

**Q: Why can't I void this invoice?**
A: Either it isn't currently Issued, it has a payment (full or partial) already recorded against it, or it's already been booked in the connected accounting system — any of these blocks voiding.

**Q: Does issuing an invoice automatically confirm a quote?**
A: Yes — if the booking was still in Quote status, issuing its invoice accepts the quote as part of the same action.
