# Iteration 044 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-043/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `Filter.Tendsto.eventually_const_le_of_nhdsWithin_Iio`, `MeasureTheory.norm_sub_le_two_mul_of_Icc_bound`, and `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2276` and the actual `sorry` at line `2312`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `2534`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke bounded-jump integrability packaging, so no external citation block was added.
- API checks this iteration: local search verified `MeasureTheory.Integrable.of_bound`, `MeasureTheory.integrable_const`, `tendsto_norm'`, `isClosed_Iic`, `IsClosed.mem_of_tendsto`, and `tendsto_const_nhds`; source search confirmed the nearby project uses of `Integrable.of_bound`, `MeasureTheory.integrable_const`, and the existing left-limit measurability lemmas.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed bounded wrapper is sound because it still assumes an explicit deterministic left-approaching sequence, explicit jump integrability, and a deterministic a.e. horizon bound. It does not infer domination from local bounded variation and does not use fixed-earlier-time increment measurability.

The next step should remove only the explicit jump-integrability hypothesis in the bounded subcase. The honest route is to prove the jump is integrable because it is a strongly measurable random variable bounded a.e. by `2 * C`: the increments `N_t - N_{u_n}` are bounded by the horizon estimate, and their limit is the jump. This leaves sequence existence, localization, variation bounds, continuity transfer, and deterministic mesh management as separate future obligations.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.integrable_jump_leftLim_of_left_approach_of_bound`
- `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`

I chose this over assigning the full predictable finite-variation reduction because the bounded wrapper now exposes a single nearby removable hypothesis, `hjump_int`. Proving it from the same horizon bound gives a stronger bounded jump-removal package without mixing in sequence construction or localization.

The cheapest signal that would make me reverse this choice is a prover result showing the past-sigma strong measurability lemma cannot be promoted to ambient a.e. strong measurability without a separate measurable-space monotonicity helper. If that happens, the corrective is to first add that monotonicity helper, not to retry the full reduction.

## Blueprint Update

Updated `blueprint/src/chapters/doob_meyer.tex` before assigning the prover:

- Added `lem:Martingale.integrable_jump_leftLim_of_left_approach_of_bound`.
- Added `lem:Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`.
- Updated the `\uses{...}` list and proof prose for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` to point at the new bounded jump-integrability package.

These blocks are Archon-original/project-bespoke and therefore have no external source lines.

## State Files Updated

- `task_pending.md`: replaced the completed bounded-horizon helper split with the bounded jump-integrability split.
- `task_done.md`: added the completed iter-043 bounded-horizon package.
- `STRATEGY.md`: refreshed the active predictable finite-variation milestone from bounded jump removal to jump integrability/wrapping; route unchanged.
- `PROGRESS.md`: assigned only `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, backed by `chapters/doob_meyer.tex`, with the two new helper targets and verification requirements.

## Next Prover Dispatch

Dispatch one prover for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. Do not dispatch `QuadraticVariation.lean` this round; its context-repair route remains queued behind the Doob-Meyer predictable finite-variation bridge.
