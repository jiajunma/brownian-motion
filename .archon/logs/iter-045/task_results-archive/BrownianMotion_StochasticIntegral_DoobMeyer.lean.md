# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.integrable_jump_leftLim_of_left_approach_of_bound (line 1157)
### Attempt 1
- **Approach:** Promote the closed past-sigma jump measurability lemma to ambient strong measurability using `iSup_le fun s => 𝓕'.le s`, then apply `MeasureTheory.Integrable.of_bound` with constant `2 * C`.
- **Result:** RESOLVED.
- **Key insight:** On the a.e. horizon-bound event, each left-approaching increment satisfies `‖N t ω - N (u n) ω‖ ≤ 2 * C` by `MeasureTheory.norm_sub_le_two_mul_of_Icc_bound`; `tendsto_leftLim_of_tendsto` and `le_of_tendsto` pass this bound to the jump.
- **Lemmas used:** `MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach`, `MeasureTheory.norm_sub_le_two_mul_of_Icc_bound`, `LocallyBoundedVariationOn.exists_tendsto_left_univ`, `tendsto_leftLim_of_tendsto`, `MeasureTheory.Integrable.of_bound`.

## MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability (line 1198)
### Attempt 1
- **Approach:** Derive `hjump_int` from `MeasureTheory.Martingale.integrable_jump_leftLim_of_left_approach_of_bound`, then call the existing bounded wrapper `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound`.
- **Result:** RESOLVED.
- **Key insight:** No new analytic content is needed once the jump integrability helper is closed.

## Remaining declarations
### MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction (declaration line 2337, sorry line 2373)
- **Result:** OPEN, pre-existing `sorry` remains.
- **Next step:** Use the new no-extra-integrability jump-removal wrapper inside the predictable finite-variation reduction, then continue the bounded/localized continuous finite-variation reduction.

### ProbabilityTheory.IsLocalSubmartingale.doob_meyer (declaration line 2590, sorry line 2595)
- **Result:** OPEN, pre-existing public weak Doob-Meyer `sorry` remains.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed; warnings only for deprecated finset integral names and the two expected `sorry` declarations at lines 2337 and 2590. The actual `sorry` tokens are at lines 2373 and 2595.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed; existing `sorry` warning at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed successfully.
