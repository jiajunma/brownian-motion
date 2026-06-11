# Iteration 012 Plan

## State Collected

- No user hints were supplied this iteration, and `iter-011/plan.md` declares no user-silent fallback.
- The iter 011 prover result resolved the assigned Doob--Meyer interface repair. `MeasureTheory.IsStronglyPredictable.const_fun` and `.sub` now compile, the weak `doob_meyer` witness includes `IsStronglyPredictable` for the increasing part, `doob_meyer_normalized` threads that field through the normalization shift, and `ProbabilityTheory.IsLocalSubmartingale.isStronglyPredictable_predictablePart` compiles.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, both downstream quadratic-variation files, and `lake build` passed. I independently spot-checked `DoobMeyer.lean`; it passes with the expected single warning for the original weak decomposition `sorry`.
- `task_pending.md` still described the pre-repair interface blocker, so I updated it. `task_done.md` now records the predictability propagation as resolved.
- There are still no proof-journal session summaries or recommendations, only `current_session/attempts_raw.jsonl`.
- Local search/source inspection verified the relevant base facts for the next route: `MeasureTheory.Martingale.eq_zero_of_predictable'` exists for discrete predictable martingales, `MonotoneOn.locallyBoundedVariationOn` exists for real-valued monotone paths, and finite measures supply `SigmaFiniteFiltration`.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, now targeting the uniqueness layer rather than returning immediately to Brownian quadratic variation.

The reason is mathematical rather than syntactic: the Brownian identity cannot honestly identify the choice-based predictable part with deterministic time until the normalized Doob--Meyer decomposition has a fixed-time a.e uniqueness theorem. The just-completed predictable witness/accessor repair was exactly the prerequisite for that theorem.

I considered pivoting to the older `QuadraticVariation.lean` squared-norm local-submartingale sorry. That remains a real prerequisite for a fully sorry-free quadratic-variation development, and the current statement is likely too weak outside a finite-measure context. I am not assigning it this round because the active route just unlocked the Doob--Meyer uniqueness proof, and jumping to the Brownian theorem would still be blocked without it.

The cheapest signal to reverse this route would be a prover result showing that the continuous-time predictable finite-variation uniqueness theorem reduces only to a large missing stochastic-calculus construction with no closeable helper lemmas. In that case the next plan should pivot to the squared-norm local-submartingale prerequisite or a smaller finite-variation/stopping-time infrastructure objective.

## Blueprint Work

- Expanded `blueprint/src/chapters/doob_meyer.tex` for `thm:IsLocalMartingale.eq_zero_of_predictable_finiteVariation` so the proof explicitly separates localization, the true-martingale case, the discrete predictable-martingale base theorem, and the finite-variation bridge.
- Refined `lem:predictablePart_eq_of_normalized_decomposition` to say the finite-variation input for `A' - A` comes from monotone real-valued paths and stability of locally bounded variation under subtraction.
- No external source was used; these are project-local stochastic-process API statements. The relevant local blueprint chapter was reread and revised before assigning the prover.

## Prover Scope

Assign one file: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
`ProbabilityTheory.IsLocalMartingale.eq_zero_of_predictable_finiteVariation`, with a fixed-time a.e conclusion. The theorem must include predictability and a locally bounded-variation path hypothesis; it must not assert pointwise equality.

Secondary target:
`ProbabilityTheory.IsLocalSubmartingale.predictablePart_eq_of_normalized_decomposition`, also fixed-time a.e, only after the uniqueness theorem is closed or reduced to one clearly isolated analytic gap.

Useful closeable helpers include `IsLocalMartingale.sub` and finite-variation closure for the difference of two nondecreasing real-valued paths. The prover should not use an unproved uniqueness theorem to prove any Brownian result.

Non-targets:
do not work on `QuadraticVariation.lean` or `QuadraticVariationBrownian.lean`; do not attempt `ProbabilityTheory.quadraticVariation_brownian`; do not revisit the completed predictable witness/accessor repair unless a direct projection bug appears.

## Processed Results

- Processed `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md`.
