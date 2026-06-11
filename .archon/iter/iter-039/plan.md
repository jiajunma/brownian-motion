# Iteration 039 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-038/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `1964` and the actual `sorry` at line `2000`. The original weak local Doob-Meyer theorem remains with the actual `sorry` at line `2222`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemma is project-bespoke bookkeeping around already formalized martingale/left-limit facts, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed original-continuity localizing wrapper is sound bookkeeping: it transfers continuity only from already continuous original paths and does not claim stopped cadlag paths are continuous before jump removal.

The next target is the first predictable-jump bookkeeping split. It assumes an explicit deterministic sequence `u n` tending to `t` from the left and assumes each increment `N t - N (u n)` is strongly measurable with respect to the earlier filtration `𝓕' (u n)`. Under those assumptions, the martingale increment lemma makes all those increments zero a.e.; local bounded variation supplies the left limit; uniqueness of limits gives `N_t = N_{t-}` a.e.

This deliberately does not prove that strong predictability supplies the earlier-time measurability hypothesis. It also does not assert global path continuity, construct deterministic mesh partitions, or build variation-localizing stopping times.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but move away from stopped/indicator wrappers. The next target is
`MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`.

I chose this over bounded/variation localization because the current reduction already has left-limit and increment-zero scaffolding in place, and this lemma removes a real jump-removal subgoal while keeping the hard predictable-section measurability as an explicit future obligation. The cheapest signal that would make me reverse this choice is a prover result showing the left-approach limit packaging is blocked by missing topology/filter API; in that case the next plan should pivot to variation-level localization under explicit deterministic bounds or isolate a lower-level a.e. sequence-limit lemma.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with:

- `lem:Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`, with `\lean{MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments}`.
- Added this lemma to the `\uses{...}` list for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- Added this lemma to the `\uses{...}` list for `lem:Martingale.eq_zero_of_predictable_finiteVariation_value_zero`.

The proof sketch says: apply the closed earlier-time measurable increment lemma for every `u n`; intersect the resulting countable a.e. events; compose the left-limit convergence supplied by locally bounded variation with `u n -> t` from the left; compare with the constant sequence `N_t`.

## Objective Set

Assigned one prover objective:

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean`: add and prove `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments` immediately after `LocallyBoundedVariationOn.exists_tendsto_left_univ`.

Verified this iteration by Lean local search: `tendsto_leftLim_of_tendsto`, `MeasureTheory.ae_all_iff`, `Filter.Tendsto.comp`, `tendsto_const_nhds`, and `tendsto_nhds_unique`.
