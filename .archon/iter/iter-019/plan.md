# Iteration 019 Plan

## State Collected

- The user hint explicitly asked to continue toward `ProbabilityTheory.quadraticVariation_brownian`, and to prefer the fixed-time Brownian quadratic-variation theorem over spending the whole iteration on the Doob-Meyer analytic bridge.
- The latest prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean` was processed, archived to `.archon/logs/iter-019/task_results-archive/`, and cleared from `task_results/`.
- That result closed three deterministic finite-variation square-increment lemmas: `BoundedVariationOn.sum_norm_sub_le_toReal_eVariationOn`, `BoundedVariationOn.sq_increment_sum_le_uniform_bound`, and `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound`.
- The remaining Doob-Meyer uniqueness gap has moved to `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous` at `DoobMeyer.lean:705`; `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero` now has no internal `sorry` beyond that dependency. The original weak local Doob-Meyer theorem remains at `DoobMeyer.lean:917`.
- The prover reported `lake env lean` passing for `DoobMeyer.lean`, `QuadraticVariation.lean`, and `QuadraticVariationBrownian.lean`, followed by a passing `lake build`.
- There are still no proof-journal session summaries or recommendations, and `PROJECT_STATUS.md` is absent.
- The Brownian quadratic-variation blueprint is the consolidated chapter `blueprint/src/chapters/stochastic_integral.tex`, which covers both `QuadraticVariation.lean` and `QuadraticVariationBrownian.lean`.
- Local/source inspection this iteration confirmed the relevant APIs: `MeasureTheory.StronglyAdapted.isStronglyPredictable_of_leftContinuous`, `MeasureTheory.IsStronglyPredictable.isStronglyProgressive`, `MeasureTheory.isStronglyProgressive_const`, `ProbabilityTheory.Locally.of_prop`, `ProbabilityTheory.HasStronglyMeasurableSupProcess`, `ProbabilityTheory.HasIntegrableSup`, `ProbabilityTheory.HasLocallyIntegrableSup`, `MonotoneOn.locallyBoundedVariationOn`, and `ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition`.
- No subagents are enabled for this project, so no subagent skip section is required.

## Decision Made

Pivot the active prover objective to `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` and target the fixed-time a.e theorem
`ProbabilityTheory.quadraticVariation_brownian`.

The prior Doob-Meyer route is converging, but the user hint is correct: the project already has `brownianQuadraticVariation`, `martingale_brownian_sq_sub_time`, and the normalized predictable-part comparison theorem. The Brownian theorem now mainly needs deterministic-process packaging for `fun t _ => (t : ℝ)`, plus the càdlàg helper for `B_t^2 - t`. That is a smaller and more direct checkpoint than another bounded-continuous finite-variation uniqueness round.

The theorem should be fixed-time a.e:
`brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`.
It should not be pointwise equality of the raw choice-based predictable part, and it should not attempt the pathwise indistinguishability upgrade yet.

The cheapest signal to reverse this route is a prover report showing that the final comparison cannot be applied without changing the statement of `quadraticVariation`, `brownianQuadraticVariation`, or the protected normalized comparison API. In that case the next plan should either return to the bounded-continuous Doob-Meyer bridge or assign a structural refactor to align the generic quadratic-variation definition with the comparison theorem.

## Blueprint Work

- Added `def:brownianDeterministicTime` to the Brownian quadratic-variation subsection of `blueprint/src/chapters/stochastic_integral.tex`.
- Added helper blocks for `isCadlag_brownian_sq_sub_time`, deterministic-time strong predictability, strong progressivity, càdlàg paths, locally integrable running supremum, monotonicity, and zero-at-bottom.
- Rewrote `lem:quadraticVariation_brownian` to state the fixed-time a.e equality explicitly and to spell out the normalized decomposition comparison route.
- No external source was used; these are project-local deterministic-process and Doob-Meyer-choice-layer statements.

## Prover Scope

Assign one file: `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`.

Primary theorem:
`ProbabilityTheory.quadraticVariation_brownian (t : ℝ≥0) :
  brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`.

Expected helper declarations:
`ProbabilityTheory.brownianDeterministicTime`,
`ProbabilityTheory.isCadlag_brownian_sq_sub_time`,
`ProbabilityTheory.isStronglyPredictable_brownianDeterministicTime`,
`ProbabilityTheory.isStronglyProgressive_brownianDeterministicTime`,
`ProbabilityTheory.isCadlag_brownianDeterministicTime`,
`ProbabilityTheory.hasLocallyIntegrableSup_brownianDeterministicTime`,
`ProbabilityTheory.monotone_brownianDeterministicTime`,
and `ProbabilityTheory.brownianDeterministicTime_bot_eq_zero`.

Non-targets: do not work on `DoobMeyer.lean` this iteration unless the Brownian theorem is blocked by a direct typechecking issue in the normalized comparison theorem; do not add new sorries; do not weaken the theorem to pointwise, inequality, or existential decomposition form.
