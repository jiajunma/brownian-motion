# Iteration 007 Plan

## State Collected

- The user hint keeps the route on normalized Doob-Meyer infrastructure toward
  `ProbabilityTheory.quadraticVariation_brownian`; Brownian independent
  increments, Standard Borel work, and compact-system tasks remain out of
  scope.
- The previous prover round added two compiled helpers in
  `BrownianMotion/StochasticIntegral/DoobMeyer.lean`:
  `ProbabilityTheory.HasIntegrableSup.sub_const_fun` and
  `ProbabilityTheory.HasLocallyIntegrableSup.sub_initial`.
- LSP diagnostics for `DoobMeyer.lean` report only two declarations using
  `sorry`: the original weak
  `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` and
  `ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`.
- The normalized theorem still has two internal gaps: the local-martingale
  closure for `M + C`, and the locally-integrable-sup closure for `A - C`,
  where `C t ω = A ⊥ ω`.
- The locally-integrable-sup closure is now isolated. The helper
  `HasLocallyIntegrableSup.sub_initial` proves it under
  `ConditionallyCompleteLinearOrderBot`, `BorelSpace`, `PolishSpace`,
  finite measure, filtration completeness, and right-continuity. Those
  assumptions are not in the current normalized theorem context.
- The remaining local-martingale closure has available infrastructure:
  `MeasureTheory.Martingale.add_const_fun`,
  `ProbabilityTheory.isStable_martingale`,
  `MeasureTheory.Martingale.stoppedProcess_indicator`,
  `MeasureTheory.IsLocalizingSequence.min`, and the Mathlib finite-measure
  instance for `SigmaFiniteFiltration`. The stopped-martingale route needs
  assumptions such as finite measure, approximability, second countability,
  Borel time index, and pseudo-metrizability, which are also absent from the
  current normalized theorem signature.

## Decision Made

Dispatch `BrownianMotion/StochasticIntegral/DoobMeyer.lean` again, but do not
ask the prover to rework the integrable-sup branch. That branch has been
reduced to a compiled usual-condition helper plus a theorem-signature
blocker.

The next prover target is the first normalized theorem gap:
`IsLocalMartingale (M + C) 𝓕 P`. The best route is a common-localization
helper: combine the localizing sequence for `M` with the localizing sequence
for the locally integrable running supremum of `A`, prove integrability and
bottom-measurability of the stopped initial value, then apply
`MeasureTheory.Martingale.add_const_fun` to the stopped martingale.

If this helper compiles only under assumptions missing from
`doob_meyer_normalized`, the prover should report the normalized theorem as a
signature blocker rather than adding more theorem-body placeholders. This is
the smallest honest progress under the user's hint: it closes or precisely
isolates one of the two remaining normalized theorem gaps.

The cheapest signal to reverse this route is a compiled proof of the
local-martingale closure in the current weak context. Otherwise the next
strategy decision should be whether the Doob-Meyer layer can expose the usual
finite-measure/topological assumptions without changing protected signatures.

## Blueprint Work

- Added blueprint blocks for
  `lem:HasIntegrableSup.sub_const_fun` and
  `lem:HasLocallyIntegrableSup.sub_initial`.
- Updated `thm:local_doobMeyer_normalized` so its proof cites the new local
  integrable-sup helper and explicitly records that the formal closure lemmas
  are currently available under usual-condition hypotheses.
- No external source was used. The changes are project-local normalization
  algebra around the existing Doob-Meyer statement, and I reread the relevant
  Lean and blueprint sections.

## Prover Scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
close or isolate the local-martingale closure
`IsLocalMartingale (M + C) 𝓕 P` inside
`ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`.

Fallback if the theorem context is too weak:
prove the smallest compiled helper under the exact assumptions needed for the
local-martingale shift by the initial value, and record those assumptions in
the task result. The expected assumptions include finite measure,
approximability, second countability, Borel time index, and
pseudo-metrizability; the prover should report the exact compiled list.

The prover should preserve all existing declaration signatures, add no new
`sorry`s, avoid the predictable-part uniqueness theorem, and run
`lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`; run
`lake build` if a gap closes or a helper is added.

## Subagent Skips

- No subagents are enabled for this project, so the classic single-agent path
  is used.

## Verification

- Collected
  `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md`;
  it reports `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
  and `lake build` succeeded after the new helpers.
- Reran `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`;
  it succeeds with the two expected `sorry` warnings.
- LSP diagnostics for `DoobMeyer.lean` show only `doob_meyer` and
  `doob_meyer_normalized` use `sorry`.
- LSP/source inspection verified the key declarations named in the next
  objective: `MeasureTheory.Martingale.add_const_fun`,
  `ProbabilityTheory.isStable_martingale`,
  `MeasureTheory.Martingale.stoppedProcess_indicator`,
  `MeasureTheory.IsLocalizingSequence.min`, and the finite-measure
  `SigmaFiniteFiltration` instance.
