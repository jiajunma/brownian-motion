# Iteration 033 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-032/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor report in the invocation says there are no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed:
  - `MeasureTheory.Martingale.eq_zero_on_event_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
  - `MeasureTheory.ae_eq_zero_of_eventually_event_zero_exhaustion`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at declaration line `1538` with the actual `sorry` at line `1574`. The original weak local Doob-Meyer theorem remains at declaration line `1791` with the actual `sorry` at line `1796`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Proof-journal session 32 records the same mathematical result, but its current-session preprocessor still incorrectly reports `no_prover_lane: true`; I used the task result/raw review as reliable evidence.
- Reference check: re-read the local project sources available for this route: `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` section. The new localized-family helpers are project-bespoke, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.

## Soundness Check

The closed event-localized wrapper and exhaustion helper are sound bookkeeping: they do not create mesh partitions, do not remove the deterministic variation bound, and do not use predictability beyond previously proved terminal agreement hypotheses.

The next unsafe shortcut is still to instantiate the full predictable finite-variation reduction directly. That proof needs at least bounded/stopped localization, deterministic bounds, variation-bound localization, continuity/mesh management, and predictable jump removal. The next safe split is therefore a countable localized-family wrapper: if a covering family of localized martingales already satisfies the bounded continuous variation-bound hypotheses and agrees with the original process on the covering events, then the original terminal value is zero almost surely.

After that, a stopped-process specialization can turn events of the form `(t : WithTop κ) < τ n ω` into terminal agreement with the stopped process. This still keeps deterministic bounds and mesh hypotheses explicit; it does not claim those hypotheses are automatically produced by a localizing sequence.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, not `QuadraticVariation.lean`. The Doob-Meyer route remains the active bottleneck, and the next target packages the just-closed event/exhaustion lemmas into the form needed by stopped localization.

I updated `blueprint/src/chapters/doob_meyer.tex` to add:

- `lem:Martingale.eq_zero_of_localized_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, the countable localized-family wrapper.
- `lem:Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`, the stopped-process specialization using events `{ω | (t : WithTop κ) < τ n ω}`.

The prover objective asks first for the localized-family wrapper. If it closes quickly, the prover should add the stopped-process specialization. It should not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` monolithically this round.

The cheapest signal to reverse course would be if the stopped-process specialization exposes a missing general stopped-process identity or a typeclass mismatch around `WithTop` stopping. In that case, the next plan should isolate that stopped-process equality as its own small helper before returning to variation-bound localization.

## Subagent Skips

- No subagents are enabled in `.archon/config.json`; the classic single-agent loop is in use.
