# Strategy Critic Directive

## Slug
qv-route

## Project goal

The project formalizes stochastic integration in Lean (Mathlib-bound), building toward
the stochastic integral against a semimartingale and Itô's lemma. The currently active
destination is the Brownian quadratic-variation result: the fixed-time theorem
`ProbabilityTheory.quadraticVariation_brownian (t : ℝ≥0) : brownianQuadraticVariation t
=ᵐ[gaussianLimit] fun _ => (t : ℝ)` has landed as a Lean declaration but still depends
transitively on three open generic proof obligations that must be discharged to remove its
`sorry` debt: (1) squared-norm local submartingales
(`IsLocalMartingale.isLocalSubmartingale_sq_norm`), (2) predictable finite-variation
uniqueness (the bridge `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`),
and (3) the weak local Doob–Meyer decomposition (`ProbabilityTheory.IsLocalSubmartingale.doob_meyer`).
The final destination beyond this is the stochastic integral / Itô's lemma.

## Strategy under review

# Strategy

## Goal

Eliminate the remaining `sorry` terms while preserving the intended mathematical surface. The fixed-time Brownian quadratic-variation theorem has landed as a Lean declaration, but it still depends transitively on open generic proof debt. The active destination is now to remove those dependencies: squared-norm local submartingales, predictable finite-variation uniqueness, and the weak local Doob-Meyer decomposition.

## Phases & estimations

| Phase | Status | Iters left | LOC (remaining · realized/it) | Key Mathlib needs | Risks |
| --- | --- | ---: | --- | --- | --- |
| Predictable finite-variation uniqueness | active `leastGT` norm-level input | 3–5 | ≈70 · ~20/it | generated past, predictable sections, stopped martingales | Variation-level localization and mesh remain explicit |
| Generic local square-norm submartingale | queued context repair | 2–4 | ≈60 · ~15/it | bounded stopping/local square-integrability under finite measure | Present global signature is too weak for the proof route |
| Local Doob-Meyer decomposition | blocked on core inputs | 6–12 | ≈420 · ~0/it | Class D, càdlàg modification, Komlós, localization, normalization | One theorem packages a long blueprint development |
| Uniform integrability, optional sampling, local stability | queued, ordered | 4–8 | ≈200 · ~0/it | UI closure; conditional expectation order; discrete approximation | General-index transfer has substantial typeclass constraints |
| Càdlàg modification theorem | queued | 3–6 | ≈180 · ~0/it | upcrossing/simple-process bounds; countable exceptional set | Main source theorem is mathematically large |
| Komlós convergence chain | ready, ordered | 4–8 | ≈260 · ~0/it | Hilbert-space convex tails; `Lp` convergence; measurability | Final `ENNReal` statement has an explicit measurability TODO |
| Square-integrable martingale convergence | queued | 2–4 | ≈120 · ~0/it | martingale convergence and `eLpNorm` identities | Time-index generality may exceed available Mathlib theorems |
| Borel and compact-system foundations | deferred | 2–4 | ≈100 · ~0/it | sum/sigma Borel spaces; compact-system closure | Not on the current Brownian quadratic-variation route |
| Final polish and audit | pending proofs | 1–2 | ≈40 · ~0/it | lints, axiom audit, blueprint synchronization | Full build passes but currently permits the known sorries |

## Routes

Single route through the Brownian dependency chain. The Brownian martingale `B_t^2 - t`, deterministic time predictable part, and fixed-time a.e theorem are now in place. Predictable-jump bookkeeping through the generated past sigma-algebra, bounded-horizon domination, bounded jump integrability, stopped/localizing bounded jump removal, stopped/original event transfer, original/stopped-bound terminal/left-limit zero packaging, nontrivial-left sequence endpoints, original-continuity stopped-bound packaging, explicit left-isolated predecessor propagation, bottom-immediate zero propagation, the stopped-bound left-branch connector, the original-bound left-branch transfer wrapper, the fixed-level endpoint, strict-left predecessor extraction, the strict-past endpoint, dense-left branch packaging, pre-stop stopped-horizon bounds, closed-pre-stop stopped-variation bounds, and dense-left pre-stop localizing packaging are closed. The current milestone constructs concrete `leastGT` norm-level pre-stop and finite stop-value bounds; after that, construct closed-pre-stop variation-level inputs and keep mesh hypotheses explicit before repairing the square-norm local-submartingale helper.

## Open strategic questions

- Is the raw Brownian natural filtration intended to be completed/right-continuized, or should the Brownian quadratic-variation declarations keep an explicit usual-condition context?
- Should the final Brownian theorem stop at fixed-time a.e equality, or add a cadlag indistinguishability upgrade in the same file?
- Should `IsLocalMartingale.isLocalSubmartingale_sq_norm` be replaced by a usual-condition version, or should both the general and usual-condition variants coexist?
- Which time-index hypothesis should support deterministic mesh partitions: an explicit mesh assumption, a connected/dense order condition, or a split into discrete predictable jumps plus continuous intervals?
- Should the predictable finite-variation bridge eventually split into a dense-time theorem plus a separate discrete/predecessor theorem, or remain a single general statement with branch hypotheses internalized?
- Does Mathlib now contain a submartingale stopped-value uniform-integrability theorem that subsumes the local result?
- Is the stated generality of `komlos_L1` sufficient to establish the requested measurable limit without an additional hypothesis?
- Do the square-integrable convergence statements require stronger directedness/countability assumptions on the time index?

