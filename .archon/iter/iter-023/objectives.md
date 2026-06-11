# Iteration 023 Objectives

## Prover Objective

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially:
   `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`,
   `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`,
   `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, and
   `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`.

   Primary target: make strict progress on
   `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

   First target the bounded-continuous square-integral helper:
   `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`.
   It should prove the square integrability and zero-square-integral premise for a bounded continuous finite-variation true martingale on a deterministic horizon, using deterministic partitions, closed martingale increment orthogonality, finite-variation square-increment estimates, and dominated convergence.

   If the full general partition construction is too large, prove a closed helper with explicit finite ordered partitions, pathwise square-increment convergence, and integrable domination hypotheses, then make the active reduction delegate to it. Keep the single analytic gap strictly deeper and do not add unrelated sorries.

## Verification Expected

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- If that passes: `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- If that passes: `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- Then `lake build`

The task result should report new helper declarations, whether the reduction or wrapper closed, and the final warning/sorry lines.
