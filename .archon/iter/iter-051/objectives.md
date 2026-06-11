# Iteration 051 Objectives

## Prover Targets

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`

   New declarations:

   - `MeasureTheory.IsStronglyPredictable.stronglyMeasurable_left_isolated_past`
   - `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous`

## Intended Split

This is the left-isolated predecessor branch requested by the iter-050 silent fallback.  It does not attempt the full predictable finite-variation reduction.  It proves only that, under an explicit greatest-strict-predecessor hypothesis `s < t` and `∀ r < t, r ≤ s`, strong predictability makes `N t` measurable at `𝓕' s`, and then the existing measurable-increment martingale lemma propagates a known a.e. zero result from `s` to `t`.

## Not Targets

- Do not infer a greatest strict predecessor from `(nhdsWithin t (Set.Iio t)) = ⊥`.
- Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- Do not construct stopped-piece bounds, variation bounds, deterministic partitions, or mesh in this round.
