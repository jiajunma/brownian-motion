# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn (line 1904)
### Attempt 1
- **Approach:** Added the planned wrapper immediately after `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`. Kept the same hypotheses as the stopped-piece wrapper, but replaced `hZ_cont` with original path continuity `hN_cont : ∀ ω, ContinuousOn (N · ω) (Set.Icc (⊥ : κ) t)`.
- **Result:** RESOLVED.
- **Key insight:** The stopped-piece continuity argument is exactly `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc (N := N) (τ := τ n) (ω := ω) (t := t) (hN_cont ω)`, which discharges the `hZ_cont` hypothesis of the existing localizing-sequence wrapper. The bound, variation, partition, and mesh hypotheses pass through unchanged.
- **Soundness:** The wrapper only transfers continuity from an already continuous original path. It does not assert that cadlag stopped paths are continuous and does not construct deterministic partitions or deterministic variation localizations.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction (declaration warning line 1964, body sorry line 2000)
### Attempt 1
- **Approach:** Not a target this round per `PROGRESS.md`.
- **Result:** PARTIAL / OPEN. Existing `sorry` remains.
- **Next step:** Use the new original-continuity localizing-sequence wrapper when a later proof has separately established predictable-jump removal, bounded/variation localizations, deterministic partitions, and mesh hypotheses.

## ProbabilityTheory.IsLocalSubmartingale.doob_meyer (declaration warning line 2217, body sorry line 2222)
### Attempt 1
- **Approach:** Not a target this round per `PROGRESS.md`.
- **Result:** PARTIAL / OPEN. Existing weak local Doob-Meyer `sorry` remains.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed. Warnings: deprecated `MeasureTheory.integrable_finset_sum` at line 1117, deprecated `MeasureTheory.integral_finset_sum` at line 1132, and existing `sorry` warnings at declaration lines 1964 and 2217.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed with the known `sorry` warning at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed with no output.
- `lake build` passed (`3312 jobs`). The final target modules built successfully; remaining project-wide output consists of pre-existing `sorry` warnings and the two deprecation warnings above.
