# Iteration 020 Objectives

## Prover Target

1. `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`

   Add the fixed-time Brownian quadratic-variation theorem under the existing usual-condition section:

   ```lean
   ProbabilityTheory.quadraticVariation_brownian (t : ℝ≥0) :
     brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)
   ```

   Use the normalized decomposition
   \[
     \|B_t\|^2 = (B_t^2 - t) + t
   \]
   and apply `ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition`.

## Helper Scope

- Add only small helpers in `QuadraticVariationBrownian.lean`.
- Preferred helper names already reflected in `chapters/stochastic_integral.tex`:
  `brownianDeterministicTime`,
  `isCadlag_brownian_sq_sub_time`,
  `isStronglyPredictable_brownianDeterministicTime`,
  `isStronglyProgressive_brownianDeterministicTime`,
  `isCadlag_brownianDeterministicTime`,
  `hasLocallyIntegrableSup_brownianDeterministicTime`,
  `monotone_brownianDeterministicTime`,
  `brownianDeterministicTime_bot_eq_zero`.
- Do not add new `sorry`, `axiom`, or weaken the theorem to pointwise/equality-by-choice form.

## Verification

Run:

```bash
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean
lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean
lake build
```
