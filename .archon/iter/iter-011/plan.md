# Iteration 011 Plan

## State Collected

- The iter 010 prover result resolved the Brownian build checkpoint:
  `ProbabilityTheory.brownianNaturalFiltration_approximable` now compiles by
  expanding the dyadic `ℝ≥0` approximation under the order instance used by
  the strengthened quadratic-variation API.
- `ProbabilityTheory.brownianQuadraticVariation` now compiles in an explicit
  Brownian usual-condition section with
  `[brownianNaturalFiltration.IsComplete gaussianLimit]` and
  `[brownianNaturalFiltration.IsRightContinuous]`; `lake env lean
  BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` and
  `lake build` passed.
- The prover did not add `ProbabilityTheory.quadraticVariation_brownian`.
  It correctly identified the next missing statement as normalized
  predictable-part uniqueness.
- Reading the current Lean and blueprint revealed a sharper issue than a
  missing helper: the formal Doob--Meyer witness currently records the
  finite-variation part only as `IsStronglyProgressive`, while the blueprint
  and the uniqueness argument require predictability. A cadlag local martingale
  of finite variation need not be constant without predictability, so the
  previously referenced `IsLocalMartingale.eq_zero_of_finiteVariation` shape is
  false as stated.
- A raw pointwise theorem
  `brownianQuadraticVariation t omega = (t : ℝ)` is also not a valid target for
  a choice-based Doob--Meyer part. At best, uniqueness gives fixed-time a.e
  equality, and then a separate cadlag/separability argument can promote it to
  indistinguishability.
- `archon-protected.yaml` contains no protected declarations, so the
  Doob--Meyer witness signature may be repaired.
- There are still no proof-journal session summaries or recommendations; only
  the current-session raw attempt stub exists.

## Decision Made

Pivot the next prover objective upstream to
`BrownianMotion/StochasticIntegral/DoobMeyer.lean`. Do not ask the prover to
try the Brownian identity again this iteration.

The goal is to make the Lean Doob--Meyer choice layer match the mathematical
surface used by uniqueness: the weak and normalized existence witnesses should
carry `IsStronglyPredictable 𝓕 A` for the increasing part, while preserving the
existing strong-progressive accessors used by running-sup and downstream
quadratic-variation code.

This is a structural repair, not a new proof of local Doob--Meyer. The original
weak `doob_meyer` theorem already has the single preserved decomposition
`sorry`; strengthening that witness with predictability does not add an escape
hatch. The prover should add a predictable-part accessor and adjust tuple
projections downstream in the same file.

The cheapest signal to reverse this route would be discovering that the
existing `IsStronglyProgressive` property was intentionally being used as the
project's definition of predictability. Source inspection of
`Predictable.lean` and Mathlib's `IsStronglyPredictable` API rules that out.

## Blueprint Work

- Updated `blueprint/src/chapters/doob_meyer.tex` so
  `thm:local_doobMeyer_normalized` explicitly records a strongly predictable
  finite-variation part in addition to strong progressivity.
- Added the blueprint lemma
  `lem:isStronglyPredictable_predictablePart` for the choice-based predictable
  part accessor.
- Replaced the false finite-variation uniqueness reference with the predictable
  version `thm:IsLocalMartingale.eq_zero_of_predictable_finiteVariation`, and
  rewrote `lem:predictablePart_eq_of_normalized_decomposition` as fixed-time
  a.e equality rather than pointwise equality.
- Updated `blueprint/src/chapters/stochastic_integral.tex` so
  `lem:quadraticVariation_brownian` targets fixed-time a.e equality, with a
  later indistinguishability upgrade if a cadlag equality helper is added.
- Reread the relevant Doob--Meyer and stochastic-integral blueprint passages
  after the edits. No external source was used; this is a project-local
  correction aligning the Lean API with the existing stochastic-integral
  blueprint and Mathlib's predictable-process API.

## Prover Scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
strengthen `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` and
`ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized` so the `A`
witness includes `IsStronglyPredictable 𝓕 A`, and add
`ProbabilityTheory.IsLocalSubmartingale.isStronglyPredictable_predictablePart`.

The prover should preserve the existing normalized choice definitions and
accessor names as far as possible, keep the existing strong-progressive
accessor, and avoid adding new sorries. The only remaining `DoobMeyer.lean`
sorry after the task should be the original weak decomposition theorem.

Implementation hints verified this iteration:

- `MeasureTheory.measurableSet_predictable_univ_prod` exists and supports
  predictability of time-constant bottom-measurable processes.
- `IsStronglyPredictable` is strong measurability of `Function.uncurry` over
  `𝓕.predictable`, so subtraction/time-constant closure can be proved by
  strong-measurability closure.
- `IsStronglyPredictable.isStronglyProgressive` exists if the prover wants to
  derive the progressive property from predictability.

Non-targets:
do not add `predictablePart_eq_of_normalized_decomposition` with a sorry; do
not assert a finite-variation local martingale zero theorem without
predictability; do not edit `QuadraticVariation.lean` or
`QuadraticVariationBrownian.lean`.

## Subagent Skips

- No subagents are enabled for this project, so the classic single-agent path
  is used.

## Verification

The prover should run:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`
