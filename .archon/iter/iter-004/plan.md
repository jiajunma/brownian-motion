# Iteration 004 Plan

## State collected

- The previous prover round added and proved
  `ProbabilityTheory.martingale_brownian_sq_sub_time` in
  `QuadraticVariationBrownian.lean`.
- `QuadraticVariationBrownian.lean` now has no sorries, but it still has no
  `ProbabilityTheory.quadraticVariation_brownian` theorem.
- The project still has 22 `sorry` occurrences. On the active route the
  remaining relevant sorries are `IsLocalSubmartingale.doob_meyer` in
  `DoobMeyer.lean` and
  `IsLocalMartingale.isLocalSubmartingale_sq_norm` in `QuadraticVariation.lean`.
- The current `doob_meyer` Lean theorem returns an unnormalized decomposition:
  it supplies `X = M + A`, local martingale/càdlàg data for `M`, and
  progressive/càdlàg/locally-integrable/monotone data for `A`, but it does not
  state `A_0 = 0`.
- Full predictable-part uniqueness also needs the finite-variation theorem
  that a zero-start local martingale of finite variation is zero. That theorem
  exists in the blueprint as `thm:IsLocalMartingale.eq_zero_of_finiteVariation`
  but is not yet formalized in Lean.

## Decision made

Dispatch `BrownianMotion/StochasticIntegral/DoobMeyer.lean` and target the
normalization layer, not another Brownian calculation. The prover should first
try to add a normalized existence theorem above the current weak
`doob_meyer`, then retarget the choice-based `martingalePart` and
`predictablePart` bodies to choose from the normalized theorem without changing
their signatures.

This is the smallest honest upstream move toward
`ProbabilityTheory.quadraticVariation_brownian`: the Brownian martingale
decomposition is available, but the old choice-based predictable part cannot be
identified with deterministic time while its chosen value at `⊥` is
unnormalized. The cheapest signal to reverse this plan is a prover report that
normalizing the weak decomposition needs an extra unprovable integrability
hypothesis on `A ⊥`; in that case the next iteration should either add that
explicit hypothesis to a compiled helper or refactor the core Doob-Meyer
existence theorem to include normalization from the start.

## Blueprint work

- Added `thm:local_doobMeyer_normalized` to
  `blueprint/src/chapters/doob_meyer.tex`.
- Added `lem:predictablePart_bot_eq_zero` for the normalized choice-based
  predictable part.
- Added the future uniqueness/identification block
  `lem:predictablePart_eq_of_normalized_decomposition`, explicitly recording
  its dependence on
  `thm:IsLocalMartingale.eq_zero_of_finiteVariation`.
- Updated `lem:quadraticVariation_brownian` in
  `blueprint/src/chapters/stochastic_integral.tex` so it points at the
  normalized predictable-part identification theorem.

No new external source was used. I reread the project README and the relevant
Doob-Meyer and stochastic-integral blueprint/Lean sections; the new
normalization prose is project-local algebra around the existing formal
statement.

## Prover scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

Primary target:
`ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`, with the same
data as `doob_meyer` plus `(∀ ω, A ⊥ ω = 0)`.

If that compiles, the prover should retarget the existing choice definitions to
use the normalized theorem, preserve all current signatures and accessor lemma
statements, and add
`ProbabilityTheory.IsLocalSubmartingale.predictablePart_bot_eq_zero`.

The prover should not add a new `sorry` for full uniqueness. If
`predictablePart_eq_of_normalized_decomposition` is blocked, the task result
should name the missing finite-variation/local-martingale theorem precisely.

## Subagent skips

- No subagents are enabled for this project, so the classic single-agent path is
  used.

## Verification

- `rg -n "sorry" BrownianMotion | wc -l` reports 22 remaining sorry
  occurrences.
- `rg -n "sorry"` on the active Brownian/Doob-Meyer/quadratic-variation files
  shows only `DoobMeyer.lean:30` and `QuadraticVariation.lean:84`.
- Lean local search found `MeasureTheory.isStronglyProgressive_const` and did
  not find project-level `IsLocalMartingale.add/sub` or
  `HasLocallyIntegrableSup.add/sub`, so the objective tells the prover to add
  local helpers if needed.
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed with
  the expected existing `doob_meyer` sorry warning.
