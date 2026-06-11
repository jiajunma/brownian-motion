# Recommendations for Iteration 054

## Prioritize

- Continue from `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch`.
- Pick one missing construction wrapper toward `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, not the full reduction.
- Good next split: package stopped-piece bounds and stopped-piece variation bounds from a localizing sequence under explicit deterministic level assumptions.
- Alternative next split: package deterministic partition/mesh existence only under hypotheses strong enough to justify it. Do not state mesh existence for arbitrary ordered Polish time without a separate proof.

## Do Not Retry

- Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic target. It still needs branch assembly, stopped-piece bounds, variation bounds, deterministic partition/mesh management, and final bridge application.
- Do not use the new left-branch connector unless the branch disjunction is an explicit hypothesis. It does not infer `(nhdsWithin t (Set.Iio t)).NeBot`, bottom-immediacy, or predecessor existence.
- Do not use the bottom-immediate or predecessor branches as a discrete-time induction without separately proving the required previous-zero statements.

## Reusable Pattern

For explicit branch routing, use:

```lean
rcases hbranch with hleft | hbranch
· exact (hN.eq_zero_and_leftLim_eq_zero_of_..._of_neBot_left ... hleft ...).1
· rcases hbranch with hbot_prev | hprev
  · exact hN.eq_zero_of_predictable_bottom_immediate hN_pred hN_zero ht hbot_prev
  · rcases hprev with ⟨s, hst, hgreatest, hs_zero⟩
    exact hN.eq_zero_of_predictable_left_isolated_of_previous hN_pred ht hst hgreatest hs_zero
```

## Tooling Note

The attempt preprocessor again emitted `no_prover_lane: true` even though the raw prover lane completed. For iter-054 review, check `meta.json`, `prover.jsonl`, and task results before treating a no-lane summary as authoritative.
