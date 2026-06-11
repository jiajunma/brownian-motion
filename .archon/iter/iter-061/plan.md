# Iteration 061 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-060/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on. I also read `.archon/logs/iter-060/blueprint-doctor.md`, which reports no orphan chapters, broken references, empty annotations, or project axioms.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_left_branch`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `3452` and the actual `sorry` at line `3488`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3710`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings. `.archon/logs/iter-060/meta.json` records final `lake` and blueprint checks passing and project sorry count `23`.
- There is no `proof-journal/` directory in this checkout, so there were no latest session `summary.md` or `recommendations.md` files to merge.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The new objective is Archon-original dense-left stopped/localizing bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures and proof shape of `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_left_branch`, `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt`, `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_dense_left`, and the active reduction. `lean_diagnostic_messages` on `DoobMeyer.lean:3190-3410` reported no errors. `lean_local_search` did not return the source-read project declarations, matching prior behavior, so the objective tags those names as source-read rather than LSP-verified.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, `blueprint/src/chapters/doob_meyer.tex`, and this iter sidecar.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-silent fallback executed

Iter 060 said that if the pre-stop localizing left-branch wrapper closes, continue with one bounded-level input rather than the full predictable finite-variation reduction. It offered either the dense-left specialization of the pre-stop localizing wrapper under `[DenselyOrdered κ]` and `⊥ < t`, or a concrete stop-value and closed-pre-stop variation/no-overshoot input under explicit stopping-level assumptions.

I chose the dense-left specialization. The branch disjunction is still an explicit input to the closed pre-stop localizing wrapper, and dense time is the Brownian route relevant to the downstream fixed-time theorem. The concrete hitting/no-overshoot inputs still require a separate level construction, so proving the dense-left branch packaging first is the smaller honest composition.

## Soundness Check

The new objective assumes every analytic and localization input explicitly:

- pre-stop horizon bounds for each localizing index;
- finite stop-value bounds when the active stopped value lies before the horizon;
- closed-pre-stop variation bounds on `{r | r ∈ Set.Icc ⊥ t ∧ (r : WithTop κ) ≤ τ n ω}`;
- original-path continuity, deterministic partitions, mesh, and a localizing sequence.

The only new construction is the branch input: `[DenselyOrdered κ]` and `⊥ < t` give `(nhdsWithin t (Set.Iio t)).NeBot` via the already closed `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt`. The objective must not infer no-overshoot, deterministic bounds or variation levels, localizing stopping times, continuity, partitions, or mesh.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_dense_left`.

The corresponding blueprint block was added in `blueprint/src/chapters/doob_meyer.tex`.

## Fallback if no user response

No user response is needed. If the dense-left pre-stop wrapper closes, do not add another branch-packaging helper. Continue by proving one concrete input-construction lemma under explicit stopping-level hypotheses, preferably a stop-value/no-overshoot bound or a closed-pre-stop variation bound for a bounded-level localization. Keep deterministic variation levels, mesh existence, continuity, stopping-time/localizing-sequence construction, and branch data explicit unless they have already been proved in separate lemmas.

Do not assign the full `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` monolithically, and do not infer deterministic variation levels, no-overshoot, mesh existence, or global deterministic bounds from cadlag paths and local bounded variation alone.
