# Iteration 033 Objectives

## Assigned File

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

## Primary Objective

Add and prove
`MeasureTheory.Martingale.eq_zero_of_localized_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

This theorem should take a countable family of localized martingales `Z n`, covering events `E n`, deterministic bounds `C n` and `V n`, one deterministic partition family from `⊥` to `t`, the explicit entourage-mesh hypothesis, and terminal agreement `Z n t = N t` on `E n`. For each `n`, assume exactly the hypotheses needed to apply
`MeasureTheory.Martingale.eq_zero_on_event_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` to `Z n`.

Proof route: apply the event-localized wrapper for each `n`, then use
`MeasureTheory.ae_eq_zero_of_eventually_event_zero_exhaustion` with `f := fun ω => N t ω`.

## Secondary Objective

If the primary helper closes quickly, add and prove
`MeasureTheory.Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

This theorem should specialize the primary helper to
`Z n := stoppedProcess (fun i ↦ {ω | ⊥ < τ n ω}.indicator (N i)) (τ n)` and events
`E n := {ω | (t : WithTop κ) < τ n ω}`. Assume the a.e. cover
`∀ᵐ ω ∂P', ∃ n, (t : WithTop κ) < τ n ω` and the bounded/variation/continuity/mesh hypotheses for each stopped process. Derive `Z n ⊥ = 0` from `N ⊥ = 0`; derive terminal agreement on `E n` using the existing stopped-process equality pattern already used in `IsLocalMartingale.eq_zero_of_predictable_finiteVariation`.

## Non-Goals

- Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one monolithic proof.
- Do not assert automatic deterministic mesh existence in arbitrary ordered Polish time.
- Do not remove deterministic variation bounds without an explicit localization or exhaustion step.
- Do not add `sorry`, weaken public theorem statements, or edit unrelated files.
