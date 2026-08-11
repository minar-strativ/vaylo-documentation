---
feature: subscription
status: completed
updated: 2026-08-11
review_note: ""
---

# Subscription Plans

Subscription Plans is the switchboard behind every paid add-on and third-party integration in the platform — dynamic pricing, survey integration, translation providers, and more. Whether a tenant can use one of these depends entirely on what's enabled in their plan.

## What it does

- Each tenant has one active subscription plan: a list of specific add-on features and third-party integrations, each simply on or off.
- Every request the tenant's staff or customers make is checked against that plan, so a feature is either available or hidden without any per-tenant code change.
- Staff can view which features are enabled on their tenant's plan, but the plan itself is set up and updated centrally rather than self-service.
- Some plan features connect to an external service provider (like a specific flight or hotel booking system) with its own connection details; others are simply on/off with no further setup.

## Who uses it

| Role | Can do |
|------|--------|
| Staff/Admin | View which features are enabled on their tenant's subscription plan. |
| System (central management) | Creates, syncs, and updates subscription plans and their enabled features. |

## How it works

1. A tenant is given a subscription plan with a specific set of features enabled — centrally managed, not something tenant staff configure themselves.
2. On every request, the platform attaches the tenant's active plan to that request.
3. Any feature elsewhere in the platform that's gated behind a paid add-on checks whether the required feature (or features) are present in that plan before allowing the action; a feature can require either all of a set of features or just one of them.
4. If a required feature isn't enabled, the request is blocked — the underlying feature stays effectively invisible to that tenant.

## Rules & Edge Cases

- Some features can require all of a set of named features to be enabled, or just at least one, depending on how that feature is configured.
- If a tenant's connected external service provider becomes inactive, any subscription features tied to that specific provider are automatically turned off.

## Limitations

- Tenant staff can see what's enabled on their plan but can't change it themselves — plan changes are managed centrally.
- A plan's overall status (Active, Inactive, Expired, Canceled) is separate from any individual feature being switched on within it; a plan can be active with only some of its possible features turned on.

## Related Features

- [Pricing & Price Manager](pricing.md), [Surveys](surveys.md), and other add-on-gated capabilities across the platform all check their access through this feature.

## FAQ

**Q: Can staff turn a paid add-on on or off themselves?**
A: No — staff can see what's enabled on their plan, but enabling or disabling features is managed centrally, not self-service.

**Q: What happens if a feature's required add-on isn't enabled?**
A: The action is blocked — the tenant simply doesn't see or can't use that capability.

**Q: Does every add-on feature need its own extra setup?**
A: Not necessarily — some are simply on/off, while others (tied to an external service provider) also need that provider's own connection details configured.

**Q: If a connected external provider is turned off, does that affect the subscription plan?**
A: Yes — any plan features tied specifically to that provider are automatically turned off along with it.
