# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_neBot_left (line 2742)
### Attempt 1
- **Approach:** Extract `<v, hv_lt, hv_tendsto>` from `Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot hleft`, then call the existing explicit-sequence original-bound wrapper with all original horizon-bound, variation-bound, continuity, partition, and mesh hypotheses unchanged.
- **Result:** RESOLVED.
- **Key insight:** The wrapper only replaces the explicit deterministic left-approaching sequence by the explicit nontrivial-left-filter hypothesis; it derives no bounds, variation, continuity, partitions, or mesh.

## MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_neBot_left (line 2817)
### Attempt 1
- **Approach:** Call the closed stopped-bound `_of_neBot_left` wrapper and supply stopped-piece continuity via `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc (hN_cont omega)` for each `n` and `omega`.
- **Result:** RESOLVED.
- **Key insight:** Stopped-piece bounds and variation bounds remain explicit hypotheses; only stopped-piece continuity is derived from original-path continuity.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction (line 2886)
### Attempt 1
- **Approach:** Not targeted this round, per `PROGRESS.md`.
- **Result:** OPEN.
- **Next step:** Continue the analytic bridge: predictable jump removal, bounded localization, deterministic partition construction, martingale increment orthogonality, and dominated convergence.
- **Current warning/sorry lines:** declaration warning at line 2886; actual `sorry` at line 2922.

## ProbabilityTheory.IsLocalSubmartingale.doob_meyer (line 3139)
### Attempt 1
- **Approach:** Not targeted this round, per `PROGRESS.md`.
- **Result:** OPEN.
- **Next step:** Return after the predictable finite-variation uniqueness bridge and remaining quadratic-variation dependency are repaired.
- **Current warning/sorry lines:** declaration warning at line 3139; actual `sorry` at line 3144.

## Verification
- `mcp__archon_lean_lsp__lean_diagnostic_messages BrownianMotion/StochasticIntegral/DoobMeyer.lean` reported no errors.
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed. Warnings: deprecated `MeasureTheory.integrable_finset_sum` at line 1701, deprecated `MeasureTheory.integral_finset_sum` at line 1716, and the two expected `sorry` declarations at lines 2886 and 3139.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed with the known `sorry` warning at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` completed successfully.
