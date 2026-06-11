# Iteration 026 Objectives

## Prover Objective

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially
   `lem:Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`,
   `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`,
   `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`,
   `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, and
   `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`.

   Primary target: prove a conditional refining-partition dominated-convergence helper
   `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`, then use it toward
   `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`
   and the active reduction
   `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`
   at `DoobMeyer.lean:1126`.

   The current direct `sorry` in the active bridge is at `DoobMeyer.lean:1162`. The old weak local Doob-Meyer theorem remains out of scope unless this bridge closes and downstream repair is immediate.

## Verification Requested

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- If that passes, also run:
  `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`,
  `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`,
  and `lake build`.
