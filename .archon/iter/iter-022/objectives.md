# Iteration 022 Objectives

## Prover Assignment

### `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

Blueprint: `blueprint/src/chapters/doob_meyer.tex`

Relevant blueprint blocks:
- `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`
- `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`
- `lem:Martingale.eq_zero_of_predictable_finiteVariation_value_zero`

Primary target:
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`.

Work order:
1. Try to prove the bounded continuous finite-variation core helper from the blueprint, preferably named `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`.
2. Use the closed deterministic estimate `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound` for the pathwise square-increment convergence.
3. Use martingale increment orthogonality for deterministic partitions and dominated convergence in the bounded stopped case.
4. Only then attack the full càdlàg strongly predictable bridge by removing predictable jumps and bounded stopping.

Guardrails:
- Do not weaken existing theorem statements.
- Do not claim strong predictability gives `StronglyMeasurable[𝓕 s] (N t - N s)` unless that exact measurability has been proved.
- If the full bridge is too large, either leave the existing `sorry` where it is after closing a real helper, or move that single gap into a strictly deeper helper with the wrapper reducing to it. Do not add unrelated new `sorry` terms.

Verification:
```bash
lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean
lake build
```

Report every new helper declaration, whether the primary target closed, and the final `sorry`/warning lines.
