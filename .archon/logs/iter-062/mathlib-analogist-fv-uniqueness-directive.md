# Mathlib Analogist Directive

## Mode
api-alignment

## Slug
fv-uniqueness

## Design question

The project is hand-building a large (~60-lemma) proof chain in `DoobMeyer.lean` whose
load-bearing core is the statement: **a bounded, continuous, finite-variation true martingale
started at 0 is almost-everywhere 0** (the "predictable finite-variation uniqueness bridge",
declaration `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`,
with the open `sorry`). This is the engine that ultimately drives the project's quadratic-variation
results (quadratic variation as the normalized predictable part of a Doob–Meyer decomposition, then
specialized to Brownian motion). The chain is built over a *general conditionally-complete
linearly-ordered time index* `κ` (with `WithTop κ`, `leastGT` hitting times, deterministic
partitions, explicit mesh hypotheses, branch disjunctions for dense / bottom-immediate /
left-isolated time), not over `ℝ≥0` / `ℝ` directly.

Two linked questions:

1. **Does Mathlib already have this core fact** — "a continuous (local) martingale of finite
   variation is a.e. constant" — or directly composable pieces of it (e.g. a quadratic-variation
   argument: a continuous finite-variation process has zero quadratic variation, and a continuous
   local martingale with zero quadratic variation is constant)? If so, the project's hand-rolled
   chain is a parallel API and we should align.

2. **Is the chosen generality (arbitrary linearly-ordered `κ` with explicit mesh/partition/branch
   bookkeeping) idiomatic for Mathlib's martingale / finite-variation / quadratic-variation
   API**, or is Mathlib's machinery built over `ℝ`-indexed (or `ℝ≥0`-indexed) filtrations such that
   the project's general-`κ` route is forced to re-derive analysis (partitions, uniform continuity
   on compact order intervals, dominated convergence over refining partitions) that Mathlib already
   provides for real time? Quantify the cost of the divergence.

## Project artifact(s) under question

- `BrownianMotion/StochasticIntegral/DoobMeyer.lean` — around the declaration
  `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`
  (declaration ≈ line 3489, `sorry` ≈ line 3525) and the long preceding chain of
  `MeasureTheory.Martingale.eq_zero_of_*_finiteVariation_*` / `integral_sq_terminal_eq_zero_of_*` /
  `eq_zero_of_localizingSequence_*` helper lemmas. Use grep/source reading to survey the chain.
- `BrownianMotion/StochasticIntegral/QuadraticVariation.lean` — `ProbabilityTheory.quadraticVariation`
  and `IsLocalMartingale.isLocalSubmartingale_sq_norm` (`sorry` ≈ line 84), the downstream consumer.
- `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` —
  `ProbabilityTheory.quadraticVariation_brownian`, the final consumer.

## Why now

A single Claude Opus iteration is reassessing whether to keep adding local `DoobMeyer.lean` helper
lemmas (the next planned one is a `leastGT` norm-level pre-stop / stop-value bound) or to pivot the
route. The route has added ~60 helpers across many iterations without closing the core `sorry`. We
need to know, before spending more budget, whether Mathlib already provides the core result or a
materially shorter idiom — i.e. whether this is a parallel API.

## Hints (optional)

Relevant Mathlib namespaces to probe: `MeasureTheory` martingale theory
(`MeasureTheory.Martingale`, `MeasureTheory.Submartingale`), finite/bounded variation
(`eVariationOn`, `BoundedVariationOn`, `LocallyBoundedVariationOn`), stopped processes
(`MeasureTheory.stoppedProcess`), hitting times (`MeasureTheory.hitting`), predictable processes,
and any quadratic-variation / continuous-martingale infrastructure that may exist
(`MeasureTheory.Martingale.eq_zero_of_predictable'` is already used by the project for the *discrete*
case — check whether a continuous-time analogue or a quadratic-variation-based uniqueness exists).
Also check whether Mathlib has any form of the Doob–Meyer / Doob decomposition in continuous time.

## Severity expectation
high-stakes
