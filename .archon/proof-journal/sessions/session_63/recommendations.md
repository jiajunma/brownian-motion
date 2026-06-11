# Session 63 Recommendations

## Prioritize

- Mark the Brownian direct-QV lane as complete for the immediate fixed-time theorem. `ProbabilityTheory.quadraticVariation_brownian` is now direct and `lean_verify` shows no `sorryAx`.
- Preserve the new semantic certificate theorem. It is the right place to record that the explicit process has the Brownian normalized decomposition properties, even though it is not a generic QV comparison theorem.

## Next Concrete Targets

- If the next milestone needs an axiom-clean Brownian certificate, target the transitive `sorryAx` under `ProbabilityTheory.hasIntegrableSup_brownianDeterministicTime` or its support. The direct fixed-time theorem itself does not depend on this.
- For the generic route, choose one sharply scoped theorem: either repair `ProbabilityTheory.IsLocalMartingale.isLocalSubmartingale_sq_norm` under honest finite-measure/usual localization hypotheses, or split a real-time/`ℝ≥0` finite-variation uniqueness kernel out of `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

## Do Not Retry Without A Structural Change

- Do not resume the iter-062 `leastGT` general-`κ` bounded-level helper package as the next default step. Iter-063 strategy review and mathlib alignment both identified that route as non-binding helper churn for the Brownian fixed-time milestone.
- Do not assign the full weak local Doob-Meyer theorem or the full predictable finite-variation uniqueness reduction as one monolithic target.
- Do not claim the direct Brownian definition proves that the generic choice-based `quadraticVariation isLocalMartingale_brownian isCadlag_brownian` equals time. That comparison remains later proof debt.

## Reusable Pattern

For a Brownian-specific canonical process with a known formula, define the formula directly and put the nontrivial stochastic content into a certificate theorem. Here the pattern is:

```lean
noncomputable abbrev brownianQuadraticVariation := brownianDeterministicTime

refine ⟨fun t ω => brownian t ω ^ 2 - (t : ℝ), ...⟩
```

Then close the identity with `Real.norm_eq_abs`, `sq_abs`, and `ring`, and close the stochastic-property branches by forwarding existing martingale/cadlag and deterministic-time lemmas.

## Structural Notes

Blueprint doctor found no structural issues. `sync_leanok` is current for iter-063 and added the expected markers in `stochastic_integral.tex`; review made no manual blueprint marker edits.
