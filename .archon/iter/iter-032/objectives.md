# Iteration 032 Objectives

## Assigned File

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

## Primary Objective

Add and prove
`MeasureTheory.Martingale.eq_zero_on_event_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

This helper should apply the closed terminal zero theorem
`MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`
to a localized martingale `Z`, then transfer the conclusion to another process `N`
on an event `E` using a terminal agreement hypothesis.

## Secondary Objective

If the primary helper closes quickly, add and prove
`MeasureTheory.ae_eq_zero_of_eventually_event_zero_exhaustion`.

This helper should turn a countable family of local zero statements
`∀ n, ∀ᵐ ω ∂P', ω ∈ E n → f ω = 0` plus an a.e. cover
`∀ᵐ ω ∂P', ∃ n, ω ∈ E n` into `f =ᵐ[P'] 0`.

## Non-Goals

- Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one monolithic proof.
- Do not assert automatic deterministic mesh existence in arbitrary ordered Polish time.
- Do not remove deterministic variation bounds without an explicit localization or exhaustion step.
