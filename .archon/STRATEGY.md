# Strategy

## Goal

Eliminate the remaining `sorry` terms while preserving the intended mathematical surface. The immediate Brownian milestone is a sorry-free fixed-time theorem `ProbabilityTheory.quadraticVariation_brownian` for canonical Brownian motion on `ℝ≥0`; the generic stochastic-integral path still requires the independent proof debts in squared-norm local submartingales, predictable finite-variation uniqueness, and weak local Doob-Meyer existence. Beyond this milestone the destination is the stochastic integral and Ito's lemma.

## Phases & estimations

| Phase | Status | Iters left | LOC (remaining · realized/it) | Key Mathlib needs | Risks |
| --- | --- | ---: | --- | --- | --- |
| Brownian direct quadratic variation | selected active lane | 1 | ≈45 · ~0/it | existing Brownian martingale and deterministic-time API | Must also package the semantic decomposition certificate |
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

The Brownian fixed-time theorem should no longer be forced through the generic choice-based `quadraticVariation` definition while that definition depends on three independent generic sorries. For Brownian motion the predictable increasing part is the explicit deterministic time process, and the file already proves the nontrivial inputs: `B_t^2 - t` is a martingale and the deterministic time process is predictable, progressive, cadlag, locally integrable, monotone, and zero at bottom. The route is to define the Brownian-specific quadratic variation explicitly as deterministic time, prove the fixed-time theorem from that definition, and add a semantic decomposition certificate recording that `B² = (B² - t) + t` has the normalized predictable-part shape.

### Generic QV Route

The generic route remains necessary for the stochastic-integral endpoint. It should proceed by first repairing the overgeneral square-norm local-submartingale statement to include the finite-measure/local-square-integrable hypotheses used by `quadraticVariation`, then proving the real-time FV-uniqueness kernel directly on `ℝ≥0` rather than adding more general-`κ` branch or `leastGT` helpers. The first FV theorem to split out is an `ℝ≥0` continuous bounded finite-variation martingale uniqueness statement with explicit dyadic/refining partitions; weak Doob-Meyer existence then decomposes into UI/optional sampling, cadlag modification, Komlos, and Class-D/localization lanes.

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

- Brownian-specific quadratic variation as the explicit deterministic time process, with a normalized Brownian decomposition certificate and the generic QV comparison deferred to the generic route.
- Generic quadratic variation as the normalized predictable part of the local Doob-Meyer decomposition.
- Normalized choice layer and usual-condition shift helpers for the Doob-Meyer predictable part.
- Stopping/localization stability for cadlag, predictable, finite-variation processes.
- Martingale increment orthogonality and bounded-continuous finite-partition square-integral helpers.
- Uniform integrability and square-integrable convergence helpers for stopped martingales.
