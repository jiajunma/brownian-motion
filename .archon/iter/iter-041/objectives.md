# Iteration 041 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Prove the generated-past zero-integral package:

   - `MeasureTheory.Filtration.ae_eq_zero_of_past_setIntegral_eq_zero`
   - `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero`

   Blueprint source: `blueprint/src/chapters/doob_meyer.tex`, labels:

   - `lem:Filtration.ae_eq_zero_of_past_setIntegral_eq_zero`
   - `lem:Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero`

## Boundaries

- Keep integrability and zero earlier-set integrals as explicit hypotheses.
- Do not claim strong predictability gives fixed earlier-time measurability of `N t - N (u n)`.
- Do not try to close `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this round.
- Add `public import Mathlib.MeasureTheory.PiSystem` if the pi-system induction theorem is not already in scope.
