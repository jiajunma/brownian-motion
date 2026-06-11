# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_stopped_bound (line 2557)
### Attempt 1
- **Approach:** Mirror the existing original-bound stopped/indicator jump-removal lemma, but use the stopped-process horizon-bound hypothesis directly as the bounded-horizon input for the stopped process `Z`.
- **Result:** RESOLVED.
- **Key insight:** The martingale, strong predictability, and locally bounded variation transfer proofs are identical to the original-bound lemma; the only removed step is `MeasureTheory.stoppedProcess_indicator_bound_on_Icc`.

## MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_stopped_bound (line 2595)
### Attempt 1
- **Approach:** Call the new stopped-bound stopped-process lemma, then reuse the existing terminal agreement and `MeasureTheory.leftLim_stoppedProcess_indicator_eq_of_lt` argument on `{ω | (t : WithTop κ) < τ ω}`.
- **Result:** RESOLVED.

## MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_stopped_bound (line 2643)
### Attempt 1
- **Approach:** Apply the stopped-bound event lemma for each localizing time, combine with `ae_all_iff.2`, and use the localizing sequence cover from `hτ.tendsto_top`.
- **Result:** RESOLVED.

## MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn (line 2682)
### Attempt 1
- **Approach:** Compose `eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` for terminal zero with the new stopped-bound localizing-sequence jump-removal lemma for `N t = N_{t-}`.
- **Result:** RESOLVED.
- **Key insight:** The wrapper keeps the stopped-piece horizon bounds, variation bounds, continuity, deterministic partitions, and mesh assumptions explicit; it does not derive them from predictability or local bounded variation.

## Remaining gaps
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` remains open. Declaration starts at line 2757; actual `sorry` at line 2793.
- The public weak local Doob-Meyer theorem remains open. Actual `sorry` at line 3015.
- `QuadraticVariation.lean` still has the known generic square-norm local-submartingale `sorry` at line 84.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed. Warnings: deprecated `MeasureTheory.integrable_finset_sum` / `MeasureTheory.integral_finset_sum`, and known `sorry` declarations at lines 2757 and 3010.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed with the known line 64 declaration-level `sorry` warning.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed successfully: 3312 jobs.
