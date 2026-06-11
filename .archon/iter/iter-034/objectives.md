# Iteration 034 Objectives

## Prover Lane

1. **`BrownianMotion/StochasticIntegral/DoobMeyer.lean`** — Blueprint: `blueprint/src/chapters/doob_meyer.tex`, lemma `lem:Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

   Add and prove `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

   The helper should take a true martingale `N`, cadlag paths, `N ⊥ = 0`, a localizing sequence `τ`, deterministic bounds `C n` and `V n`, deterministic partitions `u n` from `⊥` to `t`, the explicit entourage-mesh hypothesis, and the stopped-process boundedness, variation-bound, and continuity hypotheses for each `n`.

   Proof ingredients:

   - Use `MeasureTheory.Martingale.stoppedProcess_indicator` to build the stopped-process martingales from `hN`, `(hN_cadlag ω).right_continuous`, and `hτ.isStoppingTime n`.
   - Use `hτ.tendsto_top` to prove `∀ᵐ ω ∂P', ∃ n, (t : WithTop κ) < τ n ω`.
   - Apply `MeasureTheory.Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.

   Keep deterministic mesh, deterministic variation bounds, and stopped-process continuity as explicit assumptions. Do not try to close `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this round.

## Verification Expected

Run:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
