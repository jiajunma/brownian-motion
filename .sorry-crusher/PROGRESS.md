# Sorry Crusher: exists_modification_left_right_limit

**Target**: `BrownianMotion/StochasticIntegral/CadlagModification.lean:46` (single `sorry`)
**Blueprint**: `blueprint/src/chapters/cadlag.tex` — `thm:exists_rightContinuous_modification_of_bounded_elemStochIntegral`
**Status**: Session 1 — Plan written, implementation starting bottom-up.

## Mathematical plan (validated against blueprint + Mathlib survey)

Doob–Föllmer regularization. Statement requires limits for EVERY ω, modification per-t a.s.,
right-continuity off countable s for EVERY ω. Architecture (bottom-up layers):

### Layer A — discrete ℕ-indexed pathwise lemmas (no measure theory)
- **A1** `upperCrossingTime/lowerCrossingTime` congruence: if `f j ω ≤ a ↔ g j ω ≤ a` and
  `b ≤ f j ω ↔ b ≤ g j ω` ∀j, then crossing times agree. (Mathlib hitting is sInf-based; induct.)
- **A2** pathwise upcrossing inequality WITH correction term:
  `(b−a)·upcrossingsBefore a b f N ω ≤ Σ_{k<N} upcrossingStrat a b f N k ω·(f(k+1)−f k) ω + (a − f N ω)⁺`.
  Proof: apply Mathlib `mul_upcrossingsBefore_le` to `f̃ := f` with `f̃ N := f N ⊔ a` (only endpoint
  modified). A1 ⇒ same crossing times/strat/count. Σ differs by `strat_{N−1}·((a−f N)⁺) ≤ (a−f N)⁺`.
- **A3** alternation ⇒ crossings: if `k₁<…<k_{2m} < N` with `f k_{2i+1} ≤ a`, `b ≤ f k_{2i+2}`,
  then `m ≤ upcrossingsBefore a b f N ω`. (Induction; `hitting_le` of witnesses.)
  PURPOSE: replaces refinement-monotonicity of upcrossing counts entirely (see Layer C).

### Layer B — finite F ⊆ Iic t: elementary integral bridge
Given finite nonempty F ⊆ Iic t sorted `e : Fin n ≃o F`, discrete `f k := X (e (min k (n-1)))`:
- **B2** strat sets `B_k := {ω | upcrossingStrat … k ω = 1} ∈ 𝓕 (e k)` (crossing times are stopping
  times wrt pulled-back filtration; Mathlib `Adapted.isStoppingTime_crossing`-style lemmas).
- **B3** build `S_F : ElementaryPredictableSet 𝓕` from pieces `Ioc (e k) (e (k+1)) × B_k`;
  compute `(S_F.indicator 1 ● X) t ω = Σ_{k<N} strat k ω · (f (k+1) − f k) ω`.
- **B4** expectation bound: `(b−a)·E[upcrossings of X along F] ≤ C_t + |a| + E|X t|` =: (b−a)·K.
- **B5** maximal inequality on finite F: stopping τ := first s∈F with |X_s| > λ; stochastic interval
  as ElementaryPredictableSet; both signs via complement trick
  (E[−(1_A•X)_t] = E[(1_{Āpiece}•X)_t] − E[X_t − X_⊥]). Get `μ(max_{s∈F}|X_s| > λ) ≤ K′/λ`.

### Layer C — countable T' ⊆ ι (parameterized! reused for D, D∪{tₖ}, D∪S): a.s. regularity event
- **C1** `E_m(a,b,d)` := ∃ 2m-alternating tuple in T'∩Iic d. Countable union of tuple events;
  measure continuity from below + A3 + B4 + Markov ⇒ `μ(E_m) ≤ K/m` ⇒ `μ(⋂_m E_m) = 0`.
- **C2** boundedness: `μ(∃ s∈T'∩Iic d, |X_s|>λ) ≤ K′/λ` (B5 + continuity from below) ⇒ a.s. sup < ∞.
- **C3** good set `G(T')`: full-measure, measurable, countably-built: ∀ rational a<b, ∀ d∈D-cofinal:
  no-∞-alternations + bounded on T'∩Iic d.

