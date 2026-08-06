---
feature: supplements
status: completed
updated: 2026-08-06
review_note: ""
---

# Supplements & Add-ons

A Supplement is an optional (or sometimes mandatory) add-on — an extra activity, service, or piece of equipment — that can be attached to tours, bookings, and custom tour offers. Staff maintain the supplement catalog once, and it's reused wherever add-ons are offered across the platform.

## What it does

This is the master catalog of add-ons: their name, description, price, how they're charged (once per booking, per day, per week, or per night — flat or per passenger), which category they belong to, and their tax treatment. Every supplement is automatically priced in every currency the tenant supports, and can be translated into multiple languages.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and edit supplements and categories, adjust per-currency pricing, add translations, upload images, deactivate a supplement |

## How it works

**Creating a supplement.** Staff enter its name, description, price, pricing unit, and category. If no tax class is chosen, it defaults to "No VAT". As soon as it's saved, the system automatically creates a matching translation in the tenant's default language and generates a converted price in every currency the tenant supports — no extra steps needed.

**Organizing the catalog.** Supplements are grouped into categories, which can themselves be nested under a parent category for browsing. A duplicate category name is rejected outright rather than silently allowed.

**Pricing per currency.** Once a supplement exists, staff can override its automatically-converted price for a specific currency without touching the base price — useful when a market needs a different price point than a straight currency conversion would produce.

**Translating.** Staff add a translation for each additional language a supplement or category needs. Requesting a translation for a language that hasn't been added yet simply returns an empty result, not an error.

**Managing images.** Staff can upload, replace, or remove a promotional image on a supplement.

**Retiring a supplement.** Supplements and categories are deactivated rather than deleted — there's no delete option, only status toggling. Deactivating a supplement is blocked while it's still attached to any active booking, tour, or custom tour offer.

## Rules & Edge Cases

- A supplement can only be priced one of eight ways: once per booking, per day, per week, or per night, each either as a flat charge or multiplied by the number of passengers. The default is once per person per booking.
- A supplement can be marked as not contributing to the total price even though it's still shown to the customer — useful for informational or already-included items.
- Adding a new currency for the tenant automatically prices every active supplement in that currency, with no manual step required.
- A converted price in a foreign currency is rounded to the nearest 5 units — for example, a converted price of 123 becomes 125.
- Supplements can be grouped so customers pick just one option (like choosing a meal) or multiple options from a set, and a group can require a selection.
- Only tags belonging to the supplement category can be attached to a supplement.
- A supplement category's name must be unique tenant-wide.

## Limitations

- Supplements and categories can't be permanently deleted, only deactivated.
- A supplement can't be deactivated while it's attached to any active booking, tour, or custom tour offer — those need to be resolved first.
- This covers the master supplement catalog itself; how supplements are actually attached, priced, and displayed on a specific booking is covered in each of those features' own docs.

## Related Features

- [Bookings](booking.md) — supplements can be added to a booking's line items.
- [Tours](tours.md) — tours can offer supplements to customers as optional or mandatory add-ons.
- [Custom Tour Offers](custom-tour-offers.md) — bespoke offers can include supplements the same way.

## FAQ

**Q: Can I delete a supplement I no longer need?**
A: No — supplements are deactivated rather than deleted, which keeps historical bookings that used them intact.

**Q: What happens if I try to deactivate a supplement that's still being used?**
A: It's refused — a supplement can't be deactivated while it's attached to any currently active booking, tour, or custom tour offer.

**Q: Do I need to set a price for every currency myself?**
A: No — every supplement is automatically priced in all of the tenant's supported currencies as soon as it's created; you only need to override a specific currency's price if you want it different from the automatic conversion.

**Q: What happens if I look up a supplement's translation in a language it hasn't been translated into yet?**
A: You get back an empty result rather than an error — it just means that language hasn't been translated yet.

**Q: Can a supplement be required rather than optional?**
A: Yes — a supplement can be marked mandatory, and a supplement group can also be marked as requiring a selection from its options.
