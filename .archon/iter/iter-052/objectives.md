# Iteration 052 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Blueprint: `blueprint/src/chapters/doob_meyer.tex`
   - New block: `lem:Martingale.eq_zero_of_predictable_bottom_immediate`
   - Target declaration: `MeasureTheory.Martingale.eq_zero_of_predictable_bottom_immediate`
   - Purpose: convert pointwise bottom normalization into the previous-time a.e. zero hypothesis for the closed left-isolated predecessor lemma, under an explicit bottom-immediacy assumption.

## Not Assigned

- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`: still too broad for one prover round; it needs branch assembly plus stopped-bound, variation-bound, partition, and mesh inputs.
- `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`: still blocked on the predictable finite-variation bridge and the broader weak Doob-Meyer proof debt.
- `BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: still deferred because the generic square-norm local-submartingale statement likely needs a usual-condition/finite-measure context repair.
