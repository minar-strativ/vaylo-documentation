---
feature: accounting/vouchers-and-logs
status: completed
updated: 2026-08-11
review_note: ""
---

# Accounting Vouchers & Logs

Once a provider is connected and mapped (see [Accounting Provider Setup & Reference Data](accounting-provider-setup.md)), the platform automatically records business activity as accounting entries — and keeps a log of every attempt so staff can see what succeeded and fix what didn't.

## What it does

- When a tracked business event happens — a booking is created, a tour departs, a gift card is sold, redeemed, or expires, an invoice is settled, and similar events — the platform automatically posts a matching accounting entry to the connected provider.
- Every posting attempt is logged with what was sent, what came back, and whether it succeeded.
- If a posting failed (or otherwise needs to go again), staff can resend that one log, or resend every log matching a filter.
- Whether a posting succeeded is reflected back onto the related booking or payment so staff can see its accounting status at a glance.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | View accounting logs; resend a single failed log or resend logs in bulk by filter. |
| System | Automatically posts accounting entries when tracked business events occur, and records the attempt as a log. |

## How it works

1. A tracked business event occurs (for example, a booking is created or a gift card is sold).
2. The platform builds the matching accounting entry, using the account mapping set up for that event, and sends it to the connected provider.
3. The attempt — request, response, and whether it succeeded — is saved as a log tied to the event, and to the related booking or payment transaction.
4. That booking's or transaction's own accounting status updates to reflect whether the posting reached the books.
5. If a posting failed, a staff member can resend that specific log, or resend every log matching a filter, without redoing the underlying booking or payment action.

## Rules & Edge Cases

- A log that has already been successfully resent cannot be resent again — a repeat attempt is rejected.
- Logs for the automatic post-tour-departure and post-yacht-departure events can never be resent manually — those are only ever re-sent by the platform's own automatic process.
- Bulk-resending logs by filter always skips the post-departure, invoice-payment, and settlement-invoice event types, since those are handled automatically rather than by manual resend.

## Limitations

- Resending only re-sends the previously recorded posting — it doesn't let staff edit what gets sent.
- Some event types are deliberately excluded from manual and bulk resend (see Rules & Edge Cases) and can only be retried by the platform's own automatic process.

## Related Features

- [Accounting Provider Setup & Reference Data](accounting-provider-setup.md) — the provider connection and account mapping that determine where and how these postings land.
- [Bookings](booking.md) and [Gift Cards](gift-cards.md) — among the sources of the business events recorded here.

## FAQ

**Q: What happens if an accounting posting fails?**
A: It's recorded as a failed log entry. Staff can resend that specific log, or resend all matching logs in bulk, once the underlying issue is fixed.

**Q: Can staff manually resend a post-departure accounting entry?**
A: No — those are only ever resent automatically by the platform, never by a manual staff action.

**Q: Does a failed accounting posting undo the underlying booking or payment?**
A: No — the booking or payment itself is unaffected; only its accounting status reflects that the posting hasn't succeeded yet.

**Q: How do I know if a booking's accounting entry actually reached the books?**
A: The booking (or the related payment transaction) carries its own accounting-sent status, updated based on whether the posting succeeded.
