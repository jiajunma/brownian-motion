# Iteration 028 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially
   `lem:Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`,
   `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound`,
   `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`,
   and
   `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

   Primary declaration to add/prove:
   `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound`
   (or the same statement under an equivalent local name if the exact Lean shape needs adjustment).

   Mathematical content:
   assume monotone deterministic partitions from `⊥` to `t`, a deterministic value bound `C`, a deterministic total-variation bound `V`, and a deterministic increment modulus `δ n -> 0`; use `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound` to produce the a.e. convergence premise of the already-closed `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`, then call that lemma.

   Stronger progress if the first helper closes:
   prove `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`, or move its remaining proof debt into a strictly smaller deterministic partition/modulus-construction helper.

## Deferred This Iter

- `BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: still queued for the generic square-norm local-submartingale context repair, but deferred until the active Doob-Meyer predictable finite-variation bridge is smaller or closed.
- `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: no internal `sorry`; keep as downstream verification only.
- The old weak local Doob-Meyer theorem in `DoobMeyer.lean`: not targeted unless the predictable finite-variation bridge closes and the downstream repair is immediate.
