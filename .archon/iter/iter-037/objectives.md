# Iteration 037 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Target declaration to add and prove:
   `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc`.

   Blueprint backing:
   `blueprint/src/chapters/doob_meyer.tex`, lemma `lem:stoppedProcess_indicator_continuousOn_Icc`.

   Scope:
   prove only the stopped/indicator continuity-transfer helper. Do not retry the monolithic predictable finite-variation reduction, and do not target the weak local Doob-Meyer theorem.

   Verification requested:
   `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, then `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` if the file passes.

