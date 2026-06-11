# Iteration 046 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-045/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound` and `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_stoppedProcess_indicator_of_left_approach_of_bound`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2404` and the actual `sorry` at line `2440`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `2662`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke stopped/original event-transfer bookkeeping, so no external citation block was added.
- API checks this iteration: local search verified `tendsto_nhdsWithin_congr`, `mem_nhdsWithin_of_mem_nhds`, `MeasureTheory.stoppedProcess_eq_of_le`, `tendsto_leftLim_of_tendsto`, `Filter.Tendsto.congr'`, `Filter.EventuallyEq.tendsto`, `tendsto_nhds_unique`, and `min_eq_left`; hover/source verification confirmed the current signatures of the two newly closed stopped jump-removal wrappers, `ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt`, and `ProbabilityTheory.IsPreLocalizingSequence.isStoppingTime`.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed stopped/localizing wrappers are sound because they apply bounded jump removal only to stopped/indicator processes after explicitly transferring martingale, predictability, local bounded variation, and deterministic horizon bounds. They do not identify the stopped left limit with the original left limit, and they do not use the localizing-sequence cover.

The next target should be only that missing stopped/original event transfer. The key point is pathwise and deterministic: on a sample point satisfying `(t : WithTop κ) < τ ω`, the set of left-near times `s` with `(s : WithTop κ) < τ ω` is a left-neighborhood of `t`, so the stopped/indicator path agrees with the original path eventually along `nhdsWithin t (Set.Iio t)`. Local bounded variation then gives the original left limit and uniqueness of limits transfers the stopped left limit to it. After this, the closed stopped jump-removal identity can be rewritten into original jump-removal on `{t < τ}`, and only then may the localizing-sequence cover be used.

This still leaves separate future obligations: constructing a deterministic left-approaching sequence in the desired time-index context, producing bounded and variation localizations, transferring or assuming horizon continuity, and managing deterministic mesh/refinement hypotheses.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with the stopped/original event-transfer package:

- `MeasureTheory.stoppedProcess_indicator_eventuallyEq_left_of_lt`
- `MeasureTheory.leftLim_stoppedProcess_indicator_eq_of_lt`
- `MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_bound`
- `MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound`

I chose this over directly attacking `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` because the full reduction still lacks sequence existence, bounded/variation localization, deterministic mesh inputs, and final square-integral packaging. The proposed package closes the exact gap exposed by the stopped wrappers without pretending those later inputs exist.

The cheapest signal that would make me reverse this choice is a prover result showing that `Function.leftLim` cannot be identified under eventual equality without stronger path assumptions on the stopped path. If that happens, the next plan should first add a stopped-path left-limit existence lemma from the same eventual equality, then retry the event-transfer wrapper.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with informal blocks for:

- `lem:stoppedProcess_indicator_eventuallyEq_left_of_lt`
- `lem:leftLim_stoppedProcess_indicator_eq_of_lt`
- `lem:Martingale.ae_eq_leftLim_on_event_of_left_approach_of_bound`
- `lem:ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt`
- `lem:Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound`

I also updated the predictable finite-variation reduction overview to name these stopped/original transfer lemmas. All are Archon-original bookkeeping lemmas and intentionally have no external source citation.
