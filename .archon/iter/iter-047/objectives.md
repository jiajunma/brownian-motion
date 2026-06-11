# Iteration 047 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Add and prove `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`.
   - Place it immediately after `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`.
   - Use blueprint block `lem:Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`.
   - Proof ingredients: terminal zero from `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`; jump removal from `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound`; combine by `Filter.EventuallyEq.symm` and `Filter.EventuallyEq.trans`.

## Non-Targets

- Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this iteration.
- Do not attempt the public `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` theorem.
- Do not construct deterministic left-approaching sequences, bounded/variation localizations, continuity inputs, or deterministic mesh/refinement hypotheses in this split.
