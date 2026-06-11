# Iteration 047 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-046/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.stoppedProcess_indicator_eventuallyEq_left_of_lt`, `MeasureTheory.leftLim_stoppedProcess_indicator_eq_of_lt`, `MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_bound`, and `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2548` and the actual `sorry` at line `2584`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `2806`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemma is project-bespoke bounded/localized bookkeeping, so no external citation block was added.
- API checks this iteration: hover verification confirmed `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound` and `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`; local search verified `Filter.EventuallyEq.symm`, `Filter.EventuallyEq.trans`, and `Eq.trans`. Diagnostics on the newly closed event-transfer block returned no warnings.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed event-transfer package is sound because it only compares stopped and original paths on the explicit event `(t : WithTop κ) < τ ω`, where stopping has not yet occurred in a left-neighborhood of `t`. It does not create left-approaching sequences, deterministic bounds, variation bounds, continuity, or mesh hypotheses.

The next target is intentionally only a packaging lemma. It combines two already closed facts under the union of their explicit hypotheses: localized continuous finite-variation terminal zero gives `N t = 0` a.e., and localizing-sequence jump removal gives `N t = N_{t-}` a.e.; their intersection gives `N_{t-}=0` a.e. This statement is not vulnerable to the false shortcut "càdlàg plus finite variation implies continuous", because continuity on `[⊥, t]`, deterministic bounds, deterministic variation bounds, partitions, mesh, and the left-approaching sequence are all assumptions.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`

I chose this over retrying `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` because the full reduction still lacks construction of deterministic left-approaching sequences, bounded/variation localizations, continuity inputs, and mesh hypotheses. The new wrapper records exactly what the closed jump-removal and square-integral endpoints already prove once those inputs are supplied.

The cheapest signal that would make me reverse this choice is a prover result showing that the conjunction statement is ergonomically awkward in Lean despite the two component theorems compiling. In that case the fallback is to prove only the second component as `MeasureTheory.Martingale.leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`; the terminal zero component is already available from the existing localized continuous wrapper.

## Blueprint Update

Updated `blueprint/src/chapters/doob_meyer.tex` with a new project-bespoke lemma block:

- `lem:Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`

The block explains that terminal zero comes from `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`, while left-limit zero comes from `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound` plus eventual-equality symmetry/transitivity. I also added this lemma to the `\uses{...}` list for the main predictable finite-variation reduction block. No `\leanok` marker was edited.

## State Updates

- Updated `task_done.md` with the four iter-046 event-transfer lemmas.
- Updated `task_pending.md` so the active Doob-Meyer entry points at the bounded/localized terminal-and-left-limit zero package rather than the now-closed event-transfer split.
- Updated `STRATEGY.md` because the route status changed from stopped/original event transfer to bounded/localized packaging, and the remaining LOC estimate needed to reflect the still-explicit sequence/localization/continuity/mesh obligations.
- Rewrote `PROGRESS.md` with one prover objective for `DoobMeyer.lean`.

## Next Objective Summary

The prover should add the combined terminal/left-limit zero wrapper immediately after `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn` and before `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`. It should not attempt the full predictable finite-variation reduction or the public weak local Doob-Meyer theorem this iteration.
