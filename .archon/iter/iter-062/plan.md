# Iteration 062 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-061/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on. I also read `.archon/logs/iter-061/blueprint-doctor.md`, which reports no orphan chapters, broken references, empty annotations, or project axioms.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_dense_left`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `3489` and the actual `sorry` at line `3525`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3747`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover and review reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings. `.archon/logs/iter-061/meta.json` records final `lake` and blueprint checks passing and project sorry count `23`.
- Proof-journal session 61 recommends not adding another branch-packaging helper and instead proving one concrete stopping-input lemma, preferably a finite stop-value/no-overshoot bound or closed-pre-stop variation bound under explicit stopping-level hypotheses.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, the relevant `doob_meyer.tex` regions, and the local blueprint/source regions for `leastGT` in `debut.tex`, `local_martingales.tex`, `BrownianMotion/Choquet/Debut.lean`, and `ClassD.lean`. The new objective is Archon-original bounded-level stopping bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures around the pre-stop stopped/indicator wrappers and active reduction. LSP/local search verified `MeasureTheory.leastGT_lt_iff`, `MeasureTheory.notMem_of_lt_hittingAfter`, `MeasureTheory.hittingAfter_lt_iff`, `ContinuousOn.continuousWithinAt`, and `ContinuousWithinAt.mono`; `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt` is source-read from `DoobMeyer.lean`. `lean_diagnostic_messages` on `DoobMeyer.lean:520-840` reported no errors.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, `blueprint/src/chapters/doob_meyer.tex`, and this iter sidecar.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-silent fallback executed

Iter 061 said that if the dense-left pre-stop wrapper closes, do not add another branch-packaging helper. It asked for one concrete input-construction lemma under explicit stopping-level hypotheses, preferably a stop-value/no-overshoot bound or a closed-pre-stop variation bound for bounded-level localization.

I chose the norm-level `leastGT` input package. It is the smallest concrete bounded localization input now available: before the first strict crossing of the level \(C\), the hitting-time definition gives the pre-stop bound, and dense-time pathwise continuity rules out finite stop-value overshoot. Closed-pre-stop variation levels still require a separate variation-level construction, so they are left for the next step.

## Soundness Check

The new objective only constructs the two horizon-bound inputs used by `MeasureTheory.ae_stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound` for the specific stop
`leastGT (fun s ω => ‖N s ω‖) C`.

- The pre-stop bound comes directly from the definition of `leastGT` and does not use martingality.
- The stop-value bound assumes pathwise continuity on `[⊥, t]`, dense order, active stop, finite stop, and `τ ≤ t`; without those hypotheses no no-overshoot conclusion is claimed.
- The a.e. wrapper is only pointwise packaging by `Eventually.of_forall`.
- The objective does not prove that this `leastGT` is a stopping time or a localizing sequence, does not construct closed-pre-stop variation bounds, deterministic variation levels, partitions, mesh, or the predictable finite-variation reduction.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.leastGT_norm_pre_stop_bound_on_Icc`;
- `MeasureTheory.leastGT_norm_stop_value_bound_on_Icc_of_continuousOn`;
- `MeasureTheory.ae_leastGT_norm_pre_stop_stop_value_bound_on_Icc_of_continuousOn`.

The corresponding blueprint blocks were added in `blueprint/src/chapters/doob_meyer.tex`.

## Fallback if no user response

No user response is needed. If the `leastGT` norm-level input package closes, continue with the next concrete bounded-level input rather than the full predictable finite-variation reduction. The preferred next target is a closed-pre-stop variation bound for a variation-level localization, under explicit stopping-level hypotheses.

Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` monolithically, and do not infer deterministic variation levels, mesh existence, localizing sequences, or closed-pre-stop variation bounds from the norm-level package.