### Layer D — pure path analysis (fixed ω ∈ G)
- **D0** ∀ x, `(𝓝[>] x ⊓ 𝓟 T').NeBot` (T' dense, DenselyOrdered, NoMaxOrder); same for 𝓝[<] on (⊥,·).
- **D1** ω∈G ⇒ ∀x one-sided limits of X(·,ω) along 𝓟 T' exist: `tendsto_of_no_upcrossings`
  (s := ℚ-cast range, dense; H from C3-alternations; IsBoundedUnder from C2).
- **D2** regularization: `r(x) := lim_{s↓x, s∈T'} X_s(ω)`. Properties: r right-continuous everywhere;
  r has left limit at every x (= D-left-limit of X); for sequences tₖ↓x or ↑x with tₖ ∈ T':
  X_{tₖ}(ω) → corresponding one-sided limit. (Order-topology ε-work; the analytic core.)

### Layer E — assembly
- **E1** D₀ := countable dense (NEEDS `[TopologicalSpace.SeparableSpace ι]` — MUST ADD to statement;
  long-line counterexample shows current typeclasses insufficient. Also add to exists_modification_isCadlag.)
- **E2** Ỹ t ω := r_{D₀}(t,ω) on G, else 0. Measurable per t (sequence limit). `Ỹ_t =ᵐ X_t` may FAIL
  only on S := {t : ¬ Ỹ_t =ᵐ X_t}.
- **E3** S countable: else some `S_n∩Iic d` uncountable (S_n := {t≤d : μ(|Ỹ_t−X_t|>1/n) > 1/n});
  uncountable set in separable+DenselyOrdered linear order has self-accumulation point
  (disjoint (p,b_p) intervals argument — write helper `countable_of_isolated`, ~30 lines);
  monotone sequence tₖ→t* in S_n; rerun Layer C/D with T' := D₀∪{tₖ}∪{t*}: a.s. X_{tₖ}→limit AND
  Ỹ_{tₖ}→same (squeeze: Ỹ_{tₖ} = D₀-right-limit at tₖ lies in closure of X-values in (tₖ,tₖ₊₁)∩D₀)
  ⇒ Ỹ_{tₖ}−X_{tₖ}→0 a.s. ⇒ in prob. Contradiction with 1/n-bound.
- **E4** Final: T″ := D₀ ∪ S (countable dense); G″ := G(T″); 
  `Y t ω := if ω ∈ G″ then (if t ∈ S then X t ω else r_{T″}(t,ω)) else 0`.
  - modification: t∈S: Y_t = X_t on G″ ✓. t∉S: r_{T″}(t,·) = r_{D₀}(t,·) on G∩G″ (limit along
    bigger filter ⇒ along smaller, uniqueness) =ᵐ X_t by t∉S ✓.
  - limits ∀ω: ω∉G″ const 0 ✓. ω∈G″: split 𝓝[>]x = (⊓𝓟S) ⊔ (⊓𝓟Sᶜ) (filter inf-sup-distrib):
    on Sᶜ-part Y=r_{T″} →r_{T″}(x) (D2 rc); on S-part Y=X, S⊆T″, → same by D1. Left limits same.
  - right-continuity off s:=S ∀ω ✓.

## Mathlib assets confirmed present
- `tendsto_of_no_upcrossings` (Topology/Order/LiminfLimsup.lean:318) — needs IsBoundedUnder both sides.
- `mul_upcrossingsBefore_le (hf : a ≤ f N ω)` (Probability/Martingale/Upcrossing.lean:561) — pathwise!
- `upcrossingsBefore`, `upcrossingStrat`, hitting/crossing defs (ℕ-indexed only).

## Known typeclass gap (decision made)
Add `[TopologicalSpace.SeparableSpace ι]` to both lemmas in the file. Mathematically necessary
(countable dense set; long line shows unprovability otherwise). Flag in final report.

## Order of implementation
A1→A2→A3 (this session), then B3/B2 (read SimpleProcess integral first!), B4, B5, C, D, E.
Helpers all in CadlagModification.lean. Public statement otherwise UNCHANGED.
