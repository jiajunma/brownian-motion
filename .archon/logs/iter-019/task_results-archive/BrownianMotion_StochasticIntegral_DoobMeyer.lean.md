# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## BoundedVariationOn.sum_norm_sub_le_toReal_eVariationOn (line 628)
### Attempt 1
- **Approach:** Convert the finite partition sum of real norms to an `ENNReal.ofReal` sum, identify each term with `edist`, and apply `eVariationOn.sum_le`; then use `ENNReal.toReal_mono` under `BoundedVariationOn`.
- **Result:** RESOLVED
- **Key insight:** This provides the pathwise finite-variation bound needed for square-increment estimates.

## BoundedVariationOn.sq_increment_sum_le_uniform_bound (line 657)
### Attempt 1
- **Approach:** Bound each `‖Δ_i‖ ^ 2` by `δ * ‖Δ_i‖` using the uniform increment bound, sum, and apply the previous variation estimate.
- **Result:** RESOLVED
- **Key insight:** This isolates the deterministic inequality `sum squares ≤ max increment * variation`.

## BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound (line 679)
### Attempt 1
- **Approach:** Use `squeeze_zero` with the previous bound and `δ_n → 0`.
- **Result:** RESOLVED
- **Key insight:** This closes the finite-variation part of the blueprint's continuous square-increment argument, assuming the stochastic proof supplies partitions with uniformly vanishing increments.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous (line 705)
### Attempt 1
- **Approach:** Introduced the preferred deeper helper to hold the remaining bounded-continuous martingale bridge.
- **Result:** PARTIAL
- **Remaining gap:** The `sorry` now sits here. The unresolved work is to construct bounded continuous localization, prove martingale increment orthogonality along refining deterministic partitions, use the closed square-increment helper for pathwise convergence, and remove localization.
- **Dead-end warning:** Do not claim strong predictability gives arbitrary `𝓕_s` measurability of `N_t - N_s`; the file still only proves the explicit past-section and fixed-time reductions.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero (line 728)
### Attempt 1
- **Approach:** Kept the fixed-time theorem statement unchanged and made it delegate to the deeper bounded-continuous helper after preserving the existing past-measurable-increment and left-limit setup.
- **Result:** PARTIAL via dependency
- **Internal sorry status:** No internal `sorry`; depends on `eq_zero_of_predictable_finiteVariation_bounded_continuous`.

## Downstream uniqueness wrappers
### Attempt 1
- **Result:** PARTIAL via dependency
- **Internal sorry status:** `eq_zero_of_predictable_finiteVariation_past_condExp_zero`, `eq_zero_of_predictable_finiteVariation_noninitial_analytic`, `eq_zero_of_predictable_finiteVariation_noninitial`, `eq_zero_of_predictable_finiteVariation`, and `ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation` remain free of internal `sorry` beyond the new bounded-continuous helper dependency.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: PASS; warnings at `DoobMeyer.lean:705` and pre-existing `DoobMeyer.lean:917`.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: PASS; known warning at `QuadraticVariation.lean:64`.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: PASS.
- `lake build`: PASS; warnings are existing project sorries plus `DoobMeyer.lean:705` and `DoobMeyer.lean:917`.
