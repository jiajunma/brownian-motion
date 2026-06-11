# Iteration 019 Objectives

## Assigned File

`BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`

Blueprint: `blueprint/src/chapters/stochastic_integral.tex`, Brownian quadratic-variation subsection.

## Primary Target

Add
`ProbabilityTheory.quadraticVariation_brownian (t : ℝ≥0) :
  brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`
under the existing usual-condition assumptions for the Brownian natural filtration.

## Helper Targets

- `ProbabilityTheory.brownianDeterministicTime` for `fun t _ => (t : ℝ)`.
- `ProbabilityTheory.isCadlag_brownian_sq_sub_time`.
- `ProbabilityTheory.isStronglyPredictable_brownianDeterministicTime`.
- `ProbabilityTheory.isStronglyProgressive_brownianDeterministicTime`.
- `ProbabilityTheory.isCadlag_brownianDeterministicTime`.
- `ProbabilityTheory.hasLocallyIntegrableSup_brownianDeterministicTime`.
- `ProbabilityTheory.monotone_brownianDeterministicTime`.
- `ProbabilityTheory.brownianDeterministicTime_bot_eq_zero`.

Use `martingale_brownian_sq_sub_time` as the martingale part in
`B_t^2 = (B_t^2 - t) + t`, and use
`ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition`
for the fixed-time predictable-part comparison.

## Verification

Run:

```bash
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean
lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean
lake build
```

Report all new declarations, the exact statement of `quadraticVariation_brownian`,
and whether any new `sorry` warnings or build warnings were introduced.
