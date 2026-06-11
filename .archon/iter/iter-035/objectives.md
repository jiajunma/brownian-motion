# Iteration 035 Objectives

## Prover Lane

1. **`BrownianMotion/StochasticIntegral/DoobMeyer.lean`** — Blueprint: `blueprint/src/chapters/doob_meyer.tex`, lemmas `lem:stoppedProcess_indicator_bound_on_Icc`, `lem:eVariationOn_stoppedProcess_indicator_le_Icc`, and `lem:stoppedProcess_indicator_variation_bound_on_Icc`.

   Add and prove:

   - `MeasureTheory.stoppedProcess_indicator_bound_on_Icc`
   - `BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_Icc`
   - `BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc`

   These should be pathwise deterministic lemmas. They should not require martingale, predictability, stopping-time, finite-measure, or filtration hypotheses.

   Proof ingredients:

   - For the horizon bound, split on `(⊥ : κ) < τ ω`. On the indicator event, prove the stopped time is still in `Set.Icc (⊥ : κ) t`; off the event, the stopped/indicator path is zero.
   - For the variation inequality, use the same monotone-map argument already present in `LocallyBoundedVariationOn.stoppedProcess`: a partition of `[⊥, t]` maps under `s ↦ min (s : WithTop κ) (τ ω)` to a monotone list in `[⊥, t]`.
   - Derive the bounded-variation corollary from the extended-variation inequality, finiteness of the original variation, and monotonicity of `ENNReal.toReal`.

   Optional stretch only after those three lemmas compile: add an a.e. wrapper transferring original a.e. horizon and variation bounds to stopped/indicator a.e. bounds. Do not leave a new `sorry` for the stretch.

   Do not work on `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic target this round.

## Verification Expected

Run:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
