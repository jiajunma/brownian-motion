# Iteration 005 Objectives

## Assigned File

`BrownianMotion/StochasticIntegral/DoobMeyer.lean`

## Objective

Close the two remaining gaps inside
`ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized` without changing any existing signatures and without adding new `sorry`s.

## Concrete Targets

1. Prove that `M + C` is a local martingale, where `C t ω = A ⊥ ω`.
2. Prove `HasLocallyIntegrableSup (A - C) 𝓕 P`.

## Constraints

- Preserve the signatures of `doob_meyer`, `doob_meyer_normalized`, `martingalePart`, `predictablePart`, and all existing accessor lemmas.
- Keep the already-compiled retargeting of `martingalePart` and `predictablePart`.
- Do not work on Brownian independent increments or `QuadraticVariationBrownian.lean`.
- Do not add the full predictable-part uniqueness theorem this iteration.

## Fallback

If a closure is unprovable under the current theorem signature, prove the smallest helper in `DoobMeyer.lean` that compiles and advances one closure, then record the exact missing hypothesis in the task result.
