# Iteration 034 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-033/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor report in the invocation says there are no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed:
  - `MeasureTheory.Martingale.eq_zero_of_localized_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
  - `MeasureTheory.Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at declaration line `1637` with the actual `sorry` at line `1673`. The original weak local Doob-Meyer theorem remains at declaration line `1890` with the actual `sorry` at line `1895`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Proof-journal session 33 records the same mathematical result, while the current-session preprocessor again incorrectly reports `no_prover_lane: true`; I used the task result and raw review notes as reliable evidence.
- Reference check: re-read the local project sources available for this route: `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` section. The new localizing-sequence helper is project-bespoke, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.

## Soundness Check

The closed localized-family and stopped-process wrappers are bookkeeping lemmas. They do not create deterministic mesh partitions, remove deterministic variation bounds, or claim cadlag paths are continuous.

The next proposed helper is also sound at the stated generality because it derives only routine localization facts. A localizing sequence supplies stopping times and almost-sure convergence to `⊤`; convergence to `⊤` implies that, for each fixed deterministic `t`, almost every sample point has some `n` with `(t : WithTop κ) < τ n ω`. The stopped martingale hypothesis follows from the already present stopped-process martingale theorem and right-continuity of cadlag paths. The hard analytic hypotheses for stopped processes, namely deterministic horizon bounds, deterministic variation bounds, continuity on `[⊥, t]`, and explicit entourage mesh, remain assumptions.

The tempting shortcut would be to use this helper to close `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` immediately. That is still premature: the reduction must still construct bounded/variation localizing sequences, manage continuity after predictable-jump removal, and keep the deterministic mesh hypothesis honest.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, not `QuadraticVariation.lean`. The Doob-Meyer route remains the active bottleneck, and the next target should convert a supplied localizing sequence into the hypotheses of the stopped-process wrapper closed in iter-033.

I updated `blueprint/src/chapters/doob_meyer.tex` to add:

- `lem:Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, the localizing-sequence stopped-process wrapper.

I also updated the `\uses{...}` list of `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` to include this new helper.

## Objective Set

Assign one prover lane:

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean`: add and prove `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`. The proof should derive stopped-process martingales from `MeasureTheory.Martingale.stoppedProcess_indicator`, derive the event cover from `hτ.tendsto_top`, and then call `MeasureTheory.Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

If the cover derivation is awkward, the prover may first add a tiny fixed-time cover helper for `IsLocalizingSequence`; this should remain in `DoobMeyer.lean` near the stopped-process wrappers.

## Subagents

No subagents are enabled in `.archon/config.json`; none were available to dispatch this iteration.

## Task Result Handling

The Doob-Meyer task result was incorporated into:

- `.archon/task_pending.md`: current Doob-Meyer line numbers and next split.
- `.archon/task_done.md`: the two iter-033 helper closures.
- `.archon/PROGRESS.md`: the new prover objective.

The task result file itself was left in place due the plan-agent read-only boundary for `task_results/`.
