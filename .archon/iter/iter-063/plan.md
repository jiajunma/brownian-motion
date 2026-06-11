# Iteration 063 Plan

## State Collected

- User hint requested exactly one Codex-harness iteration after the Claude Opus iteration hit its session limit, with `strategy-critic` and `mathlib-analogist` kept enabled and used to avoid further helper churn on the stuck `QuadraticVariationBrownian` dependency route.
- There was no unprocessed prover task result in `.archon/task_results/` at plan start. Iter 062 has no review sidecar, but `.archon/logs/iter-062/meta.json` records the prover and review phases as done with final `lake` and blueprint checks passing and project sorry count still `23`.
- The standing `PROGRESS.md` objective was the `leastGT` norm-level package in `DoobMeyer.lean`. That objective came from iter 062, but the iter-062 strategy critic and mathlib analogist reports both warned against continuing general-`κ` helper work for the immediate Brownian milestone.
- Re-read `README.md`, `references/summary.md`, `blueprint/src/content.tex`, `blueprint/src/chapters/stochastic_integral.tex`, the current `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and the active Doob-Meyer reduction region.
- `QuadraticVariationBrownian.lean` has no internal textual `sorry`, but `brownianQuadraticVariation` currently unfolds to generic `quadraticVariation`, so the fixed-time Brownian theorem inherits the generic square-norm, FV-uniqueness, and weak Doob-Meyer debts transitively.
- `QuadraticVariation.lean` still has `IsLocalMartingale.isLocalSubmartingale_sq_norm` open at line `84`; `DoobMeyer.lean` still has `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` and `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` open.
- `archon-protected.yaml` contains no protected declarations, so the Brownian-specific definition can be refactored if the prover keeps names and mathematical intent honest.

## Subagents

- Dispatched `strategy-critic` with slug `direct-qv` after rewriting `STRATEGY.md` to select the Brownian direct-QV lane. Report archived at `.archon/logs/iter-063/strategy-critic-direct-qv-report.md`.
- Dispatched `mathlib-analogist` in `api-alignment` mode with slug `brownian-direct-qv`. Report archived at `.archon/logs/iter-063/mathlib-analogist-brownian-direct-qv-report.md`.

## Advisor Feedback Used

- `strategy-critic`: Brownian Direct QV is `SOUND` for the immediate Brownian fixed-time theorem if the strategy documents that it is not a proof that the generic choice-based `quadraticVariation` agrees with time. It challenged the generic route for still deferring weak Doob-Meyer/FV/UI/cadlag/Komlos infrastructure and suggested adding a semantic Brownian QV predicate or theorem so the result does not become only definitional.
- `mathlib-analogist`: `ALIGN_WITH_MATHLIB` on making Brownian QV the canonical explicit process, and `ALIGN_WITH_MATHLIB` on reusing `brownianDeterministicTime`. It explicitly recommended refactoring `brownianQuadraticVariation` away from generic `quadraticVariation`, moving it out of the usual-condition section if possible, updating the blueprint prose, and leaving the generic comparison theorem as later proof debt.

## Decision Made

Drop the iter-062 `leastGT` Doob-Meyer objective for this Codex round. Continuing it would deepen the general-`κ` localization helper route that both advisors identified as non-binding helper churn for `QuadraticVariationBrownian`.

Assign exactly one prover lane in `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`:

- redefine `brownianQuadraticVariation` as the explicit deterministic time process;
- add `ProbabilityTheory.brownianQuadraticVariation_normalized_decomposition` as the semantic certificate that `B² = (B² - t) + ⟨B⟩` with the normalized predictable-part properties;
- reprove `ProbabilityTheory.quadraticVariation_brownian` directly from the explicit definition.

## Strategy Updates

- `STRATEGY.md` now has two live routes: Brownian Direct QV as the selected active lane, and Generic QV as residual infrastructure for stochastic integration.
- The strategy explicitly says the generic route remains open and must later repair square-norm local submartingales, specialize FV uniqueness to real time, and decompose weak Doob-Meyer inputs.
- The strategy critic's generic-route challenges remain live. They are not resolved this iteration because the user asked for one Codex-harness round and both advisors agreed the direct Brownian lane is the correct immediate target. This is not a claim that generic Doob-Meyer or FV uniqueness is closed.

## Blueprint Updates

- Updated `blueprint/src/chapters/stochastic_integral.tex` so `def:brownianQuadraticVariation` is the deterministic time process rather than an application of generic `quadraticVariation`.
- Added the new blueprint block `lem:brownianQuadraticVariation_normalized_decomposition` with `\lean{ProbabilityTheory.brownianQuadraticVariation_normalized_decomposition}`.
- Updated `lem:quadraticVariation_brownian` to use the direct definition and the new semantic certificate, not `predictablePart_eq_of_normalized_decomposition`.
- Did not add or remove any `\leanok` marker.

## Soundness Check

The objective is honest only as a Brownian-specific canonical QV route. It must not be reported as closing:

- generic `ProbabilityTheory.quadraticVariation`;
- `IsLocalMartingale.isLocalSubmartingale_sq_norm`;
- predictable finite-variation uniqueness;
- weak local Doob-Meyer existence;
- the later generic comparison between choice-based QV and explicit Brownian QV.

The new certificate theorem prevents the fixed-time result from being merely undocumented definitional boilerplate: it packages the existing Brownian martingale and deterministic-time process properties as the Brownian normalized decomposition.

## Fallback if no user response

If the direct Brownian QV refactor and semantic certificate close, the next planner should verify whether `quadraticVariation_brownian` no longer depends transitively on generic `quadraticVariation`. Then continue with the generic route by repairing the square-norm local-submartingale statement or splitting the `ℝ≥0` continuous FV uniqueness kernel. Do not resume the `leastGT` helper package unless a later strategy review explicitly reactivates general-`κ` Doob-Meyer localization inputs.
