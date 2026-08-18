# Documentation Changelog

Append-only. One line per event:

`YYYY-MM-DD | feature | created/updated/audited/superseded-by | one-line reason | commit`

---

2026-07-30 | tours | created | first Create run (v2 framework), 1 of 5 scoped features | 7c0869fa1
2026-07-30 | tours | updated | back-filled Related Features link to hotels.md now that it exists | 7c0869fa1
2026-07-30 | hotels | created | 2 of 5 scoped features | 7c0869fa1
2026-07-30 | booking | created | 3 of 5 scoped features | 20675c05c
2026-07-30 | billing | created | 4 of 5 scoped features | 20675c05c
2026-07-30 | payments | created | 5 of 5 scoped features — pilot run complete | 20675c05c
2026-08-06 | passengers | created | resuming full backlog, 1 of 26 remaining features | 20675c05c
2026-08-06 | flights-tickets | split | analysis revealed >7 workflows across two distinct areas; split into parent overview + flights-tickets/pnr-tickets + flights-tickets/booking-assignment (see granularity.md) | 20675c05c
2026-08-06 | flights-tickets/pnr-tickets | created | 2 of 26 remaining features | 20675c05c
2026-08-06 | flights-tickets/booking-assignment | created | 3 of 26 remaining features | 20675c05c
2026-08-06 | tour-types | created | 4 of 26 remaining features | 20675c05c
2026-08-06 | custom-tour-offers | created | 5 of 26 remaining features | 20675c05c
2026-08-06 | yacht-booking | split | analysis revealed >7 workflows across two distinct areas (~16.5k lines, two external providers); split into parent overview + yacht-booking/catalog-and-pricing + yacht-booking/booking-and-reservation | 20675c05c
2026-08-06 | yacht-booking/catalog-and-pricing | created | 6 of 26 remaining features | 20675c05c
2026-08-06 | yacht-booking/booking-and-reservation | created | 7 of 26 remaining features | 20675c05c
2026-08-06 | supplements | created | 8 of 26 remaining features | 20675c05c
2026-08-06 | products | created | 9 of 26 remaining features | 20675c05c
2026-08-06 | tour-guides | created | 10 of 26 remaining features | 20675c05c
2026-08-07 | transport | created | 11 of 26 remaining features | 20675c05c
2026-08-11 | pricing | created | 12 of 26 remaining features | 20675c05c
2026-08-11 | res-pay | created | 13 of 26 remaining features | 20675c05c
2026-08-11 | coupons | created | 14 of 26 remaining features | 20675c05c
2026-08-11 | gift-cards | created | 15 of 26 remaining features | 20675c05c
2026-08-11 | rewards | needs_review | model-only scaffolding (no services/views/urls, nothing references it) — no doc written, flagged as likely unreleased per denylist; 16 of 26 remaining features | 20675c05c
2026-08-11 | vat | created | 17 of 26 remaining features | 20675c05c
2026-08-11 | accounting | split | analysis revealed >7 workflows across two distinct areas (~5,900 lines, two external providers); split into parent overview + accounting/provider-setup + accounting/vouchers-and-logs | 20675c05c
2026-08-11 | accounting/provider-setup | created | 18 of 26 remaining features | 20675c05c
2026-08-11 | accounting/vouchers-and-logs | created | 19 of 26 remaining features | 20675c05c
2026-08-11 | suppliers | split | analysis revealed >7 workflows across two distinct areas (~4,100 lines); split into parent overview + suppliers/invoicing-and-costs | 20675c05c
2026-08-11 | suppliers/invoicing-and-costs | created | 20 of 26 remaining features | 20675c05c
2026-08-11 | notifications | created | 21 of 26 remaining features | 20675c05c
2026-08-11 | surveys | created | 22 of 26 remaining features | 20675c05c
2026-08-11 | widget | created | 23 of 26 remaining features | 20675c05c
2026-08-11 | dynamic-forms | created | 24 of 26 remaining features | 20675c05c
2026-08-11 | user-access | split | analysis revealed >7 workflows across two distinct areas (~2,900 lines); split into parent overview + user-access/impersonation-and-privacy | 20675c05c
2026-08-11 | user-access/impersonation-and-privacy | created | 25 of 26 remaining features | 20675c05c
2026-08-11 | organizations | created | 26 of 26 remaining features | 20675c05c
2026-08-11 | subscription | created | 27th feature documented this backlog run | 20675c05c
2026-08-11 | reporting | created | reports live; escalation-event data model noted as unwired scaffolding, no separate doc | 20675c05c
2026-08-11 | notes-todos | created | last-but-one feature in the 26-feature backlog | 20675c05c
2026-08-11 | reservation-service | created | final pending feature in the full 31-feature inventory | 20675c05c
2026-08-11 | create run completed | 35 features documented (43 docs, several split into parent+children); 1 flagged needs_review (rewards — unreleased, no doc); 0 skipped | 20675c05c
2026-08-11 | maintain run started | impact analysis via diff-since.sh, 20 features flagged changed after production fast-forward pull (20675c05c..f47cf806f) | f47cf806f
2026-08-11 | dynamic-forms | updated | major rewrite — Collections/Groups now fully wired (tour/tour-type default collections, cloning, cross-tour sync), booking-level fields, CustomFieldResponse snapshots + automation (task/email/save-to-profile) | f47cf806f
2026-08-11 | booking | updated | added payment-deadline scheduling (first/second/residue), dynamic-payment same-day merging, immediate-deadline collapse; cross-linked dynamic-forms and notifications | f47cf806f
2026-08-11 | passengers | updated | passenger detail view now surfaces the passenger's own custom field responses to staff | f47cf806f
2026-08-11 | flights-tickets, flights-tickets/pnr-tickets | re-anchored | only diff was a one-off data-backfill management command (backfill_itinerary_airline_code.py) -- no doc-relevant behavior change | f47cf806f
2026-08-11 | hotels, accounting, accounting/provider-setup, accounting/vouchers-and-logs, suppliers | re-anchored | diff was a pure mechanical import-reorder/lint pass, no logic change | f47cf806f
2026-08-11 | yacht-booking, supplements, products, gift-cards, widget, notes-todos, user-access, notifications | re-anchored | flagged changed only via the multi-language shared-module fan-out (dynamic_form's own multilanguage model changed); own feature files show zero diff, and notifications' small real diff (schedule-email service) doesn't invalidate anything currently documented | f47cf806f
2026-08-11 | tour-types | updated | tour types can now pick a booking-form and passenger-form custom-field collection, defaulting to the tenant's default collection when unset | f47cf806f
2026-08-11 | tours | updated | tour creation now clones custom fields from its collections and re-syncs them on update; also fixed two stale "not in this run's scope" Related Features links (Tour Types, Pricing & Price Manager are now real docs) | f47cf806f
2026-08-11 | maintenance run completed | 20 features assessed: 5 updated (dynamic-forms major rewrite, booking, passengers, tour-types, tours), 15 re-anchored with no doc-relevant change (backfill script, mechanical import reorders, false-positive shared-module fan-out); 0 needs_review, 0 new features | f47cf806f
2026-08-18 | booking | re-anchored | google_location_service fixes (city_code truncation, country resolution robustness) are internal shared-module changes with no documented booking behavior invalidated | 167353f10
2026-08-18 | tours | re-anchored | tour_booking_room_service fix excludes non-booked passengers from room-list occupancy and correctly expands shared rooms by quantity -- a bug fix to an already-undocumented rooming-list Excel/PDF export (TourBookingsRoomExcelDownloadAPIView/PDFDownloadAPIView); no existing doc statement invalidated, but that whole export capability is unmapped in tours.md and worth a future create-mode pass | 167353f10
2026-08-18 | billing | re-anchored | invoice PDF now shows the issue date (blank for drafts) instead of created-at, and unit price/VAT/totals render with decimal precision; presentation-only, no documented business fact invalidated. Also added templates/payment/** to billing's glob (pre-existing file, was outside tracked globs) | 167353f10
2026-08-18 | transport | re-anchored | google_location_service fixes (city_code truncation, country resolution) are internal shared-module changes unrelated to vehicle home-base fields; no documented transport behavior invalidated | 167353f10
2026-08-18 | notifications | re-anchored | email log listing now also surfaces successfully-sent logs whose event has since been deactivated (previously silently hidden) -- brings behavior in line with the doc's existing "full log of sent and failed emails" claim, no new fact to add | 167353f10
2026-08-18 | dynamic-forms | re-anchored | passenger custom-field endpoints (staff + passenger portal) now look up the booking by id and 404 if missing, instead of silently returning nothing for cancelled/inactive/non-standard-status bookings; doc doesn't claim a status restriction so no statement is invalidated, but this loosens what was an undocumented implicit restriction | 167353f10
2026-08-18 | maintenance run completed | 6 features assessed: 0 updated, 6 re-anchored with no doc-relevant change (internal robustness/bug fixes with no invalidated or new client-visible facts); 0 needs_review, 0 new features. billing's files glob widened to include templates/payment/** (pre-existing file, was outside tracked globs) | 167353f10
2026-08-18 | notifications | re-anchored | email log listing now also shows successful sends even if their template was later disabled -- a bug fix that brings behavior in line with the already-documented "full log of sent and failed emails" claim; no doc change needed | 167353f10
2026-08-18 | dynamic-forms | re-anchored | custom_field_views booking retrieval refactored twice (now raises a plain NotFoundError instead of get_validated_booking's error) -- internal error-handling detail, no documented business fact invalidated | 167353f10
2026-08-18 | maintenance run completed | 6 features assessed (booking, tours, billing, transport, notifications, dynamic-forms) across 158 production commits since 2026-07-29 anchor; 0 doc content edits needed -- all changes were internal fixes/refactors (location-service robustness, invoice PDF formatting, email-log filter fix, custom-field error handling) or a rooming-list export bug fix with no invalidated business fact; 0 needs_review, 0 new features (one glob gap fixed: templates/payment/** folded into billing). Flagged for a future create-mode pass: tours' rooming-list Excel/PDF export (TourBookingsRoomExcelDownloadAPIView etc.) is unmapped in tours.md | 167353f10
2026-08-18 | maintain run started | impact analysis via diff-since.sh after fast-forwarding local tourbooker to production (167353f10..5609d882b, 149 commits); 20 features flagged changed, 58 unclaimed paths triaged into 2 new pending features (shuttle-timetable, cancellation-rules) and 1 needs_review (crm -- broken import, model-only scaffolding); remaining unclaimed paths are shared plumbing with no feature ownership | 5609d882b
2026-08-18 | dynamic-forms | updated | static (built-in) custom fields can now only have label/group/required/primary-passenger-only edited via the update path; other properties are locked | 5609d882b
2026-08-18 | booking, tours, flights-tickets, flights-tickets/pnr-tickets, flights-tickets/booking-assignment | re-anchored | entire diff (Tour Flights: seat selection, price layers, waitlist/draft/quote flows, financial-line lock/sync, no-flight-fee billing credits) belongs to new pending feature tour-flights; cross-reference links to be added once that doc exists | 5609d882b
2026-08-18 | tour-types | re-anchored | cancellation_rule_group FK addition belongs to new pending feature cancellation-rules | 5609d882b
2026-08-18 | hotels, yacht-booking, supplements, products, gift-cards, widget, user-access, notes-todos | re-anchored | flagged only via multi-language shared-module fan-out (two new unrelated multilanguage model files for shuttle-timetable and suppliers); own feature files show zero diff | 5609d882b
2026-08-18 | billing | re-anchored | flagged only via locations shared-module fan-out; no own-file diff | 5609d882b
2026-08-18 | accounting | re-anchored | new AccountingType model + M2M to AccountingProviderEvent is model-only groundwork, not wired to any service/view/serializer yet; no client-visible behavior to document | 5609d882b
2026-08-18 | suppliers | re-anchored | new SupplierCategory model (+ multilanguage) is model-only scaffolding, not referenced by any service/view/serializer yet; no client-visible behavior to document | 5609d882b
2026-08-18 | notifications | re-anchored | admin "custom flight request" email belongs to new pending feature tour-flights | 5609d882b
2026-08-18 | subscription | re-anchored | hubspot_crm is one more plan add-on flag, already covered generically by the doc's existing "list of add-on features, each on or off" description | 5609d882b
