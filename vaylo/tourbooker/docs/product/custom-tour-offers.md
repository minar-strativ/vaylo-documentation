---
feature: custom-tour-offers
status: completed
updated: 2026-08-06
review_note: ""
---

# Custom Tour Offers

A Custom Tour Offer is a bespoke, one-off tour package staff put together for a specific client — outside the standard tour catalog — that can be priced, sent to the customer as a branded quote, and converted straight into a real booking once accepted.

## What it does

Staff build a custom offer with its own pricing, pickup locations, and supplements (flights, hotels, extras), optionally starting from a client's itinerary imported from Wetu (a third-party itinerary planning tool). The offer can be previewed for cost, sent to the customer as a PDF by email, and — once accepted — converted directly into a real Tour and Booking in one action.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create offers (from scratch or from a Wetu itinerary), configure pricing/pickup/supplements, preview cost, add internal notes, send/download the offer, convert it to a booking, duplicate an offer |
| Customer | View their own custom tour offers through the customer portal |

## How it works

**Building the offer.** Staff typically start by importing a client's itinerary from Wetu, then convert it into a custom tour offer in one action — adding the pricing, territory, and tax details Wetu doesn't provide. Staff can just as easily skip Wetu and build the offer from scratch. Either way, the system fills in a default pickup location automatically, and a "request pickup" option too if the tenant allows customers to request pickup.

**Configuring pricing and add-ons.** Staff set the standard price, transfer price, discount (flat or percentage), VAT class, and billing currency, then add pickup locations and supplements. At any point — even before the offer is saved — staff can request a full cost preview to see the running total.

**Internal notes.** Staff can leave internal notes on an offer to track context on the deal. Only the note's original author can edit it later, and every edit keeps a record of what the note said before.

**Sending the offer.** Staff send the offer to the customer as a branded PDF by email, or just download the PDF to share another way. Sending can also be bundled automatically into the same action that creates or updates the offer.

**Converting to a booking.** Once the customer accepts, staff convert the offer directly into a real Tour and Booking in a single action, with the customer as the primary passenger and any discount applied. This can only be done once per offer — an already-converted offer is locked and automatically deactivated so it can't be converted again.

**Duplicating an offer.** For a similar future deal, staff can duplicate an existing offer as a starting point instead of rebuilding it from scratch. The copy always starts out as an inactive draft, regardless of the original offer's status.

**Customer view.** Customers see their own custom tour offers through the customer portal, scoped to only the offers made out to them.

## Rules & Edge Cases

- The standard price must be greater than or equal to the transfer price.
- The total seats assigned across an offer's pickup locations can't exceed its overall capacity.
- The number of passengers taking the paid transfer/pickup can't exceed the offer's total capacity.
- The default booking fee is 40% of the standard price unless changed.
- If no VAT class is set, the offer defaults to "No VAT".
- A discount only applies at conversion time if the offer is explicitly marked as discounted, and the applied amount is never less than zero — for example, a percentage discount larger than the price itself is simply capped at zero cost, not a negative charge.
- A Wetu itinerary can only become a custom offer if it's marked "Booked" in Wetu, and only once — a second attempt to convert the same itinerary is rejected.
- Only an active offer can be converted into a booking — a deactivated, already-converted offer can't be reused this way.
- Importing and converting Wetu itineraries is only available to tenants whose subscription plan includes that integration.

## Limitations

- Duplicating an offer only copies its core details — pickup locations and supplements are not carried over to the copy, and need to be re-added.
- There's no automatic expiry enforcement on an offer's expiry date — it's informational only.
- A Wetu-imported itinerary's price and currency come from Wetu's own data; if that data can't be read cleanly, the tenant's default currency is used instead rather than blocking the import.

## Related Features

- [Tours](tours.md) — converting an accepted offer creates a private tour built from its details.
- [Bookings](booking.md) — the actual booking record created when an offer is converted.
- [Passengers](passengers.md) — the customer account an offer is linked to, and who becomes the primary passenger once converted.

## FAQ

**Q: Can I convert the same custom offer into a booking twice?**
A: No — once converted, the offer is automatically deactivated and locked from further conversion.

**Q: What happens if I duplicate an offer?**
A: You get a copy of its core details as a new inactive draft — pickup locations and supplements aren't copied over and need to be re-added.

**Q: Can I preview the cost of an offer before saving anything?**
A: Yes — the cost-preview action works with raw pricing and capacity figures even before an offer exists.

**Q: What happens if I try to convert a Wetu itinerary that isn't marked "Booked" yet?**
A: It's rejected — only itineraries in Booked status in Wetu can become a custom tour offer.

**Q: Can anyone edit an internal note left on an offer?**
A: No — only the staff member who wrote the note can edit it, and every edit preserves what it said before.

**Q: Does sending an offer to a customer always require a separate action?**
A: No — sending can happen automatically as part of creating or updating the offer, or be triggered separately at any time afterward.
