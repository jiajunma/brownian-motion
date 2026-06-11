# Iteration 052 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-051/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.IsStronglyPredictable.stronglyMeasurable_left_isolated_past` and `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2924` and the actual `sorry` at line `2960`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3182`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` region. The next lemma is Archon-original predictable branch bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous` and the active reduction. Lean LSP diagnostics on `DoobMeyer.lean:730-815` returned no warnings, and diagnostics on `DoobMeyer.lean:2920-2965` returned only the known reduction `sorry` warning. LSP local name search remains stale for the newest project declarations, so source and build reports remain the reliable context for them. Source search confirmed project/Mathlib use of `Eventually.of_forall`.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/DoobMeyer.lean.md` into `task_pending.md` and `task_done.md` and cleared the processed result file, following the current plan prompt.
- Updated `STRATEGY.md` because the active predictable finite-variation milestone changed from the left-isolated predecessor step to explicit branch connective bookkeeping.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-Silent Fallback Executed

Iter 051 said that if the left-isolated helper lemmas close, continue with the cheapest connective lemma that uses them without overclaiming: either propagate zero from `⊥` to an explicitly bottom-immediate time, or prove a separate order/topology helper only under hypotheses strong enough to produce an explicit greatest strict predecessor.

I chose the bottom-immediate propagation wrapper. It is the smallest honest use of the newly closed predecessor lemma: with `s = ⊥`, the existing pointwise normalization supplies the previous zero statement, and the explicit bottom-immediacy hypothesis supplies the greatest-predecessor condition. I did not choose the order/topology helper because deriving a predecessor from filter triviality needs stronger order-topological assumptions and is riskier than this connective step.

## Soundness Check

The new objective keeps the bottom-immediacy hypothesis explicit:
`∀ r : κ, r < t → r ≤ (⊥ : κ)`. It does not infer a greatest predecessor from `(nhdsWithin t (Set.Iio t)) = ⊥`, and it does not claim a full induction over all discrete or left-isolated times.

The proof should use no finite-variation, topology, stopping-time, mesh, or localization facts. It only converts the pointwise bottom zero statement to an almost-sure bottom zero statement and applies the closed left-isolated predecessor zero lemma with predecessor `⊥`.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.eq_zero_of_predictable_bottom_immediate`

The corresponding blueprint block was added to `blueprint/src/chapters/doob_meyer.tex` with label:

- `lem:Martingale.eq_zero_of_predictable_bottom_immediate`

No `\leanok`, `\mathlibok`, or semantic marker edits were made.

## Fallback if no user response

No user response is needed. If the bottom-immediate wrapper closes, continue with the next honest connector toward branch assembly: either a lemma that uses the nontrivial-left terminal/left-limit zero wrapper to prove the active fixed-time value-zero statement under all explicit stopped-bound, variation-bound, continuity, partition, mesh, and `hleft` hypotheses, or a similarly explicit wrapper for a left-isolated successor when the previous-time zero input is already supplied. Do not assign the full predictable finite-variation reduction until the stopped-piece bounds, variation bounds, mesh inputs, and branch split are all available as explicit hypotheses or closed helper lemmas.
