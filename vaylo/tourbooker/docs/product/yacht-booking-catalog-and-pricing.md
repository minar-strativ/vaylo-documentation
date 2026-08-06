---
feature: yacht-booking/catalog-and-pricing
status: completed
updated: 2026-08-06
review_note: ""
---

# Yacht Catalog & Pricing

The yacht catalog is the list of chartered boats available for customers to book, along with the companies, countries, sailing areas, and shipyards that describe where and by whom they're operated. Most of this data is kept in sync automatically from external charter providers, with pricing refreshed on a weekly basis.

## What it does

This covers everything about a yacht as a product: its specs, home base, available add-ons and pickup locations, and its per-week price. Catalog data and pricing are synced in from external charter providers, but staff can also add a yacht by hand when it needs to sit outside that sync, and can adjust pricing discounts on top of what the provider supplies.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Browse and manage the yacht catalog and its reference data (companies, countries, sailing areas, shipyards), add yachts manually, view and adjust the price sheet, edit a yacht's supplements/pickup locations/finance settings |

## How it works

**Catalog sync.** Yachts, companies, countries, world regions, sailing areas, shipyards, and equipment are synced in from external charter providers. A full sync automatically deactivates anything from that provider no longer present in the latest data — except yachts staff added manually, which sync never touches.

**Browsing and managing the catalog.** Staff can browse the yacht list filtered by provider, drill into a single yacht for its full specs, and manage the supporting reference data (toggling entries active/inactive, triggering a re-sync).

**Adding a yacht manually.** For a boat that needs to sit outside the normal provider sync, staff clone an existing catalog yacht into a manually-added listing. This new listing stays entirely under staff control and won't be deactivated, overwritten, or removed by any future catalog sync.

**Pricing.** Staff open a price sheet for a chartering company and date range, seeing each active yacht's weekly price and any discount the provider already applied. Staff can layer an additional discount on top, either for one yacht or across many at once.

**Editing a yacht's details.** On a yacht's detail page, staff can adjust its add-on supplements, pickup locations, and finance/tax settings directly.

**Going live.** Turning a yacht on immediately refreshes its listing on the public-facing site and its availability for the current year, so it becomes bookable right away.

## Rules & Edge Cases

- A catalog sync only deactivates entries staff didn't add by hand — anything manually added is permanently exempt from being touched by sync.
- Pricing and availability are always synced in whole-week blocks.
- The price sheet only lists chartering companies with at least one active yacht, and only shows active, non-manually-added yachts.
- Some catalog reference data (pricing measurement units, seasons, services) is only available from one of the two supported charter providers — requesting it from the other is rejected with a message naming what isn't supported.
- Every yacht is automatically given a default tax classification if it doesn't have one, so pricing always has a valid basis for billing.
- Editing a yacht's supplement without a price, or with a negative price, or with an inactive supplement, is rejected; the same applies to a negative price or seat count on a pickup location.

## Limitations

- This covers the yacht catalog and its pricing — actually searching for and booking a yacht is covered in [Yacht Search, Booking & Reservation](yacht-booking-booking-and-reservation.md).
- A manually-added yacht is a one-time clone of a catalog yacht at the time it was added — it doesn't stay linked to future updates on the original.

## Related Features

- [Yacht Search, Booking & Reservation](yacht-booking-booking-and-reservation.md) — where customers actually search for and book the yachts listed here.

## FAQ

**Q: If I add a yacht manually, will a future catalog sync overwrite or remove it?**
A: No — manually-added yachts are permanently exempt from being touched by catalog sync.

**Q: Can I set my own discount on top of the provider's price?**
A: Yes — staff can layer an additional discount on a yacht's price for a single yacht or in bulk across a date range.

**Q: What happens if I turn a yacht off?**
A: Its listing status is updated on the public-facing site to reflect that it's no longer available.

**Q: Are all catalog reference types available from both charter providers?**
A: No — pricing measurement units, seasons, and services are only available from one of the two providers; requesting them from the other is rejected.
