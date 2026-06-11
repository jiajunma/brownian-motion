# Iteration 022 Plan

## State Collected

- The prior-iteration fallback check found no `.archon/iter/iter-021/plan.md`, so there was no user-silent fallback to execute.
- The latest prover result for `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` was processed. It added `ProbabilityTheory.brownianDeterministicTime`, the deterministic-time predictability/progressivity/cadlag/integrability/monotonicity helpers, `ProbabilityTheory.isCadlag_brownian_sq_sub_time`, and the exact fixed-time theorem
  `ProbabilityTheory.quadraticVariation_brownian (t : ℝ≥0) :
    brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`, `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`, `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, and `lake build` passing. Remaining warnings are the known project sorries in `DoobMeyer.lean` and `QuadraticVariation.lean`; the Brownian file has no internal `sorry`.
- Independent source inspection confirmed `QuadraticVariationBrownian.lean` now contains no `sorry`, while `DoobMeyer.lean` still has `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` and the old weak local `doob_meyer`, and `QuadraticVariation.lean` still has `IsLocalMartingale.isLocalSubmartingale_sq_norm`.
- `task_pending.md`, `task_done.md`, and `STRATEGY.md` already reflected the Brownian completion when checked this iteration. The processed Brownian result report was no longer present when archival cleanup ran, and `task_results/` is now empty.
- No proof-journal sessions or `PROJECT_STATUS.md` are present.
- No subagents are enabled for this project, so none were dispatched.

## Decision Made

Return the active prover objective to `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, targeting `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`.

The Brownian fixed-time checkpoint is now in place, but it still depends transitively on the generic predictable-part comparison chain. The remaining Doob-Meyer uniqueness bridge is the highest-leverage dependency below that checkpoint, and the blueprint now has a dedicated bounded-continuous core split. The generic square-norm submartingale gap is real, but its current statement is overgeneral for the known proof route and is better handled after this uniqueness bridge or as a structural context repair.

The assignment should not pretend the current theorem is merely the bounded continuous case. The Lean statement still carries full càdlàg, strong-predictability, and locally bounded-variation hypotheses. The prover should first land the bounded continuous finite-variation martingale core if possible, then use it toward the full bridge. If the full bridge is too large, acceptable progress is a closed core helper plus the original single gap remaining, or moving the one existing gap into a strictly deeper helper with the wrapper reducing to it.

The cheapest signal to reverse this route is a prover report showing that the ordered-time partition or predictable-jump-removal step cannot be stated under the current general `κ` hypotheses without changing public theorem signatures. In that case the next plan should either specialize the uniqueness theorem needed by the Brownian route or assign a structural repair for the time-index assumptions.

## Blueprint Work

- Re-read `blueprint/src/chapters/doob_meyer.tex` around the predictable finite-variation uniqueness section.
- Confirmed the chapter already contains the intended new core helper block `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`.
- Tightened `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` so its `\uses` list includes the measurable-increment and left-limit tools, and its proof sketch explicitly separates predictable-jump removal, bounded continuous finite-variation core, and bounded-stopping removal.
- No external source was cited. The edited bridge is project-bespoke proof infrastructure around the local blueprint, and the local `references/` directory contains no original Beiglböck-Schachermayer-Veliyev source file to quote.

## Lookup Notes

- `[verified]` Mathlib `MeasureTheory.Martingale.eq_zero_of_predictable'` exists only for `ℕ`-indexed predictable martingales.
- `[verified]` Project declaration `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_measurable_zero_increment`.
- `[verified]` Project declaration `LocallyBoundedVariationOn.exists_tendsto_left_univ`.
- `[verified]` Project declaration `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound`.
- `[verified]` Project declaration `MeasureTheory.Martingale.stoppedProcess_indicator`.
- `[verified]` Project declaration `MeasureTheory.IsStronglyPredictable.stoppedProcess_indicator`.
- `[verified]` Project declaration `ProbabilityTheory.locallyBoundedVariationOn_stoppedProcess_indicator`.

## Next Objective

Assign one file: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`.

First milestone:
add and prove a bounded continuous finite-variation core helper matching
`MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`
from the blueprint, with formal hypotheses chosen to make the bounded continuous martingale-square-increment argument honest.

Secondary target:
use that core plus predictable-jump removal to reduce or close the current full bridge. Do not weaken existing theorem statements and do not add unrelated new proof debt.
