# Iteration 060 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-059/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_closed_pre_stop_Icc`, `BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc_of_closed_pre_stop_bound`, and `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `3397` and the actual `sorry` at line `3433`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3655`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The new objective is Archon-original stopped/localizing bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound`, `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch`, the older original-bound wrapper, the dense-left endpoints, and the active reduction. `lean_diagnostic_messages` on the new stopped/indicator wrapper block reported no warnings. `lean_local_search` did not return the source-read project declarations, so the objective tags those names as source-read rather than LSP-verified.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, `blueprint/src/chapters/doob_meyer.tex`, and this iter sidecar.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-silent fallback executed

Iter 059 said that if the closed-pre-stop variation wrapper closes, continue toward bounded-level localization by choosing exactly one honest input-construction step. It named either a concrete stopping construction after stop-value/no-overshoot inputs are available, or a localizing-sequence wrapper that packages the closed-pre-stop bound and variation hypotheses into an existing stopped/localizing endpoint while keeping continuity, partitions, mesh, and branch data explicit.

I chose the localizing-sequence packaging step. The stop-value and closed-pre-stop variation/no-overshoot inputs for concrete hitting constructions are still not proved. The packaging wrapper is therefore the honest next composition: for each localizing index it uses the closed `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound` to supply the stopped-piece bound and variation hypotheses, then delegates to the existing localizing left-branch endpoint.

## Soundness Check

The new objective assumes every analytic and order input explicitly:

- pre-stop horizon bounds for each localizing index;
- finite stop-value bounds when the active stopped value lies before the horizon;
- closed-pre-stop variation bounds on `{r | r ∈ Set.Icc ⊥ t ∧ (r : WithTop κ) ≤ τ n ω}`;
- original-path continuity, deterministic partitions, mesh, and the left-branch disjunction.

The conclusion only packages those inputs to prove `N t =ᵐ[P'] 0`. It does not construct no-overshoot, deterministic bounds or variation levels, localizing stopping times, continuity, partitions, mesh, or branch data.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_left_branch`.

The corresponding blueprint block was added in `blueprint/src/chapters/doob_meyer.tex`.

## Fallback if no user response

No user response is needed. If the pre-stop localizing left-branch wrapper closes, continue with one of these bounded-level inputs rather than the full predictable finite-variation reduction:

- if the next need is branch packaging for dense time, add the dense-left specialization of the pre-stop localizing wrapper under `[DenselyOrdered κ]` and `⊥ < t`; or
- if the branch is no longer the bottleneck, prove a concrete stop-value and closed-pre-stop variation/no-overshoot input under explicit stopping-level assumptions.

Do not assign the full `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` monolithically, and do not infer deterministic variation levels, no-overshoot, mesh existence, or global deterministic bounds from cadlag paths and local bounded variation alone.
