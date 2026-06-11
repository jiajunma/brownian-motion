# Iteration 021 Plan

## State Collected

- No user hints were supplied. The iter 020 sidecar has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint doctor reported no structural findings: all chapters are input, all `\ref` / `\uses` targets resolve, and no project `axiom` declarations were detected.
- The prover result for `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` was processed. It added `ProbabilityTheory.brownianDeterministicTime`, the deterministic-time predictability/progressivity/cadlag/integrability/monotonicity helpers, `ProbabilityTheory.isCadlag_brownian_sq_sub_time`, and the exact fixed-time theorem
  `ProbabilityTheory.quadraticVariation_brownian (t : ℝ≥0) :
    brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`.
- The prover reported `lake env lean` passing for `QuadraticVariationBrownian.lean`, `QuadraticVariation.lean`, and `DoobMeyer.lean`, followed by a passing `lake build`; only pre-existing upstream `sorry` warnings remain outside the target file.
- LSP diagnostics confirm the direct warnings in `DoobMeyer.lean` are still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` at line 705 and the original weak local Doob-Meyer theorem at line 917. `QuadraticVariation.lean` still has the single `IsLocalMartingale.isLocalSubmartingale_sq_norm` warning.
- `lean_verify` on `ProbabilityTheory.quadraticVariation_brownian` reports no source-scan warnings, but the theorem still depends on `sorryAx` through upstream declarations. This is expected until the generic square-norm, predictable uniqueness, and weak local Doob-Meyer debts close.
- There are still no proof-journal session summaries or recommendations beyond the current raw attempts file.
- No subagents are enabled for this project, so none were dispatched and no subagent skip section is required.

## Decision Made

The Brownian fixed-time surface theorem is no longer the active prover target. It landed exactly as requested, so the next iteration should remove the closest upstream dependency debt rather than restating or polishing the Brownian file.

I am assigning `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, targeting `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`. This route remains mathematically central to the normalized predictable-part comparison used by Brownian quadratic variation, and prior iterations already closed the deterministic finite-variation estimates it needs.

I am not assigning `QuadraticVariation.lean` this iteration. Inspection confirmed that `IsLocalMartingale.isLocalSubmartingale_sq_norm` is currently overgeneral for the known proof route: bounded stopping gives square integrability under the finite-measure/usual localization context used by `quadraticVariation`, not in a bare arbitrary-measure statement. The blueprint and strategy now record this as a separate context repair rather than a tactic gap.

The cheapest signal to reverse this ordering is a prover report showing that the bounded-continuous bridge cannot progress without first repairing the square-norm helper or changing the normalized comparison API. In that case the next plan should pivot to the `QuadraticVariation.lean` context repair before returning to Doob-Meyer.

## Blueprint Work

- Updated `blueprint/src/chapters/stochastic_integral.tex` so `lem:IsLocalMartingale.isLocalSubmartingale_sq_norm` explicitly lives under the finite-measure/usual localization hypotheses needed by the proof route.
- Added `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_core` to `blueprint/src/chapters/doob_meyer.tex`, isolating the partition/orthogonality/dominated-convergence core for bounded continuous finite-variation martingales.
- Rewrote the proof sketch for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` to route through that core after predictable jump removal and bounded localization.
- No external citation was added; these are project-bespoke formalization steps already within the stochastic-integral blueprint.

## Lookup Notes

- `[verified]` `MeasureTheory.Martingale.setIntegral_eq`
- `[verified]` `MeasureTheory.integral_eq_zero_iff_of_nonneg_ae`
- `[verified]` `sq_eq_zero_iff`
- `[verified]` `MeasureTheory.Integrable.of_bound`
- `[verified]` `MeasureTheory.condExp_of_stronglyMeasurable`
- `[verified]` `MeasureTheory.condExp_add`
- `[verified]` `MeasureTheory.condExp_sub`
- `[verified]` `MeasureTheory.Integrable.of_mem_Icc`
- `[verified]` `MeasureTheory.Integrable.of_mem_Icc_enorm`
- `[verified]` `ProbabilityTheory.IsStable.locally_induction`
- `[verified]` `ProbabilityTheory.IsStable.locally_induction₂`
- `[verified]` `Filter.exists_seq_monotone_tendsto_atTop_atTop`
- `[verified]` `ProbabilityTheory.stoppedProcess_indicator_sq_norm`

## Task Result Processing

- Merged the QuadraticVariationBrownian result into `task_pending.md` and `task_done.md`.
- Removed `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` from the open task index.
- Updated `STRATEGY.md` to mark Brownian identification as landed and to make upstream dependency cleanup the active route.
- Archived the processed prover result to `.archon/logs/iter-021/task_results-archive/`; `.archon/task_results/` is empty.
