# Iteration 038 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-037/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `1933` and the actual `sorry` at line `1969`. The original weak local Doob-Meyer theorem remains at declaration line `2186`, with the actual `sorry` at line `2191`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next localizing-sequence wrapper is project-bespoke, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed continuity-transfer lemma is honest: it assumes original path continuity on the deterministic horizon and proves continuity only for the corresponding stopped/indicator path. It does not infer continuity from cadlag paths, does not remove predictable jumps, and does not supply deterministic partitions or deterministic variation bounds.

The next wrapper is also bookkeeping with a real effect. The currently closed localizing-sequence theorem still assumes stopped-piece continuity directly. The new wrapper should instead assume original-path continuity on `[⊥, t]`, derive stopped-piece continuity for each localizing time using `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc`, and then delegate to `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`.

This still leaves the real analytic steps separate: predictable-jump removal, bounded and variation localization, deterministic mesh management, and assembly into `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The next target is the wrapper
`MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`.

I am not assigning the full predictable finite-variation reduction. The cheapest signal that would make me reverse this choice is a prover result showing this wrapper cannot be stated without changing the existing localizing-sequence theorem's signature; in that case the next plan should either adjust the wrapper name/statement locally or pivot to one of the remaining analytic construction steps.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with:

- `lem:Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`, with `\lean{MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn}`.
- A proof paragraph explaining that original continuity supplies stopped-piece continuity by `lem:stoppedProcess_indicator_continuousOn_Icc`, after which the existing localizing-sequence wrapper applies.
- The new lemma in the `\uses{...}` list for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

No `\leanok` markers were added or removed.

## Next Objective

Assign one prover to `BrownianMotion/StochasticIntegral/DoobMeyer.lean` to add and prove the new wrapper. The prover should keep the deterministic horizon bounds, deterministic variation bounds, deterministic partitions, and mesh hypothesis explicit, and should not attempt the monolithic reduction this round.
