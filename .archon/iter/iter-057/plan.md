# Iteration 057 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-056/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `Filter.exists_greatest_lt_of_not_neBot_nhdsWithin_Iio` and `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_strictPast_zero`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `3134` and the actual `sorry` at line `3170`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3392`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` region. The new objective is Archon-original dense-order branch packaging, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of the closed localizing-sequence original-bound left-branch wrapper at `DoobMeyer.lean:2955`, the closed fixed-level left-branch endpoint at `DoobMeyer.lean:3007`, the active reduction at `DoobMeyer.lean:3134`, and Mathlib's `nhdsWithin_Iio_neBot'` and `nhdsLT_neBot_of_exists_lt` in `Mathlib/Topology/Order/DenselyOrdered.lean`. `lean_local_search` verified `nhdsWithin_Iio_neBot`, `nhdsWithin_Iio_neBot'`, and `nhdsLT_neBot_of_exists_lt`.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, `blueprint/src/chapters/doob_meyer.tex`, and this iter sidecar.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-silent fallback executed

Iter 056 said that if the strict-past-zero branch connector closes, continue toward the active reduction by choosing the next missing input family rather than assigning the full reduction. It named two good candidates: a dense-order specialization using Mathlib's strict-left neighborhood facts, or deterministic bound/variation localization from explicit stopping-level assumptions.

I chose the dense-order branch packaging. It is the smaller honest input-family step: for time indices such as `ℝ≥0`, the strict-left within-filter at every `t > ⊥` is nontrivial, so the existing left-branch endpoint can be used without predecessor data or a strict-past-zero induction hypothesis. This creates a real connector for the intended dense-time route while keeping bounds, variation bounds, partitions, mesh, and localization levels explicit.

I did not choose deterministic bound/variation localization this iteration because the current available global hypotheses are still only cadlag paths and local bounded variation. Turning those into deterministic levels requires an explicit stopping/event-level construction. Without those extra hypotheses, a localization wrapper would risk smuggling in the false global-boundedness shortcut that earlier reviews warned against.

## Soundness Check

The new dense-order objectives assume `[DenselyOrdered κ]` and `⊥ < t` in addition to the already explicit analytic inputs. The filter helper proves only:

`(nhdsWithin t (Set.Iio t)).NeBot`.

The martingale wrappers then pass `Or.inl hleft` to the already closed left-branch endpoints. They do not construct deterministic horizon bounds, deterministic variation bounds, partitions, mesh, strict-past zero, predecessor-zero propagation, or localizing stopping times.

The Mathlib lemma `nhdsWithin_Iio_neBot` itself was not chosen because it requires `[NoMinOrder κ]`, which is not honest for a time line with a bottom element. The objective instead uses `nhdsWithin_Iio_neBot'` or `nhdsLT_neBot_of_exists_lt`, both verified this iteration, with the explicit witness `⊥ < t`.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt`;
- `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_dense_left`;
- `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_dense_left`.

The corresponding blueprint blocks were added in `blueprint/src/chapters/doob_meyer.tex`.

## Fallback if no user response

No user response is needed. If the dense-left wrappers close, continue toward the active reduction by choosing one missing input-construction family rather than assigning the full reduction. The next best candidate is deterministic bound/variation localization under explicit stopping-level or event-level assumptions: state the stopping/event hypotheses directly, prove they provide the original-process or stopped-piece horizon and variation bounds needed by the closed endpoints, and keep deterministic partitions and mesh explicit.

Do not infer deterministic levels, mesh existence, or a predecessor-zero induction principle from the current general hypotheses.
