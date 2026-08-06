---
feature: products
status: completed
updated: 2026-08-06
review_note: ""
---

# Products

A Product is a standalone catalog entry — a sellable item or service with its own name, supplier, location, images, documents, and internal notes. Unlike Supplements, a Product is not attached to a booking, tour, or any other pricing flow; it functions as a reference directory rather than something customers book or pay for through the platform.

## What it does

This is a simple, self-contained catalog: staff record a product's name, description, supplier(s), location and contact details, organize it into categories, attach images and documents, leave internal notes, and translate it into multiple languages.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Create and edit products and categories, upload images/documents, add internal notes, add translations, deactivate a product or category |

## How it works

**Creating a product.** Staff enter its name, description, supplier(s), location, address, and contact details. A translation in the tenant's default language is created automatically, with no separate step needed.

**Categorizing.** Staff add categories to organize what's sellable under a product. Each category belongs to exactly one product — categories aren't shared across the whole catalog.

**Adding media and documents.** Staff build out a product's gallery of images (optionally marking one as the main image), attach relevant documents such as contracts or spec sheets, and add a single representative image to each category.

**Adding notes.** Staff leave free-text internal notes on a product, visible only to staff and shown newest first.

**Translating.** Staff add a translation for each additional language a product or category needs. Editing a product's name while working in a specific language updates that language's translation rather than the original default-language name.

**Deactivating.** Taking a product or category offline is a separate, dedicated action from editing its content.

## Rules & Edge Cases

- A product or category can only have one translation per language — adding a second is rejected.
- A translation can only be added in a language that's currently active.
- Attached documents must be under 10 MB and one of a limited set of file types (images, PDF, plain text, Word documents).
- A product's active/inactive status can only be changed through its dedicated status action, not the general edit form.
- Searching the product or category list matches either the base name or its translated name in whichever language is being viewed.

## Limitations

- A Product is entirely standalone — it doesn't attach to bookings, tours, hotels, yacht charters, or custom tour offers, and has no pricing, currency, or tax configuration of its own. For a sellable add-on that customers actually book and pay for, see [Supplements & Add-ons](supplements.md).
- Products function purely as an internal reference catalog (name, supplier, location, media, notes) rather than something that flows into any pricing or booking process.

## Related Features

- [Supplements & Add-ons](supplements.md) — the platform's booking-integrated, priced catalog of add-ons; a Product is not connected to this or any other booking flow.

## FAQ

**Q: Can customers book a Product?**
A: No — a Product is a standalone reference entry with no pricing or booking integration. For something customers can actually book and pay for, see Supplements & Add-ons.

**Q: Do I need to set up translations manually when I create a product?**
A: Not for the first language — a translation in the tenant's default language is created automatically. Additional languages are added one at a time.

**Q: What's the difference between a product's Description and its internal Notes?**
A: Description is customer-facing content about the product; Notes are free-text internal comments visible only to staff.

**Q: Can a category be shared across multiple products?**
A: No — each category belongs to exactly one product.

**Q: What happens if I try to attach a file that's too large or the wrong type?**
A: It's rejected — attached documents must be under 10 MB and one of the supported file types.
