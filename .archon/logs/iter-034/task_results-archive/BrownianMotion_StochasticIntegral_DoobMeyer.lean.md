# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.eq_zero_of_localized_bounded_continuous_finiteVariation_of_variation_bound_continuousOn (line 1509)
### Attempt 1
- **Approach:** Formalized the blueprint's countable localized-family wrapper. For each event `E n`, applied the closed one-event helper `eq_zero_on_event_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` to `Z n`, then removed the countable cover with `MeasureTheory.ae_eq_zero_of_eventually_event_zero_exhaustion`.
- **Result:** RESOLVED.
- **Key insight:** The deterministic partition and mesh hypotheses can be shared across all `n`; only `C n`, `V n`, and the martingale/path hypotheses vary.
- **Lemmas used:** `MeasureTheory.Martingale.eq_zero_on_event_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, `MeasureTheory.ae_eq_zero_of_eventually_event_zero_exhaustion`.

## MeasureTheory.Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn (line 1540)
### Attempt 1
- **Approach:** Added the stopped-process specialization with explicit hypotheses for each stopped/indicator process. Set `E n = {ω | (t : WithTop κ) < τ n ω}` and delegated to the localized-family wrapper.
- **Result:** RESOLVED.
- **Key insight:** Bottom normalization follows by splitting on `(⊥ : κ) < τ n ω`; terminal agreement follows from `stoppedProcess_eq_of_le` on the cover event and the indicator membership derived from `⊥ ≤ t < τ n ω`.
- **Lemmas used:** `stoppedProcess_eq_of_le`, `Set.indicator_of_mem`, `Set.indicator_of_notMem`, `MeasureTheory.Martingale.eq_zero_of_localized_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

## Remaining open declarations
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` remains open; declaration starts at line 1637, with the `sorry` at line 1673.
- The original weak local Doob-Meyer theorem remains open; declaration starts at line 1890, with the `sorry` at line 1895.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` and downstream wrappers still compile by depending on the open reduction declaration; no new `sorry` was introduced.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed. Warnings: deprecated `MeasureTheory.integrable_finset_sum` / `MeasureTheory.integral_finset_sum`, plus the two existing Doob-Meyer `sorry` warnings.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed with its known `IsLocalMartingale.isLocalSubmartingale_sq_norm` `sorry` warning.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed successfully.
- `lean_verify` on both new declarations reported only standard imported axioms (`propext`, `Classical.choice`, `Quot.sound`) and no source-scan warnings.
