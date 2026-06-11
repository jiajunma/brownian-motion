# Project Progress

## Current Stage
prover

## Stages
- [x] init
- [x] autoformalize
- [ ] prover
- [ ] polish

## Current Objectives

1. **`BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`** — Blueprint: `chapters/stochastic_integral.tex` (definition `def:brownianQuadraticVariation`, new lemma `lem:brownianQuadraticVariation_normalized_decomposition`, and theorem `lem:quadraticVariation_brownian`).

   Run exactly this single Codex-harness prover lane. Do not continue the rejected `leastGT` helper route in `DoobMeyer.lean` this iteration.

   Primary target: decouple the Brownian fixed-time quadratic-variation theorem from the generic choice-based `ProbabilityTheory.quadraticVariation` route, following the strategy-critic and mathlib-analogist reports from this iteration.

   Required edits:

   - Refactor `ProbabilityTheory.brownianQuadraticVariation` so it is the explicit Brownian deterministic-time process, preferably
     `noncomputable abbrev brownianQuadraticVariation := brownianDeterministicTime`.
     Move it out of the `UsualConditions` section if the surrounding code permits; the direct Brownian process should not require completeness, right-continuity, or `Approximable`.
   - Add and prove a semantic certificate theorem
     `ProbabilityTheory.brownianQuadraticVariation_normalized_decomposition` packaging the already-proved content that
     `B_t^2 = (B_t^2 - t) + brownianQuadraticVariation_t`, where the first summand is a cadlag local martingale and `brownianQuadraticVariation` is strongly predictable, strongly progressive, cadlag, has locally integrable running supremum, is monotone, and starts from zero.
   - Reprove `ProbabilityTheory.quadraticVariation_brownian` directly from the explicit definition of `brownianQuadraticVariation`.

   Suggested statement shape for the new certificate:

   ```lean
   theorem brownianQuadraticVariation_normalized_decomposition
       [brownianNaturalFiltration.IsComplete gaussianLimit]
       [brownianNaturalFiltration.IsRightContinuous] :
       ∃ M : ℝ≥0 → (ℝ≥0 → ℝ) → ℝ,
         (fun t ω => ‖brownian t ω‖ ^ 2) = M + brownianQuadraticVariation ∧
         IsLocalMartingale M brownianNaturalFiltration gaussianLimit ∧
         (∀ ω, IsCadlag (M · ω)) ∧
         IsStronglyPredictable brownianNaturalFiltration brownianQuadraticVariation ∧
         IsStronglyProgressive brownianNaturalFiltration brownianQuadraticVariation ∧
         (∀ ω, IsCadlag (brownianQuadraticVariation · ω)) ∧
         HasLocallyIntegrableSup brownianQuadraticVariation brownianNaturalFiltration gaussianLimit ∧
         (∀ ω, Monotone (brownianQuadraticVariation · ω)) ∧
         (∀ ω, brownianQuadraticVariation ⊥ ω = 0)
   ```

   Use `M := fun t ω => brownian t ω ^ 2 - (t : ℝ)`. The pathwise decomposition is algebra plus `Real.norm_eq_abs` and `sq_abs`; the local martingale and cadlag facts come from `martingale_brownian_sq_sub_time`, `Martingale.IsLocalMartingale`, and `isCadlag_brownian_sq_sub_time`; the predictable/progressive/cadlag/integrable/monotone/bottom facts are exactly the existing deterministic-time lemmas, after unfolding `brownianQuadraticVariation`.

   Soundness constraint: this round proves a Brownian-specific canonical quadratic-variation process and its Brownian decomposition certificate. It must not report the generic `ProbabilityTheory.quadraticVariation`, `IsLocalMartingale.isLocalSubmartingale_sq_norm`, predictable finite-variation uniqueness, or weak local Doob-Meyer existence as closed. A later generic comparison theorem may identify `quadraticVariation isLocalMartingale_brownian isCadlag_brownian` with the direct Brownian process once the generic debts close, but that comparison is not a target this round.

   Verification: run `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`; if it passes, run `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`, `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, and then `lake build`. The task result must report whether `quadraticVariation_brownian` now avoids transitive use of the generic `quadraticVariation` definition and must list the remaining generic `sorry` lines.

## Deferred Queue

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean` still has the active predictable finite-variation uniqueness gap at `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`. The prior planned `leastGT` norm-level input package is explicitly deferred after strategy-critic and mathlib-analogist feedback: do not add more general-`κ` helper layers until the real-time FV uniqueness kernel is split.
- `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`. The known proof route needs the finite-measure/usual localization context and a bounded-stopping/local square-integrability refinement; the current global helper statement is overgeneral for that route.
- `BrownianMotion/StochasticIntegral/DoobMeyer.lean` still has the original weak local Doob-Meyer decomposition theorem. Return to it after the predictable finite-variation uniqueness bridge and the generic quadratic-variation dependency are repaired.
- The earlier Standard Borel, compact-system, optional-sampling, local-stability, Komlós, square-integrable convergence, uniform-integrability, and càdlàg-modification objectives remain deferred while the Brownian quadratic-variation dependency chain is active.
