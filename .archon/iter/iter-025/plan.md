# Iteration 025 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-024/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor block in the invocation had no live structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed the bounded deterministic finite-partition setup:
  `Finset.sum_range_sub_consecutive`,
  `MeasureTheory.Martingale.partition_increment_sum_eq_terminal`,
  `MeasureTheory.Martingale.integral_partition_cross_increment_eq_zero`,
  `MeasureTheory.Martingale.integrable_partition_increment_mul_increment_of_bound`,
  `MeasureTheory.Martingale.integrable_partition_sq_increment_of_bound`,
  `MeasureTheory.Martingale.integrable_partition_sq_increment_sum_of_bound`,
  `MeasureTheory.Martingale.integral_partition_sq_increment_sum_of_bound`,
  `MeasureTheory.Martingale.integral_partition_cross_increment_eq_zero_of_bound`, and
  `MeasureTheory.Martingale.integrable_sq_terminal_of_ae_bound`.
- The active Doob-Meyer gap is still
  `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at `DoobMeyer.lean:991` with the `sorry` at line 1027. The old weak local Doob-Meyer theorem remains at line 1249. `QuadraticVariation.lean` still has the generic square-norm gap at line 84.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` passing with the expected project-wide `sorry` warnings.
- Reference check: `references/` currently contains only `summary.md`; for this project-local predictable finite-variation helper layer I re-read the blueprint entry point and the relevant `doob_meyer.tex` section. No external source file for the cited Beiglböck--Schachermayer--Veliyev route is present locally to quote this iteration.
- There are no proof-journal session summaries or recommendations; `proof-journal/current_session/attempts_raw.jsonl` only contains the no-prover-lane summary record.
- No subagents are enabled for this project, so none were dispatched.

## Decision Made

Keep the prover on `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but narrow the first deliverable again: the next checkpoint is the finite integrated square expansion
`MeasureTheory.Martingale.integral_sq_terminal_eq_partition_sq_sum_of_bound`.

This is the shortest honest path from the helpers that just landed. The prover now has telescoping, bounded product/square integrability, cross-term orthogonality, finite-sum integral linearity, and terminal square integrability. The remaining finite-partition algebra is to square the telescoping sum, integrate, cancel off-diagonal terms, and identify the diagonal sum. Once that is closed, the next analytic layer is the bounded-continuous zero-square-integral helper using refining partitions plus dominated convergence.

I am not pivoting to `QuadraticVariation.lean` yet. The Doob-Meyer bridge is still converging with concrete closed infrastructure each round and remains the nearest transitive dependency below the Brownian fixed-time theorem. The square-norm helper stays queued as the next context repair after this uniqueness bridge, unless the next prover report shows the refining-partition or localization layer cannot be stated under the current `κ` hypotheses.

The cheapest signal to reverse this route is a prover report showing that the finite square expansion requires changing public theorem signatures, or that deterministic refining partitions over the current general ordered Polish time index need substantial infrastructure outside `DoobMeyer.lean`. In that case the next plan should either specialize the predictable finite-variation uniqueness theorem needed by the Brownian route or pivot to the square-norm usual-condition repair before returning here.

## Blueprint Work

- Updated `blueprint/src/chapters/doob_meyer.tex` around the predictable finite-variation uniqueness section.
- Added blueprint blocks for the newly closed finite-partition helpers and terminal square-integrability helper.
- Added the planned helper block
  `lem:Martingale.integral_sq_terminal_eq_partition_sq_sum_of_bound`, which states the finite integrated square expansion for a bounded monotone deterministic partition from `⊥` to `t`.
- Repointed
  `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`
  through the finite square-expansion helper before the refining-partition and dominated-convergence argument.

## Task State Updates

- Updated `task_pending.md` with the new Doob-Meyer line numbers `1027,1249` and the current finite-square-expansion checkpoint.
- Updated `task_done.md` with the newly closed finite-partition infrastructure.
- Refreshed `STRATEGY.md` only for the active predictable finite-variation phase estimate and milestone wording.
- Rewrote `PROGRESS.md` with a single prover objective for `DoobMeyer.lean`, backed by `chapters/doob_meyer.tex`.
- Cleared the processed prover report from `.archon/task_results/`.

## Subagent Skips

- No subagents are enabled in the injected catalog, so no dispatch or skip rationale is required.
