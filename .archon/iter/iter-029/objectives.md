# Iteration 029 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially:

   - `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound` at `doob_meyer.tex:1991`.
   - `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_eventual_modulus` at `doob_meyer.tex:2028`.
   - `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation` at `doob_meyer.tex:2064`.

   Required first target: add and prove
   `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_eventual_modulus`.

   The helper should have the same deterministic partitions, horizon bound, deterministic variation bound, and terminal conclusion as the closed deterministic-modulus helper, but its increment-modulus hypothesis should be a.e. existential in the sample point: for almost every `ω`, there exists a nonnegative sequence tending to zero that bounds all partition increments of that path.

   Proof recipe: derive the partition-point bound from the horizon bound; on the a.e. event choose the pathwise modulus and apply `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound`; convert norm-square sums to real square sums via `Real.norm_eq_abs` and `sq_abs`; finish with `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`.

   Optional second target if the first closes quickly: isolate the mesh-to-pathwise-modulus construction for supplied deterministic refining partitions and continuous paths. Do not attempt the full predictable finite-variation reduction unless this smaller construction also closes cleanly.

## Do Not Target

- Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one opaque proof.
- Do not work on `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` this round.
- Do not work on `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` unless the assigned Doob-Meyer helper is impossible to state without public signature changes.
