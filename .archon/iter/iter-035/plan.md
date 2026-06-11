# Iteration 035 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-034/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor report in the invocation says there are no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed:
  - `ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt`.
  - `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at declaration line `1694` with the actual `sorry` at line `1730`. The original weak local Doob-Meyer theorem remains at declaration line `1947` with the actual `sorry` at line `1952`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Proof-journal session 34 records the same mathematical result, while the current-session preprocessor again incorrectly reports `no_prover_lane: true`; I used the task result and raw review notes as reliable evidence.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` region. The next stopped/indicator transfer lemmas are project-bespoke, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.
- The worktree already contains many dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The closed localizing-sequence wrapper is sound bookkeeping: it derives stopped true martingales and the a.e. cover, but it still keeps deterministic bounds, deterministic variation bounds, path continuity, deterministic partitions, and explicit mesh as assumptions.

The next safe split is pathwise stopped/indicator bound transfer. If the original path is bounded on `[⊥, t]`, the stopped/indicator path is bounded there because the stopped time lies inside `[⊥, t]` on the indicator event and the process is zero off it. If the original path has bounded variation on `[⊥, t]`, stopping can only read the path along a monotone map and then stay constant, so the stopped variation is no larger.

This does not remove the hard hypotheses. Continuity of stopped pieces is still not derived from càdlàg paths, deterministic mesh existence is still not asserted, and deterministic variation localization remains separate from the pathwise variation-transfer lemma. The full predictable finite-variation reduction still also needs predictable-jump removal.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, not `QuadraticVariation.lean`. The Doob-Meyer uniqueness bridge remains the active bottleneck, and the next helper is small enough to be a useful, honest step rather than another monolithic attempt.

I updated `blueprint/src/chapters/doob_meyer.tex` to add:

- `lem:stoppedProcess_indicator_bound_on_Icc`, the pointwise horizon-bound transfer.
- `lem:eVariationOn_stoppedProcess_indicator_le_Icc`, the pathwise stopped-variation inequality.
- `lem:stoppedProcess_indicator_variation_bound_on_Icc`, the deterministic real variation-bound corollary.

I also added those support lemmas to the `\uses{...}` list of `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

The prover objective asks for the three pathwise lemmas first, with an optional a.e. wrapper only if the three compile without adding any new `sorry`.
