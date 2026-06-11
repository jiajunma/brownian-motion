# Iteration 023 Plan

## State Collected

- No user hints were supplied. The iter 022 sidecar has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- No prior blueprint-doctor structural findings were injected this iteration.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed:
  `MeasureTheory.Martingale.integral_mul_increment_eq_zero_of_stronglyMeasurable`,
  `MeasureTheory.Martingale.integral_increment_mul_increment_eq_zero`,
  `MeasureTheory.Martingale.integral_mul_increment_eq_zero`,
  `MeasureTheory.ae_eq_zero_of_integral_sq_eq_zero`, and the terminal zero-square-integral-to-a.e.-zero helper
  `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`.
- The active analytic bridge is now `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`. It still contains the single scoped `sorry` in the predictable finite-variation uniqueness chain.
- LSP diagnostics for `DoobMeyer.lean` report only the expected declaration warnings in the inspected range: the active reduction at line 830 and the excluded weak local Doob-Meyer theorem at line 1083. Source grep shows the corresponding `sorry` terms at lines 866 and 1088.
- `QuadraticVariationBrownian.lean` remains complete internally and the fixed-time theorem `ProbabilityTheory.quadraticVariation_brownian` is not the active target.
- No proof-journal session summaries or `PROJECT_STATUS.md` are present. No subagents are enabled for this project, so none were dispatched.

## Decision Made

Keep the prover on `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but narrow the first deliverable to the bounded-continuous zero-square-integral premise rather than asking immediately for the whole predictable-jump/localization reduction.

The reason is that the last prover round closed the conditional-expectation and orthogonality layers. The next missing mathematical layer is now the finite-partition identity plus dominated-convergence argument proving `∫ M_t^2 = 0` for bounded continuous finite-variation martingales. Once that premise exists, the already-closed terminal core turns it into `M_t = 0` a.e.

The assignment still leaves the full reduction as the public target, but acceptable progress is a fully closed helper such as
`MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`, or a strictly smaller closed deterministic-partition helper that moves the single existing gap deeper. This avoids repeating the now-closed orthogonality work and gives the next prover a concrete checkpoint.

I am not pivoting to `QuadraticVariation.lean` this iteration. The Brownian theorem is already in place, and the predictable finite-variation uniqueness bridge remains the closest transitive dependency below it.

The cheapest signal to reverse this route is a prover report showing that refining deterministic partitions cannot be stated under the current general `κ` hypotheses without changing public theorem signatures. In that case the next plan should either introduce an explicit-partition helper layer or specialize the uniqueness route needed by the Brownian dependency chain.

## Blueprint Work

- Updated `blueprint/src/chapters/doob_meyer.tex` around the predictable finite-variation uniqueness section.
- Recorded the closed martingale orthogonality helpers and the closed square-integral endpoint in the chapter.
- Added the planned helper block
  `lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`, separating the partition/dominated-convergence proof of `∫ M_t^2 = 0` from the terminal a.e.-zero wrapper.
- Revised `lem:Martingale.eq_zero_of_bounded_continuous_finiteVariation_core` so the prose matches the compiled Lean helper: it assumes square integrability and zero square integral, then proves the a.e.-zero conclusion.
- Revised `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` to route through the new square-integral helper before the terminal core.
- No external source was cited; these are project-bespoke formalization steps in the existing stochastic-integral blueprint.

## Lookup Notes

- `[source-inspected]` `MeasureTheory.Martingale.integral_mul_increment_eq_zero_of_stronglyMeasurable`
- `[source-inspected]` `MeasureTheory.Martingale.integral_increment_mul_increment_eq_zero`
- `[source-inspected]` `MeasureTheory.Martingale.integral_mul_increment_eq_zero`
- `[source-inspected]` `MeasureTheory.ae_eq_zero_of_integral_sq_eq_zero`
- `[source-inspected]` `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_core`
- `[source-inspected]` `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound`
- `[source-inspected]` `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_measurable_zero_increment`
- `[source-inspected]` `LocallyBoundedVariationOn.exists_tendsto_left_univ`
- `[diagnostic]` `DoobMeyer.lean` warnings remain at declarations 830 and 1083.
