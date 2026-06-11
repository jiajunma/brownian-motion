# Recommendations for Iteration 053

## Prioritize

- Use `MeasureTheory.Martingale.eq_zero_of_predictable_bottom_immediate` as the bottom-immediate branch connector when the hypotheses include both `⊥ < t` and `∀ r, r < t → r ≤ ⊥`.
- Prefer another explicit branch-assembly helper before touching the full reduction. Two reasonable targets are:
  - a nontrivial-left fixed-time value-zero wrapper that calls the existing terminal/left-limit package under all explicit stopped-bound, variation-bound, continuity, partition, mesh, and `hleft` hypotheses;
  - a left-isolated successor wrapper that assumes an explicit predecessor and previous-time zero input, then delegates to `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous`.

## Do Not Retry Yet

- Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one monolithic target. The branch split, stopped-piece bounds, variation bounds, deterministic partitions, mesh inputs, and final square-integral bridge still need to be assembled as explicit helper statements.
- Do not infer a greatest predecessor or bottom-immediacy from `(nhdsWithin t (Set.Iio t)) = ⊥` without a separate honest order/topology lemma.
- Do not treat `MeasureTheory.Martingale.eq_zero_of_predictable_bottom_immediate` as a discrete-time induction principle; it proves only one immediate-above-bottom step.

## Reusable Pattern

Bottom-immediate predictable zero:

```lean
exact hN.eq_zero_of_predictable_left_isolated_of_previous hN_pred ht ht hbot_prev
  (Eventually.of_forall hN_zero)
```

This works because `ht : (⊥ : κ) < t` supplies the strict predecessor relation for `s = ⊥`, `hbot_prev` supplies the greatest-predecessor hypothesis, and `Eventually.of_forall hN_zero` supplies the previous a.e. zero statement.

## Tooling Notes

- Iter-052 repeated the known preprocessing false positive: `attempts_raw.jsonl` says `no_prover_lane: true`, but `meta.json`, `prover.jsonl`, and the task result prove the prover lane completed.
- `sync_leanok` is current for iter-052 and made zero changes. Review made no manual blueprint marker changes.
- The current Doob-Meyer open lines are `2937`/`2973` for the active reduction and `3190`/`3195` for public `doob_meyer`; refresh stale task-index line numbers when collecting the iter-052 task result.

## Blueprint Doctor

No structural findings were reported for iter-052.
