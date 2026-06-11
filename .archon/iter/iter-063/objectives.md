# Iteration 063 Objectives

## Prover Objective

1. `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
   - Refactor `ProbabilityTheory.brownianQuadraticVariation` to the explicit Brownian deterministic-time process, preferably by reusing `brownianDeterministicTime`.
   - Add and prove `ProbabilityTheory.brownianQuadraticVariation_normalized_decomposition`, packaging the pathwise identity `B² = (B² - t) + brownianQuadraticVariation` together with the existing local-martingale, cadlag, predictable, progressive, locally integrable, monotone, and bottom-zero facts.
   - Reprove `ProbabilityTheory.quadraticVariation_brownian` directly from the explicit definition.
   - Blueprint: `blueprint/src/chapters/stochastic_integral.tex`, blocks `def:brownianQuadraticVariation`, `lem:brownianQuadraticVariation_normalized_decomposition`, and `lem:quadraticVariation_brownian`.
   - Not a target: generic `ProbabilityTheory.quadraticVariation`, `IsLocalMartingale.isLocalSubmartingale_sq_norm`, `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`, and the future generic comparison theorem.

## Verification Requested

- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake build`
