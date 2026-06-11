# Iteration 062 Objectives

## Prover Objective

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Add and prove `MeasureTheory.leastGT_norm_pre_stop_bound_on_Icc`.
   - Add and prove `MeasureTheory.leastGT_norm_stop_value_bound_on_Icc_of_continuousOn`.
   - Add and prove `MeasureTheory.ae_leastGT_norm_pre_stop_stop_value_bound_on_Icc_of_continuousOn`.
   - Blueprint: `blueprint/src/chapters/doob_meyer.tex`, lemmas `lem:leastGT_norm_pre_stop_bound_on_Icc`, `lem:leastGT_norm_stop_value_bound_on_Icc_of_continuousOn`, and `lem:ae_leastGT_norm_pre_stop_stop_value_bound_on_Icc_of_continuousOn`.
   - Proof idea: the pre-stop bound follows from `leastGT` as a hitting time of `Set.Ioi C`; the stop-value bound uses pathwise continuity and dense left-neighborhoods to rule out overshoot at the finite stopped value; the a.e. wrapper packages the two pointwise statements.
   - Not a target: the closed-pre-stop variation input, stopping-time/localizing-sequence construction, mesh existence, `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, and `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` remain open.

## Verification Requested

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
