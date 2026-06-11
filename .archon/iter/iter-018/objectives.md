# Iteration 018 Objectives

## Prover Assignment

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially `lem:Martingale.eq_zero_of_predictable_finiteVariation_value_zero` and its support lemmas `lem:condExp_ae_eq_zero_of_ae_eq_zero`, `lem:LocallyBoundedVariationOn.exists_tendsto_left_univ`, and `lem:Martingale.eq_zero_of_predictable_finiteVariation_past_measurable_zero_increment`.

   Primary target: prove `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero`.

   Acceptable partial progress: close a real helper for deterministic jump removal, bounded continuous finite-variation martingales, or square-increment sums along refining partitions. A remaining gap should move below `value_zero`, not remain in `past_condExp_zero` or any public wrapper.

   Required verification: `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, then `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`, `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`, and `lake build`.

## Non-Targets

- Do not work on `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, `ProbabilityTheory.quadraticVariation_brownian`, or the weak local Doob-Meyer theorem this iteration.
- Do not use the unresolved finite-variation uniqueness bridge as a black box for downstream Brownian statements.
