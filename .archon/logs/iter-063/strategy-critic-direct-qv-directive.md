# Strategy Critic Directive

## Slug
direct-qv

## Project goal
This project formalizes Brownian motion and then builds stochastic integration toward Ito's lemma. The immediate milestone is to make the fixed-time Brownian quadratic-variation theorem `ProbabilityTheory.quadraticVariation_brownian` sorry-free for canonical Brownian motion on `ℝ≥0`, while preserving the generic stochastic-integral development and tracking the remaining generic proof debts honestly.

## Strategy under review

# Strategy

## Goal

Eliminate the remaining `sorry` terms while preserving the intended mathematical surface. The immediate Brownian milestone is a sorry-free fixed-time theorem `ProbabilityTheory.quadraticVariation_brownian` for canonical Brownian motion on `ℝ≥0`; the generic stochastic-integral path still requires the independent proof debts in squared-norm local submartingales, predictable finite-variation uniqueness, and weak local Doob-Meyer existence. Beyond this milestone the destination is the stochastic integral and Ito's lemma.

## Phases & estimations

| Phase | Status | Iters left | LOC (remaining · realized/it) | Key Mathlib needs | Risks |
| --- | --- | ---: | --- | --- | --- |
| Brownian direct quadratic variation | selected active lane | 1 | ≈30 · ~0/it | existing Brownian martingale and deterministic-time API | Must not claim generic QV/Doob-Meyer proof debt is closed |
| Square-norm local submartingale | repair signature before proof | 2–4 | ≈60 · ~0/it | local square-integrable localization; finite-measure filtration | Current global statement is too weak |
| FV-uniqueness over real time | specialize before proof | 2–4 | ≈90 · ~0/it | dyadic/refining partitions on `ℝ≥0`; Heine-Cantor | General-`κ` helper route is churning |
| Local Doob-Meyer existence | residual generic QV dependency | ≥12 once active | ≈420 · ~0/it | Class D, cadlag modification, Komlos, localization | Binding for generic QV; no active velocity |
| Uniform integrability, optional sampling, local stability | queued generic inputs | 4–8 once active | ≈200 · ~0/it | UI closure; conditional-expectation order; discrete approximation | General-index transfer has heavy typeclass constraints |
| Cadlag modification theorem | queued generic input | 3–6 once active | ≈180 · ~0/it | upcrossing/simple-process bounds; countable exceptional set | Mathematically large source theorem |
| Komlos convergence chain | queued generic input | 4–8 once active | ≈260 · ~0/it | Hilbert convex tails; `Lp` convergence; measurability | Final `ENNReal` statement has a measurability TODO |
| Square-integrable martingale convergence | queued generic input | 2–4 once active | ≈120 · ~0/it | martingale convergence; `eLpNorm` identities | Time-index generality may exceed Mathlib |
| Borel and compact-system foundations | deferred foundation lane | 2–4 once active | ≈100 · ~0/it | sum/sigma Borel spaces; compact-system closure | Off the immediate Brownian milestone |
| Final polish and audit | pending proofs | 1–2 | ≈40 · ~0/it | lints, axiom audit, blueprint sync | Build passes but permits known sorries |

## Routes

### Brownian Direct QV

The Brownian fixed-time theorem should no longer be forced through the generic choice-based `quadraticVariation` definition while that definition depends on three independent generic sorries. For Brownian motion the predictable increasing part is the explicit deterministic time process, and the file already proves the nontrivial inputs: `B_t^2 - t` is a martingale and the deterministic time process is predictable, progressive, cadlag, locally integrable, monotone, and zero at bottom. The route is to define the Brownian-specific quadratic variation explicitly as deterministic time, prove the fixed-time theorem from that definition, and document that this does not close the generic `quadraticVariation`/Doob-Meyer debts.

### Generic QV Route

The generic route remains necessary for the stochastic-integral endpoint. It should proceed by first repairing the overgeneral square-norm local-submartingale statement to include the finite-measure/local-square-integrable hypotheses used by `quadraticVariation`, then proving the real-time FV-uniqueness kernel directly on `ℝ≥0` rather than adding more general-`κ` branch or `leastGT` helpers, and only then resuming weak Doob-Meyer existence inputs.

