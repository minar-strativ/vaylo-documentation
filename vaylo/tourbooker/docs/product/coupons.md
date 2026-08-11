---
feature: coupons
status: completed
updated: 2026-08-11
review_note: ""
---

# Coupons

Coupons let staff offer a discount code customers can enter when booking a tour. A coupon can knock a percentage or a fixed amount off the booking cost, apply to every tour or only specific ones, and is capped by an overall usage limit that the system enforces automatically.

## What it does

- Staff create a discount code with a percentage or fixed-amount discount, a validity period, a total usage limit, and either all tours or a hand-picked list of tours it applies to.
- Customers can check a coupon's validity and discount for a specific tour before booking.
- Applying a coupon to a completed booking counts against its usage limit; cancelling that booking gives the usage back.
- Staff can see every booking that has used a given coupon, and turn a coupon on or off at any time.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create, edit, activate/deactivate coupons; see which tours a coupon applies to and which bookings have used it. |
| Customer | Enter a coupon code while browsing or booking a tour to see if it's valid and what discount it gives — no login required. |

## How it works

### Creating a coupon

1. Staff set a unique code, a discount (percentage or fixed amount), how long it's valid, a total use limit, and whether it applies to all tours or a specific list.
2. For a fixed-amount coupon, the system automatically converts that discount into every other currency the tenant supports, so the coupon shows a sensible discount regardless of which currency a customer is browsing in.
3. The coupon's end-of-validity date always covers the full last day, so it stays usable through the end of that calendar day.

### Checking and applying a coupon

1. While browsing or booking a tour, a customer enters a coupon code. The system immediately reports whether it's valid for that tour and what discount it would apply.
2. When the booking is confirmed with the coupon attached, the discount is applied to the booking cost and the coupon's usage count goes up by one.
3. If that booking is later cancelled, the coupon's usage count is given back and the record of that usage is removed.

### Managing coupons

- Staff can turn a coupon on or off directly, as long as its usage limit hasn't already been reached.
- Once a coupon has been used at least once, its code, discount, and discount type can no longer be changed — only its validity dates, use limit, attached tours, description, and active status remain editable.
- Staff can view every booking that has used a specific coupon, filterable by booking reference, status, and date.

## Rules & Edge Cases

- A coupon's discount can never be 0 — creating or saving one with a zero discount is rejected.
- A coupon applies either to every tour ("All Tour") or only to the specific tours attached to it ("Specific Tour") — never a mix decided per booking.
- A use limit of 0 means unlimited use; the coupon never auto-deactivates from usage.
- A coupon automatically deactivates itself once its usage count reaches its use limit, and reactivates itself if usage drops back below the limit — for example, after a booking that used it is cancelled.
- Once a coupon has been used, its active status can't be changed by hand if the use limit has already been reached — the system reports the limit has been exceeded.
- A fixed-amount coupon's discount never exceeds the booking's own cost — it can bring a booking down to zero, but never below it.
- A coupon only validates successfully if it is active and today falls within its validity dates; an expired, not-yet-active, or deactivated coupon is treated as invalid.
- Checking a coupon against a tour that doesn't exist or isn't active is rejected as an invalid tour, not an invalid coupon.
- Applying an unknown, inactive, or usage-exhausted coupon code to a booking is rejected outright.

## Limitations

- A coupon's use limit is shared across all customers — there's no separate "once per customer" limit.
- A coupon can only be all-tour or a fixed list of specific tours; it can't be scoped to a tour category or set of criteria.
- The discount is a flat percentage or fixed amount — there's no tiered or stacking discount logic within a single coupon.

## Related Features

- [Bookings](booking.md) — where a coupon's discount is actually applied to a booking's cost, and where cancelling a booking reverses the coupon's usage.
- [Tours](tours.md) — the tours a "Specific Tour" coupon is attached to, and what customers see a coupon's discount against.

## FAQ

**Q: Can a coupon apply to only some tours?**
A: Yes — set its type to "Specific Tour" and pick which tours it applies to. Otherwise, "All Tour" makes it usable on any tour.

**Q: What happens to a coupon's usage count if a booking is cancelled?**
A: The usage count is given back and the record of that booking having used the coupon is removed — as if it was never used for that booking.

**Q: Can I change a coupon's discount after it's been used?**
A: No. Once a coupon has been used at least once, its code, discount amount, and discount type are locked; only its dates, use limit, tours, description, and active status can still be changed.

**Q: What does a use limit of 0 mean?**
A: Unlimited use — the coupon never automatically deactivates based on how many times it's been used.

**Q: Can a coupon make a booking cost less than zero?**
A: No. A fixed-amount coupon's discount is capped at the booking's own cost, so the booking can go to zero but never negative.

**Q: Does checking a coupon code require the customer to be logged in?**
A: No — checking a coupon's validity and discount for a tour is a public action available while browsing.
