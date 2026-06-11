# Recommendations

## Prioritize

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The next target should be a narrow stopped/localizing wrapper that instantiates `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc` for each `τ n`, then feeds the resulting stopped-process bound and variation hypotheses into `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

Keep these as explicit assumptions in that wrapper: continuity of the stopped pieces on `[⊥, t]`, deterministic partitions, strict partition endpoints, and the entourage mesh hypothesis.

## Do Not Retry Monolithically

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a single proof. The same structural blockers remain: predictable-jump removal, bounded/variation localization, continuity transfer, deterministic mesh management, and the final application of the bounded-continuous bridge.

Do not claim that stopped càdlàg paths are continuous. This iteration only transferred boundedness and bounded variation.

## Reusable Patterns

- Stopped/indicator bound transfer:

```lean
by_cases hω : (⊥ : κ) < τ ω
· let g : κ := (min (↑s : WithTop κ) (τ ω)).untopA
  -- prove `g ∈ Set.Icc ⊥ t`
  rw [Set.indicator_of_mem hmem]
  exact hbound g hg_mem
· rw [Set.indicator_of_notMem hnotmem]
  simpa using hC_nonneg
```

- Stopped/indicator variation comparison: unfold `eVariationOn`, use `iSup_le`, map each partition by `s ↦ (min (s : WithTop κ) (τ ω)).untopA`, apply `eVariationOn.sum_le`, and use `Finset.sum_eq_zero` in the inactive-indicator branch.

- Real variation-bound transfer:

```lean
have hle := BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_Icc
  (N := N) (τ := τ) ω t
have hstop_var := ne_top_of_le_ne_top hvar hle
exact le_trans (ENNReal.toReal_mono hvar hle) hV
```

- A.e. packaging: pair the deterministic bound and variation transfers with two `filter_upwards` blocks.

## Tooling Notes

The attempt preprocessor again emitted only `no_prover_lane: true` even though the prover ran and passed verification. Continue checking `meta.json`, `prover.jsonl`, and task results when this mismatch appears.

`sync_leanok` is current for iter-035 and made zero changes. Newly closed Doob-Meyer helper blocks still lack `\leanok`; review agents should not patch those markers manually.
