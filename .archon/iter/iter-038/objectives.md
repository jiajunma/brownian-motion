# Iteration 038 Objectives

## Prover Objective

### `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

Blueprint: `blueprint/src/chapters/doob_meyer.tex`, lemma `lem:Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`.

Add and prove:

- `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`

Use the same hypothesis package as the closed theorem
`MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`, except replace the explicit stopped-piece continuity hypothesis with original-path continuity
`∀ ω, ContinuousOn (N · ω) (Set.Icc (⊥ : κ) t)`.

Proof idea: for each localizing index `n` and sample point `ω`, apply
`MeasureTheory.stoppedProcess_indicator_continuousOn_Icc` with `τ := τ n` to the original continuity hypothesis. Then pass the resulting stopped-piece continuity hypothesis to the existing localizing-sequence theorem.

Keep out of scope:

- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- The original weak `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.
- Deterministic mesh construction, predictable-jump removal, and variation-level localization.

Verification requested:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
