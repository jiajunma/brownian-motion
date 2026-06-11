# Recommendations For Iteration 058

## Closest Targets

The new dense-left connectors are the closest reusable endpoints:

- `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt`
- `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_dense_left`
- `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_dense_left`

Use them only when `[DenselyOrdered κ]`, `⊥ < t`, and the relevant analytic inputs are explicit. For the localizing-sequence endpoint this means indexed original horizon bounds, indexed variation bounds, original continuity, deterministic partitions, and mesh. For the fixed-level endpoint this means a single deterministic horizon bound, a single deterministic variation bound, original continuity, deterministic partitions, and mesh.

## Recommended Next Objectives

Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one monolithic proof.

The best next objective is deterministic bound/variation localization under explicit stopping-level or event-level assumptions. State the stopping/event hypotheses directly, prove that they provide the original-process or stopped-piece horizon and variation bounds needed by the closed endpoints, and keep deterministic partitions and mesh explicit.

Other possible objectives are narrow packaging lemmas that connect already-constructed bound/variation data to the dense-left endpoints. They should not attempt to infer deterministic levels from only cadlag paths and local bounded variation.

## Blocked Or Risky Routes

- Do not use `nhdsWithin_Iio_neBot` for the dense-left helper; it requires `[NoMinOrder κ]`, which is not honest in a time line with bottom. Use `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt` or Mathlib's `nhdsLT_neBot_of_exists_lt` route.
- Do not treat the dense-left wrappers as input-construction lemmas. They only pass `Or.inl hleft` to existing left-branch endpoints.
- Do not infer deterministic partitions, mesh, bounds, or variation levels from the current global hypotheses without an explicit construction or stronger assumptions.
- The generic `QuadraticVariation.lean` square-norm local-submartingale gap remains overgeneral for the known route and should not be retried without changing its context or adding the missing bounded/local square-integrability infrastructure.

## Blueprint And Tooling Notes

Blueprint doctor found no structural issues in iter-057.

The attempt preprocessor again reported `"no_prover_lane": true` even though `meta.json`, `prover.jsonl`, and the Doob-Meyer task result show a completed prover lane. Continue checking raw logs and task results when this mismatch appears.
