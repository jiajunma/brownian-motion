# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_left_branch (line 3195)
### Attempt 1
- **Approach:** Mirrored the existing original-bound left-branch wrapper.  For each localizing index `n`, used `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound` with `τ := τ n`, `C := C n`, and `V := V n` to package the pre-stop bound, finite stop-value bound, and closed-pre-stop variation bound into stopped/indicator horizon and variation hypotheses.
- **Result:** RESOLVED.
- **Key insight:** The target is only a bookkeeping wrapper.  The stopped-bound branch connector `hN.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch` accepts the packaged stopped-piece bounds directly, so all martingale, cadlag, predictability, local variation, localization, partition, mesh, original continuity, and branch hypotheses are forwarded unchanged.
- **Soundness note:** The proof does not infer no-overshoot, deterministic bounds, variation levels, continuity, partitions, mesh, stopping times, or branch data; these remain explicit inputs.
- **Axiom check:** `lean_verify` on this declaration reported only `propext`, `Classical.choice`, and `Quot.sound`, with no source-scan warnings.

## Remaining open declarations
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` remains open.  Declaration warning line: 3452.  Actual `sorry` line: 3488.
- The public weak local Doob-Meyer theorem `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` remains open.  Declaration warning line: 3705.  Actual `sorry` line: 3710.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed.  Warnings: deprecated `MeasureTheory.integrable_finset_sum` at line 1941, deprecated `MeasureTheory.integral_finset_sum` at line 1956, plus the two known `sorry` declarations at lines 3452 and 3705.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed with the known `sorry` warning at declaration line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed without warnings.
- `lake build` completed successfully: 3312 jobs.
