---
feature: reservation-service
status: completed
updated: 2026-08-11
review_note: ""
---

# Reservation Service Integration

Reservation Service Integration is the shared connection layer between the platform and external booking systems — airline reservation systems (GDS), hotel systems, and similar — that other features rely on to fetch or exchange live data.

## What it does

- The platform recognizes a catalog of reservation service types (Flight, Hotel, Yacht, and similar) and the external providers that can supply each one (for example, Amadeus, Sabre, or Resemolnet).
- Staff configure the connection details — credentials, connection addresses, and provider-specific settings — for each service-type-and-provider pair the tenant actually uses.
- Which connections are actually usable is filtered by the tenant's subscription plan: a connection only counts as active if its matching feature is enabled.
- Staff can retrieve a flight PNR directly from its connected airline reservation system on demand, syncing the flight, passenger, ticket, and itinerary details into the platform's own records.
- An external reservation system can also push flight ticket data into the platform directly, with anything it couldn't process kept as an error entry for staff to follow up on.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | View connection configurations; retrieve a flight PNR from its connected reservation system; check the status of a background sync job. |
| System (central management / external providers) | Syncs the catalog of services and providers, and pushes flight ticket data in from an external reservation system. |

## How it works

1. Staff configure a connection for each reservation-service-type-and-provider pair the tenant uses; configuring the same pair again updates that existing connection rather than duplicating it.
2. Other features that depend on an external system (dynamic pricing, ResPay payments, flight ticketing, yacht booking) look up their connection details through this feature.
3. For flight tickets specifically, staff can pull a PNR's latest details straight from its connected airline reservation system instead of re-entering them by hand — the platform's own ticket record updates to match.
4. An external reservation system can also push a batch of flight data into the platform on its own; any records it couldn't process are kept separately as error entries, without blocking the ones that succeeded.

## Rules & Edge Cases

- A tenant can only have one configuration per combination of service type and provider.
- A connection only counts as active if the matching feature is enabled on the tenant's subscription plan.
- When an external sync includes records that couldn't be processed, those failures never block the records that did sync successfully.

## Limitations

- This feature only manages the connection and data exchange itself — it doesn't provide any booking or pricing logic of its own; that lives in whichever feature actually uses the connection (flight ticketing, pricing, and so on).

## Related Features

- [Flights & Ticketing (PNR)](flights-tickets.md) — the main consumer of the flight-PNR retrieval and sync capability described here.
- [Pricing & Price Manager](pricing.md) and [ResPay Payments](res-pay.md) — other features that look up their own external connection details through this feature.
- [Subscription Plans](subscription.md) — determines which of a tenant's configured connections are actually usable.

## FAQ

**Q: Can a tenant configure two different connections for the same service type and provider?**
A: No — there's only one configuration per service-type-and-provider pair; reconfiguring it updates the existing one.

**Q: What happens if a tenant's subscription doesn't include a configured connection's feature?**
A: The connection exists but doesn't count as active — the feature depending on it stays unavailable.

**Q: If an external system pushes a batch of flight data and some records fail, does the whole batch fail?**
A: No — successfully processed records are still saved; only the failed ones are set aside as errors for staff to review.

**Q: Can staff manually refresh a flight ticket's details?**
A: Yes — staff can pull the latest details for a PNR directly from its connected reservation system on demand.
