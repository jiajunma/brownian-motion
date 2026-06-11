# Iteration 031 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-030/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor report in the invocation says there are no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed:
  - `UniformContinuousOn.finite_partition_sup_nnnorm_sub_tendsto_zero`.
  - `ContinuousOn.uniformContinuousOn_Icc`.
  - `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_uniformContinuousOn`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at declaration line `1448` with the actual `sorry` at line `1484`. The original weak local Doob-Meyer theorem remains at declaration line `1701` with the actual `sorry` at line `1706`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read the local project sources available for this route: `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` section. The new helper prose is project-bespoke and carries no external citation.
- Proof-journal session 30 records the same mathematical result, but its current-session preprocessor still incorrectly reports `no_prover_lane: true`; I used the task result/raw review as reliable evidence.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.

## Soundness Check

The closed uniform-continuity wrapper is sound because it keeps the deterministic entourage-mesh hypothesis explicit. The tempting next shortcut would be to assert that such partitions exist for every compact ordered Polish interval. That is false without an extra structure hypothesis: in a two-point discrete ordered interval, the diagonal entourage contains no chain from the bottom point to the top point with adjacent pairs inside the entourage.

This means the broad informal sentence "choose deterministic partitions whose mesh tends to zero" cannot be treated as automatic at the current generality. The next safe helper is therefore the continuous-path version of the already closed uniform-continuity wrapper, still with the explicit mesh hypothesis. Later work must either add an honest connected/dense-order mesh theorem, split off the predictable jump/discrete case, or keep the mesh as an explicit local hypothesis.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, not `QuadraticVariation.lean`. The Doob-Meyer route is still converging, but the next target must remain narrow and explicit to avoid proving a false general bounded-continuous statement.

I updated `blueprint/src/chapters/doob_meyer.tex` to add:

- `lem:ContinuousOn.uniformContinuousOn_Icc`, matching the Lean helper closed in iter-030.
- `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, the next explicit-mesh continuous-path square-integral helper.
- `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, the corresponding explicit-mesh terminal a.e.-zero wrapper.

I also tightened the prose for `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation` so it no longer suggests that deterministic mesh partitions follow automatically in arbitrary ordered Polish time.

## Objective Set

The next prover lane is `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target: prove `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` by deriving pathwise uniform continuity from `ContinuousOn.uniformContinuousOn_Icc` and delegating to the closed `..._variation_bound_uniformContinuousOn` helper.

If that closes quickly, prove `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` by applying the new square-integral helper and then `MeasureTheory.ae_eq_zero_of_integral_sq_eq_zero`.

Do not retry the full predictable finite-variation reduction this iteration, and do not attempt deterministic mesh existence at the current generality.
