# Session 51 Recommendations

## Prioritize

- Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with a narrow connective lemma that uses `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous`.
- The cheapest useful next target is either propagation from `⊥` to an explicitly bottom-immediate time, or a separate order/topology helper under hypotheses strong enough to produce an explicit greatest strict predecessor.

## Do Not Retry Monolithically

- Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one proof. It still needs nontrivial-left and left-isolated branch assembly, stopped-piece bounds, stopped-piece variation bounds, deterministic partition/mesh construction, and the square-integral bridge.
- Do not infer a greatest strict predecessor from `nhdsWithin t (Set.Iio t) = ⊥` without a proved order-topology lemma. The new predecessor helper assumes the predecessor explicitly.
- Do not treat `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous` as an induction over a discrete interval. It needs the previous-time zero input `N s = 0` a.s. separately.

## Reusable Patterns

- Left-isolated past measurability: get `hpast := hU.stronglyMeasurable_past ht`, then close with `hpast.mono (iSup_le fun r => 𝓕'.mono (hprev r.1 r.2))`.
- Left-isolated predecessor zero: make `N t - N s` strongly measurable at `𝓕' s` via `hNt_meas.sub (hN.stronglyMeasurable s)`, apply `hN.eq_zero_of_predictable_finiteVariation_past_measurable_zero_increment hst.le`, then combine with `hs_zero` using `filter_upwards`.

## Structural Notes

- Blueprint doctor for iter-051 reported no structural issues.
- `sync_leanok` is current for iter-051 and made no marker changes. Review did not add or remove any `\leanok`.
