# Iteration 045 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-044/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.integrable_jump_leftLim_of_left_approach_of_bound` and `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2337` and the actual `sorry` at line `2373`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `2595`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke stopped/localizing bookkeeping, so no external citation block was added.
- API checks this iteration: hover/source verification confirmed `MeasureTheory.Martingale.stoppedProcess_indicator`, `MeasureTheory.IsStronglyPredictable.stoppedProcess_indicator`, `ProbabilityTheory.locallyBoundedVariationOn_stoppedProcess_indicator`, `MeasureTheory.stoppedProcess_indicator_bound_on_Icc`, `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`, and `ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt`.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local write boundary says the plan agent must not edit `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed no-extra-integrability jump-removal wrapper is sound because it keeps the deterministic left-approaching sequence and a.e. deterministic horizon bound explicit, and it derives integrability only from that bound.

The next target must not pretend that localization, sequence existence, or continuity on all of `[⊥, t]` has been constructed. The honest next step is only to specialize bounded jump removal to stopped/indicator processes: martingale, predictability, pathwise local bounded variation, and horizon bounds are already closed under this stopped localization. The left-limit comparison back to the original process on `{t < τ n}` and the eventual-cover exhaustion are separate future obligations.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with stopped/localized bounded jump-removal wrappers:

- `MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound`
- `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_stoppedProcess_indicator_of_left_approach_of_bound`

I chose this over directly attacking `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` because the full reduction still lacks sequence existence, left-limit event transfer, variation/localization bounds, and deterministic mesh inputs. These wrappers package the newly closed bounded jump theorem in the exact stopped setting used by the existing localization infrastructure.

The cheapest signal that would make me reverse this choice is a prover result showing the stopped-process bound/predictability/variation APIs do not align definitionally with the no-extra-integrability wrapper; in that case the next plan should first add the missing stopped-process alignment lemma rather than retry the wrapper unchanged.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with informal blocks for:

- `lem:Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound`
- `lem:Martingale.ae_eq_leftLim_localizingSequence_stoppedProcess_indicator_of_left_approach_of_bound`

Both are Archon-original bookkeeping lemmas and intentionally have no external source citation.
