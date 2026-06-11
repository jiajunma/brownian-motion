# Mathlib Analogist Report

## Mode
api-alignment

## Slug
brownian-direct-qv

## Iteration
063

## Question
Should `ProbabilityTheory.brownianQuadraticVariation` be a Brownian-specific explicit deterministic-time definition, rather than an abbreviation of the generic choice-based `ProbabilityTheory.quadraticVariation`, while the generic quadratic-variation/Doob-Meyer route remains as separate project material? If the direct definition is acceptable, should it reuse the existing `ProbabilityTheory.brownianDeterministicTime` process, or should the project keep the generic definition and instead add only comparison theorems?

## Verdicts (summary)

| Decision | Verdict | Severity |
|---|---|---|
| Brownian QV as canonical explicit process vs generic choice specialization | ALIGN_WITH_MATHLIB | critical |
| Reuse `brownianDeterministicTime` for the direct definition | ALIGN_WITH_MATHLIB | major |
| Keep generic `quadraticVariation`/Doob-Meyer as separate infrastructure | NEEDS_MATHLIB_GAP_FILL | informational |
| Later comparison theorem between generic choice QV and Brownian QV | PROCEED | informational |

## Must-fix-this-iter

- Brownian QV as canonical explicit process vs generic choice specialization: refactor `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean:369` so `brownianQuadraticVariation` is the explicit Brownian predictable quadratic variation, not an abbreviation of `quadraticVariation`. Mathlib has no probability quadratic-variation API to align with directly, but its analogous idiom is clear: when a canonical formula is available, define that formula and prove its properties. Example: discrete Doob decomposition defines `MeasureTheory.predictablePart` by a conditional-increment sum, not by choosing a decomposition (`Mathlib/Probability/Martingale/Centering.lean:46`-`49`), and defines `martingalePart` explicitly from it (`Centering.lean:123`-`126`). Likewise `ProbabilityTheory.gaussianReal` is the explicit dirac/density measure (`Mathlib/Probability/Distributions/Gaussian/Real.lean:23`-`25`, `200`-`203`).
- The current shipped path forces the Brownian theorem through three unrelated generic debts: `IsLocalMartingale.isLocalSubmartingale_sq_norm` (`QuadraticVariation.lean:75`-`84`), `IsLocalSubmartingale.doob_meyer` (`DoobMeyer.lean:3742`-`3747`), and the finite-variation predictable local-martingale uniqueness used by comparison. This is exactly the kind of choice-layer coupling Mathlib avoids when a special formula is already known.

## Major

- Reuse `ProbabilityTheory.brownianDeterministicTime`, preferably as `noncomputable abbrev brownianQuadraticVariation := brownianDeterministicTime`. The file already proves the required API for that process: predictability, progressivity, cadlag paths, local integrable supremum, monotonicity, and zero at bottom (`QuadraticVariationBrownian.lean:262`-`355`). Duplicating `fun t _ => (t : ℝ)` under a second name would create avoidable bridge lemmas.
- If signatures are not frozen, move the direct definition out of the `UsualConditions` section. The deterministic-time Brownian QV does not require completeness/right-continuity or `Approximable`; those hypotheses belong to the generic comparison theorem, not the canonical Brownian process.

## Informational

- The direct definition is honest only if the blueprint stops presenting `brownianQuadraticVariation` as `quadraticVariation(B)`. Current prose at `blueprint/src/chapters/stochastic_integral.tex:681`-`693` says it is an application of the generic choice layer; that should change to "the Brownian predictable quadratic variation is the deterministic time process". The generic definition at `stochastic_integral.tex:426`-`432` should remain separate.
- Keep a later comparison theorem, inside the usual-condition/generic section, showing the generic choice-based `quadraticVariation isLocalMartingale_brownian isCadlag_brownian` agrees with `brownianQuadraticVariation` at each deterministic time a.s. The existing local theorem `predictablePart_eq_of_normalized_decomposition` already has exactly the right equality shape (`DoobMeyer.lean:3860`-`3870`), and the blueprint correctly warns that raw pointwise equality of choice representatives is not the honest target (`stochastic_integral.tex:911`-`918`).
- `quadraticVariation_brownian` may remain the immediate Brownian fixed-time theorem if its statement is about `brownianQuadraticVariation t =ᵐ[gaussianLimit] fun _ => (t : ℝ)`. With the direct definition, this theorem becomes definitional/a.e. boilerplate; that is acceptable because the nontrivial Brownian martingale statement is now carried by the separate decomposition/comparison theorem, not hidden in the definition.

## Persistent file

- Not written: this invocation explicitly restricted writable targets to `.archon/task_results/mathlib-analogist-brownian-direct-qv.md`.

Overall verdict: refactor the Brownian-specific QV to `brownianDeterministicTime`, document that this is the canonical Brownian process rather than the generic choice representative, and leave the generic Doob-Meyer/QV comparison as a separate proof obligation.
