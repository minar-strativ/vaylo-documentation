# Granularity Rules — What Counts as a Feature

**Definition:** a feature is a capability a business stakeholder would name in one sentence — "customers can book appointments", "admins manage staff schedules". Never a code unit ("BookingController"), never a technical layer ("API", "database").

## Sizing

- Target: one doc of **~400–1,500 words**.
- **Split** when analysis reveals more than ~7 distinct workflows → sub-feature docs under a parent (parent holds the overview + links; children hold detail; ids like `booking/cancellation`).
- **Merge** when a candidate cannot meaningfully fill What/Why/Who on its own → fold into its owning feature.

## Shared modules

A cross-cutting module (auth, pricing, notifications) becomes its OWN feature only if it carries business rules a stakeholder would care about (e.g., pricing logic with fees and discounts → yes; a date-formatting helper → no). Pure plumbing owns nothing — its consumers mention the behavior it provides.

Either way, record it in `shared_modules` with `used_by`, because impact analysis needs the fan-out.

## Litmus tests

| Question | If no → |
|---|---|
| Would a client recognize this name? | Rename or merge |
| Can it fill What/Why/Who non-trivially? | Merge |
| Does it have its own business rules? | Merge |
| Is any single doc drifting past ~1,500 words? | Split |
| Are two docs explaining the same rule? | One owns it, the other cross-references |
