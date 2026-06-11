# Iteration 054 Objectives

## Prover Objective

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Target declaration to add and prove:

   - `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_left_branch`

   Blueprint source:

   - `blueprint/src/chapters/doob_meyer.tex`
   - `lem:Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_left_branch`

   Mathematical role:

   - Convert explicit original-process horizon and variation bounds into the stopped/indicator bounds required by the closed fixed-time branch connector.
   - Preserve all remaining inputs as hypotheses: localizing sequence, deterministic partitions, mesh, original-path continuity, and the explicit left-branch disjunction.
   - Do not attempt `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

## Expected Proof Ingredients

- Use `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc` for each localizing time `τ n`.
- Feed the resulting stopped-piece horizon and variation bounds into `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch`.
- The conclusion should be `N t =ᵐ[P'] 0`.

## Verification Requested

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
