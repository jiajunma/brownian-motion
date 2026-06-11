# Iteration 015 Objectives

## Prover Assignment

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`, especially:
   - `thm:Martingale.eq_zero_of_predictable_finiteVariation_noninitial`
   - `thm:Martingale.eq_zero_of_predictable_finiteVariation_discrete`
   - `thm:Martingale.eq_zero_of_predictable_finiteVariation`
   - downstream users `thm:IsLocalMartingale.eq_zero_of_predictable_finiteVariation` and `lem:predictablePart_eq_of_normalized_decomposition`

## Target

Prove `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial`, or close a real sublemma that reduces it.

Acceptable partial progress must include at least one closed helper such as:
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`, or
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_no_jumps`.

Do not only move the `sorry` into another theorem with the same mathematical content.

## Verified Hints

- `[verified]` `MeasureTheory.Martingale.eq_zero_of_predictable'` and `[verified]` `MeasureTheory.IsStronglyPredictable.measurable_add_one` cover the discrete predictable-martingale base.
- `[verified]` `MeasureTheory.measurableSet_predictable_Ioi_prod` and `[verified]` `MeasureTheory.measurable_inclusion_predictable` are the relevant continuous predictable sigma-algebra APIs.
- `[verified]` `BoundedVariationOn.leftLim` and `[verified]` `BoundedVariationOn.tendsto_eVariationOn_Ioc_zero` are available for the finite-variation jump/continuous split.
- Strong predictability should not be used as if it made `N t` measurable with respect to every fixed `𝓕 s`, `s<t`; make any past-measurability bridge explicit.

## Non-Targets

- Do not work on `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, or `ProbabilityTheory.quadraticVariation_brownian`.
- Do not weaken any a.e. equality target.
- Do not introduce axioms, and do not use the unproved non-initial bridge as a black box for downstream Brownian statements.
