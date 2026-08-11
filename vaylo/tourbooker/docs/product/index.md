# Product Knowledge Base

Generated and maintained by Canopy. One page per business capability — see each feature's own doc for details. 31 business capabilities discovered total (40 docs, since Flights & Ticketing and Yacht Booking each split into a parent + 2 child docs, Accounting Integration into a parent + 2 child docs, and Suppliers into a parent + 1 child doc); 28 documented, 1 flagged needs-review (Rewards & Loyalty — unreleased) so far.

## Bookings & Catalog

- [Tours](tours.md) — The catalog listing customers browse and book: dates, capacity, pricing, drafts, and multi-brand visibility.
- [Hotels & Accommodation](hotels.md) — Room-type inventory tours draw from when selling accommodation, plus simple lodging references.
- [Bookings](booking.md) — Core booking record: reserve tours/hotels/yachts for passengers, payment/cancellation handling, waitlisting.
- [Passengers](passengers.md) — Passenger and co-passenger records, bulk passenger import.
- [Flights & Ticketing (PNR)](flights-tickets.md) — Flight itineraries, PNR/ticket management, ticket assignment, and error-PNR handling.
  - [PNR & Ticket Records](flights-tickets-pnr-tickets.md) — Creating/importing/syncing PNRs, deadlines, error PNRs, flight reports.
  - [Booking Flight Assignment](flights-tickets-booking-assignment.md) — Reserving and assigning PNR seats to bookings and passengers.
- [Tour Types](tour-types.md) — Reusable tour templates (type, images, vehicles, pickup locations) that tours are built from.
- [Custom Tour Offers](custom-tour-offers.md) — Bespoke tour offers with Wetu itinerary import, supplements and pickup locations.
- [Yacht Booking](yacht-booking.md) — Yacht catalog with bases, seasons, equipment, sailing areas, and yacht pricing.
  - [Yacht Catalog & Pricing](yacht-booking-catalog-and-pricing.md) — Catalog sync, manual boats, price sheets and discounts.
  - [Yacht Search, Booking & Reservation](yacht-booking-booking-and-reservation.md) — Customer search/booking flow and reservation lifecycle with the charter provider.
- [Supplements & Add-ons](supplements.md) — Optional add-on products/supplements with groups, categories and local pricing.
- [Products](products.md) — Generic sellable products with categories, images, files and notes.
- [Tour Guides](tour-guides.md) — Tour guides, guide types and their time-slot availability.
- [Vehicles, Carriers & Stations](transport.md) — Transport logistics: vehicles and types, home bases, carriers and pickup/drop stations.
- [Booking Widget](widget.md) — Embeddable widget configuration: defaults, theme, redirects, and its search-filter catalog.

## Pricing & Payments

- [Pricing & Price Manager](pricing.md) — Receiving, reviewing, and applying dynamic price suggestions from an external pricing engine.
- [Payments](payments.md) — Payment/refund transactions against bookings, invoices, and gift cards; manual payment recording.
- [ResPay Payments](res-pay.md) — Standalone, booking-free payment links customers pay via Klarna, Trustly, or Altapay.
- [Billing & Invoicing](billing.md) — Billing lines and account invoices generated from bookings, invoice issue/void/credit lifecycle.
- [Coupons](coupons.md) — Discount codes with per-currency amounts, usage limits and per-booking usage tracking.
- [Gift Cards](gift-cards.md) — Purchasable and staff-issued vouchers with greeting texts/images, spendable against bookings.
- Rewards & Loyalty — Loyalty point accounts, reward tiers, and a point ledger. *(needs review — data model only, no services/views/urls exist yet; likely unreleased, see `.ai/metadata/inventory.json`)*
- [VAT & Tax Classes](vat.md) — Tax rate setup (VAT classes/types) and the accounting accounts they post to.
- [Accounting Integration](accounting.md) — Connecting an external accounting provider and auto-posting business events to it.
  - [Accounting Provider Setup & Reference Data](accounting-provider-setup.md) — Connecting a provider and syncing/mapping its projects, cost centers, tax codes and accounts.
  - [Accounting Vouchers & Logs](accounting-vouchers-and-logs.md) — Automatic voucher posting on business events, logging, and manual/batch resend.
- [Suppliers](suppliers.md) — The vendor directory: contact, financial and accounting defaults per supplier.
  - [Supplier Invoices & Cost Registration](suppliers-invoicing-and-costs.md) — Recording supplier invoices and reconciling them against booking costs.

## Communication & Content

- [Notifications (Email)](notifications.md) — Templated/translated email events, provider connection, scheduling and delivery logs.
- [Surveys](surveys.md) — Post-tour feedback surveys, synced from Netigate and auto-dispatched after a tour returns.
- [Dynamic Forms & Custom Fields](dynamic-forms.md) — Per-tour custom booking/passenger form fields, seeded with standard fields and validated on submission.
- Notes, Todos & Travel Information — Internal notes, to-do items and traveller-facing travel information content. *(pending)*

## Platform & Access

- User & Access Management — Users and profiles, roles/permissions, passenger impersonation with audit, and GDPR data anonymisation. *(pending)*
- Organizations — Organization records grouping users/customers. *(pending)*
- Subscription Plans — Tenant-facing subscription plans that gate platform capabilities. *(pending)*
- Reporting & Escalation — Operational reports and escalation events. *(pending)*
- Reservation Service Integration — Integration with external reservation-service providers and their configuration. *(pending)*

## Not yet documented

The 19 features marked *(pending)* above are still queued — run `/doc-create` to continue documenting them, in the same dependency order recorded in `.ai/metadata/inventory.json`.
