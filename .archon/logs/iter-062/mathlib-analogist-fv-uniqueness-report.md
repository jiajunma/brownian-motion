# Mathlib Analogist Report

## Mode
api-alignment

## Slug
fv-uniqueness

## Iteration
062

## Question

(1) Does Mathlib already have "a continuous (local) martingale of finite variation is a.e.
constant", or directly composable pieces (a continuous FV process has zero quadratic variation; a
continuous local martingale with zero QV is constant)? If so the project's chain is a parallel API.
(2) Is the chosen generality (arbitrary linearly-ordered `κ` with `WithTop`/`leastGT`/explicit
mesh/partition + dense/bottom-immediate/left-isolated branch disjunctions) idiomatic for Mathlib's
martingale / FV / QV API, or is it re-deriving real-time analysis Mathlib already has? Quantify the
cost.

## Verdicts (summary)

| Decision | Verdict | Severity |
|---|---|---|
| Core FV-uniqueness / QV pieces exist in Mathlib? | NEEDS_MATHLIB_GAP_FILL | informational |
| Foundational process layer over general κ (filtration/stopping/predictable/variation) | DIVERGE_INTENTIONALLY (aligned) | informational |
| Analytic core over general κ vs. specialize to ℝ≥0 | ALIGN_WITH_MATHLIB (specialize) | critical |

## Must-fix-this-iter

- **Analytic core generality**: the load-bearing `sorry` at
  `DoobMeyer.lean:3525` (`eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`) and
  its premise `eq_zero_of_bounded_continuous_finiteVariation_core` (line 3462) should be closed
  **specialized to `κ = ℝ≥0`** (or `[0,t] ⊆ ℝ`), not over general `κ`. The sole consumer is Brownian
  over `ℝ≥0` (`QuadraticVariationBrownian.lean:24`), which is `DenselyOrdered`
  (`Mathlib/Data/NNReal/Defs.lean:84,397`) — so the bottom-immediate and left-isolated branches are
  vacuous for the real target. The general-κ choice is the cost driver: in `DoobMeyer.lean` ~28
  declarations carry branch bookkeeping (`left_branch`/`dense_left`/`left_isolated`/
  `bottom_immediate`/`strictPast`/`neBot_left`/`of_previous`), ~58 `Or.inl`/`Or.inr`/`hleft` plumbing
  sites, and ~163 mesh/partition/localizingSequence/modulus/pre_stop references — most of it dead at
  ℝ≥0, where Heine–Cantor uniform continuity on compacts (`Mathlib/Topology/UniformSpace/
  HeineCantor.lean`) and canonical dyadic partitions replace the hand-threaded `hmesh : ∀ W ∈ 𝓤 κ`
  hypotheses. **Do not add the planned `leastGT` pre-stop/stop-value helper** — it deepens the
  general-κ branch layer that the only consumer never exercises.

## Informational

- **Core fact is genuinely absent from Mathlib (NEEDS_MATHLIB_GAP_FILL).** The project's chain is
  **not** a parallel API to any existing Mathlib theorem — there is nothing to align *to* on the
  result itself. Exhaustive probe of bundled Mathlib:
  - No quadratic variation in probability (`grep -rli quadratic Mathlib/Probability` → empty; only
    algebraic quadratic forms exist).
  - No continuous-time Doob–Meyer. Only the **discrete** Doob decomposition
    `MeasureTheory.predictablePart`/`martingalePart` (`Mathlib/Probability/Martingale/Centering.lean`,
    ℕ-indexed).
  - No stochastic integral / Itô / Brownian motion / Wiener measure anywhere in Mathlib.
  - No "continuous local martingale of FV is constant", no "continuous FV ⇒ zero QV", no L²
    increment-orthogonality lemma.
  - `Martingale.eq_zero_of_predictable'` (`Mathlib/Probability/Martingale/Basic.lean:529`) **is**
    present (ℕ-only) and the project already consumes it for the discrete case
    (`DoobMeyer.lean:3658`). It is precisely the discrete shadow of the target fact.
  Consequence: the route must be built; there is no shorter Mathlib idiom, because the QV machinery
  the alternative "zero-QV" argument would compose with does not exist either. The project's actual
  proof idea (deterministic-partition square-increment + localization) **is** the standard QV-style
  argument and is correct.

- **Foundational layer over general κ is aligned, not a divergence.** Mathlib's own process
  foundations are general over the order index: `Filtration`/`IsStoppingTime`/`stoppedProcess`
  (`Process/Stopping.lean:64`, `Preorder ι`), `IsStronglyPredictable` (`Process/Predictable.lean`),
  `hitting`/`hittingBtwn`/`hittingAfter` (`Process/HittingTime.lean:48,108,499`, up to
  `ConditionallyCompleteLinearOrderBot` + `WellFoundedLT`), and `eVariationOn`/`BoundedVariationOn`/
  `LocallyBoundedVariationOn` (`Topology/EMetricSpace/BoundedVariation.lean:55`, `LinearOrder α`).
  Building these pieces over general κ matches Mathlib. (Minor: `leastGT` is a project-local
  reimplementation overlapping Mathlib's `hittingAfter`/`hittingBtwn`; small candidate parallel API,
  not load-bearing.)

## Persistent file
- `analogies/fv-uniqueness.md` — full decision blocks, citations, and the specialize-to-ℝ≥0
  rationale captured for future iters.

Overall verdict: The core fact is a real Mathlib gap (must be built, not aligned), but the project is
paying a large, avoidable tax by proving it over general `κ` with dense/bottom-immediate/left-isolated
branch disjunctions when its only consumer is densely-ordered `ℝ≥0` — pivot to close the `sorry` at
ℝ≥0 (Heine–Cantor + dyadic partitions, single dense branch) and stop adding general-κ helpers.
