# Iteration 006 Plan

## State Collected

- The user hint explicitly keeps the route on normalized Doob-Meyer infrastructure toward `ProbabilityTheory.quadraticVariation_brownian`; Brownian independent-increment work, Standard Borel work, and unrelated foundation tasks remain out of scope.
- The previous prover round did not close either gap inside
  `ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`, but it did add two useful compiled helpers in `DoobMeyer.lean`:
  `MeasureTheory.Martingale.add_const_fun` and
  `ProbabilityTheory.runningSup_norm_sub_const_le`.
- `doob_meyer_normalized` still has exactly two closure sorries after the original weak `doob_meyer` sorry. Its decomposition algebra, càdlàg branches, progressivity branch, monotonicity branch, and bottom-value branch are already closed.
- The local martingale shift gap is now isolated to simultaneous localization and stopped-martingale stability. The available project lemma `isStable_martingale` carries finite-measure, approximability, and topological assumptions that are not present in the current normalized theorem signature.
- The locally integrable-sup shift gap has the pathwise domination lemma available. The remaining obstruction is the `HasStronglyMeasurableSupProcess` part of `HasIntegrableSup` for the shifted stopped process.

## Decision Made

Dispatch `BrownianMotion/StochasticIntegral/DoobMeyer.lean` again, but make the primary target the locally integrable-sup gap rather than another equal two-gap pass.

This is the best chance to close one gap outright this iteration: the prover now has the exact running-sup estimate needed for integrability, and the monotone normalized stopped paths may allow the running norm supremum to be identified with the stopped shifted value. If that measurability transport still needs assumptions absent from the theorem, the fallback is not to add a new broad helper, but to prove the smallest compiled `HasIntegrableSup`/`HasLocallyIntegrableSup` shift lemma under the exact missing assumptions and report them.

The local martingale shift gap remains secondary. The compiled non-local helper `MeasureTheory.Martingale.add_const_fun` confirms the sigma-finite-filtration route after localization, but the current blocker is stopped-martingale stability under the theorem's weak assumptions.

## Blueprint Work

- Added blueprint blocks for `lem:Martingale.add_const_fun` and
  `lem:runningSup_norm_sub_const_le` in `blueprint/src/chapters/doob_meyer.tex`.
- Updated `thm:local_doobMeyer_normalized` so its proof sketch refers to those helper lemmas and explains that integrability follows from the running-sup domination while strong measurability is the remaining transport step.
- No external source was used; these are project-local algebra and localization facts around the existing Doob-Meyer statement.

## Prover Scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
close the `HasLocallyIntegrableSup (A - C) 𝓕 P` branch inside
`ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`, preserving all existing signatures and adding no new `sorry`s.

Fallback if the theorem signature is too weak:
prove the smallest compiled helper under the exact missing assumptions, preferably a `HasIntegrableSup` or `HasLocallyIntegrableSup` shift lemma using
`ProbabilityTheory.runningSup_norm_sub_const_le`, and record the missing assumptions precisely in the task result.

Secondary target:
only after the integrable-sup branch closes or its exact obstruction is isolated, revisit `IsLocalMartingale (M + C) 𝓕 P` using
`MeasureTheory.Martingale.add_const_fun` after simultaneous localization.

## Subagent Skips

- No subagents are enabled for this project, so the classic single-agent path is used.

## Verification

- Source inspection confirmed `HasLocallyIntegrableSup` is `Locally HasIntegrableSup`, `HasIntegrableSup` includes `HasStronglyMeasurableSupProcess`, `isStable_hasLocallyIntegrableSup` requires `[SecondCountableTopology ι]`, and `MeasureTheory.Martingale.add_const_fun` requires `[SigmaFiniteFiltration P 𝓕]`.
- `git diff --check` passed.
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed with only the known `sorry` warnings at the weak `doob_meyer` theorem and `doob_meyer_normalized`.
- No `.lean` files were edited by the plan agent.
