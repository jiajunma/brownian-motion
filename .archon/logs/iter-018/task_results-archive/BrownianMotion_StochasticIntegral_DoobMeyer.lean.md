# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.condExp_ae_eq_zero_of_ae_eq_zero (line 595)
### Attempt 1
- **Approach:** Use `MeasureTheory.condExp_congr_ae` to replace an a.e.-zero random variable by the zero function, then simplify with `condExp_zero`.
- **Result:** RESOLVED.
- **Key insight:** This closes the final conditional-expectation endpoint once the analytic argument proves fixed-time a.e. value zero.

## LocallyBoundedVariationOn.exists_tendsto_left_univ (line 607)
### Attempt 1
- **Approach:** Restrict local bounded variation to the compact interval `Set.Icc ⊥ x`, apply `BoundedVariationOn.exists_tendsto_left`, and rewrite `(Set.Iic x ∩ Set.Iio x)` to `Set.Iio x`.
- **Result:** RESOLVED.
- **Key insight:** This packages the pathwise left-limit existence needed for deterministic predictable-jump removal.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero (line 631)
### Attempt 1
- **Approach:** Factored the remaining analytic core into the stronger fixed-time value-zero statement. Preserved the already-closed past-measurable increment reduction and added the new left-limit existence/tendsto facts inside the partial proof.
- **Result:** PARTIAL. The remaining `sorry` is at line 664.
- **Next step:** Use `hleftLim_tendsto` plus `hzero_of_past_measurable_increment` to remove deterministic predictable jumps, then prove the bounded continuous finite-variation square-increment argument on finite horizons.
- **Dead-end warning:** Do not assert that strong predictability makes `N t` or `N t - N s` measurable with respect to an arbitrary fixed `𝓕' s` for `s < t`; the current usable reduction still requires an explicit `StronglyMeasurable[𝓕' s] (N t - N s)` hypothesis.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_condExp_zero (line 673)
### Attempt 1
- **Approach:** Prove it formally from `eq_zero_of_predictable_finiteVariation_value_zero` using `MeasureTheory.condExp_ae_eq_zero_of_ae_eq_zero`.
- **Result:** RESOLVED modulo dependency. This declaration has no internal `sorry`; it depends on the `sorry` in `eq_zero_of_predictable_finiteVariation_value_zero`.

## Downstream uniqueness wrappers
### Attempt 1
- **Approach:** Left `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic`, `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial`, `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation`, and `ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation` as wrappers over the deepest analytic helper.
- **Result:** RESOLVED modulo dependency. No new internal `sorry` was introduced in those wrappers.

## Existing weak decomposition theorem (line 819)
### Attempt 1
- **Approach:** Not a target this iteration.
- **Result:** UNCHANGED. The pre-existing `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` `sorry` remains at line 824.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed with `sorry` warnings at declaration lines 631 and 819.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed with its pre-existing `sorry` warning.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed.
