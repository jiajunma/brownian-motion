# Iteration 036 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Add and prove `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`.
   - Blueprint: `blueprint/src/chapters/doob_meyer.tex`, labels `lem:ae_stoppedProcess_indicator_bound_variation_on_Icc` and `lem:Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`.
   - Use `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc` for each `τ n` to build the stopped-process bound and variation hypotheses required by `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
   - Include the `ConditionallyCompleteLinearOrderBot κ` ordered-time context required by the stopped/indicator transfer helper, in addition to the topology/filtration assumptions needed by the existing localizing-sequence theorem.
   - Leave `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` and `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` open.

## Verification Requested

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
