# Iteration 032 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-031/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor report in the invocation says there are no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed:
  - `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
  - `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at declaration line `1496` with the actual `sorry` at line `1532`. The original weak local Doob-Meyer theorem remains at declaration line `1749` with the actual `sorry` at line `1754`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read the local project sources available for this route: `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` section. The new event-localized and exhaustion helpers are project-bespoke, so no external citation block was added.
- Proof-journal session 31 records the same mathematical result, but its current-session preprocessor still incorrectly reports `no_prover_lane: true`; I used the task result/raw review as reliable evidence.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.

## Soundness Check

The closed continuous-path wrapper is sound because it still keeps the deterministic variation bound and explicit deterministic entourage-mesh hypothesis. It does not prove mesh existence or remove the variation bound.

The next unsafe shortcut would be to jump directly to the full predictable finite-variation reduction. That proof still mixes predictable jump removal, bounded localization, variation-level localization, deterministic mesh management, and terminal zero transfer. The next safe split is therefore an event-localized wrapper: apply the closed bounded theorem to a localized process with deterministic `C` and `V`, then conclude zero for the original process only on the event where the localized process agrees with it. A separate countable-exhaustion helper then removes such events when they cover almost every sample point.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, not `QuadraticVariation.lean`. The Doob-Meyer route is still converging, but the next target should move from bounded terminal zero to localization glue instead of adding another continuity/modulus wrapper.

I updated `blueprint/src/chapters/doob_meyer.tex` to add:

- `lem:Martingale.eq_zero_on_event_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, the event-localized bounded wrapper.
- `lem:MeasureTheory.ae_eq_zero_of_eventually_event_zero_exhaustion`, the countable exhaustion step for local zero statements.

The prover objective asks first for the event-localized wrapper. If it closes quickly, the prover should add the exhaustion helper. It should not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` monolithically this round.

The cheapest signal to reverse course would be if the event-localized wrapper cannot be stated without awkwardly changing the existing closed bounded theorem's hypotheses. In that case, the next plan should target a smaller pure a.e.-logic helper first, then return to stopped/localized process structure.

## Subagent Skips

- No subagents are enabled in `.archon/config.json`; the classic single-agent loop is in use.
