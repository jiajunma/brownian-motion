# Iteration 057 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Add and prove:

   - `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt`;
   - `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_dense_left`;
   - `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_dense_left`.

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, labels:

   - `lem:Filter.nhdsWithin_Iio_self_neBot_of_bot_lt`;
   - `lem:Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_dense_left`;
   - `lem:Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_dense_left`.

## Verified Inputs

- `nhdsWithin_Iio_neBot'` exists in Mathlib and supplies `NeBot (𝓝[Iio c] b)` from `(Iio c).Nonempty` and `b ≤ c`.
- `nhdsLT_neBot_of_exists_lt` exists in Mathlib and supplies the same strict-left neighborhood fact from an explicit predecessor.
- The closed delegation targets are `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_left_branch` and `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_left_branch`.

## Non-Targets

- Do not prove the full `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this round.
- Do not change existing theorem signatures.
- Do not introduce `[NoMinOrder κ]`; use the explicit witness `⊥ < t` instead.
