# Iteration 050 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`.

   Add and prove:

   - `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_neBot_left`
   - `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_neBot_left`

   The first wrapper replaces the explicit left-approaching sequence in the existing original-bound terminal/left-limit theorem by `(nhdsWithin t (Set.Iio t)).NeBot`, using the already closed sequence-extraction lemma.

   The second wrapper replaces stopped-piece continuity in the stopped-bound `_of_neBot_left` theorem by original-path continuity, using `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc`.

## Non-Targets

- Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this iteration.
- Do not attempt `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` this iteration.
- Do not attempt `ProbabilityTheory.IsLocalMartingale.isLocalSubmartingale_sq_norm` this iteration; it still needs context/signature repair before a proof lane is useful.
