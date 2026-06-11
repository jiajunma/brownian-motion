# BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean

## deterministic Brownian quadratic variation helpers
### Attempt 1
- **Approach:** Added the deterministic time process `brownianDeterministicTime` and proved the required predictable-decomposition side conditions directly: strong adaptedness, strong predictability, strong progressivity, càdlàg paths, global/local integrable running supremum, pathwise monotonicity, and zero initial value.
- **Result:** RESOLVED
- **Key declarations:**
  - `ProbabilityTheory.brownianDeterministicTime`
  - `ProbabilityTheory.isCadlag_brownian_sq_sub_time`
  - `ProbabilityTheory.stronglyAdapted_brownianDeterministicTime`
  - `ProbabilityTheory.isStronglyPredictable_brownianDeterministicTime`
  - `ProbabilityTheory.isStronglyProgressive_brownianDeterministicTime`
  - `ProbabilityTheory.isCadlag_brownianDeterministicTime`
  - `ProbabilityTheory.monotone_brownianDeterministicTime`
  - `ProbabilityTheory.brownianDeterministicTime_bot_eq_zero`
  - `ProbabilityTheory.hasIntegrableSup_brownianDeterministicTime`
  - `ProbabilityTheory.hasLocallyIntegrableSup_brownianDeterministicTime`
- **Key insight:** The running supremum of `s ↦ s` up to deterministic `t` is bounded by the constant `‖(t : ℝ)‖ₑ`, so `Integrable.of_mem_Icc_enorm` closes global integrability under finite measure; `Locally.of_prop` then gives the local version.

## quadraticVariation_brownian
### Attempt 1
- **Approach:** Proved the fixed-time a.e. theorem from the normalized decomposition
  `‖brownian s ω‖ ^ 2 = (brownian s ω ^ 2 - (s : ℝ)) + (s : ℝ)`.
  The martingale part is supplied by `martingale_brownian_sq_sub_time`; the predictable part is `brownianDeterministicTime`; the comparison uses `IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition`.
- **Result:** RESOLVED
- **Statement added exactly:**
  `ProbabilityTheory.quadraticVariation_brownian (t : ℝ≥0) :
    brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`.
- **No new gaps:** No `sorry`, `axiom`, `admit`, or theorem-statement weakening was introduced in the assigned file.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: passed with no output.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: passed; pre-existing warning at line 64 uses `sorry`.
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: passed; pre-existing warnings at lines 705 and 917 use `sorry`.
- `lake build`: passed. Remaining warnings are pre-existing project `sorry` warnings in non-target files and the existing `QuadraticVariation.lean` gap; no new warning remains in `QuadraticVariationBrownian.lean`.
