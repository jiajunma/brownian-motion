# Iteration 053 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Add and prove:

   - `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch`

   Blueprint:

   - `blueprint/src/chapters/doob_meyer.tex`
   - `lem:Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch`

## Target Shape

Use the stopped-bound/original-continuity nontrivial-left pair theorem's ambient hypotheses and explicit stopped-bound, stopped-variation, original-continuity, partition, and mesh inputs. Add one branch hypothesis:

`(nhdsWithin t (Set.Iio t)).NeBot ∨ (∀ r : κ, r < t → r ≤ (⊥ : κ)) ∨ ∃ s : κ, s < t ∧ (∀ r : κ, r < t → r ≤ s) ∧ N s =ᵐ[P'] 0`.

Conclude `N t =ᵐ[P'] 0`.

## Proof Dependencies

- Nontrivial-left branch: call `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_neBot_left` and take the terminal-zero component.
- Bottom-immediate branch: call `MeasureTheory.Martingale.eq_zero_of_predictable_bottom_immediate`.
- Explicit predecessor branch: call `MeasureTheory.Martingale.eq_zero_of_predictable_left_isolated_of_previous`.

## Out of Scope

- Do not fill `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- Do not fill `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.
- Do not infer nontrivial-left, bottom-immediacy, greatest-predecessor existence, stopped bounds, variation bounds, deterministic partitions, or mesh from the global martingale hypotheses.
