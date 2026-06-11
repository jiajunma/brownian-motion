# Strategy Critic Report

## Slug
qv-route

## Iteration
062

## Routes audited

STRATEGY.md declares a single route ("Single route through the Brownian dependency chain").
I audit that route, then handle the focus request, the format block, the deferral findings,
and the alternatives.

### Route: Single Brownian dependency chain (QV = predictable part of Doob–Meyer of `X²`)

- **Goal-alignment**: PARTIAL — the route does reach `quadraticVariation_brownian`, but the
  *active milestone it leads with* (predictable finite-variation uniqueness) is NOT the binding
  constraint. `quadraticVariation_brownian` (QuadraticVariationBrownian.lean:376) transitively
  needs all three sorries closed: `isLocalSubmartingale_sq_norm` (QuadraticVariation.lean:84),
  `doob_meyer` (DoobMeyer.lean:3747), and the FV-uniqueness `_reduction` (DoobMeyer.lean:3525).
  Finishing only the FV-uniqueness phase the strategy makes "active" produces **zero end-to-end
  unblock** — the theorem stays sorry-bound on the other two. Leading with the most-invested link
  rather than the binding one is a sequencing miss.
- **Mathematical soundness**: PASS — the math is correct. The kernel is correctly identified:
  `eq_zero_of_bounded_continuous_finiteVariation_core` (DoobMeyer.lean:3462) isolates the trivial
  tail (`∫ Nₜ² = 0 ⟹ Nₜ =ᵐ 0` via `ae_eq_zero_of_integral_sq_eq_zero`), and increment
  orthogonality is already available (`integral_increment_mul_increment_eq_zero`). The classical
  L² mesh estimate `E[Nₜ²] = Σ E[(N_{t_{i+1}}−N_{t_i})²] ≤ E[maxᵢ|ΔN|·V_t] → 0` is the right
  argument and is partially scaffolded.
- **Sunk-cost reasoning detected**: yes — see Sunk-cost flags. The Routes paragraph justifies the
  phase ordering by enumerating ~20 *already-closed* helper lemmas, and makes the phase with that
  accumulated momentum the lead "active" phase even though it is the last (non-binding) link.
- **Infrastructure-deferral detected**: yes — two distinct patterns (see findings): (i) the
  `doob_meyer` existence theorem (required by the goal) sits at `~0/it` "blocked on core inputs"
  whose own inputs (Komlós, càdlàg modification, Class D) are also `~0/it`; (ii) the FV-uniqueness
  tower is a stack of pass-through wrappers that funnel into a single `sorry` while renaming the
  hard analytic core (see focus response).
- **Phantom prerequisites**: none detected. Mathlib has no general "continuous FV martingale is
  constant" / Doob–Meyer / continuous-martingale QV result, so the project-built kernel is
  appropriate, not a missing-infra bet. The project-internal lemmas in the chain
  (`integral_increment_mul_increment_eq_zero`, `ae_eq_zero_of_integral_sq_eq_zero`,
  `stronglyMeasurable_past`) compile, hence exist.
- **Effort honesty**: under-counted on the back half. Rows 3–9 (`doob_meyer`, UI/optional
  sampling, càdlàg modification, Komlós, sq-integrable convergence, Borel foundations, polish)
  all carry `~0/it` realized velocity. A row claiming `Iters left: 6–12` with `~0/it` realized is
  internally inconsistent: at the observed velocity it never completes. The honest reading is that
  only the top two rows are moving and the binding constraint (`doob_meyer`, ≈420 LOC) has shown
  no realized progress.
