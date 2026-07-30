---
feature: payments
status: completed
updated: 2026-07-30
review_note: ""
---

# Payments

Payments records every amount that moves against a booking, invoice, gift card, or account — whether it's a customer paying online, staff recording a manual payment, or a refund going back out.

## What it does

Every payment or refund is recorded as a **Transaction**. A transaction can apply against a booking, an invoice, a gift card, or an account balance — which one it's linked to determines what happens when it completes. Customers pay through the tenant's supported online payment options; staff can also record a payment manually (e.g. a bank transfer) when it didn't come through an online payment.

## Who uses it

| Role | Can do |
|------|--------|
| Customer | Pay online for their own bookings; view their own transaction history |
| Staff/Admin | View and manage transactions, record manual payments (admin-only), process refunds |
| System | Automatically pushes completed payments/refunds to the tenant's connected accounting system |

## How it works

**Paying.** When a payment against a booking succeeds, the booking's balance updates immediately, any pending payment-reminder email for it is cancelled, and if the booking was still a draft it's finalized. The transaction is then eligible to be synced to the tenant's connected accounting system, if that hasn't already happened.

**Recording a manual payment.** Staff with admin access can record a payment directly — for money that arrived outside the normal online payment flow — separate from the automated payment processing paths.

**Refunding.** A refund creates its own transaction record rather than editing the original payment, and reduces the booking's recorded paid amount by the refunded amount. When cancelling a booking, any refund owed is created and processed automatically as part of cancellation — no separate manual refund step is needed in that case.

## Rules & Edge Cases

- A refund can't go through a payment method that isn't set up for the tenant — with one exception: a refund triggered automatically by cancelling a booking is always allowed to proceed, regardless of that configuration.
- Every transaction tracks two separate statuses: whether the payment itself succeeded, and separately, whether it's been settled/reconciled with accounting — a transaction can be a successful payment that hasn't finished settling yet.
- A transaction's amount is what it covers; a separate pending-amount figure tracks how much of that is still awaiting completion, relevant for payment methods that don't complete instantly.

## Limitations

- This feature processes and records payments/refunds; it doesn't decide *how much* a booking owes or is due back — that comes from the Bookings and Billing features.
- Manual payment recording is restricted to admin users specifically, not general staff, since it bypasses the automated payment flow.
- Accounting sync for a transaction is a tenant-level configuration; not every transaction is guaranteed to sync immediately.

## Related Features

- [Bookings](booking.md) — a booking's payment/refund events flow through here, and cancellation-triggered refunds originate there.
- [Billing & Invoicing](billing.md) — an invoice's payment status is driven by transactions recorded against it here.
- Gift Cards — gift cards can be a payment target for a transaction. (not in this run's scope)

## FAQ

**Q: Does a customer need to do anything extra to get refunded when they cancel a booking?**
A: No — cancelling the booking automatically creates and processes the refund as part of that action.

**Q: Can any staff member record a manual payment?**
A: No — that's restricted to admin users specifically, since it's a way of recording payment received outside the normal online flow.

**Q: Why was my refund rejected?**
A: The payment method being used for the refund isn't configured for this tenant. The one exception is a refund created automatically by cancelling a booking, which always goes through.

**Q: What's the difference between a transaction's payment status and its settlement status?**
A: Payment status tells you whether the payment itself succeeded. Settlement status tracks separately whether that payment has been reconciled with the connected accounting system — a payment can succeed well before it finishes settling.
