# Iteration 010 Objectives

## Prover Dispatch

1. `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
   - First make `ProbabilityTheory.brownianQuadraticVariation` compile with
     the strengthened generic `quadraticVariation` API.
   - Provide `Approximable brownianNaturalFiltration gaussianLimit` honestly,
     using the existing `NNReal.approximable` dyadic approximation instance if
     typeclass search does not find it automatically.
   - Continue through any further usual-condition obligations exposed by Lean.
     Do not assert raw-filtration completeness or right-continuity unless
     proved; if the current Brownian declarations are too weak, use an explicit
     Brownian-specific usual-condition section and report it as a strengthened
     checkpoint, not as the unconditional target.
   - If `brownianQuadraticVariation` compiles, push toward
     `ProbabilityTheory.quadraticVariation_brownian`, with intended pointwise
     statement `brownianQuadraticVariation t ω = (t : ℝ)`.
   - Use `martingale_brownian_sq_sub_time` and the decomposition
     `B_t^2 = (B_t^2 - t) + t`; if normalized predictable-part uniqueness is
     missing, stop without adding a sorry and report the exact theorem needed.

## Verification

- Run `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`.
- If it passes, run `lake build`.
- Report separately whether the Brownian definition compiles and whether the
  equality theorem was added and closed.
