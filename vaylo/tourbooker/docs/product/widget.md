---
feature: widget
status: completed
updated: 2026-08-11
review_note: ""
---

# Booking Widget

The Booking Widget is the embeddable search-and-book component tenants place on their own website. This feature is its configuration: what it looks like, which search filters it offers, and where customers land after using it.

## What it does

- Staff set the widget's defaults (language, currency, tours shown per page), its visual theme, and where a customer is sent after searching or completing a booking.
- Staff maintain a shared catalog of possible search filters (like destination or dates), each with a display name, order, and translations, and choose which of those filters this tenant's widget actually shows and in what order.
- The embedded widget fetches this configuration publicly, with no login, so it renders correctly wherever it's placed.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Configure the widget's defaults, theme, and redirects; activate/deactivate and reorder search filters; manage filter translations. |
| Visitor/Customer | Uses the embedded widget on the tenant's own site — no direct interaction with this configuration. |

## How it works

1. Staff set the widget's defaults — language, currency, tours per page, whether to show all tours by default, whether room prices show separately from the tour price — and its visual theme.
2. Staff choose which search filters (from the shared catalog) the widget should show, and in what order; if none are explicitly chosen, every active filter in the catalog is shown in its default order.
3. Staff set where a customer is redirected after searching, or after completing a booking.
4. Wherever the widget is embedded, it fetches this configuration publicly to render itself with the right filters, language, and look.

## Rules & Edge Cases

- Deactivating a search filter always resets its display order to the very end of the list, so re-activating it later doesn't restore its old position.
- Staff can reorder active filters by supplying the desired order; any filter left out of that list is pushed to the end.
- A search filter's translation can be edited per language, but which language it belongs to can never be changed once created.
- If a tenant hasn't chosen specific search filters, the widget falls back to showing every active filter from the shared catalog.

## Limitations

- The search-filter catalog itself (which filters exist at all, beyond activation and ordering) is shared platform-wide — tenants choose from it, they don't define entirely new filter types here.
- This feature only configures the widget's appearance and behavior — it doesn't run the actual tour search or booking logic itself.

## Related Features

- [Tours](tours.md) — the catalog the widget searches and lets customers book.
- [Bookings](booking.md) — where a customer ends up after using the widget to book.

## FAQ

**Q: What happens if a tenant hasn't picked any search filters for their widget?**
A: The widget falls back to showing every active filter from the shared catalog, in its default order.

**Q: Does re-activating a search filter restore its previous position?**
A: No — a deactivated filter is always sent to the end of the order, and stays there even after being reactivated, until staff reorder it.

**Q: Does the widget need a staff login to load its configuration?**
A: No — the widget's own configuration lookup is public, since it's embedded on external pages and needs to fetch its settings to render itself.

**Q: Can staff fully redesign the widget's look?**
A: Staff can customize its theme (visual styling) and choose its default language/currency and filters, but the widget's underlying layout and behavior come from the platform itself.
