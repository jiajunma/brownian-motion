# Recommendations for Iteration 050

## Prioritize

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but keep the split narrow. The newly closed wrapper is now the nontrivial-left-filter endpoint:

- construct or assume the remaining stopped-piece hypotheses, then apply `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left`;
- or prove a separate branch lemma for left-isolated times where `nhdsWithin t (Set.Iio t)` is trivial.

## Do Not Retry

Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a single proof. The blocker is structural, not a missing tactic: the reduction still lacks left-isolated-time handling, stopped-piece horizon bounds, stopped variation bounds, stopped continuity, deterministic partitions, and mesh.

Do not infer a strict left-approaching sequence from `⊥ < t` in an arbitrary ordered Polish time. The only closed sequence helper requires the explicit hypothesis `(nhdsWithin t (Set.Iio t)).NeBot`.

Do not infer stopped-piece boundedness, variation bounds, continuity, partitions, or mesh from strong predictability or local bounded variation. The stopped-bound wrappers deliberately keep those as hypotheses.

## Reusable Patterns

- Nontrivial left-neighborhood sequence extraction: install `haveI : NeBot (nhdsWithin t (Set.Iio t)) := hleft`, use `self_mem_nhdsWithin` to get eventual membership in `Set.Iio t`, convert to frequency with `.frequently`, then call `Filter.exists_seq_forall_of_frequently`.
- Nontrivial-left stopped-bound wrapper: extract `v, hv_lt, hv_tendsto` with `Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot hleft`, then delegate to the explicit-sequence theorem without modifying any stopped-piece hypotheses.

## Blueprint

Blueprint doctor found no structural issues. No manual marker updates are needed for iter-049. `sync_leanok` is current and added no markers, so continue not touching `\leanok` manually.

