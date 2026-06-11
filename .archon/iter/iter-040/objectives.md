# Iteration 040 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`

   Targets:

   - `MeasureTheory.Martingale.stronglyMeasurable_leftLim_past_of_left_approach`
   - `MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach`

   Scope:

   - Add both lemmas after `LocallyBoundedVariationOn.exists_tendsto_left_univ` and before `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`.
   - Prove only past-sigma measurability of the left limit and jump.
   - Do not prove jump vanishing, do not infer fixed earlier-time `𝓕' (u n)` measurability from strong predictability, and do not attack `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic proof.

## Verification Expected

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
