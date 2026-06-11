# Iteration 036 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-035/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor report in the invocation says there are no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed:
  - `MeasureTheory.stoppedProcess_indicator_bound_on_Icc`.
  - `BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_Icc`.
  - `BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc`.
  - `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at declaration line `1843` with the actual `sorry` at line `1879`. The original weak local Doob-Meyer theorem remains at declaration line `2096` with the actual `sorry` at line `2101`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Proof-journal session 35 records the same mathematical result, while the current-session preprocessor again incorrectly reports `no_prover_lane: true`; I used the task result and review notes as reliable evidence.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` region. The next stopped/localizing wrapper is project-bespoke, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.
- The worktree already contains many dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed stopped/indicator transfer lemmas are sound pathwise bookkeeping. They do not claim that stopping creates continuity, they do not produce deterministic mesh partitions, and they do not turn local bounded variation into deterministic variation bounds.

The next wrapper is also only bookkeeping. It assumes original a.e. horizon bounds and original a.e. variation bounds indexed by the localizing time, applies `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc` for each `τ n`, and delegates to the already closed localizing-sequence zero theorem. The wrapper should carry the extra `ConditionallyCompleteLinearOrderBot κ` context required by the stopped/indicator transfer. Stopped-piece continuity, deterministic partitions, and explicit mesh remain assumptions.

The full predictable finite-variation reduction is still not ready as a single objective. It still needs predictable-jump removal, construction of bounded and variation localizations, continuity transfer, and honest deterministic mesh handling.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, not `QuadraticVariation.lean`. The active bottleneck is still predictable finite-variation uniqueness, and the next small target turns the stopped/indicator transfer layer into the exact hypotheses of the localizing-sequence theorem.

I updated `blueprint/src/chapters/doob_meyer.tex` to add:

- `lem:ae_stoppedProcess_indicator_bound_variation_on_Icc`, documenting the a.e. packaging helper closed in iter-035.
- `lem:Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`, the new stopped/localizing wrapper to be proved this iteration.

I also added those support lemmas to the `\uses{...}` list of `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` and updated `STRATEGY.md` to reflect that the route has moved from stopped-bound transfer to localization packaging.

The prover objective asks for exactly the wrapper `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn` and explicitly forbids a monolithic retry of `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
