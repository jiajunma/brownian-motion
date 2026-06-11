# BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean

## brownianQuadraticVariation
### Attempt 1
- **Approach:** Refactor the Brownian quadratic-variation process away from the generic choice-based `quadraticVariation` API and make it the explicit deterministic-time process.
- **Result:** RESOLVED.
- **Key insight:** `brownianQuadraticVariation` is now `brownianDeterministicTime` outside the usual-condition section, so it has no completeness, right-continuity, or `Approximable` dependency.

## brownianQuadraticVariation_normalized_decomposition
### Attempt 1
- **Approach:** Package `M := fun t ω => brownian t ω ^ 2 - (t : ℝ)` with the pathwise identity `‖B_t‖^2 = M_t + t`, then reuse the existing Brownian martingale, càdlàg, deterministic-time predictability/progressiveness, local-integrable-sup, monotonicity, and zero-at-bottom lemmas.
- **Result:** RESOLVED.
- **Key insight:** The proof is Brownian-specific and uses `martingale_brownian_sq_sub_time` plus deterministic-time structure, not the generic Doob-Meyer predictable-part comparison.

## quadraticVariation_brownian
### Attempt 1
- **Approach:** Reprove fixed-time equality directly from the explicit definition of `brownianQuadraticVariation`.
- **Result:** RESOLVED.
- **Key insight:** The theorem is now a pointwise `simp` proof from `brownianQuadraticVariation = brownianDeterministicTime`; it no longer uses `quadraticVariation`, `IsLocalMartingale.isLocalSubmartingale_sq_norm`, `predictablePart_eq_of_normalized_decomposition`, or any generic Doob-Meyer route transitively.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed with no warnings.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed; remaining generic `sorry`: `BrownianMotion/StochasticIntegral/QuadraticVariation.lean:84`.
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed; remaining generic `sorry`s: `BrownianMotion/StochasticIntegral/DoobMeyer.lean:3525`, `BrownianMotion/StochasticIntegral/DoobMeyer.lean:3747`.
- `lake build` passed.
