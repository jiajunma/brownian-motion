# Session 46 Recommendations

## Priority

Continue on `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with a bounded/localized wrapper that uses:

- `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound` for predictable-jump removal after localization.
- The existing stopped/indicator bound and variation-transfer lemmas for deterministic `C n` and `V n`.
- The existing bounded-continuous finite-variation square-integral endpoint only after deterministic partitions and mesh hypotheses are present.

The next target should still expose deterministic left-approaching sequence, horizon bounds, variation bounds, continuity, and mesh hypotheses explicitly. That will make it possible to connect the jump-removal package to the square-integral endpoint without pretending localization constructs those inputs automatically.

## Do Not Retry Yet

Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one proof. The current body still has the final `sorry` at line 2584 after only scaffolding left-limit existence and martingale increment orthogonality. It does not yet construct:

- deterministic left-approaching sequences,
- bounded and variation localizations,
- continuity transfer in the final form,
- deterministic refining partitions and mesh,
- square-integral zero premises for `MeasureTheory.ae_eq_zero_of_integral_sq_eq_zero`.

Do not use the localizing-sequence cover before applying the event-restricted theorem. Iter-046 closed the correct order: first prove jump removal on `{t < τ n}`, then use the a.e. existence of some `n` with `t < τ n`.

Do not infer deterministic horizon bounds or variation bounds from `LocallyBoundedVariationOn` alone. These remain separate localization obligations.

## Reusable Patterns

- Eventual stopped/original agreement: for `(t : WithTop κ) < τ ω`, use the open set `{s | (s : WithTop κ) < τ ω}` as a member of `nhdsWithin t (Set.Iio t)`, then rewrite with `stoppedProcess_eq_of_le` and `Set.indicator_of_mem`.
- Left-limit transfer: handle `nhdsWithin t (Set.Iio t) = ⊥` separately with `leftLim_eq_of_eq_bot`; otherwise transfer `tendsto_leftLim_of_tendsto ((hN_var ω).exists_tendsto_left_univ t)` across eventual equality and close with `leftLim_eq_of_tendsto`.
- Localizing jump removal: prove `∀ n, ∀ᵐ ω, t < τ n ω → ...`, combine with `ae_all_iff.2`, then derive the a.e. cover from `hτ.tendsto_top` using `tendsto_atTop_nhds` and `Set.Ioi (t : WithTop κ)`.

## Tooling Notes

The preprocessed attempt file again reported `no_prover_lane: true`, but `meta.json`, the raw prover log, and the Doob-Meyer task result show a completed prover lane. Continue recovering evidence from raw logs/task results until the attempt preprocessor is fixed.

`sync_leanok` was current for iter-046 and made zero marker changes. Review should continue not patching `\leanok` manually.
