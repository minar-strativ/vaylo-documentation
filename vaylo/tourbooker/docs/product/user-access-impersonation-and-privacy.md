---
feature: user-access/impersonation-and-privacy
status: completed
updated: 2026-08-11
review_note: ""
---

# Passenger Impersonation & GDPR Anonymisation

Two related tools for handling a passenger's account on their behalf: temporarily viewing the passenger portal as they see it for support purposes, and permanently erasing their personal data on request.

## What it does

- Staff can start a read-only impersonation session to view the passenger portal exactly as a specific passenger sees it — useful for support and troubleshooting.
- Every action taken during an impersonation session is logged, and the session can be ended explicitly or is superseded automatically when a new one starts.
- Staff can permanently anonymise a passenger's personal data for a GDPR erasure request, scrubbing their identifying details from every record that mentions them.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | Start and end an impersonation session for a passenger. |
| Super Admin | Trigger permanent GDPR anonymisation of a passenger's data. |

## How it works

### Impersonation

1. A staff member starts an impersonation session for a specific passenger, which issues a time-limited access token.
2. While that session is active, the staff member sees the passenger portal exactly as that passenger would — but can only view, not change anything; any attempted change is blocked, apart from a small set of exceptions like ending the session or downloading an invoice/receipt.
3. Every request made during the session is logged with the method, IP address, and path, giving a full audit trail of what was viewed.
4. The session can be ended explicitly, and starting a new impersonation session anywhere automatically closes out any other still-open session platform-wide.

### GDPR anonymisation

1. Once a passenger's bookings have all departed or been cancelled, staff can trigger anonymisation of their data.
2. Their name and email are replaced everywhere they appear — their own account, passenger profile, any booking they were the primary or a co-passenger on, and their payment/invoice history — while the underlying booking, transaction, and invoice records themselves are kept, just without the identifying details.
3. A private record of exactly what was anonymised is kept, and a designated admin recipient is automatically emailed a notice of the action.

## Rules & Edge Cases

- During impersonation, only read (safe) actions are allowed; any attempt to create, change, or delete something is blocked.
- An impersonation token only works for the exact passenger account it was issued for, and only while that session is still valid — an expired, ended, or mismatched token is rejected.
- A user who's already been anonymised, is a superuser, or currently has an active, not-yet-departed booking as a passenger, cannot be anonymised.
- Anonymising a user never deletes their booking, transaction, or invoice history — only the personally identifying details on those records are scrubbed.

## Limitations

- Anonymisation is one-way and permanent — there's no way to reverse it or restore the original personal data afterward.
- Impersonation sessions are exclusive platform-wide: starting a new one automatically ends any other currently open session, even for a different passenger.

## Related Features

- [User & Access Management](user-access.md) — the accounts these two capabilities act on.
- [Bookings](booking.md), [Payments](payments.md), and [Billing & Invoicing](billing.md) — where an anonymised user's personal details are scrubbed from existing records.

## FAQ

**Q: Can staff make changes to a booking while impersonating a passenger?**
A: No — impersonation is read-only, with only a small set of explicit exceptions (like ending the session or downloading an invoice/receipt).

**Q: What happens if a passenger still has an upcoming booking when staff try to anonymise their data?**
A: It's rejected — anonymisation is only allowed once all their bookings have departed or been cancelled.

**Q: Is anonymised data recoverable later?**
A: No — anonymisation is permanent. The original details aren't retained anywhere.

**Q: Can two staff members impersonate different passengers at the same time?**
A: No — starting a new impersonation session automatically closes out any other currently open session platform-wide.
