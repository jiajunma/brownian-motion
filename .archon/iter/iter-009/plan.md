# Iteration 009 Plan

## State Collected

- The user hint directs this iteration to continue toward
  `ProbabilityTheory.quadraticVariation_brownian`, but first repair the
  downstream full-build failure created by the successful normalized
  Doob--Meyer strengthening.
- The iter 008 prover result reports `DoobMeyer.lean` now compiles with
  `ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`,
  `martingalePart`, `predictablePart`, and the accessors closed under the usual
  assumptions. The only remaining `DoobMeyer.lean` sorry is the original weak
  `doob_meyer` theorem.
- Independent verification with
  `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
  reproduces the current build failure at `QuadraticVariation.lean:99`: Lean
  cannot synthesize `[ConditionallyCompleteLinearOrderBot ι]` for the call to
  the strengthened `predictablePart`, and the locally constructed
  `hX2_cadlag` uses the partial-order instance coming from the old weak
  `[LinearOrder ι]` context.
- `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` still has its
  older, separate sorry in
  `ProbabilityTheory.IsLocalMartingale.isLocalSubmartingale_sq_norm`; this is
  not the source of the current build break and remains a deeper localization
  task.
- The relevant blueprint chapter is the consolidated
  `blueprint/src/chapters/stochastic_integral.tex`, which covers both
  `QuadraticVariation.lean` and `QuadraticVariationBrownian.lean`.

## Decision Made

Dispatch `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` only.
The immediate target is a context-propagation repair, not the final Brownian
identity and not the old squared-norm submartingale gap.

The prover should put `quadraticVariation` and any mechanically affected
quadratic-variation declarations in a strengthened section where the time index
and filtration are formed under the same assumptions as normalized Doob--Meyer:
`[ConditionallyCompleteLinearOrderBot κ] [BorelSpace κ] [PolishSpace κ]
[IsFiniteMeasure P'] [Approximable 𝓕' P'] [𝓕'.IsComplete P']
[𝓕'.IsRightContinuous]`, while retaining the existing topology,
measurability, order-topology, and normed-space assumptions.

The important implementation shape is to avoid adding the strong order class on
top of an already-formed weak `Filtration ι mΩ`; doing so creates the
partial-order mismatch shown in the error. A fresh strengthened section
variable, as used in `DoobMeyer.lean`, is the intended route.

The cheapest signal to reverse this plan would be a prover report showing that
`quadraticVariation` can compile in the weak global section by supplying only
instances, with no order-instance mismatch. The current compiler error makes
that unlikely.

## Blueprint Work

- Updated `blueprint/src/chapters/stochastic_integral.tex` in the local
  martingales section to state that the generic quadratic-variation API using
  the normalized predictable part lives under the same usual hypotheses as the
  normalized Doob--Meyer choice layer.
- Refined `def:quadraticVariation` so the informal statement explicitly says
  the definition is the normalized predictable part of `||M||^2` under those
  hypotheses.
- No external source was used; this is a project-local API propagation after a
  Lean signature strengthening.

## Prover Scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/QuadraticVariation.lean`.

Primary target:
make `ProbabilityTheory.quadraticVariation` compile with the strengthened
`ProbabilityTheory.IsLocalSubmartingale.predictablePart` API by moving it, and
only declarations that need the same context, into a strengthened usual-
assumption section.

Non-targets:
do not try to prove `ProbabilityTheory.quadraticVariation_brownian`; do not
work on predictable-part uniqueness; do not reopen `DoobMeyer.lean`; do not
work on Standard Borel, compact systems, or Brownian independent increments.

The existing sorry in
`ProbabilityTheory.IsLocalMartingale.isLocalSubmartingale_sq_norm` may remain.
The prover must not add new sorries.

## Subagent Skips

- No subagents are enabled for this project, so the classic single-agent path is
  used.

## Verification

- Ran `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`;
  it fails at line 99 with missing
  `[ConditionallyCompleteLinearOrderBot ι]` and an `IsCadlag` partial-order
  mismatch, confirming the user hint.
- The next prover should run the same file check, then `lake build`. If the
  build next fails in `QuadraticVariationBrownian.lean`, the required checkpoint
  is to report the exact usual-condition instances missing for
  `brownianQuadraticVariation`.
