# Recommendations For Iteration 061

## Prioritize

If branch packaging is still the next bottleneck, add the dense-left specialization of:

```lean
MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_pre_stop_bound_variation_bound_original_continuousOn_of_left_branch
```

under `[DenselyOrdered κ]` and `ht : (⊥ : κ) < t`, using `Filter.nhdsWithin_Iio_self_neBot_of_bot_lt ht` to supply `Or.inl hleft`.

If branch data is no longer the bottleneck, prove one concrete stopping input instead: a finite stop-value bound and/or closed-pre-stop variation/no-overshoot hypothesis under explicit stopping-level assumptions.

## Do Not Retry

Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic proof. The active route still needs bounded-level input construction, branch handling, continuity/partition/mesh management, jump removal, and localization to be composed in smaller lemmas.

Do not use the new pre-stop localizing wrapper as a no-overshoot or deterministic-localization theorem. It assumes the pre-stop bound, stop-value bound, closed-pre-stop variation bound, original continuity, deterministic partitions, mesh, localizing sequence, and branch disjunction explicitly.

## Reusable Pattern

For localizing-sequence wrappers, define:

```lean
have hstopped_bounds : ∀ n, stopped_bound n ∧ stopped_variation n := by
  intro n
  exact MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound
    (τ := τ n) (C := C n) (V := V n) ...
```

Then pass `(fun n => (hstopped_bounds n).1)` and `(fun n => (hstopped_bounds n).2)` to the existing stopped/localizing endpoint. This is bookkeeping only; keep all analytic inputs explicit.

## Blueprint And Tooling

Blueprint doctor has no findings for iter-060. `sync_leanok` is current for iter-060 and made zero changes; do not manually edit `\leanok`.
