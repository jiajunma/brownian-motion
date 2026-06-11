# Iteration 004 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Blueprint: `blueprint/src/chapters/doob_meyer.tex`
   - Target declarations:
     `ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized` and,
     if normalization compiles,
     `ProbabilityTheory.IsLocalSubmartingale.predictablePart_bot_eq_zero`.
   - Preserve existing declaration signatures.
   - Do not rework Brownian independent-increment calculations.
   - Do not add a new uniqueness theorem with `sorry`; report the missing
     finite-variation local-martingale zero theorem if that is the blocker.

## Deferred

- `ProbabilityTheory.quadraticVariation_brownian` remains deferred until the
  normalized predictable-part identification theorem is available.
- `ProbabilityTheory.IsLocalMartingale.isLocalSubmartingale_sq_norm` remains
  blocked by the missing sigma-finite/local square-integrability assumptions.
