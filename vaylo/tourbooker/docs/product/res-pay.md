---
feature: res-pay
status: completed
updated: 2026-08-11
review_note: ""
---

# ResPay Payments

ResPay lets staff request a one-off payment from a customer without needing a booking behind it — for example, charging for something outside the normal booking flow. Staff set an amount and a due date, the customer gets a payment link, and the request is tracked through to payment (or expiry) automatically.

## What it does

- Staff create a payment request: an amount, a currency, a due date, and the customer's email — choosing to notify the customer by email, SMS, or both.
- The system generates a unique, one-time payment link for that request.
- The customer opens the link, sees the amount, due date, and available payment methods, and pays through one of them.
- The request's status updates automatically as it's paid, expires, or is canceled, and staff can mark a paid request as accounted once it's recorded for accounting.
- Reminders go out to the customer before the link expires, and to the staff member who created it if it's about to expire unpaid.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and list payment requests. Cancel, mark accounted, resend a reminder, or view request detail (requires standard staff permissions). Export requests to Excel and view the paid/outstanding dashboard summary. |
| Customer | Open a payment link (no login needed) and pay through one of the offered payment methods. |
| System (scheduler) | Automatically expires overdue requests and sends the internal expiry warning; these run unattended, not as a staff action. |

## How it works

### Creating and sending a payment request

1. A staff member enters the amount, currency, due date, and the customer's email, and chooses whether to notify by email, SMS, or both.
2. The system generates a unique payment code and payment link for the request and, if requested, immediately emails the customer that link.
3. A reminder is scheduled ahead of the due date so the customer is prompted again before the link expires.

### Customer payment

1. The customer opens the payment link's page, which shows the company's name and logo, the amount, the due date, and the payment methods available (manual, refund, and invoice payment are never offered here since they don't apply to a link-based payment).
2. The customer picks a payment method and completes payment through it.
3. Once the payment provider confirms success, the request's status becomes Paid, and the staff member who created the request gets an internal confirmation email.

### Reminders and expiry

- Staff can resend a reminder to the customer manually at any time before the request is paid.
- If the due date passes without payment, the request automatically becomes Expired and the link stops accepting payment.
- The day before an unpaid request's due date, the staff member who created it receives an email listing every customer whose link is about to expire.

### Managing requests

- Staff can cancel a request that hasn't been paid or expired yet.
- Once a request is Paid, staff can mark it as Accounted to show it's been recorded for accounting, keeping a record of who did so and when.
- Staff can export all payment requests to an Excel report, and view a dashboard summary comparing this month's paid and outstanding totals to last month's.

## Rules & Edge Cases

- A payment request can only be created if the tenant has an active Resemolnet payment connection configured — otherwise creation is rejected.
- A request that is already Paid or Expired cannot be canceled.
- Only a Paid request can be marked Accounted; Pending, Expired, Failed, or Canceled requests are rejected.
- A reminder cannot be sent for a request that has already been paid.
- The moment a request's due date passes, its payment page and status immediately show it as Expired — even before the scheduled cleanup job runs — so a customer can never pay a link past its due date.
- Every payment link's code is unique, so a link can never be shared between two requests.
- Whether requests automatically email or SMS customers, whether staff get expiry/paid notifications, and how long a link stays valid (and how far ahead of that the internal expiry warning goes out) are all configurable per tenant.
- The public payment page and the customer's checkout steps need no staff login — they identify the request purely by its link's unique code, so anyone holding the link can view and pay it.

## Limitations

- ResPay is not tied to a booking — it does not, on its own, apply a payment to any specific booking, invoice, or order; it only tracks the standalone request and its payment.
- Only Klarna, Trustly, and Altapay are supported as customer-facing payment methods for a ResPay link.
- Expiry and reminder timing are fixed per tenant configuration; there's no per-request override of when a link expires or when reminders fire.

## Related Features

- [Payments](payments.md) — a completed ResPay payment creates the same kind of transaction record used for booking payments, sharing that payment history.

## FAQ

**Q: Does a customer need an account to pay a ResPay link?**
A: No. The link is public and identified by its own unique code — the customer just opens it and pays, no login required.

**Q: What happens if the customer doesn't pay before the due date?**
A: The request automatically becomes Expired and the link stops working. The staff member who created it is warned by email the day before this happens.

**Q: Can staff cancel a payment request after it's been paid?**
A: No. Once a request is Paid (or already Expired), it can no longer be canceled.

**Q: What does marking a request "Accounted" mean?**
A: It's a separate flag staff set on a Paid request to show it's been recorded for accounting purposes, along with who marked it and when.

**Q: Which payment methods can a customer use?**
A: Whichever of Klarna, Trustly, or Altapay the tenant has configured — manual, refund, and invoice payment methods are never shown on a payment link.

**Q: Is a ResPay payment linked to a booking?**
A: No — it's a standalone request. It creates the same kind of transaction record used elsewhere for booking payments, but doesn't attach itself to any specific booking.
