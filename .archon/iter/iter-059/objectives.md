# Iteration 059 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`

   Targets:

   - `BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_closed_pre_stop_Icc`
   - `BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc_of_closed_pre_stop_bound`
   - `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound`

## Mathematical Scope

The target is stopped/indicator variation bookkeeping. The closed pre-stop horizon set is
`{r : κ | r ∈ Set.Icc (⊥ : κ) t ∧ (r : WithTop κ) ≤ τ ω}`. The non-strict inequality is intentional because stopped variation includes the finite stop value.

The prover should reuse the existing stopped/indicator variation proof pattern:

- compare finite partition sums through `g s = (min (↑s : WithTop κ) (τ ω)).untopA`;
- use `eVariationOn.sum_le` on the image partition in the closed pre-stop set;
- transfer finiteness with `ne_top_of_le_ne_top`;
- transfer the real bound with `ENNReal.toReal_mono`;
- package the a.e. bound component by calling `MeasureTheory.ae_stoppedProcess_indicator_bound_on_Icc_of_pre_stop_bound`.

## Non-Targets

- Do not prove `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- Do not target the public weak local Doob-Meyer theorem.
- Do not infer stop-value bounds, no-overshoot, deterministic variation levels, continuity, partitions, mesh, localizing sequences, or branch data.