## Mathlib gaps & new material

**Gaps to fill**

- Local square-integrable bounded-stopping localization for càdlàg local martingales under finite measure.
- Predictable finite-variation local-martingale uniqueness, stated a.e and routed through generated-past jump uniqueness.
- Explicit deterministic entourage-mesh partitions and pathwise uniform-continuity control on compact ordered intervals.
- Borel-space instances for binary and countable dependent sums.
- Compact-system closure under products, finite unions, and countable intersections.
- Optional sampling, càdlàg modification, and Komlós convergence inputs for local Doob-Meyer.

**New project material**

- Normalized choice layer for the local Doob-Meyer predictable part.
- Usual-condition subtraction and initial-value shift helpers for Doob-Meyer normalization.
- Stopping/localization stability for càdlàg, predictable, and finite-variation processes.
- `leastGT` norm-level horizon localization from hitting-time pre-stop bounds and continuous no-overshoot.
- Closed pre-stop stopped-variation localization from explicit variation/no-overshoot inputs.
- Stopped/original left-limit transfer and localizing-cover jump-removal wrappers.
- Martingale increment orthogonality and bounded-continuous finite-partition square-integral helpers.
- Explicit predictable value-zero connectors for nontrivial-left, dense-left, bottom-immediate, and left-isolated branches.
- Uniform integrability and square-integrable convergence helpers for stopped martingales.
- Quadratic variation as the normalized predictable part of the local Doob-Meyer decomposition.
- Brownian quadratic variation via the canonical Brownian martingale, stated up to a.e/indistinguishability equality.

## References index

| File | Description | How to read |
| ---- | ----------- | ----------- |
| `../README.md` | Project overview: Brownian motion complete and being upstreamed; stochastic integration and Itô's lemma ongoing. Names the preprint (arXiv:2511.20118). | `sed -n '1,220p' README.md`. |
| `../Manuscript/proof_outline.tex` | Informal proof outline for the Brownian-motion formalization (probability preliminaries, separating algebras, characteristic functions, Gaussian variables, projectivity, Kolmogorov–Chentsov). | `sed -n '1,260p' Manuscript/proof_outline.tex`. |
| `../blueprint/src/content.tex` | Blueprint entry point: completed Brownian-motion part + ongoing stochastic-integral part, lists chapter files. | `sed -n '1,240p' blueprint/src/content.tex`; chapters under `blueprint/src/chapters/`. |

Note: the references above are focused on the *completed* Brownian-motion development. The active
stochastic-integral / Doob–Meyer / quadratic-variation route is largely Archon-original Lean
development without a dedicated transcribed reference text in `references/`. A standard textbook
treatment of these results is Karatzas–Shreve, *Brownian Motion and Stochastic Calculus*
(Doob–Meyer decomposition, quadratic variation), and Revuz–Yor, *Continuous Martingales and
Brownian Motion*. These are NOT currently in `references/`; flag if you believe the route needs a
transcribed source before proceeding.

## Blueprint summary

- `process.tex` — Stochastic processes.
- `filtration_martingale.tex` — Filtrations, processes and martingales.
- `elementary.tex` — Simple processes and elementary integrals.
- `debut.tex` — Debut theorem (hitting times).
- `local_martingales.tex` — Local martingales.
- `doob_meyer.tex` — Doob–Meyer theorem (the active route lives here).
- `cadlag.tex` — Modifications with càdlàg paths.
- `stochastic_integral.tex` — Stochastic integral.
- `kolmogorov_chentsov.tex` — Kolmogorov–Chentsov continuity theorem.
- `gaussian.tex` — Gaussian distributions.
- `characteristic_function.tex` — Characteristic function and covariance.
- `projective_family.tex` — Projective family of the Brownian motion.
- `brownian.tex` — Brownian motion.
- `BrownianMotion_Auxiliary_StandardBorel.tex` — Borel structures on countable disjoint unions.

## Prior critique status

no prior critique (strategy-critic has not previously been dispatched on this project).

## Focus request

Beyond the standard audit, give particular scrutiny to the FIRST phase row, "Predictable
finite-variation uniqueness", and its place in the single route. The route narrative lists ~20
closed helper lemmas and names a *further* `leastGT` norm-level helper as the current milestone,
while the load-bearing reduction it all feeds
(`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`)
remains unproven. Assess specifically:
- whether the mathematical content of that bridge (a bounded continuous finite-variation true
  martingale started at 0 is a.e. zero) is being proved by an idiomatic route or a hand-rolled
  parallel one;
- whether decomposing the goal into this long single sequential chain of bound/variation/branch
  wrappers is a sound decomposition or an infrastructure-deferral pattern that keeps renaming the
  same hard analytic core;
- whether a cheaper alternative route to the quadratic-variation goal exists (e.g. a direct
  Itô-isometry / L² argument, or a Mathlib continuous-martingale result) that bypasses the full
  Doob–Meyer machinery.
