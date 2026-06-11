# Iteration 049 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`

   New blueprint blocks:

   - `lem:Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot`
   - `lem:Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left`

   Task: prove the deterministic left-approach sequence extraction helper under the explicit hypothesis `(nhdsWithin t (Set.Iio t)).NeBot`, then use it to prove the stopped-bound terminal/left-limit zero wrapper with the sequence argument removed.

   Key proof ingredients: `isCountablyGenerated_nhdsWithin`, `SecondCountableTopology.to_firstCountableTopology`, `self_mem_nhdsWithin`, `Filter.Eventually.frequently`, and `Filter.exists_seq_forall_of_frequently` for the sequence helper; then call the closed `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` with the constructed sequence.

## Non-Targets

- Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this iteration.
- Do not attempt `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.
- Do not construct stopped-piece bounds, stopped-piece variation bounds, stopped-piece continuity, deterministic partitions, or mesh in this split.
- Do not claim `⊥ < t` alone gives a strict left-approaching sequence; keep the nontrivial-left-filter hypothesis explicit.

## Verification

Run `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, then `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`, `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`, and `lake build`.
