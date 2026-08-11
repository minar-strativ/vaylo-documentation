---
feature: gift-cards
status: completed
updated: 2026-08-11
review_note: ""
---

# Gift Cards

Gift Cards let customers buy a personalized voucher for someone else, or let staff issue one directly (for example, as a goodwill gesture). Once active, a gift card can be spent — in full or in parts — against the cost of a booking, and every card's remaining balance and usage history is tracked automatically.

## What it does

- Customers buy a gift card through a public purchase flow: a recipient, an amount, a greeting text, and an image, paid for like any other purchase.
- Staff can also issue a gift card directly from the admin — an "internal" card that's active immediately, with no separate payment step.
- Staff maintain a reusable library of greeting texts (with translations) and an image gallery that customers and staff pick from.
- A recipient (or staff on their behalf) can spend a gift card against a booking's outstanding balance, in full or in part.
- Expired or long-unfinished cards are cleaned up automatically, and staff can see a sales/outstanding-balance summary for any date range.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create, view, and update gift cards (including issuing internal cards); manage the greeting text library and image gallery; apply a card to a booking on a customer's behalf; view sales/outstanding summaries; download a card as PDF. |
| Customer | Buy a gift card publicly with no login required; through the passenger portal, check a card's remaining balance and apply it to their own booking. |
| System (scheduler) | Automatically expires overdue cards and deletes long-unfinished draft cards. |

## How it works

### Buying or issuing a gift card

1. A customer picks a greeting text, an image, an amount, and the recipient's name and email, then pays for the card like any other purchase. The card starts out Inactive and its expiry date is set automatically from the tenant's configured expiry period.
2. Once payment succeeds, the card automatically becomes Active and is marked as paid — it's now ready to spend.
3. If the customer chose to have it emailed, the recipient receives the card as a PDF attachment.
4. Alternatively, staff can issue an internal gift card directly — it skips the payment step and is Active right away.

### Spending a gift card

1. The recipient (or a staff member on their behalf) enters the gift card code against a booking.
2. The system applies as much of the card's remaining balance as requested, capped by what's actually left on the card and by the booking's outstanding amount — never more than either.
3. If that clears the booking's balance in full, the booking is marked paid. The card's remaining balance drops by the amount used, and that usage is recorded against the specific booking.

### Managing gift cards

- Staff can update most fields on a still-Draft card; once a card is no longer a Draft, only its expiry date, note, image, and greeting text stay editable.
- A scheduled job automatically expires any card past its expiry date; a paid card that still had unspent balance when it expired is recorded so that unused value isn't lost from the books.
- A Draft card left unfinished past the tenant's configured number of days is deleted automatically.
- Staff can pull a sales and outstanding-balance summary for any date range.

## Rules & Edge Cases

- A gift card can only be spent on bookings priced in SEK — it can't be applied to a booking in any other currency.
- The amount applied is capped at the smallest of: the amount requested, the card's remaining balance, and the booking's outstanding amount.
- A gift card can't be applied to a booking that's already fully paid, and can't be applied for a zero or negative amount.
- A gift card only counts as valid to redeem if it is Active and hasn't passed its expiry date; an inactive, wrong-status, or expired card is rejected with the specific reason why.
- Once a card is no longer a Draft, its recipient details, amount, and code are locked — only expiry date, note, image, and greeting text can still change.
- "Internal" gift cards (issued directly by staff) skip the payment step entirely and are active right away.

## Limitations

- Gift cards are only supported in SEK — there's no multi-currency gift card balance.
- A card's expiry period for public purchases is set once per tenant configuration; there's no per-purchase custom expiry.
- A card can only be spent on a booking's outstanding balance — it's not a general store-credit balance usable outside a booking.

## Related Features

- [Payments](payments.md) — spending a gift card creates the same kind of payment transaction used for other booking payments.
- [Bookings](booking.md) — the booking whose outstanding balance a gift card reduces, and which may be marked fully paid as a result.

## FAQ

**Q: Can a customer buy a gift card without an account?**
A: Yes — buying a gift card is a public action, and only requires completing payment for it.

**Q: What happens if a gift card isn't fully spent before it expires?**
A: It automatically becomes Expired and can no longer be applied to a booking; if it still had unspent balance when it expired, that's recorded so the outstanding value isn't lost from the books.

**Q: Can a gift card cover a booking in any currency?**
A: No — a gift card can only be applied to a booking priced in SEK.

**Q: Can staff change a gift card's amount after it's been created?**
A: Only while it's still a Draft. Once it's no longer a Draft, the amount, recipient details, and code are locked — only the expiry date, note, image, and greeting text can still be edited.

**Q: What's the difference between an "internal" gift card and a regular one?**
A: An internal gift card is issued directly by staff (for example, as a goodwill gesture) and is active immediately with no payment step. A regular gift card is purchased by a customer and only becomes active once that payment succeeds.

**Q: Can a gift card be used for more than one booking?**
A: Yes, as long as it has remaining balance — it can be applied across multiple bookings until it's fully used or expires.
