# Iteration 014 Plan

## State Collected

- No user hints were supplied. The iter 013 sidecar declared no user-silent fallback, so no fallback was executed.
- The iter 013 prover result made the intended Doob-Meyer split: `MeasureTheory.IsStronglyPredictable.stoppedProcess_indicator`, `LocallyBoundedVariationOn.stoppedProcess`, and `ProbabilityTheory.locallyBoundedVariationOn_stoppedProcess_indicator` now compile.
- `ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation` now has no internal `sorry`; it reduces by the localizing sequence to the true-martingale theorem.
- The only new remaining gap on this route is `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation`, with its `sorry` at `DoobMeyer.lean:530`. The old weak local Doob-Meyer theorem still has its original `sorry` at `DoobMeyer.lean:593`.
- The prover reported `DoobMeyer.lean`, both downstream quadratic-variation files, and `lake build` passed. I spot-checked the relevant declarations in `DoobMeyer.lean`.
- There are still no proof-journal session summaries or recommendations, only `proof-journal/current_session/attempts_raw.jsonl`.
- Source inspection verified the relevant APIs for the next layer: `MeasureTheory.Martingale.eq_zero_of_predictable'` for discrete predictable martingales, finite-measure `SigmaFiniteFiltration`, `ProbabilityTheory.isLocalizingSequence_leastGE`, `MeasureTheory.Martingale.stoppedProcess_indicator`, and the predictable sigma-algebra generators in Mathlib.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but target only the true-martingale analytic bridge.

The previous objective succeeded at the structural layer, so reassigning stopped predictability or local-wrapper work would be stale. The next prover should first formalize the discrete base wrapper around Mathlib's predictable-martingale theorem, then use it as the foundation for the continuous theorem. If the continuous proof is still too large, the remaining `sorry` should move into a sharply named analytic lemma such as jump elimination or the bounded continuous finite-variation case.

I am not pivoting to `QuadraticVariation.lean` this iteration. The square-norm theorem is still real and likely needs a usual finite-measure/sigma-finite context repair, but the active Brownian identification is immediately blocked by Doob-Meyer uniqueness. The stopped-localization part just converged, so one more narrowed true-bridge round is justified.

The cheapest signal to reverse this route would be a prover result showing that the continuous theorem needs substantial quadratic-variation infrastructure before any further reduction can compile. In that case the next plan should pivot to the square-norm/local square-integrability prerequisite or refactor the uniqueness theorem to the exact monotone predictable-part comparison needed downstream.

## Blueprint Work

- Added `thm:Martingale.eq_zero_of_predictable_finiteVariation_discrete` to `blueprint/src/chapters/doob_meyer.tex` as the discrete predictable-martingale base theorem backed by Mathlib's `MeasureTheory.Martingale.eq_zero_of_predictable'`.
- Rewrote the proof sketch of `thm:Martingale.eq_zero_of_predictable_finiteVariation` into three explicit components: sampled discrete predictable martingales, predictable jump elimination, and the bounded/localized continuous finite-variation square-increment argument.
- No external source was used. These are project-local API and proof-structure refinements around the existing Doob-Meyer blueprint.

## Prover Scope

Assign one file: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation`. Start by adding the discrete wrapper `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_discrete` from the blueprint, using the verified Mathlib theorem `MeasureTheory.Martingale.eq_zero_of_predictable'`.

Secondary target:
Use the discrete wrapper to split the continuous theorem into explicit analytic lemmas. If the theorem cannot be closed, leave exactly one honest `sorry` in the deepest new analytic lemma, not in the local wrapper or normalized predictable-part comparison.

Non-targets:
Do not edit `QuadraticVariation.lean` or `QuadraticVariationBrownian.lean`, and do not use the unproved true bridge to prove Brownian quadratic variation.

## Subagent Skips

- No subagents are enabled for this project, so the classic single-agent path is used.

## Verification Notes

- `lake build` was reported green by the prover after the iter 013 changes.
- I did not rerun a full build in the plan phase because only blueprint and Archon state files were edited.
