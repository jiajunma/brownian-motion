# Iteration 002 Plan

## State collected

- No prover result files or proof-journal summaries exist to merge.
- The current Lean tree contains 22 sorries, not the stale 23-sorry count from the prior plan.
- `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` now has only one sorry: the submartingale-localization proof inside `IsLocalMartingale.isLocalSubmartingale_sq_norm`.
- `IsCadlag.continuous_comp` already exists in `Cadlag.lean`, and both squared-norm càdlàg composition obligations in `QuadraticVariation.lean` are closed.
- `QuadraticVariationBrownian.lean` already contains the canonical Brownian filtration, càdlàg path lemma, martingale lemma, local martingale lemma, and the `brownianQuadraticVariation` abbreviation. It does not yet contain a theorem identifying that process with time.

## Decision made

Dispatch `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` and target the remaining `IsLocalMartingale.isLocalSubmartingale_sq_norm` proof. This is the strongest upstream compiled lemma directly supporting blueprint Lemma 13.40 before attempting a Brownian equality theorem.

The canonical Brownian quadratic-variation theorem is not ready as the first objective because the current `quadraticVariation` definition is the chosen predictable part of an existential Doob-Meyer decomposition. Identifying it with time will require both the Brownian square-minus-time martingale setup and a uniqueness or predictable-part identification theorem, neither of which is present yet.

The mathematical risk is that the existing local-martingale square theorem may be under-hypothesized: the available square-integrable result requires stopped martingales that are square-integrable, and local martingales do not provide that syntactically without an additional localization argument. The prover should attempt that refinement honestly and report the exact missing hypothesis/API if it cannot be produced under the current signature.

## Blueprint work

- Added explicit coverage for `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` to `blueprint/src/chapters/stochastic_integral.tex`.
- Added a project-local helper block for `lem:stoppedProcess_indicator_sq_norm`.
- Filled the previously empty proof of `lem:IsLocalMartingale.isLocalSubmartingale_sq_norm` with the intended localization route: refine to square-integrable stopped martingales, apply `lem:IsSquareIntegrable.submartingale_sq`, then transport through `stoppedProcess_indicator_sq_norm`.
- Fixed the blueprint-doctor broken cross-reference in `blueprint/src/chapters/doob_meyer.tex` by replacing `lem:isPredictable.predictablePart_eq` with the existing label `lem:isStronglyPredictable.predictablePart_eq`.

I reread the project README and the relevant `stochastic_integral.tex` section. No new external source file was cited for the square-norm local-submartingale proof; the prose is a project-local upstream proof obligation for the existing Lean statement.

## Prover scope

The prover gets one file: `BrownianMotion/StochasticIntegral/QuadraticVariation.lean`.

The target is the sorry at line 70 only. The prover may use existing APIs from `Locally.lean`, `LocalizingSequence.lean`, `ClassD.lean`, `SquareIntegrable.lean`, and `Auxiliary/Martingale.lean`, but should not edit those files this iteration. If a reusable upstream lemma is truly required outside the assigned file, the prover should report its exact statement.

## Blueprint doctor

The live broken `\uses` target from iter-001 has been addressed in `doob_meyer.tex`.

## Subagent skips

- No subagents are enabled for this project, so the classic single-agent path is used.

## Verification

- `lake build` completed successfully; the build reports the known 22 sorry warnings, including the single remaining `QuadraticVariation.lean` warning.
- `git diff --check` passed.
- A targeted cross-reference check confirms the stale `lem:isPredictable.predictablePart_eq` use is gone and the stochastic-integral chapter now explicitly covers `BrownianMotion/StochasticIntegral/QuadraticVariation.lean`.
