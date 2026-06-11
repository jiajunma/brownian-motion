# Iteration 010 Plan

## State Collected

- The user hint asks to continue toward
  `ProbabilityTheory.quadraticVariation_brownian`, starting from the current
  full-build error at `QuadraticVariationBrownian.lean:254`.
- The iter 009 prover result resolved the assigned generic API task:
  `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` now compiles with
  `ProbabilityTheory.quadraticVariation` in a strengthened usual-hypothesis
  section. The pre-existing `IsLocalMartingale.isLocalSubmartingale_sq_norm`
  sorry remains unchanged.
- Independent verification of
  `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
  reproduces the current error exactly:
  Lean cannot synthesize
  `Approximable brownianNaturalFiltration gaussianLimit` at
  `brownianQuadraticVariation`.
- Source inspection of `BrownianMotion/StochasticIntegral/ApproxSeq.lean`
  shows the generic noncomputable instance
  `NNReal.approximable : Approximable 𝓕 μ` for any filtration indexed by
  `ℝ≥0`. LSP hover confirmed this type. Thus the first Brownian blocker is not
  mathematical; it is an instance exposure/synthesis problem.
- The same strengthened `quadraticVariation` API will also require
  `IsFiniteMeasure gaussianLimit`,
  `brownianNaturalFiltration.IsComplete gaussianLimit`, and
  `brownianNaturalFiltration.IsRightContinuous`. Finite measure should follow
  from the existing probability-measure instance for `gaussianLimit`.
  Completeness of the raw natural filtration is mathematically suspect, so the
  prover must not manufacture that instance.
- No proof-journal session summary or recommendations exist yet; only the
  current-session raw attempts file is present.

## Decision Made

Dispatch `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`.
The generic API propagation task is done, and the next real checkpoint is the
Brownian specialization.

The prover should first make `Approximable brownianNaturalFiltration
gaussianLimit` available, preferably as a named Brownian instance backed by the
already compiled `NNReal.approximable` construction. If Lean then exposes
finite-measure, right-continuity, or completeness obligations, the prover
should continue only with honest facts. In particular, it should not declare the
raw natural filtration complete unless it proves that statement from the actual
measurable-space and measure definitions.

If the raw Brownian declarations are too weak for the strengthened API, the
route chosen this iteration is to use a Brownian-specific strengthened section
carrying the required usual-condition assumptions explicitly, rather than
mixing order instances or adding false global instances. This follows the user
hint and keeps the normalized Doob--Meyer and quadratic-variation APIs intact.
Such a theorem is only a strengthened checkpoint; it should not be reported as
closing the unconditional Brownian identity.

After `brownianQuadraticVariation` compiles, the prover should push toward
`quadraticVariation_brownian`. The expected mathematical blocker remains
normalized Doob--Meyer predictable-part uniqueness: the Brownian decomposition
`B_t^2 = (B_t^2 - t) + t` is available on the martingale side, but identifying
the choice-based predictable part with the deterministic time process requires
a uniqueness theorem for normalized decompositions. If that theorem cannot be
proved locally in this file without new infrastructure, the prover should stop
after the compiled Brownian checkpoint and report the exact missing uniqueness
statement.

The cheapest signal to reverse this route would be Lean exposing a simple
existing complete/right-continuous usual Brownian filtration construction under
a different name. In that case the Brownian declarations should use that
construction rather than carrying raw-filtration assumptions.

## Blueprint Work

- Added `lem:brownianNaturalFiltration_approximable` to
  `blueprint/src/chapters/stochastic_integral.tex`, with the dyadic stopping
  time approximation proof for the `ℝ≥0` time index.
- Updated `def:brownianQuadraticVariation` to cite the approximability lemma
  and to record that completeness/right-continuity are genuine usual-condition
  obligations for the filtration used by the formal quadratic-variation API.
- No external source was used; this is project-local API propagation and the
  dyadic approximation already present in the Lean file `ApproxSeq.lean`.

## Prover Scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`.

Primary target:
make `ProbabilityTheory.brownianQuadraticVariation` compile under the
strengthened `ProbabilityTheory.quadraticVariation` API by providing the
Brownian usual-condition support honestly, starting with
`Approximable brownianNaturalFiltration gaussianLimit`.

Secondary target:
if the definition compiles, add and prove
`ProbabilityTheory.quadraticVariation_brownian` as the pointwise identity
`brownianQuadraticVariation t ω = (t : ℝ)` if the normalized predictable-part
identification can be closed without new sorries.

Fallback:
if the equality theorem is blocked by predictable-part uniqueness, do not add a
new theorem with `sorry`; leave only compiled helper lemmas that directly
support the future proof and report the precise missing uniqueness theorem. If
raw-filtration completeness/right-continuity is the blocker, use an explicit
Brownian-specific usual-condition section or report the needed usual
augmentation; do not assert false global instances, and do not claim a
strengthened theorem proves the unconditional target.

## Subagent Skips

- No subagents are enabled for this project, so the classic single-agent path
  is used.

## Verification

- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
  currently fails at line 254 with missing
  `Approximable brownianNaturalFiltration gaussianLimit`.
- `NNReal.approximable` was confirmed by source inspection and LSP hover as a
  generic `Approximable` instance for `ℝ≥0`-indexed filtrations.
