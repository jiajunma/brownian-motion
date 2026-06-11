# Iteration 061 Objectives

## Prover Objective

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Add and prove `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_dense_left`.
   - Blueprint: `blueprint/src/chapters/doob_meyer.tex`, lemma `lem:Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_dense_left`.
   - Proof idea: use `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt ht` to produce the nontrivial-left branch, then apply the closed pre-stop left-branch wrapper with all analytic inputs unchanged.
   - Not a target: `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` and `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` remain open.

## Verification Requested

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
