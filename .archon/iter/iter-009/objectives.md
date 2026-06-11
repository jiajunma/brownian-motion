# Iteration 009 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
   - Put `ProbabilityTheory.quadraticVariation` in a strengthened usual-
     assumption section matching the normalized Doob--Meyer section.
   - Use a fresh strengthened time-index variable for the filtration context to
     avoid the weak `[LinearOrder]` versus
     `[ConditionallyCompleteLinearOrderBot]` `IsCadlag` partial-order mismatch.
   - Preserve the existing `IsLocalMartingale.isLocalSubmartingale_sq_norm`
     sorry unless a mechanical section move is necessary; add no new sorries.
   - Run `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
     and then `lake build`.

## Checkpoint

- If `QuadraticVariation.lean` compiles and the full build moves the failure to
  `QuadraticVariationBrownian.lean`, stop after recording the exact missing
  usual-condition instances or declarations for the Brownian specialization.
