# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound (line 1219)
### Attempt 1
- **Approach:** Defined the stopped/indicator process `Z`, transferred martingale, strong predictability, pathwise locally bounded variation, and the deterministic a.e. horizon bound to `Z`.
- **Result:** RESOLVED.
- **Key lemmas used:** `MeasureTheory.Martingale.stoppedProcess_indicator`, `MeasureTheory.IsStronglyPredictable.stoppedProcess_indicator`, `locallyBoundedVariationOn_stoppedProcess_indicator`, `MeasureTheory.stoppedProcess_indicator_bound_on_Icc`, and `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`.

## MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_stoppedProcess_indicator_of_left_approach_of_bound (line 1260)
### Attempt 1
- **Approach:** Introduced `n` and applied the stopped/indicator wrapper to `τ n`, using `hτ.isStoppingTime n`, `C n`, `hC_nonneg n`, and `hbound_horizon n`.
- **Result:** RESOLVED.
- **Key insight:** The family statement does not need the a.e. exhaustion lemma; each stopped member is proved independently.

## Remaining DoobMeyer proof debts
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` remains open at line 2404, with the `sorry` at line 2440.
- `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` remains open at line 2657, with the `sorry` at line 2662.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed.
  - Warnings: deprecated `MeasureTheory.integrable_finset_sum` at line 1557; deprecated `MeasureTheory.integral_finset_sum` at line 1572; expected sorries at lines 2404 and 2657.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed.
  - Warning: known sorry at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed successfully.
