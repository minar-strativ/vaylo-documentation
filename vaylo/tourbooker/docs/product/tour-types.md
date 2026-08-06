---
feature: tour-types
status: completed
updated: 2026-08-06
review_note: ""
---

# Tour Types

A Tour Type is the reusable template a Tour is built from — its pricing, fee structure, capacity, pickup options, vehicles, images, and translations. Instead of configuring every detail from scratch for each departure, staff set it up once on the tour type and every Tour created from it inherits that configuration.

## What it does

A tour type defines what a family of tours has in common: the standard price and transfer price, how deposit/cancellation/insurance fees are calculated, total passenger capacity, which pickup locations and vehicles are available, the images shown to customers, and the content translated into each supported language. Staff configure this once, and it becomes the starting point for every Tour built from that template.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and edit tour types, manage images, add translations, configure pickup locations and vehicle assignments, deactivate a tour type |
| Customer | Sees the tour type's public-facing name, image, and description page as part of browsing a tour built from it — no direct management access |

## How it works

**Creating a tour type.** Staff enter the core commercial details — name, description, price, transfer price, duration, capacity, currency, territory, and fee configuration — along with optional pickup locations, vehicle assignments, and images, all in one submission. The system fills in a couple of things automatically: a default pickup location is added if none was specified, plus a "request pickup" option if the tenant allows customers to request pickup, and a translation entry in the tenant's default language is created immediately from the name/description/tour information just entered, ready for staff to translate into other languages from there.

**Managing images.** Once a tour type exists, staff upload images to it one at a time. The first image uploaded automatically becomes the cover/main image; staff can change which image is the cover at any time, and if the current cover image is deleted, another remaining image is automatically promoted to take its place.

**Adding translations.** Staff add a translation for each additional language the tour type should support. Requesting the content for a language that hasn't been translated yet simply returns an empty result rather than an error — a normal, expected state rather than a failure.

**Assigning vehicles.** Staff can assign vehicles to a tour type with their own seat capacity for that tour type specifically (which can differ from the vehicle's general capacity). A vehicle assignment can be deactivated without deleting its configuration, and any vehicle left out of a later update to the assignment list is removed.

**Editing a tour type.** Any update recalculates the tour type's fees from its current pricing, re-checks that pickup-location seat totals still fit within capacity, and resyncs the default-language translation — so a pricing change is picked up consistently everywhere it's referenced. Updating the pickup-location or vehicle-assignment list also removes anything not included in the new submission.

**Retiring a tour type.** A tour type is deactivated rather than deleted, and this is blocked while any active Tour is still built from it — the dependent tours need to be handled first.

## Rules & Edge Cases

- Standard price must be greater than or equal to transfer price — a tour type can't be priced with a transport cost higher than its own base price.
- Fees can be calculated as a percentage of the standard price, a flat amount, or a flat amount per passenger. Percentage is the default, with a default booking fee of 40% of the standard price — for example, a tour type with a 1,000 SEK standard price and the default fee type has a 400 SEK booking fee unless changed.
- The total seats assigned across a tour type's pickup locations can't exceed its overall capacity — a tour type with capacity 20 can't have pickup locations that together add up to more than 20 seats.
- Saving a tour type's pickup-location configuration resets every pickup location's available seats back to its full seat count, and drops any pickup location no longer included in the submission.
- Supplements, vehicles, and accommodations linked to a tour type must all be active; an inactive one is rejected.
- Each vehicle can only be assigned once per tour type, and each language can only have one translation per tour type.
- Leaving a vehicle assignment's seat capacity at 0 means it inherits the vehicle's own default capacity, not that it offers zero seats.
- Only one image per tour type can be the cover/main image at a time.
- If no VAT class is set on a tour type, it defaults to "No VAT".

## Limitations

- A tour type can't be deleted, only deactivated — and deactivation is refused while any active Tour still uses it.
- Editing a tour type's pickup locations or vehicle assignments replaces the whole list; there's no way to update just one entry without resubmitting the rest.
- This feature covers the template itself — how a specific Tour departure inherits or overrides these defaults is covered in [Tours](tours.md).

## Related Features

- [Tours](tours.md) — individual bookable tour departures are built from a tour type template.
- [Hotels & Accommodation](hotels.md) — accommodation options can be linked to a tour type.

## FAQ

**Q: Can I set a transfer price higher than the standard price?**
A: No — the standard price must always be greater than or equal to the transfer price.

**Q: What happens if I try to deactivate a tour type that's still in use?**
A: It's refused — a tour type can't be deactivated while any active Tour is still built from it.

**Q: If I haven't translated a tour type into a language yet, what happens if I look it up in that language?**
A: You get back an empty result rather than an error — it just means that language hasn't been translated yet.

**Q: Does removing a pickup location from a tour type keep its seat history?**
A: No — resaving the pickup-location list drops anything not included, and resets the remaining seats on the ones that stay back to their full count.

**Q: What happens to the first image I upload to a new tour type?**
A: It automatically becomes the cover/main image — no separate step needed.

**Q: Can I assign an inactive vehicle or supplement to a tour type?**
A: No — vehicles, supplements, and accommodations linked to a tour type must all be active.
