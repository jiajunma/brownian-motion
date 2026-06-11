# Iteration 020 Plan

## State Collected

- User hint directs this iteration toward `ProbabilityTheory.quadraticVariation_brownian`, specifically the fixed-time theorem
  `brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`, and asks not to spend the whole round only deepening the Doob-Meyer analytic bridge unless required.
- The latest prover result for `DoobMeyer.lean` closed the deterministic finite-variation square-increment helpers:
  `BoundedVariationOn.sum_norm_sub_le_toReal_eVariationOn`,
  `BoundedVariationOn.sq_increment_sum_le_uniform_bound`, and
  `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound`.
- The remaining predictable finite-variation uniqueness gap has moved to
  `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`.
  `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero` and all downstream uniqueness wrappers have no internal `sorry` beyond that dependency.
- `QuadraticVariationBrownian.lean` still compiles through `brownianQuadraticVariation` under the usual Brownian filtration assumptions, and `ProbabilityTheory.quadraticVariation_brownian` is still absent.
- There are no proof-journal session summaries or recommendations present under `.archon/proof-journal/sessions/`.
- No subagents are enabled for this project, so none were dispatched.
- After processing, `.archon/task_results/` is empty. The Doob-Meyer result was no longer present when archival cleanup ran; the latest Doob-Meyer task-result archive visible on disk is under `logs/iter-019/`.

## Decision Made

Pivot the prover objective to `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` and ask for the fixed-time Brownian quadratic-variation theorem now.

The decisive reason is that the theorem can be obtained from the already available normalized predictable-part comparison API:
`ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition`.
That theorem still has a transitive dependency on the bounded-continuous uniqueness bridge, but the user explicitly requested this route and the Brownian theorem itself should not require additional analytic uniqueness work. This also creates the public Brownian checkpoint the project has been circling around.

The theorem must remain a fixed-time a.e equality, not pointwise equality of the choice-based predictable part. The later indistinguishability upgrade remains deferred until the project has the needed càdlàg equality/modification theorem.

The cheapest signal to reverse this pivot is a prover result showing that `quadraticVariation_brownian` cannot even be stated or typechecked from the existing normalized comparison theorem without changing upstream signatures. In that case the next plan should return immediately to the bounded-continuous Doob-Meyer bridge.

## Blueprint Work

- Read `blueprint/src/content.tex` and the consolidated chapter `blueprint/src/chapters/stochastic_integral.tex`, which covers `QuadraticVariation.lean` and `QuadraticVariationBrownian.lean`.
- Updated the `brownianDeterministicTime_progressive` proof sketch to use the verified right-continuous strongly adapted process criterion rather than an unverified predictable-to-progressive shortcut.
- Tightened the `quadraticVariation_brownian` statement in the blueprint to the exact fixed-time Lean target:
  `brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`.
- Updated `blueprint/src/chapters/doob_meyer.tex` with the square-increment helper lemmas and the bounded-continuous bridge now isolated by the prover result.
- No external source was cited; these are project-bespoke formalization steps already described by the local blueprint.

## Lookup Notes

- `[verified]` `MeasureTheory.StronglyAdapted.isStronglyPredictable_of_leftContinuous`
- `[verified]` `MeasureTheory.StronglyAdapted.isStronglyProgressive_of_rightContinuous`
- `[verified]` `Continuous.isCadlag`
- `[verified]` `ProbabilityTheory.Martingale.IsLocalMartingale`
- `[verified]` `ProbabilityTheory.continuous_brownian`
- `[verified]` `ProbabilityTheory.HasStronglyMeasurableSupProcess`
- `[verified]` `ProbabilityTheory.HasIntegrableSup`
- `[verified]` `ProbabilityTheory.HasLocallyIntegrableSup`
- `[verified]` `ProbabilityTheory.IsLocalizingSequence`
- `[verified]` `MeasureTheory.isStoppingTime_const`
- `[verified]` `MonotoneOn.locallyBoundedVariationOn`

## Objectives Written

`PROGRESS.md` now assigns only `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`.
The objective asks the prover to add the deterministic time-process helpers and prove
`ProbabilityTheory.quadraticVariation_brownian (t : ℝ≥0) :
  brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`.

`DoobMeyer.lean` is deferred this iteration except for a hard dependency failure in the Brownian file.
