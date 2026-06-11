# Iteration 021 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Target `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` at line 705. The blueprint support is `blueprint/src/chapters/doob_meyer.tex`, especially `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_core` and `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`.

   First try to prove a bounded continuous finite-variation martingale core helper, then use it to replace the current bridge `sorry`. Keep the theorem statements honest; do not work on the weak local Doob-Meyer theorem at line 917 and do not edit `QuadraticVariation.lean` this iteration.

## Deferred

- `QuadraticVariation.lean`: repair `IsLocalMartingale.isLocalSubmartingale_sq_norm` to the finite-measure/usual context before attempting its proof.
- `QuadraticVariationBrownian.lean`: no direct objective; `ProbabilityTheory.quadraticVariation_brownian` has landed and now waits on upstream proof debt.
