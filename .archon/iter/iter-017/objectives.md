# Iteration 017 Objectives

## Assigned File

`BrownianMotion/StochasticIntegral/DoobMeyer.lean`

## Objective

Prove `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_condExp_zero`, the remaining conditional-expectation bridge for predictable finite-variation martingale uniqueness.

The prover should formalize the blueprint's jump-removal and bounded continuous finite-variation square-increment route. If the full lemma remains too large, it should close one substantive helper around predictable jump removal, bounded continuous finite-variation martingales, or square-increment sums, and leave any `sorry` only at the deepest remaining analytic point.

## Success Criteria

- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_condExp_zero` is proved, or the remaining `sorry` is moved into a strictly deeper helper with a closed wrapper.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic`, `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial`, `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation`, and `ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation` remain free of internal `sorry` beyond their dependency on the deepest analytic helper.
- No theorem statement is weakened, and no downstream Brownian result uses the unproved uniqueness bridge as a black box.

## Verification Required

Run:

```bash
lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean
lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean
lake build
```

The task result must report exact new declarations, exact remaining `sorry` locations, and whether the public uniqueness wrappers still contain no internal `sorry`.
