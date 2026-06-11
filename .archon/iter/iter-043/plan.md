# Iteration 043 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-042/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.setIntegral_increment_eq_zero_of_measurableSet` and `MeasureTheory.Martingale.setIntegral_jump_leftLim_eq_zero_of_left_approach_of_dominated`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2218` and the actual `sorry` at line `2254`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `2476`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke order-topology and bounded-horizon domination packaging, so no external citation block was added.
- API checks this iteration: local search verified `Ioi_mem_nhds`, `nhdsWithin_le_nhds`, `MeasureTheory.integrable_const`, and `MeasureTheory.ae_restrict_of_ae`; the closed project lemmas were checked directly in `DoobMeyer.lean`.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table and plan prompt write-boundary give the plan agent read/collect access, not write access, to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed jump set-integral helper is sound because it keeps the restricted-measure dominator and eventual `s ≤ u n` hypothesis explicit. It does not manufacture domination from local bounded variation and does not use the unsound fixed-earlier-time measurability shortcut.

The next step should not assign the full predictable finite-variation reduction. The honest bounded subcase is: a deterministic left-approaching sequence gives eventual ordering for each fixed strict-past time, and a deterministic a.e. horizon bound gives a constant dominator for the increments on every restricted event. Together these instantiate the closed dominated jump helper and then the generated-past jump-removal wrapper.

This still leaves separate future obligations: constructing or assuming an announcing sequence in the desired time-index context, producing bounded/variation localizations, and managing deterministic mesh hypotheses for the square-integral endpoint.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with the bounded-horizon jump-removal package:

- `Filter.Tendsto.eventually_const_le_of_nhdsWithin_Iio`
- `MeasureTheory.norm_sub_le_two_mul_of_Icc_bound`
- `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound`

I chose this over directly attacking `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` because the latter still lacks sequence/localization/mesh inputs, while the proposed wrapper consumes the exact dominated set-integral lemma proved in iter-042 and exposes the remaining assumptions cleanly.

The cheapest signal that would make me reverse this choice is a prover result showing that the bounded wrapper still has too many moving pieces for one round, especially around `P'.restrict A` domination. In that case the next plan should first split out an a.e. restricted constant-dominator lemma, then retry the jump-removal wrapper.

## Strategy Update

Updated `STRATEGY.md` to mark the active predictable finite-variation phase as bounded jump-removal packaging rather than the jump set-integral limit split. The route now records that past measurability, pi-system uniqueness, and dominated set-integral passage are closed; sequence existence, localization, and deterministic mesh work remain.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with:

- `lem:Tendsto.eventually_const_le_of_nhdsWithin_Iio`, with `\lean{Filter.Tendsto.eventually_const_le_of_nhdsWithin_Iio}`.
- `lem:norm_sub_le_two_mul_of_Icc_bound`, with `\lean{MeasureTheory.norm_sub_le_two_mul_of_Icc_bound}`.
- `lem:Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound`, with `\lean{MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound}`.

I also added the new bounded wrapper to the `\uses{...}` list and prose for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

## Objectives Written

`PROGRESS.md` now assigns one prover lane:

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean`: add and prove the three bounded jump-removal helpers after `MeasureTheory.Martingale.setIntegral_jump_leftLim_eq_zero_of_left_approach_of_dominated` and before `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`.

The objective explicitly forbids retrying the full predictable finite-variation reduction, constructing deterministic meshes, or inferring sequence/domination/jump-integrability hypotheses from strong predictability or local bounded variation.

## User-silent Fallback Executed

None. The prior iteration sidecar declared no fallback.
