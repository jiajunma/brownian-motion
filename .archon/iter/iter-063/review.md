# Iteration 063 Review

## Outcome

The structured attempt file again reports `no_prover_lane: true`, but
`.archon/logs/iter-063/meta.json`, `.archon/logs/iter-063/prover.jsonl`, and
`.archon/task_results/BrownianMotion_StochasticIntegral_QuadraticVariationBrownian.lean.md`
show that the prover did run. This review uses the raw prover log and task
result as recovered evidence.

The prover closed the direct Brownian quadratic-variation lane:

- `ProbabilityTheory.brownianQuadraticVariation` is now the explicit
  deterministic-time process `brownianDeterministicTime`, outside the
  usual-condition section.
- `ProbabilityTheory.brownianQuadraticVariation_normalized_decomposition` was
  added as the semantic certificate for
  `‖B_t‖ ^ 2 = (B_t ^ 2 - t) + brownianQuadraticVariation_t`, with the
  local-martingale, cadlag, predictable, progressive, local-integrable-sup,
  monotone, and bottom-zero fields.
- `ProbabilityTheory.quadraticVariation_brownian` was reproved directly by
  unfolding the explicit deterministic-time process.

The final source search in `QuadraticVariationBrownian.lean` finds no remaining
use of the generic `quadraticVariation` API, `IsLocalMartingale.isLocalSubmartingale_sq_norm`,
`predictablePart_eq_of_normalized_decomposition`, or `doob_meyer`, except for
the theorem name `quadraticVariation_brownian`.

## Current Sorry State

Project-wide textual `sorry` count under `BrownianMotion` remains 23 after the
iteration, unchanged. This round removed a transitive dependency from the
Brownian fixed-time theorem rather than replacing a textual `sorry`.

Open dependency-chain gaps remain:

- `QuadraticVariation.lean:64` declaration warning, actual `sorry` at line 84:
  `IsLocalMartingale.isLocalSubmartingale_sq_norm`.
- `DoobMeyer.lean:3489` declaration warning, actual `sorry` at line 3525:
  `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- `DoobMeyer.lean:3742` declaration warning, actual `sorry` at line 3747:
  public `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.

## Verification

Review reran:

- `lean_diagnostic_messages` on `QuadraticVariationBrownian.lean:360-418`
- `lean_verify` on `ProbabilityTheory.brownianQuadraticVariation`
- `lean_verify` on `ProbabilityTheory.brownianQuadraticVariation_normalized_decomposition`
- `lean_verify` on `ProbabilityTheory.quadraticVariation_brownian`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake build`

All compile checks passed. `QuadraticVariationBrownian.lean` has no diagnostics
or warnings. `QuadraticVariation.lean`, `DoobMeyer.lean`, and the full build
show only known project `sorry` warnings and the existing Doob-Meyer
deprecation warnings.

`lean_verify` reported no `sorryAx` for `ProbabilityTheory.quadraticVariation_brownian`.
It did report transitive `sorryAx` for
`ProbabilityTheory.brownianQuadraticVariation_normalized_decomposition`, traced
to the existing deterministic-time integrable-sup dependency
`ProbabilityTheory.hasIntegrableSup_brownianDeterministicTime`; the edited
certificate proof body itself contains no local `sorry`.

## Blueprint And Markers

Blueprint doctor found no structural issues.

Manual marker changes: none.

`sync_leanok` is current for iter-063 and reported `added: 2`, `removed: 0`,
touching `blueprint/src/chapters/stochastic_integral.tex`. Review did not touch
`\leanok`.

The new blueprint block
`lem:brownianQuadraticVariation_normalized_decomposition` points to
`\lean{ProbabilityTheory.brownianQuadraticVariation_normalized_decomposition}`,
and `lem:quadraticVariation_brownian` points to
`\lean{ProbabilityTheory.quadraticVariation_brownian}`. No stale `\notready`
was found in this chapter.

## Advisor Reports

The iter-063 plan already dispatched the available advisors:

- `strategy-critic` with slug `direct-qv`: direct Brownian QV was `SOUND` for
  the immediate Brownian-specific theorem, while the generic QV route remains a
  `CHALLENGE` because weak Doob-Meyer, predictable finite-variation uniqueness,
  cadlag modification, Komlos, UI, and optional-sampling inputs are still
  deferred.
- `mathlib-analogist` with slug `brownian-direct-qv`: `ALIGN_WITH_MATHLIB` on
  making Brownian QV the canonical explicit process and reusing
  `brownianDeterministicTime`.

No additional review subagent was dispatched. This was a focused prover/refactor
round, and the relevant strategy/API advisors had already run during planning.

## Next Plan Guidance

Treat the direct Brownian fixed-time QV theorem as complete. It is now
independent of the generic choice-based `quadraticVariation` route.

Do not report this as closing generic `ProbabilityTheory.quadraticVariation`,
`IsLocalMartingale.isLocalSubmartingale_sq_norm`, predictable finite-variation
uniqueness, or weak local Doob-Meyer. The later generic comparison theorem
between `quadraticVariation isLocalMartingale_brownian isCadlag_brownian` and
the explicit Brownian process remains proof debt.

The next useful target is either to remove the transitive `sorryAx` under the
deterministic-time integrable-sup dependency if the Brownian certificate must be
axiom-clean, or to resume the generic route with one sharply scoped theorem:
the finite-measure/usual repair of `IsLocalMartingale.isLocalSubmartingale_sq_norm`
or a real-time/`ℝ≥0` finite-variation uniqueness kernel. Do not resume the
deferred `leastGT` general-`κ` helper package without a new strategy review
explicitly reactivating it.

## Blueprint Doctor Report

The deterministic `blueprint-doctor` report for iter-063 says:

> No structural findings: every chapter is `\input`'d by `content.tex`, every
> `\ref{...}` / `\uses{...}` resolves to a defined `\label{...}`, every
> annotation has a non-empty argument, and no `axiom` declarations are present
> under the project's `.lean` files.
