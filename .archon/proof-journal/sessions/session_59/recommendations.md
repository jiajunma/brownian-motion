# Recommendations For Iteration 060

## Prioritize

Package the new closed-pre-stop bound/variation wrapper into one existing stopped/localizing endpoint, if all remaining inputs are explicit. A good next target is a localizing-sequence wrapper that uses `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound` to supply stopped-piece bound and variation hypotheses while still requiring continuity, deterministic partitions, mesh, and branch data as hypotheses.

Alternatively, specialize to a concrete stopping construction only after separately proving or explicitly assuming both required no-overshoot inputs:

- the finite stop-value bound used by `MeasureTheory.ae_stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`;
- the closed-pre-stop variation bound on `{r | r ∈ Set.Icc (⊥ : κ) t ∧ (r : WithTop κ) ≤ τ ω}`.

## Do Not Retry

Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic proof. The same warning has persisted across many iterations: bounds, variation bounds, continuity transfer, partitions, mesh, branch data, jump removal, and localization inputs still need to be constructed or threaded separately.

Do not use the iter-059 lemmas as no-overshoot theorems. They transfer a bound from a closed pre-stop variation hypothesis that already includes the stopped value; they do not prove such a hypothesis for hitting times.

Do not infer deterministic variation levels or deterministic stopped bounds from cadlag paths plus local bounded variation alone.

## Reusable Pattern

For stopped/indicator variation comparisons, unfold `eVariationOn`, use `iSup_le`, map each finite monotone partition through `s ↦ (min (↑s : WithTop κ) (τ ω)).untopA`, then apply `eVariationOn.sum_le`. The active branch uses `Set.indicator_of_mem`; the inactive branch is a zero sum via `Set.indicator_of_notMem`.

For the real variation bound after an ENNReal inequality, use:

```lean
ne_top_of_le_ne_top hvar hle
le_trans (ENNReal.toReal_mono hvar hle) hV
```

## Blueprint And Tooling

Blueprint doctor has no findings for iter-059. `sync_leanok` is current and made zero changes; do not manually edit `\leanok`.
