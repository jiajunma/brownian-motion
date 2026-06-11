# Iteration 039 Objectives

## Prover Target

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Add and prove:

   `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`

   Blueprint theorem:

   `blueprint/src/chapters/doob_meyer.tex`, label `lem:Martingale.ae_eq_leftLim_of_left_approach_past_measurable_increments`.

## Intended Statement

Assume:

- `hN : Martingale N 𝓕' P'`;
- `hN_var : ∀ ω, LocallyBoundedVariationOn (N · ω) Set.univ`;
- a deterministic sequence `u : ℕ → κ`;
- `hu_lt : ∀ n, u n < t`;
- `hu_tendsto : Tendsto u atTop (nhdsWithin t (Set.Iio t))`;
- `hinc_meas : ∀ n, StronglyMeasurable[𝓕' (u n)] (N t - N (u n))`.

Conclude:

`N t =ᵐ[P'] fun ω => Function.leftLim (N · ω) t`.

## Non-Goals

- Do not prove that strong predictability supplies `hinc_meas` this round.
- Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic proof.
- Do not construct deterministic mesh partitions or variation-localizing stopping times in this objective.
