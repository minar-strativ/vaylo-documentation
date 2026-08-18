---
feature: notifications
status: completed
updated: 2026-08-18
review_note: ""
---

# Notifications (Email)

Notifications is the engine behind every email the platform sends — booking confirmations, payment reminders, ticket updates, and more. Staff define what each notification says and who it comes from; the platform fills in the real details, translates it, sends it through the connected email provider, and keeps a log of every attempt.

## What it does

- Staff define email events: a subject and content template, with a fixed set of placeholders ("dynamic values") the content can use, connected to a template on the tenant's email provider.
- Content can be translated per language by staff, or auto-translated by the platform for any language staff haven't written by hand — without ever overwriting what staff already wrote.
- Staff connect one active email provider (currently Sendgrid) that all notifications are sent through.
- Business events elsewhere in the platform (a booking confirmation, a payment reminder, and so on) trigger the matching email immediately, or schedule it for a later date.
- Every send attempt is logged, whether it succeeded or failed, and staff can review, export, or resend any of them.
- Outside the templated system, staff or an integrated tool can send an ad-hoc email (like a chat transcript) through the same provider connection.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Define email events, templates, translations, and default recipients; connect and configure the email provider; view, export, and resend email logs. |
| System | Automatically triggers and sends notifications when business events occur, runs the scheduled-email dispatch, and sends ad-hoc emails from integrated tools. |

Customers only ever receive the resulting emails — they have no direct interaction with this feature.

## How it works

### Setting up a notification

1. Staff create an email event: a subject, a content template, and the placeholders that template is allowed to use.
2. Staff can write a translated version of the subject/content for each language; for any language they leave blank, the platform automatically machine-translates the default-language version — without ever overwriting a translation staff already wrote by hand.
3. Staff can set a default recipient (and CC/BCC) for an event, independent of who the email is actually about — useful for routing an internal notification to a fixed staff mailbox.

### Sending a notification

1. A business event happens elsewhere in the platform — a booking is confirmed, a payment deadline approaches, a ticket changes, and so on.
2. The platform renders the matching email event's content with the real data for that situation, in the recipient's preferred language, and sends it through the connected provider.
3. The attempt is logged with who it was sent to, what triggered it, whether it succeeded, and the provider's response.

### Scheduling ahead

- Some notifications are scheduled for a future date instead of sent right away — tied to a specific record (like a booking).
- Most scheduled emails go out in a fixed daily batch on their send date; one-off dynamic dates are instead handed to an external scheduler that fires the send at the exact date and time.
- A scheduled email tied to something that changes (like a payment deadline moving) has its send date automatically pushed to match.
- A scheduled email is skipped instead of sent if it's already gone out, or if what it's about no longer applies — for example, a reminder for a booking that's since been cancelled.

### Reviewing and resending

- Staff can review the full log of sent and failed emails, export it, and resend any specific one.
- Resending uses the same template data that was originally attempted, so nothing needs to be re-entered.

## Rules & Edge Cases

- An email only actually sends if its event is active, marked available, has a configured provider template, and has a recipient — otherwise the attempt fails and is logged with the specific reason.
- A translation can only use the placeholders already defined for that event; an undefined placeholder in translated content is rejected.
- Auto-translation never overwrites a translation staff already wrote — it only fills in what's still empty.
- Only one email provider connection can be active at a time; connecting a new one deactivates all others.
- A scheduled email whose underlying record no longer applies (for example, its booking was cancelled) is skipped rather than sent.

## Limitations

- Only one email provider can be active for the tenant at a time.
- Auto-translation depends on an external translation service and is best-effort — a language with no staff-written translation may show machine-translated content until staff review it.
- Resending a failed email replays the original attempt's data — it doesn't let staff edit the content before resending.

## Related Features

- [Bookings](booking.md) — the source of most notification triggers (confirmations, reminders, ticket updates) and the scheduled emails tied to a booking's own dates.
- [Payments](payments.md) — payment deadline reminders are scheduled and rescheduled through this feature as a booking's payment dates change.
- [Tour Flights](tour-flights.md) — a customer's custom flight request can trigger an admin email through this feature.

## FAQ

**Q: What happens if an email fails to send?**
A: It's recorded as a failed log entry with the reason. Staff can review it and resend it once the underlying issue is fixed.

**Q: Do all languages need a manually written translation?**
A: No — any language staff haven't translated by hand is automatically machine-translated, and staff can go back and refine it later without losing their own edits elsewhere.

**Q: Can a booking's payment reminder move if the payment deadline changes?**
A: Yes — its scheduled send date automatically shifts to stay aligned with the deadline.

**Q: Can more than one email provider be connected at once?**
A: No — only one provider connection can be active for the tenant at a time.

**Q: Does resending an email let staff change what's in it?**
A: No — it resends using the same data as the original attempt.
