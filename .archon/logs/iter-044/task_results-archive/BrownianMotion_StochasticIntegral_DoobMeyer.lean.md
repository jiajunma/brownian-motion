# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## Filter.Tendsto.eventually_const_le_of_nhdsWithin_Iio (line 1100)
### Attempt 1
- **Approach:** Pull the open interval `Set.Ioi s` back along the left-neighborhood convergence, then weaken `s < u n` to `s ≤ u n`.
- **Result:** RESOLVED.
- **Key insight:** Mathlib's `Ioi_mem_nhds` / order-topology API requires `LinearOrder`, so the helper is stated with `[LinearOrder κ]`. The consuming martingale wrapper has `[ConditionallyCompleteLinearOrderBot κ]`, so this is sufficient for the target package.

## MeasureTheory.norm_sub_le_two_mul_of_Icc_bound (line 1112)
### Attempt 1
- **Approach:** Apply `norm_sub_le`, use the horizon bound at `t` and at `u`, and close `C + C = 2 * C` by `ring`.
- **Result:** RESOLVED.
- **Key insight:** The explicit nonnegativity hypothesis is retained for downstream dominator bookkeeping, though the triangle-inequality proof itself only needs the two horizon bounds.

## MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound (line 1128)
### Attempt 1
- **Approach:** Delegate to `ae_eq_leftLim_of_left_approach_past_setIntegral_zero`; for each strict-past set integral, call `setIntegral_jump_leftLim_eq_zero_of_left_approach_of_dominated` with constant bound `2 * C`.
- **Result:** RESOLVED.
- **Key insight:** `Filter.Tendsto.eventually_const_le_of_nhdsWithin_Iio` supplies eventual `s ≤ u n`; `MeasureTheory.ae_restrict_of_ae hbound_horizon` transfers the deterministic horizon bound to `P'.restrict A`; `norm_sub_le_two_mul_of_Icc_bound` gives the domination for every `n`.

## Remaining open declarations
### Current status
- **MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction:** still open at line 2312, as requested.
- **ProbabilityTheory.IsLocalSubmartingale.doob_meyer:** still open at line 2534, as requested.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: PASS. Warnings: two deprecated finite-sum names and the two expected remaining `sorry` declarations.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: PASS. Warning: existing `IsLocalMartingale.isLocalSubmartingale_sq_norm` sorry.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: PASS.
- `lake build`: PASS.
