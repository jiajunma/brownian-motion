# Iteration 030 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`.

   Primary theorem to add and prove:
   `UniformContinuousOn.finite_partition_sup_nnnorm_sub_tendsto_zero`.

   Statement intent: for a uniformly continuous real-valued function on a set \(S\), finite deterministic point families in \(S\), and an adjacent-pair entourage mesh tending to zero, the finite maximum of adjacent real increments tends to zero.

   Secondary theorem to add and prove if the first closes:
   `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_uniformContinuousOn`.

   Statement intent: combine the pure topology helper with the closed finite-sup martingale helper
   `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_sup_modulus`.

## Non-Targets

- Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one proof.
- Do not work on `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` this round.
- Do not switch to `QuadraticVariation.lean` unless the Doob-Meyer file mechanically fails before the assigned helper work begins.
