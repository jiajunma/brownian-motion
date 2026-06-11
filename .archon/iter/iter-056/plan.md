# Iteration 056 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-055/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed and cleared the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_left_branch`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `3075` and the actual `sorry` at line `3111`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3333`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` region. The new objective is Archon-original order/topology and branch-data bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of the closed fixed-level endpoint at `DoobMeyer.lean:3007`, the active reduction at `DoobMeyer.lean:3075`, the left-isolated and bottom-immediate helpers at `DoobMeyer.lean:805` and `DoobMeyer.lean:826`, Mathlib's `exists_Ioc_subset_of_mem_nhds`, `Filter.not_neBot`, `Filter.empty_mem_iff_bot`, and `mem_nhdsWithin_iff_exists_mem_nhds_inter`.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, `blueprint/src/chapters/doob_meyer.tex`, and this iter sidecar.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-silent fallback executed

Iter 055 said that if the bounded-level endpoint closes, continue toward the active reduction by choosing one missing input-construction step rather than assigning the full reduction: either construct an explicit branch disjunction under honest additional hypotheses, or package deterministic bound/variation localization from stated stopping-time or level assumptions.

I chose the branch-data connector. It first proves the honest order-topology fact that a trivial left-neighborhood filter at a non-bottom time yields a greatest strict predecessor. It then uses the fixed-level endpoint under an explicit strict-past-zero hypothesis `∀ s < t, N s =ᵐ[P'] 0`; in the nontrivial-left case the existing branch endpoint applies directly, and in the trivial-left case the new predecessor supplies the predecessor branch.

I did not choose deterministic bound/variation localization this iteration because the current available hypotheses are still only pathwise local bounded variation and cadlag paths. Turning those into deterministic levels requires a separate stopping/event construction; stating that construction without explicit stopping or level assumptions would risk exactly the false global-boundedness shortcut the recent reviews warned against.

## Soundness Check

The new martingale wrapper assumes all analytic bounded-level inputs explicitly:

- a single a.e. horizon bound on `Set.Icc (⊥ : κ) t`;
- a single a.e. variation bound on `Set.Icc (⊥ : κ) t`;
- original-path continuity on that interval;
- deterministic monotone partitions with endpoints and interval membership;
- the deterministic mesh hypothesis;
- the strict-past zero hypothesis `∀ s : κ, s < t → N s =ᵐ[P'] 0`.

The order helper proves only:

`¬ (nhdsWithin t (Set.Iio t)).NeBot → ∃ s, s < t ∧ ∀ r, r < t → r ≤ s`.

This does not supply `N s = 0`; the wrapper gets that only from the explicit strict-past-zero hypothesis. It does not infer deterministic bounds, deterministic variation levels, mesh, or a predecessor-zero induction principle from topology, local bounded variation, or cadlag paths.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `Filter.exists_greatest_lt_of_not_neBot_nhdsWithin_Iio`;
- `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_strictPast_zero`.

The corresponding blueprint blocks were added in `blueprint/src/chapters/doob_meyer.tex`.

## Fallback if no user response

No user response is needed. If the strict-past-zero branch connector closes, continue toward the active reduction by choosing the next missing input family rather than assigning the full reduction. Good candidates are:

- a dense-order specialization using Mathlib's `nhdsWithin_Iio_neBot` when `[DenselyOrdered κ]` is an honest hypothesis; or
- deterministic bound/variation localization from explicit stopping-level assumptions.

Do not infer mesh existence, deterministic levels, or predecessor-zero induction from the current general hypotheses.
