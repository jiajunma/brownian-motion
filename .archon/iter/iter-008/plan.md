# Iteration 008 Plan

## State Collected

- The iter 007 prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean` is consistent with the user hint: `ProbabilityTheory.IsLocalMartingale.add_initial_of_hasLocallyIntegrableSup` now compiles.
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` and `lake build` succeeded in iter 007, with the known Doob-Meyer sorries still present.
- The normalized theorem still has exactly two internal closure gaps, but both are now isolated to missing assumptions:
  - `IsLocalMartingale (M + C) 𝓕 P` closes under `[SecondCountableTopology ι] [BorelSpace ι] [PseudoMetrizableSpace ι] [IsFiniteMeasure P] [Approximable 𝓕 P]`.
  - `HasLocallyIntegrableSup (A - C) 𝓕 P` closes under `[ConditionallyCompleteLinearOrderBot ι] [BorelSpace ι] [PolishSpace ι] [IsFiniteMeasure P] [𝓕.IsComplete P] [𝓕.IsRightContinuous]`.
- `archon-protected.yaml` is empty, so the normalized theorem/accessor signatures are not frozen.
- The only downstream Lean use of the choice-based predictable part found by search is the quadratic-variation definition. The runner is configured with `max_objectives = 1`, so this iter keeps the prover lane on the upstream Doob-Meyer file and asks for a full-build report on any downstream fallout.
- There are no proof-journal session summaries or recommendations yet; only the current-session raw attempt stub exists.

## Decision Made

Strengthen the normalized Doob-Meyer layer now. The helper route has converged: both closure facts are compiled, and the remaining weak signature is the blocker. Assigning another helper pass would be churn.

The theorem should gain the smallest union of usual assumptions needed by the two compiled helpers, and the choice definitions/accessors that call it should gain the same ambient assumptions. The weak `doob_meyer` theorem remains unchanged and still carries the original decomposition sorry.

The cheapest signal to reverse this decision would be a prover report showing that the strengthened normalized theorem breaks `DoobMeyer.lean` itself in a way not attributable to assumption propagation. If only downstream quadratic-variation declarations need the same assumptions, keep the normalized theorem closed and propagate downstream next iter.

## Blueprint Work

- Added the blueprint lemma `lem:IsLocalMartingale.add_initial_of_hasLocallyIntegrableSup`.
- Updated `thm:local_doobMeyer_normalized` so its informal statement and proof explicitly use the usual-hypothesis closure lemmas rather than describing a residual weak-context gap.
- No external source was used; this is project-local normalization algebra around the existing Doob-Meyer statement. I reread the README plus the relevant Lean and blueprint sections.

## Prover Scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
strengthen `ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized` and the choice/accessor declarations that depend on it with the smallest usual assumptions needed, then close the two normalized theorem sorries using:

- `ProbabilityTheory.IsLocalMartingale.add_initial_of_hasLocallyIntegrableSup`
- `ProbabilityTheory.HasLocallyIntegrableSup.sub_initial`

The expected assumption union is:
`[ConditionallyCompleteLinearOrderBot ι] [BorelSpace ι] [PolishSpace ι] [IsFiniteMeasure P] [Approximable 𝓕 P] [𝓕.IsComplete P] [𝓕.IsRightContinuous]`, with explicit `[SecondCountableTopology ι]` / `[PseudoMetrizableSpace ι]` only if Lean does not synthesize them from the Polish context.

The prover should preserve the weak `doob_meyer` statement, add no new sorries, and avoid predictable-part uniqueness. It should run `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` and then `lake build`; if full build fails downstream, the task result should name the exact downstream declarations and assumptions that need propagation.

## Subagent Skips

- No subagents are enabled for this project, so the classic single-agent path is used.

## Verification

- Source inspection verified the compiled helper signatures in `DoobMeyer.lean`.
- `rg` found current choice/accessor uses in `DoobMeyer.lean` and the quadratic-variation definition only.
- Processed the iter 007 Doob-Meyer task result into `task_pending.md` and `task_done.md`; the report file itself remains in `task_results/` because the plan-agent write-permission section marks task result files as read-only.
