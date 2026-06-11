# Iteration 040 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-039/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `1997` and the actual `sorry` at line `2033`. The original weak local Doob-Meyer theorem remains with the actual `sorry` at line `2255`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke measurability packaging around already formalized martingale/predictable/left-limit facts, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed left-approaching jump-removal lemma is sound but strong: it assumes each increment `N t - N (u n)` is already measurable at the earlier deterministic time `u n`. Strong predictability alone does not give that fixed earlier-time measurability; it gives measurability of the time section with respect to the past sigma-algebra `⨆ s : {s // s < t}, 𝓕' s`.

Therefore the next step should not try to manufacture `𝓕' (u n)`-measurability from predictability. The honest route is to make the left-limit random variable and the jump `N_t - N_{t-}` measurable with respect to the past sigma-algebra, then leave the conditional-expectation zero argument as the next separate analytic obligation.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but pivot the predictable-jump bookkeeping route from fixed-earlier-time increment measurability to past-sigma jump measurability.

The next target is the two-lemma package:

- `MeasureTheory.Martingale.stronglyMeasurable_leftLim_past_of_left_approach`
- `MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach`

I chose this over directly attacking the past conditional-expectation zero theorem because the latter still needs conditional-expectation continuity along increasing filtrations, while the measurability package is a concrete missing prerequisite already supported by the closed left-limit and strong-predictability section lemmas. The cheapest signal that would make me reverse this choice is a prover result showing that `stronglyMeasurable_of_tendsto` cannot handle the pointwise `ℕ`-sequence limit in the past sigma-algebra; in that case the next plan should isolate an even lower-level measurable-limit lemma for real-valued random variables.

## Strategy Update

Updated `STRATEGY.md` to describe the active predictable finite-variation phase as a past-sigma jump split rather than an announcing-sequence/fixed-earlier-time measurability split. The estimated remaining work increased modestly because the route now explicitly separates past-sigma measurability from the conditional-expectation zero step.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with:

- `lem:Martingale.stronglyMeasurable_leftLim_past_of_left_approach`, with `\lean{MeasureTheory.Martingale.stronglyMeasurable_leftLim_past_of_left_approach}`.
- `lem:Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach`, with `\lean{MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach}`.
- Added these lemmas to the `\uses{...}` lists and proof prose for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` and `lem:Martingale.eq_zero_of_predictable_finiteVariation_value_zero`.

The proof sketch says: each `N (u n)` is measurable in the past sigma-algebra by martingale adaptedness and `u n < t`; the random variables `N (u n)` converge pointwise to `N_{t-}` by the finite-variation left-limit theorem and `u n -> t` from the left; a sequential limit of strongly measurable real random variables is strongly measurable. Then strong predictability supplies past measurability of `N_t`, and subtraction gives past measurability of the jump.

## Objective Set

Assigned one prover objective:

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean`: add and prove `MeasureTheory.Martingale.stronglyMeasurable_leftLim_past_of_left_approach` and `MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach` immediately after `LocallyBoundedVariationOn.exists_tendsto_left_univ`.

Verified this iteration by Lean local search/source inspection: `stronglyMeasurable_of_tendsto`, `tendsto_pi_nhds`, `StronglyMeasurable.mono`, `tendsto_leftLim_of_tendsto`, `Filter.Tendsto.comp`, `MeasureTheory.IsStronglyPredictable.stronglyMeasurable_past`, and `Tendsto.congr'`.
