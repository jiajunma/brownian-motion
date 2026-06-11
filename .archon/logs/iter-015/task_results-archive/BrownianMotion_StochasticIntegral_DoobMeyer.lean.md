# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_discrete (line 538)
### Attempt 1
- **Approach:** Wrap Mathlib's `MeasureTheory.Martingale.eq_zero_of_predictable'` for `Nat`-indexed strongly predictable martingales, using the finite-measure `SigmaFiniteFiltration` instance and rewriting the initial value with `hN_zero`.
- **Result:** RESOLVED.
- **Key insight:** The Mathlib theorem gives `N n =ᵐ[P] N 0`; `filter_upwards` plus `simpa [hN_zero omega]` closes the zero-normalized conclusion.
- **Verification:** `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passes.
  Downstream checks also pass: `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`,
  `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`, and `lake build`.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation (line 548)
### Attempt 1
- **Approach:** Split off the deterministic initial time case directly from `hN_zero`, and move the remaining non-initial continuous-time argument into `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial`.
- **Result:** PARTIAL. The wrapper now has no internal `sorry`; it calls the non-initial analytic bridge for `bot < t`.
- **Remaining gap:** `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial` (line 520) still contains the single true-martingale uniqueness `sorry`.
- **Next step:** Prove the non-initial analytic bridge by making sampled predictability explicit, eliminating predictable jumps, then applying the localized square-increment argument for the continuous finite-variation remainder.
- **Dead-end warning:** Strong predictability for a continuous-time process does not by itself simplify to past measurability of arbitrary deterministic samples; the predictable sigma-algebra section argument must be formalized.

## ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation (line 568)
### Attempt 1
- **Approach:** Leave the already-compiled stopped-localization wrapper unchanged.
- **Result:** RESOLVED modulo the true bridge. It remains free of internal `sorry` and depends only on `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation`.
- **Verification:** `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` reports only the expected `sorry` warnings at lines 520 and 622.
  Full `lake build` completed successfully; unrelated/project-known `sorry` warnings remain in other files.

## ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition (line 742)
### Attempt 1
- **Approach:** No edit; verified it still compiles through the local uniqueness wrapper.
- **Result:** RESOLVED modulo the true bridge.

## ProbabilityTheory.IsLocalSubmartingale.doob_meyer (line 622)
### Attempt 1
- **Approach:** No edit; this is the older weak Doob-Meyer decomposition placeholder, outside the current finite-variation uniqueness bridge.
- **Result:** PARTIAL. The existing `sorry` remains unchanged.
