# Iteration 046 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Add and prove `MeasureTheory.stoppedProcess_indicator_eventuallyEq_left_of_lt`.
   - Add and prove `MeasureTheory.leftLim_stoppedProcess_indicator_eq_of_lt`.
   - Add and prove `MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_bound`.
   - Add and prove `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound`.
   - Place these declarations immediately after `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_stoppedProcess_indicator_of_left_approach_of_bound`.
   - Use the blueprint blocks `lem:stoppedProcess_indicator_eventuallyEq_left_of_lt`, `lem:leftLim_stoppedProcess_indicator_eq_of_lt`, `lem:Martingale.ae_eq_leftLim_on_event_of_left_approach_of_bound`, and `lem:Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound`.

## Non-Targets

- Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this iteration.
- Do not attempt the public `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` theorem.
- Do not construct deterministic announcing sequences, bounded/variation localizations, or deterministic mesh/refinement hypotheses in this split.
