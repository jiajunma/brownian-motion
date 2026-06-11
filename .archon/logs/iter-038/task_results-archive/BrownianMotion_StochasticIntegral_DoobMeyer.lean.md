# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.stoppedProcess_indicator_continuousOn_Icc (line 665)
### Attempt 1
- **Approach:** Split on `(⊥ : κ) < τ ω`. The inactive branch is the constant-zero path. In the active branch, split on `τ ω = ⊤`; the top branch is pointwise equal to the original path, while the finite branch writes `τ ω = a` and composes the original `ContinuousOn` path with the continuous map `s ↦ min s a`.
- **Result:** RESOLVED.
- **Key lemmas/API:** `Continuous.min`, `ContinuousOn.comp'`, `WithTop.ne_top_iff_exists`, `WithTop.coe_min`, `WithTop.untopA_coe`.
- **Assumptions used:** `[ConditionallyCompleteLinearOrderBot κ] [TopologicalSpace κ] [OrderTopology κ]`.

## MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn
### Attempt 1
- **Approach:** Left unchanged this iteration, per blueprint note: the current Lean statement still assumes stopped-piece continuity directly.
- **Result:** NOT MODIFIED. The new helper now supplies the intended path-continuity transfer for later uses from original-process continuity.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction (line 1933)
### Attempt 1
- **Approach:** Not retried as a monolithic proof, per current objective.
- **Result:** OPEN. The internal `sorry` remains at line 1969.

## Weak local Doob-Meyer wrapper (line 2191)
### Attempt 1
- **Approach:** Not a target this iteration.
- **Result:** OPEN. The original weak local Doob-Meyer theorem still has its existing `sorry` at line 2191.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed, with the known `sorry` warning at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed.
- Final `DoobMeyer.lean` warnings: deprecated `MeasureTheory.integrable_finset_sum` at line 1117, deprecated `MeasureTheory.integral_finset_sum` at line 1132, existing `sorry` declarations at lines 1933/2186 with actual `sorry`s at lines 1969/2191.
