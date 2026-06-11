# Iteration 044 Objectives

## Prover Objective

### `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

Blueprint: `blueprint/src/chapters/doob_meyer.tex`

Target declarations:

- `MeasureTheory.Martingale.integrable_jump_leftLim_of_left_approach_of_bound`
- `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`

Place both declarations immediately after `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound` and before `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`.

The first helper should prove integrability of `fun ω => N t ω - Function.leftLim (N · ω) t` under the same explicit left-approaching sequence and deterministic a.e. horizon bound used by the existing bounded jump-removal theorem. The proof should dominate the jump by `2 * C` as the limit of the bounded increments `N t - N (u n)`.

The second helper should obtain the jump integrability from the first helper and call the existing `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound`.

## Non-Goals

- Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- Do not infer sequence existence, localization, or deterministic domination from strong predictability or local bounded variation.
- Do not use fixed-time `𝓕' (u n)`-measurability of `N t - N (u n)` unless a separate theorem proves it.
- Do not construct deterministic mesh partitions or variation-localizing stopping times in this split.

## Verification Required

Run:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`

Report both new declarations, the remaining Doob-Meyer `sorry` lines, and whether the build passes.
