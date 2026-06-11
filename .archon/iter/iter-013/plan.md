# Iteration 013 Plan

## State Collected

- No user hints were supplied this iteration. `iter-012/plan.md` declared no
  user-silent fallback, so there was no fallback to execute.
- The iter 012 prover result made real Doob--Meyer progress:
  `BoundedVariationOn.sub`, `LocallyBoundedVariationOn.sub`, and
  `ProbabilityTheory.IsLocalMartingale.sub` compile.
- `ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition`
  now compiles as a reduction to
  `ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation`.
  It introduces no additional internal `sorry`.
- `ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation`
  remains partial with one `sorry`: the continuous-time theorem that a
  strongly predictable càdlàg local martingale with locally bounded-variation
  paths and zero bottom value is zero at each deterministic time a.e.
- Verification reported by the prover passed for
  `DoobMeyer.lean`, both downstream quadratic-variation files, and
  `lake build`. Independent source inspection shows the current sorries on
  this route are `DoobMeyer.lean:386` for the new uniqueness bridge and
  `DoobMeyer.lean:395` for the original weak local Doob--Meyer theorem.
- There are still no proof-journal session summaries or recommendations, only
  `current_session/attempts_raw.jsonl`.
- Source inspection this iteration confirmed the relevant existing APIs:
  `MeasureTheory.Martingale.eq_zero_of_predictable'` for discrete predictable
  martingales, `MeasureTheory.IsStronglyPredictable.stronglyAdapted`,
  `.isStronglyProgressive`, `MeasureTheory.IsStronglyProgressive.stoppedProcess`,
  `MeasureTheory.stoppedProcess_indicator_comm`,
  `ProbabilityTheory.Locally.localSeq`,
  `ProbabilityTheory.Locally.stoppedProcess_localSeq`, and
  `MeasureTheory.stoppedProcess_eq_of_le`.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but do not
re-dispatch the same broad theorem as an opaque hard problem.

The next prover objective is to split the remaining bridge into the stopped
predictability/localization layer and the true-martingale finite-variation
layer.  The local wrapper should be proved from a true-martingale theorem by
using the localizing sequence, stopped-indicator predictability, and pathwise
locally bounded-variation stability under stopping.  If the continuous-time
true-martingale theorem is still too large, the only remaining `sorry` should
move into `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation`,
not remain in the local wrapper.

I am not returning to `quadraticVariation_brownian` yet.  Even though the
normalized predictable-part comparison now compiles, it depends on an unproved
uniqueness bridge; using it to close the Brownian theorem would only hide the
actual mathematical gap.  I am also not pivoting to the square-norm
submartingale sorry this round because the active route just exposed a sharper
and still plausible next layer rather than repeating a failed approach.

The cheapest signal to reverse this route would be a prover result showing
that stopped predictability cannot be proved from the current predictable
sigma-algebra API without a substantial refactor.  In that case the next plan
should either narrow the uniqueness theorem to the exact deterministic-time
process needed for Brownian quadratic variation or pivot to the queued
square-norm submartingale prerequisite.

## Blueprint Work

- Expanded `blueprint/src/chapters/doob_meyer.tex` with
  `lem:IsStronglyPredictable_stoppedProcess_indicator`, giving the generator
  proof for stopping and bottom-time indicator truncation preserving strong
  predictability.
- Added `lem:LocallyBoundedVariationOn_stoppedProcess_indicator`, reducing
  stopped path variation on a compact interval to the original variation after
  deleting repeated partition points.
- Added `thm:Martingale.eq_zero_of_predictable_finiteVariation` as the
  true-martingale bridge that should absorb any remaining analytic gap.
- Refined `thm:IsLocalMartingale.eq_zero_of_predictable_finiteVariation` so
  its proof first localizes to the true-martingale theorem and then passes
  fixed-time a.e equalities back through the localizing sequence.
- No external source was used; this is project-local stochastic-process
  infrastructure.

## State Updates

- Updated `task_pending.md` to show the two current `DoobMeyer.lean` sorries
  and the new stopped-predictability/localization objective.
- Updated `task_done.md` with the newly compiled finite-variation subtraction,
  local-martingale subtraction, and normalized predictable-part comparison
  declarations.
- Updated `STRATEGY.md` to mark the predictable finite-variation uniqueness
  bridge as isolated and to add stopped predictability as an explicit gap.
- Rewrote `PROGRESS.md` with a single next prover assignment for
  `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

## Subagents

No subagents are enabled for this project this iteration, so none were
dispatched or skipped.
