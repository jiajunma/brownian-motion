# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.stoppedProcess_indicator_bound_on_Icc (line 516)
### Attempt 1
- **Approach:** Proved the pathwise bound by splitting on `(⊥ : κ) < τ ω`; in the true branch the stopped time `min s (τ ω)` stays in `Set.Icc ⊥ t`, and in the false branch the indicator path is zero.
- **Result:** RESOLVED.
- **Key insight:** No stopping-time or measurability hypothesis is needed; explicit `Set.indicator_of_mem` / `Set.indicator_of_notMem` rewrites avoid simplifier ambiguity from the bound variable named `ω`.

## BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_Icc (line 545)
### Attempt 1
- **Approach:** Followed the existing `LocallyBoundedVariationOn.stoppedProcess` partition-map proof. Each monotone finite partition of `[⊥, t]` is sent through `s ↦ (min (s : WithTop κ) (τ ω)).untopA`; the image remains monotone and inside `[⊥, t]`.
- **Result:** RESOLVED.
- **Key insight:** In the false indicator branch, every increment is zero. In the true branch, `eVariationOn.sum_le` on the image partition gives the desired supremum bound.

## BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc (line 614)
### Attempt 1
- **Approach:** Applied the extended-variation inequality, then used `ne_top_of_le_ne_top` for bounded variation and `ENNReal.toReal_mono` to transfer the deterministic real bound.
- **Result:** RESOLVED.

## MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc (line 637)
### Attempt 1
- **Approach:** Added the optional a.e. wrapper requested in the objective by `filter_upwards` over the original a.e. horizon-bound and variation-bound hypotheses.
- **Result:** RESOLVED.

## Remaining declarations
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` remains open: declaration starts at line 1843; the `sorry` is at line 1879.
- `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` remains open: declaration starts at line 2096; the `sorry` is at line 2101.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` has no internal `sorry`; it still delegates to the open bounded-continuous reduction.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed.
  - Existing warnings: deprecated `MeasureTheory.integrable_finset_sum` at line 1074 and `MeasureTheory.integral_finset_sum` at line 1089.
  - Expected `sorry` warnings: line 1843 and line 2096.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed with the known `sorry` warning at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed.
