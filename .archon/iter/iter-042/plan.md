# Iteration 042 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-041/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Filtration.ae_eq_zero_of_past_setIntegral_eq_zero` and `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2145` and the actual `sorry` at line `2181`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `2403`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke martingale/dominated-convergence bookkeeping, so no external citation block was added.
- API checks this iteration: hover/source search verified the local declarations `MeasureTheory.Martingale.integral_mul_increment_eq_zero_of_stronglyMeasurable` and `MeasureTheory.Martingale.condExp_increment_eq_zero`, Mathlib `MeasureTheory.tendsto_integral_of_dominated_convergence`, Mathlib `MeasureTheory.tendsto_setIntegral_of_L1`, `MeasureTheory.integral_indicator`, `stronglyMeasurable_const.indicator`, and `Integrable.indicator`.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed generated-past package is sound: it proves jump removal only after integrability, past-sigma measurability, and zero set integrals on every earlier-filtration measurable set are all explicit.

The next target must not infer those zero set integrals from past measurability alone. The honest split is: finite martingale increments have zero set integral over earlier-filtration sets; if a left-approaching sequence is eventually after a fixed strict-past time and the increments are dominated on the restricted set, dominated convergence passes those zero integrals to the predictable jump. The domination/localization hypotheses remain separate future obligations.

This also avoids the unsound fixed-earlier-time measurability shortcut: no claim is made that strong predictability makes `N t - N (u n)` strongly measurable with respect to `𝓕' (u n)`.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with the analytic jump set-integral package:

- `MeasureTheory.Martingale.setIntegral_increment_eq_zero_of_measurableSet`
- `MeasureTheory.Martingale.setIntegral_jump_leftLim_eq_zero_of_left_approach_of_dominated`

I chose this over assigning the full predictable finite-variation reduction because the closed generated-past wrapper now identifies the exact missing hypothesis: zero integrals of `N_t - N_{t-}` over all earlier-filtration sets. The proposed pair proves the finite-increment identity and a dominated left-limit passage, while keeping construction of dominators/localizing bounds for a later iteration.

The cheapest signal that would make me reverse this choice is a prover result showing that even the restricted-measure dominated-convergence wrapper is blocked by set-integral/restrict API friction. In that case the next plan should weaken the second helper to an L1-convergence wrapper using `MeasureTheory.tendsto_setIntegral_of_L1`, then separately prove domination implies the L1 convergence needed by that wrapper.

## Strategy Update

Updated `STRATEGY.md` to mark the active predictable finite-variation phase as the jump set-integral limit split rather than the generated-past uniqueness split. The remaining estimate is now `3-5` iterations and about `70` Lean LOC for this phase before the route moves to localization/mesh packaging.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with:

- `lem:Martingale.setIntegral_increment_eq_zero_of_measurableSet`, with `\lean{MeasureTheory.Martingale.setIntegral_increment_eq_zero_of_measurableSet}`.
- `lem:Martingale.setIntegral_jump_leftLim_eq_zero_of_left_approach_of_dominated`, with `\lean{MeasureTheory.Martingale.setIntegral_jump_leftLim_eq_zero_of_left_approach_of_dominated}`.

I also added these labels to the `\uses{...}` lists for the predictable finite-variation reduction and value-zero bridge, and expanded the reduction prose so the finite-increment identity and dominated left-limit passage are explicit.

## Objectives Written

`PROGRESS.md` now assigns one prover lane:

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean`: add and prove the two new set-integral helpers after `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero` and before `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`.

The objective explicitly forbids retrying `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic proof this round.

## User-silent Fallback Executed

None. The prior iteration sidecar declared no fallback.
