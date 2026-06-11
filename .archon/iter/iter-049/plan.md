# Iteration 049 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-048/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_stopped_bound`, `MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_stopped_bound`, `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_stopped_bound`, and `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2757` and the actual `sorry` at line `2793`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3015`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke filter/localization bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of the stopped-bound terminal/left-limit wrapper and the active reduction. Lean LSP diagnostics on the stopped-bound/reduction region returned only the known reduction `sorry` warning. LSP/source checks verified `isCountablyGenerated_nhdsWithin`, `SecondCountableTopology.to_firstCountableTopology`, `self_mem_nhdsWithin`, `Filter.Eventually.frequently`, `Filter.exists_seq_forall_of_frequently`, and `Filter.tendsto_add_atTop_iff_nat`; local name search remains stale for the newest project declarations, so source and build reports are the reliable context for them.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The stopped-bound package is sound because it applies jump removal to stopped/indicator processes under direct stopped-process bounds, then transfers the identity to the original process only on the explicit event `{ω | (t : WithTop κ) < τ n ω}` and finally uses the localizing-sequence cover. It does not construct left-approaching sequences, stopped-piece bounds, variation bounds, continuity, partitions, or mesh.

The next target should construct only the deterministic left-approach input, and only under an explicit nontrivial-left-filter hypothesis. This avoids the false inference that every ordered Polish time with `⊥ < t` has a strict left-approaching sequence. Left-isolated or discrete cases still require a separate branch; the sequence helper must not hide that issue.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot`
- `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left`

I chose this over retrying `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` because the full reduction still lacks left-isolated-time handling, actual stopped-piece bounds, stopped variation bounds, stopped continuity inputs, deterministic partitions, and mesh management. The new split removes exactly one explicit hypothesis from the stopped-bound endpoint: the sequence itself, replacing it with the honest condition that the left-neighborhood filter is nontrivial.

## Blueprint Updates

- Added `lem:Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot` to `blueprint/src/chapters/doob_meyer.tex`.
- Added `lem:Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left` to `blueprint/src/chapters/doob_meyer.tex`.
- Added both labels to the `\uses{...}` list for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- Did not add or remove `\leanok`; marker synchronization owns that.

## State Updates

- Updated `task_done.md` with the closed stopped-bound jump-removal and terminal/left-limit zero package.
- Updated `task_pending.md` to make the nontrivial-left-filter sequence construction the next Doob-Meyer split.
- Updated `STRATEGY.md` only to reflect the active phase status change from stopped-bound localization packaging to left-approach construction.
- Replaced `PROGRESS.md` current objectives with the single Doob-Meyer prover lane.
