# Iteration 024 Objectives

## Prover Objective

### `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially:

- `lem:Martingale.integral_mul_increment_eq_zero_of_stronglyMeasurable`
- `lem:Martingale.integral_increment_mul_increment_eq_zero`
- `lem:Martingale.integral_mul_increment_eq_zero`
- `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`
- `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`
- `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`
- `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`

Primary target:

Close `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`. The public theorem `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` already delegates to this reduction, so closing the reduction should close the public wrapper and downstream true-martingale uniqueness chain.

Recommended proof order:

1. Add and prove `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`, the bounded continuous stopped/localized square-integral-zero premise on `[⊥, t]`.
2. Use deterministic finite partitions and telescoping sums; cancel cross terms with the closed orthogonality lemmas.
3. Use continuity plus pathwise bounded variation to send square-increment sums to zero, and use boundedness for dominated convergence.
4. Feed `Integrable (fun ω => N t ω ^ 2)` and `∫ ω, N t ω ^ 2 ∂P' = 0` into `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`.
5. Finish predictable jump removal and delocalization using only the predictable-past section theorem, left-limit package, and existing stopped-process stability helpers.

Allowed partial progress:

Add the named bounded-continuous square-integral-zero helper above, or a strictly smaller deterministic partition orthogonality theorem, with the original single gap moved into that helper. Do not add unrelated new `sorry` terms, weaken public theorem statements, or work on the old weak local Doob-Meyer theorem unless the reduction is fully closed first.

Verification:

Run `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`; if it passes, also run `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`, `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`, and `lake build`. Report new helper declarations, whether the reduction and public wrapper closed, and the final warning/sorry lines.
