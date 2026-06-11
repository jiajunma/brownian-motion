# Iteration 055 Objectives

## Prover Objective

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Add and prove `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_left_branch`.
   - Blueprint: `blueprint/src/chapters/doob_meyer.tex`, label `lem:Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_left_branch`.
   - Main proof idea: instantiate `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_left_branch` with the constant-top localizing sequence from `ProbabilityTheory.isLocalizingSequence_const_top`, and use constant level families `fun _ => C` and `fun _ => V`.
   - Inputs that remain explicit: original horizon bound, original variation bound, original continuity, deterministic partitions, mesh, and the left-branch disjunction.

## Not Targeted

- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` remains open at actual `sorry` line `3071` and is not assigned as a monolithic target.
- `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` remains open at actual `sorry` line `3293`.
- `IsLocalMartingale.isLocalSubmartingale_sq_norm` remains open at actual `sorry` line `84` in `QuadraticVariation.lean`.
