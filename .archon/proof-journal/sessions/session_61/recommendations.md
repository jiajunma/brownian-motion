# Recommendations For Iteration 062

## Prioritize

The dense-left pre-stop wrapper is now closed:

```lean
MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_dense_left
```

Do not spend the next iteration on another branch-packaging specialization. The closest useful next target is a concrete stopping-input lemma under explicit bounded-level hypotheses, preferably one of:

- a finite stop-value/no-overshoot bound for the chosen bounded localization;
- a closed-pre-stop variation bound on `{r | r ∈ Set.Icc ⊥ t ∧ (r : WithTop κ) ≤ τ n ω}`.

## Do Not Retry

Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic proof. It still needs concrete construction of the localization inputs, plus continuity, partition/mesh, jump-removal, and bounded-continuous finite-variation composition.

Do not use the new dense-left wrapper as a no-overshoot or deterministic-localization theorem. It assumes pre-stop bounds, finite stop-value bounds, closed-pre-stop variation bounds, original continuity, deterministic partitions, mesh, and the localizing sequence explicitly; it only supplies the dense-left branch.

## Reusable Pattern

For dense-left specializations, build the branch input with:

```lean
have hleft : (nhdsWithin t (Set.Iio t)).NeBot :=
  Filter.nhdsWithin_Iio_self_neBot_of_bot_lt ht
```

Then call the corresponding left-branch endpoint with `(Or.inl hleft)` and forward all analytic hypotheses unchanged.

## Blueprint And Tooling

Blueprint doctor has no findings for iter-061. `sync_leanok` is current for iter-061 and made zero changes; do not manually edit `\leanok`.
