# Mathlib Analogist Directive

## Mode
api-alignment

## Slug
brownian-direct-qv

## Design question
Should `ProbabilityTheory.brownianQuadraticVariation` be a Brownian-specific explicit deterministic-time definition, rather than an abbreviation of the generic choice-based `ProbabilityTheory.quadraticVariation`, while the generic quadratic-variation/Doob-Meyer route remains as separate project material? If the direct definition is acceptable, should it reuse the existing `ProbabilityTheory.brownianDeterministicTime` process, or should the project keep the generic definition and instead add only comparison theorems?

## Project artifact(s) under question
- `BrownianMotion/StochasticIntegral/QuadraticVariation.lean:102` — generic `ProbabilityTheory.quadraticVariation`, defined through `IsLocalMartingale.isLocalSubmartingale_sq_norm` and normalized Doob-Meyer.
- `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean:370` — current `ProbabilityTheory.brownianQuadraticVariation`, currently an abbreviation of generic `quadraticVariation`.
- `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean:377` — current fixed-time theorem `ProbabilityTheory.quadraticVariation_brownian`.
- `blueprint/src/chapters/stochastic_integral.tex:681` — blueprint definition of Brownian quadratic variation.
- `blueprint/src/chapters/stochastic_integral.tex:868` — blueprint fixed-time Brownian quadratic-variation theorem.

## Why now
The current generic `brownianQuadraticVariation` dependency route is blocked by three independent generic sorries and has caused helper churn in `DoobMeyer.lean`. Before assigning the prover, I need to know whether pivoting the Brownian theorem to an explicit deterministic-time Brownian QV definition is an idiomatic and honest Mathlib-style specialization, or whether it would improperly weaken the intended mathematical statement.

## Hints
Relevant local declarations include `ProbabilityTheory.martingale_brownian_sq_sub_time`, `ProbabilityTheory.brownianDeterministicTime`, `ProbabilityTheory.isStronglyPredictable_brownianDeterministicTime`, `ProbabilityTheory.hasLocallyIntegrableSup_brownianDeterministicTime`, and `ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition`. Prior Mathlib searches found no bundled probability quadratic-variation API and no continuous-time Doob-Meyer theorem in Mathlib.

## Severity expectation
high-stakes
