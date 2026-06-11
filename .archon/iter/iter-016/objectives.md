# Iteration 016 Objectives

## Assigned Files

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

## Objective

Prove `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic`, or split it so that at least one new substantive analytic helper is closed and any remaining `sorry` moves strictly deeper.

## Blueprint Gate

Backed by `blueprint/src/chapters/doob_meyer.tex`:

- `lem:Filtration.measurable_prod_mk_predictable_past`
- `lem:IsStronglyPredictable.stronglyMeasurable_past`
- `thm:Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic`
- `thm:Martingale.eq_zero_of_predictable_finiteVariation_noninitial`
- `thm:Martingale.eq_zero_of_predictable_finiteVariation`

## Required Reporting

Report exact new declarations, exact remaining `sorry` locations, and whether the public non-initial theorem, the main true-martingale theorem, the stopped-local theorem, and the normalized predictable-part comparison remain free of internal `sorry` beyond their dependency on the analytic core.
