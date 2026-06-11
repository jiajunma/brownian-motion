# Iteration 043 Objectives

## Prover Lane

### `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

Blueprint: `blueprint/src/chapters/doob_meyer.tex`

Targets:

1. `Filter.Tendsto.eventually_const_le_of_nhdsWithin_Iio`
   - Prove that a sequence tending to `t` within `Set.Iio t` is eventually above every fixed `s < t`.
   - Use `Ioi_mem_nhds`, `nhdsWithin_le_nhds`, and `hu.eventually`.

2. `MeasureTheory.norm_sub_le_two_mul_of_Icc_bound`
   - Prove the pathwise horizon-bound estimate `‖N t ω - N u ω‖ ≤ 2 * C` when `u ∈ Set.Icc ⊥ t` and every value on the horizon is bounded by `C`.
   - Use triangle inequality plus the two horizon-bound applications.

3. `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound`
   - Combine the existing generated-past jump-removal wrapper with the existing dominated jump set-integral helper.
   - Keep the left-approaching sequence, jump integrability, and deterministic a.e. horizon bound as explicit hypotheses.
   - Use constant dominator `fun _ => 2 * C` on `P'.restrict A`, with `MeasureTheory.integrable_const` and `MeasureTheory.ae_restrict_of_ae`.

Non-targets:

- Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- Do not target the public weak local Doob-Meyer theorem.
- Do not infer announcing sequences, domination, fixed-time earlier measurability, or jump integrability from strong predictability/local bounded variation.

Required verification:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
