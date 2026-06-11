# Session 38 Recommendations

## Closest Useful Target

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but stop adding wrappers around the same stopped/indicator package unless the wrapper removes a genuinely new hypothesis from the main reduction.

The newly closed theorem:

- `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`

now packages original a.e. bounds, original a.e. variation bounds, and original path continuity into the stopped-process hypotheses needed by the localizing-sequence zero theorem.

## Do Not Retry As A Monolith

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a single proof attempt. It still needs separate construction steps:

- predictable-jump removal or a precise jump-zero lemma under strong predictability and finite variation,
- bounded localization with deterministic horizon bounds,
- variation localization with deterministic `V_n`,
- deterministic partitions and mesh hypotheses under honest assumptions,
- final assembly using the closed localizing-sequence wrappers.

## Promising Next Splits

- Prove a small predictable-jump lemma using the existing left-limit scaffold in `eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`; keep the statement explicit about the conditional-expectation/increment hypothesis it uses.
- Alternatively, isolate a bounded/variation localization lemma that produces the a.e. hypotheses expected by `eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn` without trying to construct continuity or mesh at the same time.
- Keep deterministic mesh existence out of broad ordered-Polish statements unless an additional assumption guarantees it.

## Reusable Pattern

To derive stopped-piece continuity from original continuity in a localizing-sequence wrapper, pass:

```lean
fun n ω => MeasureTheory.stoppedProcess_indicator_continuousOn_Icc
  (N := N) (τ := τ n) (ω := ω) (t := t) (hN_cont ω)
```

as the `hZ_cont` argument, then delegate to `hN.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`.
