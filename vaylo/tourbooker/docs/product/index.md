# Product Knowledge Base

Generated and maintained by Canopy. One page per business capability — see each feature's own doc for details. 31 business capabilities discovered total (33 docs, since Flights & Ticketing splits into a parent + 2 child docs); 10 documented so far.

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
- Yacht Booking — Yacht catalog with bases, seasons, equipment, sailing areas, and yacht pricing. *(pending)*
- Supplements & Add-ons — Optional add-on products/supplements with groups, categories and local pricing. *(pending)*
- Products — Generic sellable products with categories, images, files and notes. *(pending)*
- Tour Guides — Tour guides, guide types and their time-slot availability. *(pending)*
- Vehicles, Carriers & Stations — Transport logistics: vehicles and types, home bases, carriers and pickup/drop stations. *(pending)*
- Booking Widget — Embeddable booking widget search parameters and configuration. *(pending)*

## Pricing & Payments

- Pricing & Price Manager — Pricing projects, price calculation, pricing webhooks and logs across products. *(pending)*
- [Payments](payments.md) — Payment/refund transactions against bookings, invoices, and gift cards; manual payment recording.
- ResPay Payments — ResPay payment provider integration and its configuration. *(pending)*
- [Billing & Invoicing](billing.md) — Billing lines and account invoices generated from bookings, invoice issue/void/credit lifecycle.
- Coupons — Discount coupons with local pricing and usage tracking. *(pending)*
- Gift Cards — Gift cards with configurable greeting texts, images and usage history. *(pending)*
- Rewards & Loyalty — Loyalty point accounts, reward tiers, and a point ledger. *(pending)*
- VAT & Tax Classes — VAT classes, VAT/cost accounts and tax categorisation used in billing. *(pending)*
- Accounting Integration — Integration with external accounting providers: projects, VAT codes, customers, cost centers, event sync. *(pending)*
- Suppliers — Suppliers, supplier types, supplier invoices and their financial/VAT accounts. *(pending)*

## Communication & Content

- Notifications (Email) — Email events, templates, scheduled mail, recipients and delivery logs. *(pending)*
- Surveys — Customer surveys with dispatch and dispatch-status tracking. *(pending)*
- Dynamic Forms & Custom Fields — Configurable custom form fields, collections/groups and stored responses. *(pending)*
- Notes, Todos & Travel Information — Internal notes, to-do items and traveller-facing travel information content. *(pending)*

## Platform & Access

- User & Access Management — Users and profiles, roles/permissions, passenger impersonation with audit, and GDPR data anonymisation. *(pending)*
- Organizations — Organization records grouping users/customers. *(pending)*
- Subscription Plans — Tenant-facing subscription plans that gate platform capabilities. *(pending)*
- Reporting & Escalation — Operational reports and escalation events. *(pending)*
- Reservation Service Integration — Integration with external reservation-service providers and their configuration. *(pending)*

## Not yet documented

The 26 features marked *(pending)* above are still queued — run `/doc-create` to continue documenting them, in the same dependency order recorded in `.ai/metadata/inventory.json`.
