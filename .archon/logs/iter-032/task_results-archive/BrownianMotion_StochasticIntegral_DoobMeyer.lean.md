# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn (line 1419)
### Attempt 1
- **Approach:** Convert each pathwise `ContinuousOn (N · ω) (Set.Icc ⊥ t)` hypothesis to `UniformContinuousOn` using the closed `ContinuousOn.uniformContinuousOn_Icc`, under `[CompactIccSpace κ]`, then delegate to `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_uniformContinuousOn`.
- **Result:** RESOLVED.
- **Key insight:** The deterministic entourage-mesh hypothesis is unchanged; only the pathwise regularity hypothesis changes from continuous-on to uniform-continuous-on.
- **Marker readiness:** Ready for the blueprint declaration `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

## MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn (line 1443)
### Attempt 1
- **Approach:** Apply the new continuous-on square-integral wrapper to get `Integrable (fun ω => N t ω ^ 2) P'` and `∫ ω, N t ω ^ 2 ∂P' = 0`, then finish with `MeasureTheory.ae_eq_zero_of_integral_sq_eq_zero`.
- **Result:** RESOLVED.
- **Key insight:** No extra stochastic hypotheses are needed beyond the square-integral wrapper.
- **Marker readiness:** Ready for the blueprint declaration `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

## Remaining DoobMeyer gaps
### Current status
- **MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction:** still open; declaration warning at line 1496, actual `sorry` at line 1532.
- **ProbabilityTheory.IsLocalSubmartingale.doob_meyer:** still open; declaration warning at line 1749, actual `sorry` at line 1754.
- **Predictable finite-variation reduction/public wrapper:** not retried as a monolithic proof this round, per objective.

## Verification
### Commands
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` — PASSED; warnings only for deprecated finset integral names and the two pre-existing `sorry` declarations.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` — PASSED; existing `sorry` warning at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` — PASSED.
- `lake build` — PASSED, 3312 jobs.
