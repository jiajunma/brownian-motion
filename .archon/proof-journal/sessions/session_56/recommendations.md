# Recommendations For Iteration 057

## Closest Targets

The new strict-past endpoint is the closest reusable connector:

- `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_strictPast_zero`

Use it only when these inputs are explicit:

- a single a.e. horizon bound on `Set.Icc (⊥ : κ) t`;
- a single a.e. variation bound on `Set.Icc (⊥ : κ) t`;
- original-path continuity on that interval;
- deterministic monotone partitions, endpoints, interval membership, and mesh;
- strict-past zero, `∀ s : κ, s < t → N s =ᵐ[P'] 0`.

## Recommended Next Objectives

Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one monolithic proof.

Useful next objectives are:

- A dense-order specialization where `[DenselyOrdered κ]` or an equivalent honest hypothesis supplies the nontrivial-left branch without needing predecessor data.
- A deterministic bound/variation localization wrapper from explicit stopping-level or event-level assumptions. The current local bounded variation and cadlag hypotheses alone are not enough to claim deterministic global levels.
- A separately stated strict-past-zero propagation principle, but only under additional assumptions strong enough to prove the needed predecessor/dense-left alternatives and previous-zero inputs.

## Blocked Or Risky Routes

- Do not treat `Filter.exists_greatest_lt_of_not_neBot_nhdsWithin_Iio` as a zero-propagation lemma. It only extracts a greatest strict predecessor from a trivial strict-left within-filter.
- Do not treat the strict-past endpoint as discrete induction. It assumes `∀ s < t, N s =ᵐ[P'] 0`; it does not prove it.
- Do not infer deterministic partitions, mesh, bounds, or variation levels from the current global hypotheses without an explicit construction or stronger topology/order assumptions.
- The generic `QuadraticVariation.lean` square-norm local-submartingale gap remains overgeneral for the known route and should not be retried without changing its context or adding the missing bounded/local square-integrability infrastructure.

## Blueprint And Tooling Notes

Blueprint doctor found no structural issues in iter-056.

The attempt preprocessor again reported `"no_prover_lane": true` even though `meta.json`, `prover.jsonl`, and the Doob-Meyer task result show a completed prover lane. Continue checking raw logs and task results when this mismatch appears.
