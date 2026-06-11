# Iteration 037 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-036/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor report in the invocation says there are no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `1890` and the actual `sorry` at line `1926`. The original weak local Doob-Meyer theorem remains at declaration line `2143`, with the actual `sorry` at line `2148`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next stopped/indicator continuity-transfer lemma is project-bespoke, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read-only access to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but stop adding wrappers around the same stopped-bound package. The next target is the analytic construction lemma `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc`: if an original path is continuous on `[⊥, t]`, then its stopped/indicator path is continuous on `[⊥, t]`.

This is narrower than the full predictable finite-variation reduction, but it removes a real hypothesis from the localization layer. It is also honest: it transfers continuity from already continuous paths only, and does not claim that càdlàg stopped paths are continuous before predictable jumps are removed.

The cheapest signal that would make me reverse this choice is a prover result showing that the stopped-coordinate continuity is blocked by missing `WithTop`/order-topology API. In that case the next plan should pivot to deterministic mesh construction under an explicit specialized time index, or to a small predictable-jump lemma with a stronger explicit past-conditional-expectation hypothesis.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with:

- `lem:stoppedProcess_indicator_continuousOn_Icc`, with `\lean{MeasureTheory.stoppedProcess_indicator_continuousOn_Icc}`.
- Added this lemma to the `\uses{...}` list for `lem:Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_continuousOn`.
- Added this lemma to the `\uses{...}` list for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

The proof sketch splits on whether the indicator is active. The inactive branch is the zero path; the active infinite branch is the original path; the active finite branch composes the original continuous path with the continuous stopped-coordinate map `s ↦ min s a`.

## Soundness Check

The assigned lemma does not assert continuity for càdlàg paths. It requires original-path continuity on the horizon and proves only that stopping and multiplying by the fixed indicator preserve that continuity.

The objective leaves predictable-jump removal, deterministic variation localization, construction of bounded localizing sequences, and deterministic mesh existence as later tasks. The full `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` is explicitly not assigned this iteration.

## State Updates

- `task_done.md` now records the closed original-bound localizing-sequence wrapper.
- `task_pending.md` now names `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc` as the current Doob-Meyer split.
- `STRATEGY.md` now marks the predictable finite-variation route as active continuity transfer rather than localization packaging.
- `PROGRESS.md` now assigns only `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, backed by `chapters/doob_meyer.tex`.

