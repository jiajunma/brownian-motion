# Iteration 013 Objectives

## Prover Assignment

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially
   `lem:IsStronglyPredictable_stoppedProcess_indicator`,
   `lem:LocallyBoundedVariationOn_stoppedProcess_indicator`,
   `thm:Martingale.eq_zero_of_predictable_finiteVariation`, and
   `thm:IsLocalMartingale.eq_zero_of_predictable_finiteVariation`.

   First formalize the stopped-predictability and stopped pathwise
   locally-bounded-variation support needed to localize the uniqueness theorem.
   Then prove the localizing reduction for
   `ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation`
   from a true-martingale theorem.

   Add and attempt
   `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation` for the
   true-martingale bridge.  If the full bridge cannot be closed, leave exactly
   one honest `sorry` there and ensure the local wrapper has no `sorry`.

## Verification Requested

Run:

```text
lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean
lake build
```

Report the exact new declarations, any remaining `sorry` location, and whether
the local wrapper still contains a `sorry`.
