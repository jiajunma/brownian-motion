# Iteration 008 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
   - Strengthen `ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized` with the smallest usual assumptions needed by the compiled normalization helpers.
   - Propagate the same assumptions to `martingalePart`, `predictablePart`, and the accessors in the file that call `doob_meyer_normalized`.
   - Close the two normalized theorem sorries using `IsLocalMartingale.add_initial_of_hasLocallyIntegrableSup` and `HasLocallyIntegrableSup.sub_initial`.
   - Keep the weak `doob_meyer` theorem unchanged, add no new sorries, and run the file check plus full build.

## Deferred

- Downstream quadratic-variation signature propagation is deferred unless the Doob-Meyer prover can handle it without leaving its assigned file. A full-build failure should be recorded precisely for the next iteration.
