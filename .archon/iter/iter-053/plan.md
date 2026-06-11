# Iteration 053 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-052/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed and cleared the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_of_predictable_bottom_immediate`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2937` and the actual `sorry` at line `2973`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3195`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` region. The next lemma is Archon-original branch bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of the closed nontrivial-left stopped-bound/original-continuity pair theorem at `DoobMeyer.lean:2868`, `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous` at `DoobMeyer.lean:805`, `MeasureTheory.Martingale.eq_zero_of_predictable_bottom_immediate` at `DoobMeyer.lean:826`, and the active reduction at `DoobMeyer.lean:2937`.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, and `blueprint/src/chapters/doob_meyer.tex`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-Silent Fallback Executed

Iter 052 said that if the bottom-immediate wrapper closes, continue with the next honest connector toward branch assembly: either a nontrivial-left fixed-time value-zero wrapper under all explicit stopped-bound, variation-bound, continuity, partition, mesh, and `hleft` hypotheses, or a similarly explicit left-isolated successor wrapper with a previous-time zero input.

I chose a slightly broader explicit branch connector. It assumes the common stopped-bound/original-continuity data for the nontrivial-left branch and then assumes, explicitly, one of three left-branch hypotheses: nontrivial left-neighborhood filter, bottom-immediacy, or an explicit greatest predecessor with previous-time zero. This uses both closed isolated-time helpers while still making every branch hypothesis an input.

## Soundness Check

The new objective does not derive a topological/order trichotomy. The disjunction

- `(nhdsWithin t (Set.Iio t)).NeBot`,
- `∀ r : κ, r < t → r ≤ (⊥ : κ)`,
- `∃ s : κ, s < t ∧ (∀ r : κ, r < t → r ≤ s) ∧ N s =ᵐ[P'] 0`,

is an explicit hypothesis of the connector. The stopped-piece bounds, stopped-piece variation bounds, deterministic partitions, mesh, and original-path continuity are also explicit and are only used in the nontrivial-left branch.

This keeps predecessor existence and discrete induction out of the theorem. It also avoids claiming that `(nhdsWithin t (Set.Iio t)) = ⊥` implies either bottom-immediacy or the existence of a greatest strict predecessor.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch`

The corresponding blueprint block was added to `blueprint/src/chapters/doob_meyer.tex` with label:

- `lem:Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch`

No `\leanok`, `\mathlibok`, or semantic marker edits were made.

## Fallback if no user response

No user response is needed. If the explicit branch connector closes, continue toward the active reduction by choosing one missing hypothesis-construction wrapper rather than assigning the full reduction: either package stopped-piece bounds/variation bounds from a localizing sequence under honest explicit level assumptions, or package deterministic mesh/partition existence only under sufficiently strong ordered compactness assumptions. Do not infer any branch condition or mesh existence without a separate proved lemma.
