# Iteration 026 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-025/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor block in the invocation had no live structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed:
  `MeasureTheory.Martingale.integrable_partition_value_mul_increment_of_bound` and
  `MeasureTheory.Martingale.integral_sq_terminal_eq_partition_sq_sum_of_bound`.
- The active Doob-Meyer gap is still
  `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at `DoobMeyer.lean:1126` with the `sorry` at line 1162. The original weak local Doob-Meyer theorem remains at line 1384, and `QuadraticVariation.lean` still has the generic square-norm gap at line 84.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` passing with only the known project `sorry` warnings plus two existing deprecated integral finite-sum warnings.
- Reference check: `references/` currently contains only `summary.md`. I re-read the local project references available for this route: `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` section. No local original source file for the Beiglböck--Schachermayer--Veliyev route is available to quote, so the new helper prose is treated as project-bespoke and carries no fabricated citation.
- Proof-journal session summaries and recommendations are still absent; `proof-journal/current_session/attempts_raw.jsonl` only contains the no-prover-lane summary record.
- No subagents are enabled for this project, so none were dispatched.
- Archived the processed prover report to `.archon/logs/iter-026/task_results-archive/` and cleared it from `.archon/task_results/`.

## Soundness Check

The bounded-continuous finite-variation martingale statement is mathematically plausible, but the previous blueprint wording hid a domination issue: pathwise bounded variation alone does not give an integrable deterministic dominator for the partition square-increment sums. The cheap counterexample check is that bounded real-valued continuous functions can have arbitrarily large total variation, so a bound on \(|M_s|\) alone cannot dominate \(\sum_i (\Delta M_i)^2\) uniformly in the partition.

This does not refute the target theorem; it means the formal proof should first prove the variation-bounded stopped subcase, where total variation on `[⊥, t]` is bounded by a deterministic level. Localization at increasing variation levels can then recover the locally bounded-variation statement.

## Decision Made

Continue with `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but advance the checkpoint from finite-square algebra to a dominated-convergence helper with an explicit variation bound:
`MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`.

This is the shortest honest next step. The finite square expansion is now closed, so the remaining bounded-continuous layer needs two ingredients: a measure-theoretic dominated-convergence wrapper for partition square sums, and then construction/refinement/localization to supply that wrapper's hypotheses. Asking for the full predictable finite-variation reduction in one jump would likely mix the missing dominator, partition refinement, predictable jump removal, and localization into one opaque `sorry`.

I am not pivoting to `QuadraticVariation.lean` yet. The Doob-Meyer bridge is still producing closed infrastructure and the current gap has become sharper. The square-norm helper stays queued as the next context repair after this uniqueness bridge, unless the prover reports that the variation-bounded refinement still cannot be stated without changing public theorem signatures.

The cheapest signal to reverse this route is a prover report showing that the conditional refining-partition dominated-convergence helper cannot be expressed with the existing martingale, finite-variation, and integration APIs without changing public signatures. If that happens, the next plan should either introduce a smaller purely measure-theoretic helper for finite sums of nonnegative random variables, or pivot to the square-norm usual-condition repair before returning here.

## Blueprint Work

- Updated `blueprint/src/chapters/doob_meyer.tex` to add
  `lem:Martingale.integrable_partition_value_mul_increment_of_bound`.
- Rewrote the proof sketch for
  `lem:Martingale.integral_sq_terminal_eq_partition_sq_sum_of_bound` to match the compiled Lean induction proof rather than the earlier full finite-sum square expansion sketch.
- Added the new checkpoint
  `lem:Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`, separating the dominated-convergence argument under a deterministic total-variation bound from the later partition construction/localization layer.
- Revised
  `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation` so it explicitly uses the variation-bounded stopped subcase before delocalizing.

## State Updates

- Added the newly closed finite-square helper to `task_done.md`.
- Updated `task_pending.md` with current Doob-Meyer line numbers and the next bounded-continuous/refining-partition checkpoint.
- Refreshed the active row in `STRATEGY.md` from finite-square algebra to bounded-continuous dominated convergence.
- Rewrote `PROGRESS.md` to send the next prover to the new refining-partition zero-square-integral helper first.
