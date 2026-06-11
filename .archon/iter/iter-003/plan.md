# Iteration 003 Plan

## State collected

- The previous prover round resolved the transport helper
  `ProbabilityTheory.Locally.isSquareIntegrable_submartingale_sq_norm` in
  `QuadraticVariation.lean`.
- The remaining sorry in
  `ProbabilityTheory.IsLocalMartingale.isLocalSubmartingale_sq_norm` is still
  blocked by real hypotheses, not by naming: the available square-integrable
  submartingale route needs `SigmaFiniteFiltration P F`, and the current theorem
  statement has no such assumption.
- `QuadraticVariationBrownian.lean` currently contains the Brownian natural
  filtration, càdlàg lemma, martingale lemma, local martingale lemma, and
  `brownianQuadraticVariation`, but no theorem identifying that process with
  time.
- The choice-based `predictablePart` is not enough to prove
  `quadraticVariation_brownian`: the Lean `doob_meyer` theorem returns an
  unnormalized decomposition and does not state `A_0 = 0`, so the predictable
  finite-variation part is not unique as stated.
- No proof-journal session or `PROJECT_STATUS.md` exists yet. No subagents are
  enabled for this project.

## Decision made

Dispatch `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`.
The prover should attempt `ProbabilityTheory.quadraticVariation_brownian` only
if normalized predictable-part uniqueness is already available. Otherwise, the
objective is to add and prove the Brownian-specific prerequisite
`ProbabilityTheory.martingale_brownian_sq_sub_time`, namely that
`B_t^2 - t` is a martingale for the canonical Brownian motion and its natural
filtration.

This is the smallest honest Brownian-route objective that can move downstream
without pretending the generic square theorem or Doob-Meyer uniqueness is
solved. The cheapest signal to reverse this choice would be a prover report
that the mixed-term conditional expectation requires substantial missing
infrastructure; in that case the next iteration should isolate that product
conditional-expectation lemma.

## Blueprint work

- Expanded `blueprint/src/chapters/stochastic_integral.tex` so its coverage
  line includes
  `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`.
- Added Brownian quadratic-variation blueprint blocks for
  `brownianNaturalFiltration`, `isCadlag_brownian`, `martingale_brownian`,
  `isLocalMartingale_brownian`, `brownianQuadraticVariation`,
  `martingale_brownian_sq_sub_time`, and `quadraticVariation_brownian`.
- Wrote the full informal proof of the fallback theorem using Brownian
  independent increments, the expansion
  `B_t^2 - t = B_s^2 - s + 2 B_s Delta + (Delta^2 - (t-s))`, and Gaussian second
  moments.
- Marked in prose that final identification of `predictablePart` with time
  requires normalized Doob-Meyer uniqueness; without `A_0 = 0`, constant shifts
  make uniqueness false.

No new external source was used. This is a project-local consequence of the
already formalized Brownian independent-increment and Gaussian-moment facts,
and I reread the project README plus the relevant blueprint and Lean files.

## Prover scope

The prover gets one file:
`BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`.

The fallback theorem should be added in namespace `ProbabilityTheory` with the
name `martingale_brownian_sq_sub_time`. The direct Brownian quadratic-variation
theorem should not be asserted unless the missing normalized uniqueness API is
available. The prover may add local helper lemmas in the same file for the
mixed-term conditional expectation or Brownian second moment, but should not
edit `QuadraticVariation.lean`, `DoobMeyer.lean`, or unrelated foundation files
this iteration.

## Subagent skips

- No subagents are enabled, so the classic single-agent path is used.

## Verification

- `git diff --check` passed.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed with the known project-wide sorry warnings, including the remaining `QuadraticVariation.lean` warning.
