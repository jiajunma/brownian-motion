# Iteration 031 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Blueprint: `blueprint/src/chapters/doob_meyer.tex`.
   - Primary declaration to add and prove:
     `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
   - Follow-on if the primary target closes quickly:
     `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

## Constraints

- Keep deterministic entourage-mesh partitions as an explicit hypothesis.
- Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` monolithically.
- Do not work on `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` this iteration.
- Run `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, then the two quadratic-variation files, then `lake build` if the file check passes.
