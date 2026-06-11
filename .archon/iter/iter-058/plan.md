# Iteration 058 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-057/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed and cleared the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt`, `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_dense_left`, and `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_dense_left`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `3209` and the actual `sorry` at line `3245`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3467`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The new objective is Archon-original stopped-process bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of `MeasureTheory.stoppedProcess_indicator_bound_on_Icc`, `BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc`, `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc`, `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, the active reduction at `DoobMeyer.lean:3209`, `ProbabilityTheory.LocalizingSequenceOfProp`, `ProbabilityTheory.isLocalizingSequence_localizingSequenceOfProp`, and the norm-hitting localizing API in `ClassD.lean`.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, `blueprint/src/chapters/doob_meyer.tex`, and this iter sidecar.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-silent fallback executed

Iter 057 said that if the dense-left wrappers close, continue toward the active reduction by choosing one missing input-construction family rather than assigning the full reduction. It named deterministic bound/variation localization under explicit stopping-level or event-level assumptions, while warning not to infer deterministic levels, mesh existence, or predecessor-zero induction from current global hypotheses.

I chose the stopped-horizon-bound half of that fallback. The next objective proves that a stopped/indicator process is deterministically bounded on `[⊥, t]` provided two explicit inputs hold: a pre-stop bound before the cutoff and a stop-value bound on the active indicator branch when the cutoff is finite and before `t`. This is the bookkeeping lemma needed before instantiating norm- or level-stopping constructions, and it avoids the false shortcut that a hitting time automatically gives a deterministic stopped bound in the presence of jumps.

I did not assign variation-level localization in the same round. Variation stopping has its own no-overshoot problem and should be split separately, likely using an analogous explicit stop-variation input after this horizon-bound wrapper closes.

## Soundness Check

The new lemmas assume all bound-producing data explicitly:

- a deterministic nonnegative constant `C`;
- a pointwise or a.e. pre-stop bound for every `r ∈ Set.Icc ⊥ t` with `(r : WithTop κ) < τ ω`;
- a pointwise or a.e. stop-value bound when `(⊥ : κ) < τ ω`, `τ ω ≠ ⊤`, and `τ ω ≤ (t : WithTop κ)`.

They conclude only the stopped/indicator horizon bound on `[⊥, t]`. They do not construct stopping times, localizing sequences, deterministic variation bounds, continuity, partitions, mesh, dense-left branch data, or no-overshoot at a hitting time.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`;
- `MeasureTheory.ae_stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`.

The corresponding blueprint blocks were added in `blueprint/src/chapters/doob_meyer.tex`.

## Fallback if no user response

No user response is needed. If the stopped-horizon-bound wrapper closes, continue with the next honest bounded-level localization input rather than the full predictable finite-variation reduction. The best next targets are either:

- a variation-bound analogue under explicit pre-stop variation and stop/no-overshoot hypotheses; or
- an instantiation of the new horizon-bound wrapper for a concrete norm-level stopping time, but only under hypotheses strong enough to prove the stop-value bound.

Do not infer deterministic variation levels, stop-value no-overshoot, path continuity, mesh existence, or global deterministic bounds from cadlag paths and local bounded variation alone.
