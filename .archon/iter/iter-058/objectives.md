# Iteration 058 Objectives

## Prover Assignment

### `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

Blueprint: `blueprint/src/chapters/doob_meyer.tex`

New declarations:

- `MeasureTheory.stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`
- `MeasureTheory.ae_stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`

Goal: construct the stopped/indicator deterministic horizon-bound input from explicit pre-stop and stop-value bounds. Place the lemmas near the existing `MeasureTheory.stoppedProcess_indicator_bound_on_Icc`.

Do not work on:

- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`
- `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`
- `IsLocalMartingale.isLocalSubmartingale_sq_norm`

## Verification Required

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`

The task result should report the two new horizon-bound lemmas and confirm the known remaining `sorry` locations.
