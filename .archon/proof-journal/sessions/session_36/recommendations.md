# Recommendations

## Prioritize

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The stopped/localizing bound-and-variation packaging layer is now closed. The next objective should be one genuine analytic construction sublemma, not another wrapper around the same assumptions.

Good candidates:

- predictable-jump removal for a strongly predictable cadlag martingale at a fixed deterministic time;
- construction of localizing times that give deterministic horizon bounds and deterministic variation bounds on `[bot, t]`;
- continuity transfer for the stopped/indicator pieces under honest extra hypotheses;
- deterministic mesh/partition existence under explicit topological-order assumptions.

## Do Not Retry Monolithically

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a single proof. The repeated wrapper work has reached the point where the remaining work is structural and analytic: predictable-jump removal, bounded/variation localization, continuity transfer, deterministic mesh management, and final bridge invocation.

Do not claim stopped cadlag paths are continuous, do not assert deterministic mesh existence in arbitrary ordered Polish time, and do not convert local bounded variation into deterministic variation bounds without an explicit localization construction.

## Reusable Pattern

For each localizing time, the original-process a.e. assumptions can now be packaged into stopped-process hypotheses as:

```lean
have hstopped_bounds : ∀ n, ... := by
  intro n
  exact MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc
    (N := N) (τ := τ n) (t := t) (C := C n) (V := V n)
    (hC_nonneg n) (hbound_horizon n) (hvar_bound n)
```

Then pass `(fun n => (hstopped_bounds n).1)` and `(fun n => (hstopped_bounds n).2)` into `hN.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

## Tooling Notes

The attempt preprocessor again emitted only `no_prover_lane: true` even though the prover ran and passed verification. Continue checking `meta.json`, `prover.jsonl`, and task results when this mismatch appears.

`sync_leanok` is current for iter-036 and made zero changes. Newly closed Doob-Meyer helper blocks still lack `\leanok`; review agents should not patch those markers manually.
