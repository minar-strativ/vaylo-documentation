---
feature: reporting
status: completed
updated: 2026-08-11
review_note: ""
---

# Reporting & Escalation

Reporting gives staff a set of operational reports over bookings, payments, and invoices — plus a quick dashboard summary — so they can answer day-to-day business questions without digging through individual records.

## What it does

- Staff generate reports over a date range — sales, transactions, payment deadlines, revenue, and invoices — choosing which columns to include, and download the result as an Excel file.
- Sales and transaction reports can be filtered by either a booking's departure date or the date it was booked.
- Payment-deadline and revenue reports can also be scheduled to email themselves out automatically for a given date range, instead of being pulled on demand.
- Staff can pull a report of bookings still owing a remaining balance for a given year, and a separate report of upcoming tours' advance payments due before departure.
- A dashboard gives an at-a-glance operational summary: the last 30 days of transactions and their total, this month's booking and transaction summaries, and today's bookings.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Generate and download any of the reports; view the dashboard summary. |
| System | Sends the scheduled payment-deadline and revenue reports by email on schedule. |

## How it works

1. Staff open the dashboard for a quick pulse on the business — recent transactions, this month's summary, and today's bookings.
2. To dig deeper, staff choose a specific report — sales, transactions, payment deadlines, revenue, or invoices — set a date range and (for most reports) which columns to include, and generate it.
3. Sales and transaction reports can be pulled by departure date or by booking date, depending on which question staff are answering.
4. The result can be downloaded as an Excel file for sharing or archiving.
5. For payment-deadline and revenue reports, staff can instead have the report generated and emailed out automatically for a given date range, on a schedule, rather than pulling it manually each time.

## Limitations

- Reports are a way to view and export existing data — they don't let staff edit bookings, payments, or invoices from within the report itself.
- The data model includes an "escalation event" concept for tracking internal operational failures (like a failed accounting post or a missed settlement deadline), but nothing in the platform currently creates or surfaces these events — it exists as reserved scaffolding, not a working capability.

## Related Features

- [Bookings](booking.md), [Payments](payments.md), and [Billing & Invoicing](billing.md) — the underlying records these reports summarize.

## FAQ

**Q: Can a report be generated for a date range instead of just one day?**
A: Yes — every report is generated over a chosen date range.

**Q: Do I have to manually pull the payment-deadline and revenue reports every time?**
A: No — both can be scheduled to email themselves out automatically for a given date range.

**Q: Can staff choose which columns appear in a report?**
A: Yes, for the reports that support it — staff pick which columns to include before generating.

**Q: Where do I see a quick summary without running a full report?**
A: The dashboard gives an at-a-glance view of recent transactions, this month's activity, and today's bookings.
