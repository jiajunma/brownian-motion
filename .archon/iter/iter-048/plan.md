# Iteration 048 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-047/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2586` and the actual `sorry` at line `2622`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `2844`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke stopped-bound localization bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of `MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound`, `MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_bound`, `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound`, `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, and `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`. LSP diagnostics on the stopped/original jump-transfer region returned no errors; LSP local name search appears stale for the newest declarations, so the raw source and build reports are the reliable context.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed original-bound terminal/left-limit zero wrapper is sound, but its jump-removal side still assumes the original process itself is bounded on `[⊥, t]` for every localization index. That is too strong for the eventual localization step: bounded localization naturally gives bounds for each stopped/indicator process, not global deterministic bounds for the unstopped original process.

The next split should therefore remove only that over-strong original-bound assumption from jump removal. The proof is still honest because the bounded jump theorem is applied to the stopped process `Z`, with a direct a.e. stopped-process horizon bound. Only after the stopped jump identity is proved should it be transferred back to the original process on `{ω | (t : WithTop κ) < τ n ω}` using the already closed terminal and left-limit agreement lemmas. The localizing-sequence cover then globalizes the event statement.

This still leaves separate future obligations: constructing deterministic left-approaching sequences where valid, producing actual stopped-piece bounds and variation bounds, proving or assuming stopped-piece continuity, and managing deterministic partitions and mesh hypotheses. None of these should be inferred from strong predictability or locally bounded variation alone.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with the stopped-bound jump-removal and terminal/left-limit zero package:

- `MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_stopped_bound`
- `MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_stopped_bound`
- `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_stopped_bound`
- `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`

I chose this over retrying `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` because the full reduction still lacks sequence construction, actual stopped bounds, stopped variation bounds, continuity inputs, and deterministic mesh management. The new package aligns jump removal with the stopped-bound hypotheses already used by the continuous finite-variation zero wrapper.

## Blueprint Updates

- Added four project-bespoke lemma blocks to `blueprint/src/chapters/doob_meyer.tex` for the stopped-bound jump-removal package.
- Added those new labels to the `\uses{...}` list for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- Did not add or remove `\leanok`; marker synchronization owns that.

## State Updates

- Updated `task_done.md` with the closed original-bound terminal/left-limit zero wrapper.
- Updated `task_pending.md` to make the stopped-bound analogue the next Doob-Meyer split.
- Updated `STRATEGY.md` only to reflect the active phase status change from original-bound packaging to stopped-bound localization packaging.
- Replaced `PROGRESS.md` current objectives with the single Doob-Meyer prover lane.
