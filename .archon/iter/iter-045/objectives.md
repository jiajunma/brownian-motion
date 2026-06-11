# Iteration 045 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Add and prove `MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound`.
   - Add and prove `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_stoppedProcess_indicator_of_left_approach_of_bound`.
   - Place both declarations immediately after `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`.
   - Use the blueprint blocks `lem:Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound` and `lem:Martingale.ae_eq_leftLim_localizingSequence_stoppedProcess_indicator_of_left_approach_of_bound`.

## Non-Targets

- Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this iteration.
- Do not attempt the public `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` theorem.
- Do not transfer the stopped left limit back to the original process on `{t < τ n}` yet; that is the next split after these wrappers land.
