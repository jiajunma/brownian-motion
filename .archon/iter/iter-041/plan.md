# Iteration 041 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-040/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.stronglyMeasurable_leftLim_past_of_left_approach` and `MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2049` and the actual `sorry` at line `2085`. The original weak local Doob-Meyer theorem remains with the actual `sorry` at line `2307`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` regions. The next lemmas are project-bespoke measure-theoretic bookkeeping around the generated past sigma-algebra, so no external citation block was added.
- No subagents are enabled for this project, so none were dispatched.
- I processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` into `task_pending.md` and `task_done.md`. I did not delete or edit the result file because the Codex-local role table gives the plan agent read/collect access, not write access, to `task_results/`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## Soundness Check

The newly closed past-sigma measurability lemmas are honest: they prove measurability only with respect to `⨆ s : {s // s < t}, 𝓕' s`, and do not upgrade strong predictability to fixed earlier-time measurability.

The next target should not assert jump vanishing from measurability alone. The sound reduction is: if an integrable random variable is strongly measurable with respect to the generated past sigma-algebra and has zero integral over every earlier-filtration set, then it is zero a.e. This uses the linear-order filtration structure: the earlier-filtration generator is a pi-system, and Dynkin induction extends zero integrals to the generated past sigma-algebra. The martingale jump specialization must keep both integrability of the jump and zero earlier-set integrals as explicit hypotheses.

This still leaves the real analytic step separate: proving those earlier-set integrals are zero for the predictable jump, likely by a martingale/left-limit limit argument with domination or localization.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with the generated-past zero-integral package:

- `MeasureTheory.Filtration.ae_eq_zero_of_past_setIntegral_eq_zero`
- `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero`

I chose this over directly assigning the full past conditional-expectation identity because local search found no ready `condExp` continuity theorem for `⨆ s<t, 𝓕' s`; the available `MeasureTheory.tendsto_condExp_unique` works at a fixed sigma-algebra and does not bridge from all earlier `𝓕_s` to the generated past sigma-algebra by itself. The pi-system uniqueness lemma is the missing measure-theoretic conversion that makes the next analytic integral-zero obligation precise.

The cheapest signal that would make me reverse this choice is a prover result showing `MeasurableSpace.induction_on_inter` is impractical for the filtration generator in this file. In that case the next plan should isolate the pi-system/generator lemma in an even more abstract measure-theory statement or add the required import/API wrapper first.

## Strategy Update

Updated `STRATEGY.md` to describe the active predictable finite-variation phase as a generated-past jump split: closed past measurability is followed by pi-system/Dynkin uniqueness and then the still-open earlier-set integral-zero argument.

## Blueprint Updates

Updated `blueprint/src/chapters/doob_meyer.tex` with:

- `lem:Filtration.ae_eq_zero_of_past_setIntegral_eq_zero`, with `\lean{MeasureTheory.Filtration.ae_eq_zero_of_past_setIntegral_eq_zero}`.
- `lem:Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero`, with `\lean{MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero}`.
- Added these lemmas to the `\uses{...}` lists and proof prose for `lem:Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` and `lem:Martingale.eq_zero_of_predictable_finiteVariation_value_zero`.

The proof sketch says: the class of earlier-filtration measurable sets is a pi-system because the filtration is linearly ordered; it generates the past sigma-algebra; Dynkin induction extends zero integrals from this generator to all past-measurable sets; then the standard Bochner integral uniqueness theorem makes an integrable past-measurable random variable zero a.e. The jump specialization applies this to `N_t - N_{t-}` using the closed past-sigma jump measurability lemma.

## Objective Set

Assigned one prover objective:

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean`: add and prove `MeasureTheory.Filtration.ae_eq_zero_of_past_setIntegral_eq_zero` and `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero` immediately after `MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach`.

Verified this iteration by Lean local search/source inspection: `MeasurableSpace.induction_on_inter`, `IsPiSystem`, `MeasurableSpace.measurableSpace_iSup_eq`, `MeasureTheory.integral_iUnion`, `MeasureTheory.setIntegral_compl`, `MeasureTheory.ae_eq_zero_of_forall_setIntegral_eq_of_sigmaFinite'`, and `MeasureTheory.ae_eq_zero_of_forall_setIntegral_eq_of_finStronglyMeasurable_trim`.
