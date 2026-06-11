# Session 50 Recommendations

## Prioritize

- Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with a narrow input lemma for the current stopped-bound/original-continuity endpoint.
- The closest useful targets are stopped-piece horizon-bound or variation-bound localization lemmas with all hypotheses stated explicitly, or a separate left-isolated-time branch with a genuine past/discrete uniqueness argument.

## Do Not Retry Monolithically

- Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one proof. It still needs left-isolated-time handling or assumptions, stopped-piece bounds, stopped-piece variation bounds, deterministic partition/mesh construction, and the final square-integral bridge assembly.
- Do not assume `nhdsWithin t (Set.Iio t)` is always nontrivial. The current wrappers are sound only under the explicit `NeBot` hypothesis.
- Do not infer stopped-piece bounds or variation bounds from the wrapper closed in this iteration. It only transfers stopped-piece continuity from original continuity.

## Reusable Patterns

- Nontrivial-left wrappers: use `Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot hleft` to obtain `v`, `hv_lt`, and `hv_tendsto`, then call the explicit-sequence theorem unchanged.
- Original-continuity to stopped-continuity: pass `(fun n ω => MeasureTheory.stoppedProcess_indicator_continuousOn_Icc (N := N) (τ := τ n) (ω := ω) (t := t) (hN_cont ω))`.

## Structural Notes

- Blueprint doctor for iter-050 reported no structural issues.
- `sync_leanok` is current for iter-050 and made no marker changes. Review did not add or remove any `\leanok`.
