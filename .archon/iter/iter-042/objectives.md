# Iteration 042 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`

   Target declarations:

   - `MeasureTheory.Martingale.setIntegral_increment_eq_zero_of_measurableSet`
   - `MeasureTheory.Martingale.setIntegral_jump_leftLim_eq_zero_of_left_approach_of_dominated`

## Mathematical Scope

The first helper proves that if `s ≤ u ≤ v` and `A ∈ 𝓕' s`, then a martingale increment satisfies

```text
∫ ω in A, (N v ω - N u ω) ∂P' = 0.
```

The second helper proves that, along a deterministic sequence `u n < t` tending to `t` from the left, those finite-increment set integrals pass to the jump set integral under explicit eventual-order and restricted-measure domination hypotheses:

```text
∫ ω in A, (N t ω - Function.leftLim (N · ω) t) ∂P' = 0.
```

The second helper should not claim the domination hypothesis follows from local bounded variation. It should assume the restricted-set dominator explicitly.

## Out Of Scope

- Do not prove `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this iteration.
- Do not infer fixed-time `𝓕' (u n)`-measurability of `N t - N (u n)` from strong predictability.
- Do not assert jump vanishing from past-sigma measurability alone.
- Do not build deterministic mesh partitions or variation-localizing stopping times.

## Verification

Run:

```text
lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean
lake build
```