## Open strategic questions

- Should the later generic `quadraticVariation` definition require local square integrability explicitly, or should the local square-integrability refinement be built from local martingality under usual finite-measure hypotheses?
- Should the FV-uniqueness chain keep a continuity hypothesis for the Brownian/generic continuous applications and leave cadlag jump-removal as a later strengthening?
- Is the raw Brownian natural filtration intended to be completed/right-continuized, or kept as an explicit usual-condition context?
- Does Mathlib now contain a submartingale stopped-value uniform-integrability theorem subsuming the local result?

## Mathlib gaps & new material

**Gaps to fill**

- Local square-integrable bounded-stopping localization for cadlag local martingales under finite measure.
- Continuous-time Doob-Meyer / "continuous FV martingale is constant" remains absent from Mathlib; build the real-time kernel in-project.
- Deterministic refining partitions with vanishing mesh on compact intervals in `ℝ≥0`.
- Borel-space instances for binary and countable dependent sums; compact-system closure.
- Optional sampling, cadlag modification, and Komlos convergence inputs for local Doob-Meyer.

**New project material**

- Brownian-specific quadratic variation as the explicit deterministic time process, with the generic QV comparison deferred to the generic route.
- Generic quadratic variation as the normalized predictable part of the local Doob-Meyer decomposition.
- Normalized choice layer and usual-condition shift helpers for the Doob-Meyer predictable part.
- Stopping/localization stability for cadlag, predictable, finite-variation processes.
- Martingale increment orthogonality and bounded-continuous finite-partition square-integral helpers.
- Uniform integrability and square-integrable convergence helpers for stopped martingales.

## References index

# References

<!-- archon:references-summary -->
<!-- One row per file. Agents append/update rows as they discover what -->
<!-- actually works. The `How to read` column is a LIVING LOG, not a -->
<!-- static cheat-sheet — fill it in the first time you successfully -->
<!-- ingest a file, and correct it if a later attempt finds a better way. -->

## File inventory

| File | Description | How to read (confirmed working) |
| ---- | ----------- | ------------------------------- |
| `../README.md` | Project overview: Brownian motion is complete and being upstreamed; stochastic integration and Itô's lemma are ongoing. It also identifies the Brownian-motion preprint and project resources. | From the project root: `sed -n '1,220p' README.md`. |
| `../Manuscript/proof_outline.tex` | Detailed informal proof outline for the Brownian-motion formalization, covering probability preliminaries, separating algebras and characteristic functions, Gaussian variables, projectivity, and Kolmogorov–Chentsov continuity. | From the project root: `sed -n '1,260p' Manuscript/proof_outline.tex`; section discovery also works with `rg -n '^\\(section|subsection)' Manuscript/proof_outline.tex`. |
| `../blueprint/src/content.tex` | Blueprint entry point. It records the completed Brownian-motion part and the ongoing stochastic-integral part, and lists the chapter files for each. | From the project root: `sed -n '1,240p' blueprint/src/content.tex`; open the referenced files under `blueprint/src/chapters/` for theorem-level prose. |

## Blueprint summary

- BrownianMotion_Auxiliary_StandardBorel.tex: Borel structures on countable disjoint unions.
- brownian.tex: Brownian motion.
- cadlag.tex: Modifications with cadlag paths.
- characteristic_function.tex: Characteristic function and covariance.
- debut.tex: Debut Theorem.
- doob_meyer.tex: Doob-Meyer Theorem.
- elementary.tex: Simple processes and elementary integrals.
- filtration_martingale.tex: Filtrations, processes and martingales.
- gaussian.tex: Gaussian distributions.
- kolmogorov_chentsov.tex: Kolmogorov-Chentsov Theorem.
- local_martingales.tex: Local martingales.
- process.tex: Stochastic processes.
- projective_family.tex: Projective family of the Brownian motion.
- stochastic_integral.tex: Stochastic integral.

## Prior critique status

- iter-062: active FV helper sequencing — addressed
- iter-062: Doob-Meyer existence stagnant — live
- iter-062: FV pass-through tower — live
- iter-062: continuous real-time FV alternative — addressed
- iter-062: direct Brownian QV alternative — addressed
- iter-062: Routes accumulation — addressed
