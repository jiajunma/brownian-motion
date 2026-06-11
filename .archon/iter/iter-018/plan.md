# Iteration 018 Plan

## State Collected

- No user hints were supplied. The iter 017 sidecar declares no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The latest prover result made concrete Doob-Meyer progress. It closed `MeasureTheory.condExp_ae_eq_zero_of_ae_eq_zero` and `LocallyBoundedVariationOn.exists_tendsto_left_univ`.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_condExp_zero` now compiles as a wrapper: it applies conditional expectation to the a.e. zero statement supplied by `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero`.
- The one remaining new uniqueness gap is now `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero` at `DoobMeyer.lean:631`, with its `sorry` at line 664. The older weak local Doob-Meyer theorem remains open at `DoobMeyer.lean:819`.
- The prover reported successful checks for `DoobMeyer.lean`, both downstream quadratic-variation files, and `lake build`.
- There are still no proof-journal session summaries or recommendations; only `proof-journal/current_session/attempts_raw.jsonl` is present, and it contains no actionable prover recommendations.
- Fresh lookup this iteration confirmed `[verified]` `MeasureTheory.condExp_congr_ae`, `[verified]` `MeasureTheory.condExp_zero`, `[verified]` `tendsto_leftLim_of_tendsto`, `[verified]` `eVariationOn._root_.BoundedVariationOn.exists_tendsto_left`, and `[verified]` `eVariationOn._root_.BoundedVariationOn.tendsto_eVariationOn_Ioc_zero`.
- Source inspection this iteration confirmed the current project declarations `MeasureTheory.condExp_ae_eq_zero_of_ae_eq_zero`, `LocallyBoundedVariationOn.exists_tendsto_left_univ`, `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero`, and `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_past_condExp_zero`.
- No subagents are enabled for this project, so no subagent skip section is required.
- The processed prover result was merged into `task_pending.md` and `task_done.md`, archived to `logs/iter-018/task_results-archive/`, and cleared from `task_results/`.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but target the fixed-time value-zero lemma rather than the now-closed conditional-expectation wrapper.

This route is still converging. The previous round closed two real support lemmas and moved the residual from a conditional-expectation statement to the mathematically central fixed-time assertion. The remaining proof is the same jump-removal plus continuous finite-variation square-increment argument, now stated at the right level.

I am not pivoting to `QuadraticVariation.lean` this iteration. The Brownian identification is still blocked by predictable finite-variation uniqueness, and the current gap is narrower than the prior `past_condExp_zero` objective. I am also not dispatching the prover on the weak local Doob-Meyer decomposition, because that theorem packages the longer Komlos/optional-sampling route and is not the immediate blocker for normalized predictable-part comparison.

The cheapest signal to reverse this route would be a prover result showing that neither deterministic jump removal nor the bounded continuous finite-variation helper can be closed without first formalizing substantial optional-sampling or quadratic-variation infrastructure. In that case the next plan should pivot to the queued square-norm/local square-integrability prerequisite or restructure the uniqueness theorem around a weaker deterministic-time comparison sufficient for Brownian quadratic variation.

## Blueprint Work

- Added `lem:condExp_ae_eq_zero_of_ae_eq_zero` to `blueprint/src/chapters/doob_meyer.tex`.
- Added `lem:LocallyBoundedVariationOn.exists_tendsto_left_univ` to record the closed left-limit packaging lemma.
- Added `lem:Martingale.eq_zero_of_predictable_finiteVariation_value_zero`, matching the new deepest Lean split and carrying the jump-removal plus bounded continuous finite-variation square-increment proof.
- Rewrote `lem:Martingale.eq_zero_of_predictable_finiteVariation_past_condExp_zero` as a short reduction through `value_zero` and the conditional-expectation endpoint.
- No external source was used; these are project-local stochastic-process infrastructure statements.

## Prover Scope

Assign one file: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_value_zero`.

If the full lemma is still too large, the prover should close at least one substantive helper before leaving any `sorry`. Preferred helper targets are:

- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_no_predictable_jumps`, using the closed past-measurable increment helper plus `LocallyBoundedVariationOn.exists_tendsto_left_univ` and càdlàg limits.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous`, for the bounded continuous finite-variation martingale case on a fixed finite horizon.
- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_sq_increment_sum_tendsto_zero`, for the pathwise square-increment estimate along refining deterministic partitions.

A remaining `sorry`, if unavoidable, should be in the deepest honest analytic helper, not in `value_zero`, `past_condExp_zero`, the public analytic wrapper, the public non-initial theorem, the stopped-local wrapper, or the normalized predictable-part comparison.

Non-targets:
Do not work on `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, `ProbabilityTheory.quadraticVariation_brownian`, or the weak local Doob-Meyer decomposition this iteration.