- **Parallelism under-exploited**: yes — the three open sorries are largely independent.
  `isLocalSubmartingale_sq_norm` (a local-square-integrability/Jensen argument, QV.lean:84) shares
  no dependency with the FV-uniqueness bridge, and `doob_meyer` existence is independent of
  FV-uniqueness. Serializing them ("Predictable FV uniqueness" first, then "square-norm
  submartingale", then "doob_meyer") implicitly multiplies the iter count.
- **Verdict**: CHALLENGE

## Format compliance

- **Size**: ≈60 lines / well under budget — within budget (~250 lines / ~12 KB).
- **Headings**: PASS — `## Goal`, `## Phases & estimations`, `## Routes`, `## Open strategic
  questions`, `## Mathlib gaps & new material`, in canonical order. (`## References index` and
  `## Blueprint summary` in the directive are the *directive's* sections, not part of STRATEGY.md.)
- **Per-iter narrative detected**: no literal `iter-NNN` references.
- **Accumulation detected**: yes — the `## Routes` section is a single run-on sentence
  enumerating ~20 *closed* helper lemmas ("Predictable-jump bookkeeping through the generated past
  sigma-algebra, bounded-horizon domination, bounded jump integrability, … are closed."). A list
  of completed sub-lemmas is per-iter progress accumulation; it belongs in iter sidecars, not in
  the route description. The route should state the *remaining* path, not a changelog of closed
  helpers.
- **Table discipline**: PASS structurally (all six columns, LOC carries both figures), but six of
  nine rows read `~0/it` — see effort honesty.
- **Format verdict**: DRIFTED — the accumulation in `## Routes` is the one material deviation;
  compress it to the remaining path.

## Infrastructure-deferral findings

### Deferred: `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` (local Doob–Meyer existence)

- **Required by goal**: yes — the directive names it as obligation (3); `quadraticVariation` is
  *defined* as `(doob_meyer_normalized …).choose_spec.choose` (DoobMeyer.lean:3810,
  QuadraticVariation.lean:109), so `quadraticVariation_brownian` cannot be sorry-free without it.
- **Current plan for building it**: row 3 marks it "blocked on core inputs" at `≈420 · ~0/it`,
  with prerequisites (Class D, càdlàg modification, Komlós, localization, normalization)
  themselves rows at `~0/it`. No row shows realized progress on this sub-tree.
- **Timeline**: vague — `6–12` iters at `~0/it` realized is not a credible timeline; the
  prerequisite phases have no concrete start.
- **Verdict**: CHALLENGE — this is the project's true binding constraint and it is stagnant while
  effort flows to the non-binding FV-uniqueness link. Either start a concrete prover lane on the
  `doob_meyer` sub-tree (decomposed into the Komlós / càdlàg-modification / Class-D sub-phases this
  iter) or explicitly re-sequence so the active destination is gated on it.

### Deferred: the FV-uniqueness wrapper tower → single `_reduction` sorry

- **Required by goal**: partially — *a* proof of FV-uniqueness is required; the **tower** is not.
- **Current plan**: DoobMeyer.lean 3489–3684 is a chain — `_reduction` (the lone sorry, 3525) →
  `_bounded_continuous` (3533, just calls `_reduction`) → `_value_zero` (3553, builds left-limit +
  past-increment `have`s, discards them via `_…_used`, calls `_bounded_continuous`) →
  `_past_condExp_zero` (3596, `condExp` of `_value_zero`) → `_noninitial_analytic` (3616) →
  `_noninitial` (3639) → `_finiteVariation` (3668). The middle lemmas add **no** mathematical
  content: `_value_zero`/`_noninitial_analytic`/`_past_condExp_zero` set up hypotheses, immediately
  shelve them, and forward to the next layer, and `_past_condExp_zero ↔ _value_zero` is circular
  (condExp-zero derived from value-zero, value-zero "derived" from condExp-zero).
- **Timeline**: the `≈70 · ~20/it` figure measures wrapper/helper churn, not the unproven core.
- **Verdict**: CHALLENGE — the ~20 closed helpers and the wrapper tower keep renaming the hard
  analytic core (the one `_reduction` sorry) without shrinking it. Collapse the dead wrappers and
  point effort at the single mesh/orthogonality estimate that is the only real content.

## Alternative routes (suggested)

### Alternative: prove a *continuous*-hypothesis FV-uniqueness, drop the jump machinery

- **What it looks like**: state the bridge with `∀ ω, ContinuousOn (N · ω) (Icc ⊥ t)` (which the
  `core` lemma at 3462 already assumes) instead of càdlàg-`hN_cadlag` + `IsStronglyPredictable` +
  jump removal. For a continuous bounded FV martingale started at 0 the proof is exactly the mesh
  estimate on `[0,t]` with deterministic partitions — no predictable-jump removal, no
  generated-past sigma-algebra, no left-isolated/bottom-immediate/dense-left/strict-predecessor
  case split. In the Brownian application `A₀ − A` *is* continuous (`B²` is continuous, so its
  Doob–Meyer predictable part is continuous, and `A = t` is continuous), so the jump branches are
  **vacuous** there.
- **Why it might be cheaper or sounder**: the entire order-theoretic case analysis on a general
  `PolishSpace`-ordered `κ` (the source of the ~20 helpers) exists only to handle jumps and
  isolated/discrete time points that `ℝ≥0` and the continuous Brownian application never produce.
  A `ℝ≥0`/dense-order, continuous-paths statement is the textbook Karatzas–Shreve argument and is a
  fraction of the LOC.
- **What the current strategy may have rejected**: it appears to be chasing the fully general
  càdlàg-predictable statement for eventual reuse — open questions #4/#5 show the planner is aware
  the general-`κ` branch is what spawns the jump/predecessor complexity but has not committed to
  splitting it off.
- **Severity of the omission**: major

### Alternative: decouple the Brownian milestone from full Doob–Meyer existence

- **What it looks like**: `quadraticVariation` is currently *defined* through the general
  `doob_meyer` existence theorem, so the fixed-time Brownian result inherits the entire Doob–Meyer
  monster (Komlós + càdlàg modification + Class D + optional sampling) as a hard prerequisite. For
  Brownian motion the answer is explicit: `B_t² − t` is already a martingale
  (`martingale_brownian_sq_sub_time`) and `t` is a continuous predictable increasing FV process
  from 0 — i.e. `t` is a normalized predictable part *by inspection*. Define the Brownian QV
  directly (as `t`, or as the ucp/L² limit of `Σ(B_{t_{i+1}}−B_{t_i})²`, the textbook definition)
  and prove `quadraticVariation_brownian` via Itô-isometry/mesh, gated only on FV-*uniqueness*
  (to identify the abstract predictable part with `t`) rather than on Doob–Meyer *existence*.
- **Why it might be cheaper or sounder**: it removes the ≈420-LOC `~0/it` `doob_meyer` existence
  theorem (and its Komlós/càdlàg/Class-D sub-tree) from the critical path of the *currently active
  destination*. The general Doob–Meyer definition is defensible for the eventual semimartingale/Itô
  goal, but binding the Brownian fixed-time milestone to the project's single largest stagnant
  phase is what makes the milestone unreachable.
- **What the current strategy may have rejected**: the strategy commits to "Single route" with
  QV ≡ Doob–Meyer predictable part and lists no alternative QV definition; this trade-off is not
  surfaced anywhere in STRATEGY.md.
- **Severity of the omission**: major

## Sunk-cost flags

- `"… are closed. The current milestone constructs concrete leastGT norm-level pre-stop and finite
  stop-value bounds; after that, construct closed-pre-stop variation-level inputs …"` — Why this is
  sunk-cost: the route is justified and sequenced by the volume of already-closed helper lemmas,
  making the most-invested link the lead "active" phase even though closing it unblocks nothing
  end-to-end (two other sorries gate the goal). Recommendation: sequence by binding constraint
  (`doob_meyer` existence and `isLocalSubmartingale_sq_norm`), not by accumulated helper count, and
  move the closed-helper enumeration out of `## Routes`.

## Must-fix-this-iter

- Route (single chain): CHALLENGE — re-sequence so effort targets the binding constraints.
  Completing the FV-uniqueness phase alone leaves `quadraticVariation_brownian` sorry-bound;
  `isLocalSubmartingale_sq_norm` and `doob_meyer` must also be addressed. Either parallelize the
  three independent sorries or justify the ordering with an explicit rebuttal in plan.md.
- Infrastructure-deferral CHALLENGE — `doob_meyer` existence is required by the goal, sits at
  `~0/it`, and its prerequisites (Komlós, càdlàg modification, Class D) are also `~0/it`. Start a
  concrete prover lane decomposed into those sub-phases this iter, or re-sequence the active
  destination to depend on it explicitly with an iter estimate.
- Infrastructure-deferral CHALLENGE — collapse the FV-uniqueness pass-through tower
  (`_value_zero`/`_noninitial_analytic`/`_past_condExp_zero` add no content and are circular) and
  point effort at the single `_reduction` mesh/orthogonality estimate.
- Alternative (continuous-hypothesis FV-uniqueness): major omission — the general-`κ` jump-removal
  machinery is vacuous in the continuous Brownian application; evaluate a continuous-paths /
  dense-order statement that drops the order-theoretic case split.
- Alternative (decouple Brownian milestone from Doob–Meyer existence): major omission — the active
  destination inherits the project's largest stagnant phase purely through the QV *definition*;
  evaluate a direct Brownian QV definition gated on uniqueness, not existence.
- Format: DRIFTED — compress the `## Routes` closed-helper enumeration to the remaining path; move
  the changelog of closed lemmas to an iter sidecar.

## Overall verdict

The single route is mathematically sound and reaches the stated theorem, and the analytic kernel
(increment orthogonality + the `∫ Nₜ²=0` core) is correctly identified — so this is not a REJECT.
But the strategy commits two infrastructure-deferral patterns the planner must address. First, the
strategy defers `doob_meyer` (the local Doob–Meyer existence theorem), which is required for the
stated goal — `quadraticVariation` is defined through it — yet it sits at `~0/it` "blocked" behind
prerequisites that are themselves `~0/it`, while effort flows to the non-binding FV-uniqueness link
that, even when finished, unblocks nothing end-to-end. Second, the FV-uniqueness tower renames the
hard analytic core through a stack of pass-through/circular wrappers and ~20 order-theoretic helper
lemmas whose generality (general `PolishSpace`-ordered `κ`, predictable jumps) is vacuous in the
continuous Brownian application. Two major alternatives go unmentioned: a continuous-hypothesis
FV-uniqueness that deletes the jump/predecessor case split, and decoupling the Brownian milestone
from full Doob–Meyer existence by defining the QV directly for this case. Re-sequence by binding
constraint, parallelize the three independent sorries, and compress the accumulated `## Routes`
changelog.
