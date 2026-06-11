# Iteration 050 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-049/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot` and `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2813` and the actual `sorry` at line `2849`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3071`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke localization bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of the original-bound explicit-sequence wrapper, the stopped-bound `_of_neBot_left` wrapper, and `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc`. The left-isolated branch was considered but not assigned because triviality of `nhdsWithin t (Set.Iio t)` only identifies `Function.leftLim f t` with `f t`; it does not provide the past-induction/discrete uniqueness argument needed for `N t = 0`.
- I briefly inspected the `QuadraticVariation.lean` gap. Its current global statement remains overgeneral for the known proof route because the square-integrability localization needs finite-measure/usual hypotheses. No protected signatures are listed, but no structural subagent is enabled, so this stays deferred rather than sending the prover into a likely false/under-hypothesized statement.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- Updated `STRATEGY.md` only to remove the stale "active left-approach construction" wording and replace it with the current stopped-piece packaging milestone.

## Soundness Check

The newly closed sequence helper is sound because it assumes the nontrivial left-neighborhood filter explicitly. It does not assert that every `⊥ < t` has a strict left-approaching sequence.

The next targets are intentionally bookkeeping wrappers. The original-bound wrapper only constructs the strict-left sequence and calls the existing explicit-sequence original-bound terminal/left-limit theorem. The stopped-bound/original-continuity wrapper only derives stopped-piece continuity from original-path continuity with `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc`, then calls the stopped-bound `_of_neBot_left` theorem. Neither target derives stopped-piece bounds, variation bounds, partitions, mesh, localizing levels, or a left-isolated branch.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_neBot_left`
- `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_neBot_left`

I chose these over the full predictable finite-variation reduction because the full reduction still lacks left-isolated-time handling, stopped-piece bounds, stopped variation bounds, deterministic partition/mesh construction, and a route from cadlag/no-jump information to the full continuity hypotheses used by the current square-integral endpoint.

I chose these over `QuadraticVariation.lean` because the open square-norm theorem appears to need a signature/context repair before proof work is meaningful. Without a structural subagent enabled, assigning that theorem as-is would likely repeat the known blocker.

## Blueprint Updates

Added two Archon-original blocks to `blueprint/src/chapters/doob_meyer.tex`:

- `lem:Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_neBot_left`
- `lem:Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_neBot_left`

No `\leanok`, `\mathlibok`, or semantic marker edits were made.

## Fallback if no user response

No user response is needed. If no hint appears next iteration and these wrappers close, continue by choosing one genuinely missing input for the same endpoint: either a left-isolated-time branch with an explicit past/discrete argument, or a stopped-piece bound/variation localization lemma with all additional hypotheses stated honestly.
