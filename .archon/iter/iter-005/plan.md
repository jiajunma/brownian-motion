# Iteration 005 Plan

## State Collected

- The previous prover added `ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized` and retargeted `martingalePart`/`predictablePart` to choose from it.
- `ProbabilityTheory.IsLocalSubmartingale.predictablePart_bot_eq_zero` now compiles and has no independent proof gap.
- `doob_meyer_normalized` still contains two explicit sorries: adding the time-constant initial value process to a local martingale, and proving `HasLocallyIntegrableSup (A - C)`.
- `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` remains closed and already contains `ProbabilityTheory.martingale_brownian_sq_sub_time`.
- `QuadraticVariation.lean` remains deferred because its local square-norm theorem lacks a `SigmaFiniteFiltration P 𝓕` hypothesis under the current signature.

## Decision Made

Dispatch `BrownianMotion/StochasticIntegral/DoobMeyer.lean` again, but narrow the objective to the two concrete closure gaps inside `doob_meyer_normalized`.

This follows the user hint and is still the shortest route toward `ProbabilityTheory.quadraticVariation_brownian`: the Brownian martingale decomposition is proved, and the choice-based predictable part is now structurally normalized except for those two closures. The prover should not work on independent increments, StandardBorel, or the full predictable-part uniqueness theorem this iteration.

The likely hard point is not algebra but missing hypotheses in Mathlib conditional expectation and measurability APIs. `MeasureTheory.martingale_const_fun` exists but requires `[SigmaFiniteFiltration P 𝓕]`, absent from the current signature. `isStable_hasLocallyIntegrableSup` exists but requires `[SecondCountableTopology ι]`, also absent. The cheapest signal to pivot is a prover report showing that one of these assumptions is genuinely necessary for the current theorem statement, after proving a smaller helper that isolates the precise obstruction.

## Blueprint Work

- Expanded the proof of `thm:local_doobMeyer_normalized` in `blueprint/src/chapters/doob_meyer.tex`.
- The proof now spells out the two closure facts: local martingale closure under adding `C_t=A_0`, and locally integrable running-sup preservation under replacing `A` by `A-C`.
- No new external reference was used; this is project-local algebra and localization around the existing Doob-Meyer theorem. I reread the project README and the relevant Doob-Meyer blueprint/Lean sections.

## Prover Scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The target is only the two sorries at lines 55 and 65 inside
`ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`.

If the prover can close both, it should run `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` and `lake build`. If either cannot be closed without changing signatures, it should leave no additional sorries, prove the smallest compiled helper that advances one closure, and record the exact missing hypothesis in the task result.

## Subagent Skips

- No subagents are enabled for this project, so the classic single-agent path is used.

## Verification

- `rg -n "sorry"` shows `DoobMeyer.lean` now has three sorries: the original weak `doob_meyer` theorem and two closure gaps in `doob_meyer_normalized`.
- Lean local search/source inspection confirmed `MeasureTheory.isStronglyProgressive_const`, `MeasureTheory.martingale_const_fun`, and `ProbabilityTheory.IsStable.locally_induction₂` exist.
- Source inspection confirmed `MeasureTheory.martingale_const_fun` currently requires `[SigmaFiniteFiltration P 𝓕]`.
