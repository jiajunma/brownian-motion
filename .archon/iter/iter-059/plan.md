# Iteration 059 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-058/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound` and `MeasureTheory.ae_stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `3259` and the actual `sorry` at line `3295`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3517`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The new objective is Archon-original stopped-process variation bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures and proof shape of `MeasureTheory.stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`, `MeasureTheory.ae_stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`, `BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_Icc`, `BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc`, `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc`, Mathlib's `stoppedProcess`, `stoppedProcess_eq_of_le`, `stoppedProcess_eq_of_ge`, `eVariationOn`, `eVariationOn.sum_le`, and the available `WithTop.untopA_*` helpers.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, `blueprint/src/chapters/doob_meyer.tex`, and this iter sidecar.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-silent fallback executed

Iter 058 said that if the stopped-horizon-bound wrapper closes, continue with one honest bounded-level localization input rather than the full predictable finite-variation reduction. It named a variation-bound analogue under explicit pre-stop variation and stop/no-overshoot hypotheses as the best next target.

I chose that variation-bound analogue. The new objective proves that the stopped/indicator path has controlled variation on `[⊥, t]` from an explicit variation bound on the closed pre-stop horizon set
`{r | r ∈ Set.Icc ⊥ t ∧ (r : WithTop κ) ≤ τ ω}`. This set includes the finite stopped value, so the statement does not smuggle in a no-overshoot theorem from strict pre-stop information.

I did not choose a concrete norm-level stopping-time instantiation this round because the required stop-value/no-overshoot bound is still not available. Proving the closed-pre-stop variation transfer first gives a reusable target for later concrete stopping constructions.

## Soundness Check

The new objective assumes all variation-producing data explicitly:

- a pathwise closed pre-stop horizon variation bound on `{r | r ∈ Set.Icc ⊥ t ∧ (r : WithTop κ) ≤ τ ω}`;
- a pathwise real bound for that extended variation;
- for the combined a.e. wrapper, the already explicit pre-stop horizon bound and finite stop-value bound from the closed iter-058 lemmas.

The conclusion constructs only stopped/indicator horizon and variation bounds on `[⊥, t]`. It does not construct stopping times, no-overshoot for hitting times, deterministic levels from local bounded variation, continuity, partitions, mesh, localizing covers, or branch data.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_closed_pre_stop_Icc`;
- `BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc_of_closed_pre_stop_bound`;
- `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound`.

The corresponding blueprint blocks were added in `blueprint/src/chapters/doob_meyer.tex`.

## Fallback if no user response

No user response is needed. If the closed-pre-stop variation wrapper closes, continue toward bounded-level localization by choosing exactly one of these honest input-construction steps:

- specialize the new horizon-plus-variation wrapper to a concrete stopping construction only after the stop-value and closed-pre-stop variation/no-overshoot inputs have been proved or stated explicitly; or
- package the closed-pre-stop bound and variation hypotheses into a localizing-sequence wrapper that forwards them to the existing stopped-bound left-branch endpoints while keeping continuity, partitions, mesh, and branch data explicit.

Do not assign the full predictable finite-variation reduction monolithically, and do not infer deterministic variation levels, no-overshoot, mesh existence, or global deterministic bounds from cadlag paths and local bounded variation alone.
