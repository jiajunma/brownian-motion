# Iteration 056 Objectives

## Prover Dispatch

### `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

Blueprint: `blueprint/src/chapters/doob_meyer.tex`

New declarations:

- `Filter.exists_greatest_lt_of_not_neBot_nhdsWithin_Iio`
- `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_strictPast_zero`

The order helper should prove that a trivial left-neighborhood filter at `t > ⊥` produces a greatest strict predecessor. Use the verified Mathlib ingredients `Filter.not_neBot`, `Filter.empty_mem_iff_bot`, `mem_nhdsWithin_iff_exists_mem_nhds_inter`, and `exists_Ioc_subset_of_mem_nhds`.

The martingale helper should use the same bounded-level inputs as `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_left_branch`, replacing only its explicit branch disjunction by `hprev_zero : ∀ s : κ, s < t → N s =ᵐ[P'] 0`. Prove the branch disjunction by splitting on `(nhdsWithin t (Set.Iio t)).NeBot`; use the new order helper and `hprev_zero` in the complementary case.

Do not target `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this iteration.

Verification requested: `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, then `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`, `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`, and `lake build`.
