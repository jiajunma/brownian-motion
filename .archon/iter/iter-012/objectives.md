# Iteration 012 Objectives

## Prover Assignment

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially
   `thm:IsLocalMartingale.eq_zero_of_predictable_finiteVariation` and
   `lem:predictablePart_eq_of_normalized_decomposition`.

   Target `ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation` first. The intended conclusion is fixed-time a.e equality `N t =ᵐ[P] 0` for a strongly predictable càdlàg local martingale starting at zero whose paths have locally bounded variation.

   If that theorem closes or is reduced to a single isolated analytic gap, add the normalized predictable-part uniqueness theorem
   `ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition` with fixed-time a.e equality.

   Verified hints this iteration:
   `MeasureTheory.Martingale.eq_zero_of_predictable'`,
   `MonotoneOn.locallyBoundedVariationOn`, and
   `IsFiniteMeasure.sigmaFiniteFiltration` are available.

## Verification Requested

Run:

```text
lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean
lake build
```

Report exact new declarations and any remaining `sorry` location.
