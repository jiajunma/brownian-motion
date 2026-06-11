# Index
<!-- One line per file. Update line numbers when the file changes. -->

- [ ] `BrownianMotion/Auxiliary/StandardBorel.lean:15` — 2 sorries: `BorelSpace.sum`, `BorelSpace.sigma`.
- [ ] `BrownianMotion/Choquet/CompactSystem.lean:59` — 5 sorries: finite-union representation and compact-system closure lemmas.
- [ ] `BrownianMotion/StochasticIntegral/CadlagModification.lean:46` — 1 sorry: `exists_modification_left_right_limit`.
- [ ] `BrownianMotion/StochasticIntegral/DoobMeyer.lean:3525,3747` — 2 sorries: `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` is the active predictable finite-variation true-martingale bridge, and `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` is the long upstream weak local Doob-Meyer theorem. The stopped/localizing, left-branch, dense-left, pre-stop bound, and closed-pre-stop variation wrapper layers are closed, but strategy-critic and mathlib-analogist feedback now flags further general-`κ` helper work, including the planned `leastGT` norm-level package, as helper churn for the immediate Brownian milestone. The next Doob-Meyer work should be a real-time FV uniqueness kernel split or a decomposed Doob-Meyer input lane, not another branch/localization wrapper.
- [ ] `BrownianMotion/StochasticIntegral/Komlos.lean:353` — 5 sorries: convergence chain from uniform convex tails through `komlos_ennreal`.
- [ ] `BrownianMotion/StochasticIntegral/LocalMartingale.lean:96` — 1 sorry: stability of càdlàg submartingales.
- [ ] `BrownianMotion/StochasticIntegral/OptionalSampling.lean:190` — 2 sorries: bounded optional-sampling inequalities.
- [ ] `BrownianMotion/StochasticIntegral/QuadraticVariation.lean:84` — 1 sorry: `IsLocalMartingale.isLocalSubmartingale_sq_norm`; transport through local square-integrability is done, but the remaining localization route requires the finite-measure/usual localization context used by `quadraticVariation`, plus a local square-integrable bounded-stopping refinement. The current global helper statement is overgeneral for the known proof route and should be repaired before the proof is closed.
- [ ] `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` — no internal textual `sorry`, but the current `brownianQuadraticVariation` abbreviation is still routed through the generic choice-based `quadraticVariation`, so `quadraticVariation_brownian` inherits generic proof debts transitively. Current active plan: refactor the Brownian-specific QV definition to `brownianDeterministicTime`, add a normalized Brownian decomposition certificate, and keep the generic comparison as later proof debt.
- [ ] `BrownianMotion/StochasticIntegral/SquareIntegrable.lean:66` — 3 sorries: scalar closure and martingale convergence.
- [ ] `BrownianMotion/StochasticIntegral/UniformIntegrable.lean:201` — 1 sorry: uniform integrability of bounded stopped submartingales.

---
