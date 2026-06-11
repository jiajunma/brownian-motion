# Iteration 011 Objectives

## Prover Assignment

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

## Required Outcome

- Strengthen the weak and normalized Doob--Meyer witnesses so their increasing
  part includes `IsStronglyPredictable`.
- Add
  `ProbabilityTheory.IsLocalSubmartingale.isStronglyPredictable_predictablePart`.
- Preserve the existing `predictablePart`/`martingalePart` definitions and
  accessors as far as possible, including
  `isStronglyProgressive_predictablePart`.
- Keep the only `DoobMeyer.lean` sorry as the original weak
  `doob_meyer` decomposition.

## Explicit Non-Goals

- Do not prove or add `quadraticVariation_brownian`.
- Do not add a new uniqueness theorem with `sorry`.
- Do not use the false theorem shape that a cadlag finite-variation local
  martingale is constant without predictability.
- Do not edit `QuadraticVariation.lean` or `QuadraticVariationBrownian.lean`.

## Verification Commands

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
