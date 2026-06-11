# Iteration 051 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-050/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_neBot_left` and `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_neBot_left`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2886` and the actual `sorry` at line `2922`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3144`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are Archon-original predictable/past-sigma bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the signatures of `MeasureTheory.IsStronglyPredictable.stronglyMeasurable_past`, `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_measurable_zero_increment`, the closed nontrivial-left wrappers, and the active reduction. Lean LSP diagnostics on `DoobMeyer.lean:2740-2925` returned only the known reduction `sorry` warning. LSP local name search is still stale for newest project declarations, so raw source and build reports remain the reliable context for them.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- Updated `STRATEGY.md` because the active predictable finite-variation milestone changed from stopped-continuity packaging to the left-isolated predecessor branch.

## User-Silent Fallback Executed

Iter 050 said that if no hint appears and the wrappers close, continue by choosing one genuinely missing input for the same endpoint: either a left-isolated-time branch with an explicit past/discrete argument, or a stopped-piece bound/variation localization lemma with all additional hypotheses stated honestly.

I chose the left-isolated predecessor branch. The stopped-bound/variation path still lacks an honest construction of suitable stopping times and deterministic variation levels from local bounded variation alone; assigning it now would likely repackage assumptions rather than close a new mathematical case. The left-isolated branch has a precise discrete argument: if `s < t` is an explicit greatest strict predecessor and `N s = 0` a.s., strong predictability makes `N t` measurable at `𝓕' s`, the martingale increment lemma gives `N t - N s = 0` a.s., and hence `N t = 0` a.s.

## Soundness Check

The new objective deliberately keeps the greatest-predecessor hypothesis explicit:
`s < t` and `∀ r, r < t → r ≤ s`. It does not assert that triviality of `nhdsWithin t (Set.Iio t)` supplies such an `s`; that remains a separate order-topology question.

The predecessor-zero lemma also keeps the previous-time zero input explicit. This is not a full induction over a discrete interval and not a replacement for the nontrivial-left branch. It is only the local discrete step needed once a predecessor and prior zero statement are available.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.IsStronglyPredictable.stronglyMeasurable_left_isolated_past`
- `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous`

The corresponding blueprint blocks were added to `blueprint/src/chapters/doob_meyer.tex` with labels:

- `lem:IsStronglyPredictable.stronglyMeasurable_left_isolated_past`
- `lem:Martingale.eq_zero_of_predictable_left_isolated_of_previous`

No `\leanok`, `\mathlibok`, or semantic marker edits were made.

## Fallback if no user response

No user response is needed. If these two left-isolated helper lemmas close, continue with the cheapest connective lemma that uses them without overclaiming: either propagate zero from `⊥` to an explicitly bottom-immediate time, or prove a separate order/topology helper only under hypotheses strong enough to produce an explicit greatest strict predecessor. If they fail because the predecessor hypothesis or measurability target is slightly mis-scoped, repair that helper shape rather than returning to the full reduction.
