# Recommendations for Iteration 055

## Prioritize

- Continue from `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_left_branch`.
- Pick one missing input-construction step toward `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, not the full reduction.
- Good next split: package deterministic original horizon bounds and original variation bounds from explicit localization/level assumptions, then feed them to the new wrapper.
- Alternative next split: prove deterministic partition/mesh existence only under hypotheses strong enough to justify it. Do not state mesh existence for arbitrary ordered Polish time without a separate proof.

## Do Not Retry

- Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic target. It still needs branch assembly, deterministic bounds and variation levels, deterministic partition/mesh management, and final bridge application.
- Do not use the new original-bound branch wrapper unless the original horizon bounds, original variation bounds, original continuity, partition data, mesh hypothesis, and explicit branch disjunction are already available.
- Do not infer the branch disjunction, bottom-immediacy, predecessor existence, or predecessor-zero induction from topology or cadlag/local-variation assumptions without separate proved lemmas.

## Reusable Pattern

For original-bound localizing branch wrappers, use:

```lean
have hstopped_bounds : ∀ n, stopped_bound n ∧ stopped_variation_bound n := by
  intro n
  exact MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc
    (N := N) (τ := τ n) (t := t) (C := C n) (V := V n)
    (hC_nonneg n) (hbound_horizon n) (hvar_bound n)
exact hN.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch
  ... (fun n => (hstopped_bounds n).1) (fun n => (hstopped_bounds n).2) ...
```

## Tooling Note

The attempt preprocessor again emitted `no_prover_lane: true` even though the raw prover lane completed. For iter-055 review, check `meta.json`, `prover.jsonl`, and task results before treating a no-lane summary as authoritative.
