# Iteration 016 Plan

## State Collected

- No user hints were supplied. The iter 015 sidecar declared no user-silent fallback, so no fallback was executed.
- The latest prover result made concrete Doob-Meyer progress. It closed `MeasureTheory.Filtration.measurable_prod_mk_predictable_past` and `MeasureTheory.IsStronglyPredictable.stronglyMeasurable_past`.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial` now compiles as a wrapper: it derives the past-measurability hypothesis from strong predictability and delegates only to `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic`.
- The one remaining new uniqueness gap is now `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic` at `DoobMeyer.lean:573`. The older weak local Doob-Meyer theorem remains open at `DoobMeyer.lean:690`.
- The prover reported successful checks for `DoobMeyer.lean`, both downstream quadratic-variation files, and `lake build`.
- There are still no proof-journal session summaries or recommendations; `PROJECT_STATUS.md` is absent.
- This iteration's local lookup confirmed `[verified]` `MeasureTheory.condExp_of_stronglyMeasurable`, `[verified]` `MeasureTheory.Martingale.condExp_ae_eq`, `[verified]` `MeasureTheory.condExp_sub`, `[verified]` `BoundedVariationOn.leftLim`, and `[verified]` `BoundedVariationOn.tendsto_eVariationOn_Ioc_zero`.
- No subagents are enabled for this project, so no subagent skip section is required.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but target the analytic-core theorem rather than the public non-initial wrapper.

This route is still converging. The last pass did not just rename the old gap: it closed the predictable-past measurability layer and made the remaining theorem carry exactly the needed sigma-algebra hypothesis. The next useful step is therefore to prove, or at least split with a closed helper, the conditional-expectation/jump-removal part inside `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic`.

I am not pivoting to `QuadraticVariation.lean` this iteration. The Brownian identification is still blocked by this uniqueness theorem, and the active route has narrowed to a genuine analytic core with supporting Mathlib APIs now visible. I am also not dispatching the prover on the weak local Doob-Meyer theorem, because that theorem packages the long Komlos/optional-sampling route and is not the immediate blocker for normalized predictable-part comparison.

The cheapest signal to reverse this route would be a prover result showing that the analytic core cannot close any helper without first formalizing substantial quadratic-variation or optional-sampling infrastructure. In that case the next plan should pivot to the queued square-norm/local square-integrability prerequisite or explicitly restructure the uniqueness theorem around a weaker deterministic-time comparison sufficient for Brownian quadratic variation.

## Blueprint Work

- Added `lem:Filtration.measurable_prod_mk_predictable_past` to `blueprint/src/chapters/doob_meyer.tex`.
- Added `lem:IsStronglyPredictable.stronglyMeasurable_past` to record the strong-predictability-to-past-measurability bridge.
- Added `thm:Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic`, matching the new Lean split and spelling out the conditional-expectation, jump-removal, and continuous finite-variation square-increment route.
- Rewrote `thm:Martingale.eq_zero_of_predictable_finiteVariation_noninitial` as a short reduction to the analytic core.
- No external source was used; these are project-local stochastic-process infrastructure statements.

## Prover Scope

Assign one file: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_noninitial_analytic`.

If the full theorem is still too large, the prover should close at least one substantive helper before leaving any `sorry`. Preferred helper targets are:

- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_measurable_zero_increment`, proving that a past-measurable martingale increment with zero conditional expectation is zero a.e.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_no_jumps`, using the explicit past-measurability hypothesis and `BoundedVariationOn.leftLim`.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`, handling the bounded continuous finite-variation martingale case on a fixed horizon.

A remaining `sorry`, if unavoidable, should be in the deepest honest analytic helper, not in the analytic-core wrapper, the public non-initial theorem, the stopped-local wrapper, or the normalized predictable-part comparison.

Non-targets:
Do not work on `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, `ProbabilityTheory.quadraticVariation_brownian`, or the weak local Doob-Meyer decomposition this iteration.
