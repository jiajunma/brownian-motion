/-
Copyright (c) 2026 Kexing Ying. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kexing Ying
-/
module

public import BrownianMotion.StochasticIntegral.Cadlag
public import BrownianMotion.StochasticIntegral.SimpleProcess
public import BrownianMotion.StochasticIntegral.OptionalSampling
public import Mathlib.Probability.Notation
public import Mathlib.Probability.Martingale.Upcrossing

/-! # Cadlag modification stochastic processes -/

@[expose] public section

open MeasureTheory Finset Filter
open scoped ENNReal Topology MeasureTheory

noncomputable section

namespace ProbabilityTheory

variable {ι Ω : Type*} [TopologicalSpace ι] [LinearOrder ι] [OrderBot ι] [OrderTopology ι]
  [FirstCountableTopology ι] -- required for ∀ t : ι, (𝓝[>] t).IsCountablyGenerated
  [DenselyOrdered ι] [NoMaxOrder ι] -- required for ∀ t : ι, (𝓝[>] t).NeBot)
  {mΩ : MeasurableSpace Ω} {𝓕 : Filtration ι mΩ} {μ : Measure Ω}
  {X : ι → Ω → ℝ} {τ σ : Ω → WithTop ι} {i : ι}

-- Is this the correct time index?
variable [Approximable 𝓕 μ]

local notation:25 V " ● " X => SimpleProcess.integral (ContinuousLinearMap.mul ℝ ℝ) V X

/-! ### Discrete upcrossing helpers

Pathwise upcrossing estimates for `ℕ`-indexed processes. These supply the quantitative core of
the regularization argument: the number of upcrossings of `X` along a finite subset of the time
domain is controlled by an elementary stochastic integral. -/

section DiscreteUpcrossing

variable {f g : ℕ → Ω → ℝ} {a b : ℝ} {N : ℕ} {ω : Ω}

/-- `hittingBtwn` only depends on the hitting predicate. -/
lemma hittingBtwn_congr {u v : ℕ → Ω → ℝ} {s : Set ℝ}
    (h : ∀ i ω, u i ω ∈ s ↔ v i ω ∈ s) (n m : ℕ) :
    hittingBtwn u s n m = hittingBtwn v s n m := by
  ext ω
  have hs : {i : ℕ | u i ω ∈ s} = {i : ℕ | v i ω ∈ s} := Set.ext fun i ↦ h i ω
  have hex : (∃ j ∈ Set.Icc n m, u j ω ∈ s) = (∃ j ∈ Set.Icc n m, v j ω ∈ s) :=
    propext (exists_congr fun j ↦ and_congr_right fun _ ↦ h j ω)
  unfold hittingBtwn
  rw [hs, hex]

/-- Upper crossing times only depend on the position of the process relative to `a` and `b`. -/
lemma upperCrossingTime_congr
    (hIic : ∀ i ω, f i ω ≤ a ↔ g i ω ≤ a) (hIci : ∀ i ω, b ≤ f i ω ↔ b ≤ g i ω) (n : ℕ) :
    upperCrossingTime a b f N n = upperCrossingTime a b g N n := by
  have hIic' : ∀ i ω, f i ω ∈ Set.Iic a ↔ g i ω ∈ Set.Iic a := hIic
  have hIci' : ∀ i ω, f i ω ∈ Set.Ici b ↔ g i ω ∈ Set.Ici b := hIci
  induction n with
  | zero => rfl
  | succ n ih =>
    funext ω
    rw [upperCrossingTime_succ_eq, upperCrossingTime_succ_eq, lowerCrossingTime,
      lowerCrossingTime, ih, hittingBtwn_congr hIic', hittingBtwn_congr hIci']

/-- Lower crossing times only depend on the position of the process relative to `a` and `b`. -/
lemma lowerCrossingTime_congr
    (hIic : ∀ i ω, f i ω ≤ a ↔ g i ω ≤ a) (hIci : ∀ i ω, b ≤ f i ω ↔ b ≤ g i ω) (n : ℕ) :
    lowerCrossingTime a b f N n = lowerCrossingTime a b g N n := by
  have hIic' : ∀ i ω, f i ω ∈ Set.Iic a ↔ g i ω ∈ Set.Iic a := hIic
  funext ω
  rw [lowerCrossingTime, lowerCrossingTime, upperCrossingTime_congr hIic hIci,
    hittingBtwn_congr hIic']

lemma upcrossingStrat_congr
    (hIic : ∀ i ω, f i ω ≤ a ↔ g i ω ≤ a) (hIci : ∀ i ω, b ≤ f i ω ↔ b ≤ g i ω) (n : ℕ) :
    upcrossingStrat a b f N n = upcrossingStrat a b g N n := by
  funext ω
  unfold upcrossingStrat
  simp_rw [upperCrossingTime_congr hIic hIci, lowerCrossingTime_congr hIic hIci]

lemma upcrossingsBefore_congr
    (hIic : ∀ i ω, f i ω ≤ a ↔ g i ω ≤ a) (hIci : ∀ i ω, b ≤ f i ω ↔ b ≤ g i ω) :
    upcrossingsBefore a b f N ω = upcrossingsBefore a b g N ω := by
  unfold upcrossingsBefore
  simp_rw [upperCrossingTime_congr hIic hIci]

/-- Pathwise upcrossing inequality with correction term: unlike
`MeasureTheory.mul_upcrossingsBefore_le`, this requires no assumption `a ≤ f N ω`, at the price
of the extra term `max (a - f N ω) 0`. -/
lemma mul_upcrossingsBefore_le_sum_add_max (hab : a < b) :
    (b - a) * upcrossingsBefore a b f N ω ≤
      (∑ k ∈ Finset.range N, upcrossingStrat a b f N k ω * (f (k + 1) - f k) ω)
        + max (a - f N ω) 0 := by
  classical
  rcases Nat.eq_zero_or_pos N with rfl | hN
  · simp [upcrossingsBefore_zero]
  obtain ⟨M, rfl⟩ : ∃ M, N = M + 1 := ⟨N - 1, (Nat.succ_pred_eq_of_pos hN).symm⟩
  set g : ℕ → Ω → ℝ := fun k ω' => if k = M + 1 then max (f k ω') a else f k ω' with hg
  have hIic : ∀ i ω', g i ω' ≤ a ↔ f i ω' ≤ a := by
    intro i ω'
    simp only [hg]
    split_ifs with h
    · simp
    · rfl
  have hIci : ∀ i ω', b ≤ g i ω' ↔ b ≤ f i ω' := by
    intro i ω'
    simp only [hg]
    split_ifs with h
    · rw [le_max_iff]
      simp only [or_iff_left_iff_imp]
      exact fun hba ↦ absurd (hba.trans_lt hab) (lt_irrefl b)
    · rfl
  have hga : a ≤ g (M + 1) ω := by simp [hg]
  have key := mul_upcrossingsBefore_le (f := g) (N := M + 1) (ω := ω) hga hab
  rw [upcrossingsBefore_congr hIic hIci] at key
  simp only [upcrossingStrat_congr hIic hIci] at key
  refine key.trans ?_
  rw [Finset.sum_range_succ, Finset.sum_range_succ
    (f := fun k ↦ upcrossingStrat a b f (M + 1) k ω * (f (k + 1) - f k) ω)]
  have hsum : ∀ k ∈ Finset.range M,
      upcrossingStrat a b f (M + 1) k ω * (g (k + 1) - g k) ω
        = upcrossingStrat a b f (M + 1) k ω * (f (k + 1) - f k) ω := by
    intro k hk
    rw [Finset.mem_range] at hk
    have h1 : g (k + 1) = f (k + 1) := by
      simp only [hg, if_neg (Nat.succ_lt_succ hk).ne]
    have h2 : g k = f k := by
      simp only [hg, if_neg (hk.trans M.lt_succ_self).ne]
    rw [h1, h2]
  rw [Finset.sum_congr rfl hsum, add_assoc]
  gcongr
  have hgM : g M = f M := by simp only [hg, if_neg M.lt_succ_self.ne]
  have hgM1 : g (M + 1) ω = f (M + 1) ω + max (a - f (M + 1) ω) 0 := by
    simp only [hg, if_pos rfl]
    rcases le_total a (f (M + 1) ω) with h | h
    · rw [max_eq_left h, max_eq_right (by linarith)]
      ring
    · rw [max_eq_right h, max_eq_left (by linarith)]
      ring
  rw [Pi.sub_apply, hgM, hgM1]
  have h01 : 0 ≤ upcrossingStrat a b f (M + 1) M ω := upcrossingStrat_nonneg
  have h11 : upcrossingStrat a b f (M + 1) M ω ≤ 1 := upcrossingStrat_le_one
  have hmax : 0 ≤ max (a - f (M + 1) ω) 0 := le_max_right _ _
  calc upcrossingStrat a b f (M + 1) M ω * (f (M + 1) ω + max (a - f (M + 1) ω) 0 - f M ω)
      = upcrossingStrat a b f (M + 1) M ω * (f (M + 1) - f M) ω
        + upcrossingStrat a b f (M + 1) M ω * max (a - f (M + 1) ω) 0 := by
        rw [Pi.sub_apply]; ring
    _ ≤ upcrossingStrat a b f (M + 1) M ω * (f (M + 1) - f M) ω + max (a - f (M + 1) ω) 0 := by
        gcongr
        calc upcrossingStrat a b f (M + 1) M ω * max (a - f (M + 1) ω) 0
            ≤ 1 * max (a - f (M + 1) ω) 0 := by gcongr
          _ = max (a - f (M + 1) ω) 0 := one_mul _

/-- Alternations force upcrossings: if there are `m` pairs of (strictly increasing) times below
`N` at which `f` is alternately strictly below `a` and strictly above `b`, then `f` has at least
`m` upcrossings of `[a, b]` before `N`. -/
lemma le_upcrossingsBefore_of_alternating (hab : a < b) {m : ℕ} {c : ℕ → ℕ}
    (hmono : ∀ i, i + 1 < 2 * m → c i < c (i + 1))
    (hN : ∀ i < 2 * m, c i < N)
    (ha : ∀ i < m, f (c (2 * i)) ω < a)
    (hb : ∀ i < m, b < f (c (2 * i + 1)) ω) :
    m ≤ upcrossingsBefore a b f N ω := by
  rcases Nat.eq_zero_or_pos m with rfl | hm
  · simp
  -- key step: `i + 1 ≤ upcrossingsBefore a b f (c (2 * i + 1) + 1) ω` for all `i < m`
  have key : ∀ i, i < m → i + 1 ≤ upcrossingsBefore a b f (c (2 * i + 1) + 1) ω := by
    intro i
    induction i with
    | zero =>
      intro h0
      have := upcrossingsBefore_lt_of_exists_upcrossing (f := f) (ω := ω) (N := 0) hab
        (Nat.zero_le (c 0)) (ha 0 h0) (hmono 0 (by omega)).le (hb 0 h0)
      simpa [upcrossingsBefore_zero] using this
    | succ i ih =>
      intro hi
      have h1 : i + 1 ≤ upcrossingsBefore a b f (c (2 * i + 1) + 1) ω := ih (by omega)
      have h2 := upcrossingsBefore_lt_of_exists_upcrossing (f := f) (ω := ω)
        (N := c (2 * i + 1) + 1) hab
        (show c (2 * i + 1) + 1 ≤ c (2 * (i + 1)) from hmono (2 * i + 1) (by omega))
        (ha (i + 1) hi)
        (show c (2 * (i + 1)) ≤ c (2 * (i + 1) + 1) from (hmono (2 * (i + 1)) (by omega)).le)
        (hb (i + 1) hi)
      omega
  have hlast := key (m - 1) (by omega)
  have hmono' := upcrossingsBefore_mono (f := f) hab
    (show c (2 * (m - 1) + 1) + 1 ≤ N from hN (2 * (m - 1) + 1) (by omega))
  have hm1 : m - 1 + 1 = m := by omega
  rw [hm1] at hlast
  exact hlast.trans (hmono' ω)

end DiscreteUpcrossing

/-! ### Finite skeletons and the elementary integral bridge

Discrete data along a monotone sequence of times is converted into elementary predictable sets,
whose elementary stochastic integrals compute weighted sums of increments of `X`. -/

section Bridge

set_option linter.unusedSectionVars false

/-- The filtration on `ℕ` obtained by pulling back `𝓕` along a monotone sequence of times. -/
def pullbackFiltration (𝓕 : Filtration ι mΩ) {idx : ℕ → ι} (hidx : Monotone idx) :
    Filtration ℕ mΩ where
  seq k := 𝓕 (idx k)
  mono' _ _ h := 𝓕.mono (hidx h)
  le' _ := 𝓕.le _

@[simp] lemma pullbackFiltration_apply {idx : ℕ → ι} (hidx : Monotone idx) (k : ℕ) :
    pullbackFiltration 𝓕 hidx k = 𝓕 (idx k) := rfl

/-- The monotone enumeration of a finite set of times, extended by the constant `t` at indices
beyond `F.card`. -/
noncomputable def finIdx (F : Finset ι) (t : ι) : ℕ → ι := fun k ↦
  if h : k < F.card then (F.orderIsoOfFin rfl ⟨k, h⟩ : ι) else t

lemma finIdx_mem {F : Finset ι} {t : ι} {k : ℕ} (h : k < F.card) : finIdx F t k ∈ F := by
  rw [finIdx, dif_pos h]
  exact (F.orderIsoOfFin rfl ⟨k, h⟩).2

lemma finIdx_eq_of_card_le {F : Finset ι} {t : ι} {k : ℕ} (h : F.card ≤ k) :
    finIdx F t k = t := by
  rw [finIdx, dif_neg (by omega)]

lemma finIdx_le {F : Finset ι} {t : ι} (hF : ∀ s ∈ F, s ≤ t) (k : ℕ) : finIdx F t k ≤ t := by
  rcases lt_or_ge k F.card with h | h
  · exact hF _ (finIdx_mem h)
  · exact (finIdx_eq_of_card_le h).le

lemma finIdx_lt_of_lt {F : Finset ι} {t : ι} {k l : ℕ} (hkl : k < l) (hl : l < F.card) :
    finIdx F t k < finIdx F t l := by
  rw [finIdx, finIdx, dif_pos (hkl.trans hl), dif_pos hl]
  exact_mod_cast (F.orderIsoOfFin rfl).strictMono (by exact_mod_cast hkl)

lemma finIdx_monotone {F : Finset ι} {t : ι} (hF : ∀ s ∈ F, s ≤ t) : Monotone (finIdx F t) := by
  intro k l hkl
  rcases eq_or_lt_of_le hkl with rfl | hkl
  · exact le_rfl
  rcases lt_or_ge l F.card with h | h
  · exact (finIdx_lt_of_lt hkl h).le
  · rw [finIdx_eq_of_card_le h]
    exact finIdx_le hF k

lemma exists_finIdx_eq {F : Finset ι} {t : ι} {s : ι} (hs : s ∈ F) :
    ∃ k, k < F.card ∧ finIdx F t k = s := by
  obtain ⟨k, hk⟩ := (F.orderIsoOfFin rfl).surjective ⟨s, hs⟩
  exact ⟨k, k.2, by rw [finIdx, dif_pos k.2, Fin.eta, hk]⟩

/-- **Bridge lemma**: a finite collection of `{0,1}`-valued adapted weights along a monotone
sequence of times below `t` is realized by an elementary predictable set whose elementary
stochastic integral at time `t` is the weighted sum of increments of `X`. -/
lemma exists_elementaryPredictableSet_integral_eq {t : ι} (n : ℕ) {idx : ℕ → ι}
    (hidx : Monotone idx) (hidxt : ∀ k, idx k ≤ t) {W : ℕ → Ω → ℝ}
    (hW01 : ∀ k, k < n → ∀ ω, W k ω = 0 ∨ W k ω = 1)
    (hWmeas : ∀ k, k < n → Measurable[𝓕 (idx k)] (W k)) :
    ∃ S : ElementaryPredictableSet 𝓕, ∀ ω,
      (S.indicator (1 : ℝ) ● X) t ω
        = ∑ k ∈ Finset.range n, W k ω * (X (idx (k + 1)) ω - X (idx k) ω) := by
  classical
  set K : Finset ℕ := {k ∈ Finset.range n | idx k < idx (k + 1)} with hK
  have hKmem : ∀ {k}, k ∈ K → k < n ∧ idx k < idx (k + 1) := by
    intro k hk
    simpa [hK] using hk
  have hinj : Set.InjOn (fun k ↦ (idx k, idx (k + 1))) K := by
    intro k hk l hl hkl
    simp only [Prod.mk.injEq] at hkl
    by_contra hne
    rcases lt_or_gt_of_ne hne with h | h
    · exact absurd ((hidx (Nat.succ_le_of_lt h)).trans_eq hkl.1.symm) (hKmem hk).2.not_ge
    · exact absurd ((hidx (Nat.succ_le_of_lt h)).trans_eq hkl.1) (hKmem hl).2.not_ge
  refine ⟨⟨∅, K.image fun k ↦ (idx k, idx (k + 1)),
    fun p ↦ if h : ∃ k ∈ K, (idx k, idx (k + 1)) = p then W h.choose ⁻¹' {1} else ∅,
    ?_, @MeasurableSet.empty _ (𝓕 ⊥), ?_, ?_⟩, ?_⟩
  · -- le_of_mem_I
    intro p hp
    obtain ⟨k, hk, rfl⟩ := Finset.mem_image.1 hp
    exact (hKmem hk).2.le
  · -- measurableSet_set
    intro p hp
    obtain ⟨k, hk, rfl⟩ := Finset.mem_image.1 hp
    have hex : ∃ k' ∈ K, (idx k', idx (k' + 1)) = (idx k, idx (k + 1)) := ⟨k, hk, rfl⟩
    simp only [dif_pos hex]
    obtain ⟨hcK, hceq⟩ := hex.choose_spec
    have h1 : idx hex.choose = idx k := (Prod.ext_iff.1 hceq).1
    have h2 : MeasurableSet[𝓕 (idx hex.choose)] (W hex.choose ⁻¹' {1}) :=
      hWmeas _ (hKmem hcK).1 (measurableSet_singleton 1)
    rwa [h1] at h2
  · -- pairwiseDisjoint
    intro p hp q hq hpq
    simp only [Finset.coe_image, Set.mem_image, Finset.mem_coe] at hp hq
    obtain ⟨k, hk, rfl⟩ := hp
    obtain ⟨l, hl, rfl⟩ := hq
    have hkl : k ≠ l := fun h ↦ hpq (by rw [h])
    have hIoc : Disjoint (Set.Ioc (idx k) (idx (k + 1))) (Set.Ioc (idx l) (idx (l + 1))) := by
      rcases lt_or_gt_of_ne hkl with h | h
      · exact Set.Ioc_disjoint_Ioc_of_le (hidx (Nat.succ_le_of_lt h))
      · exact (Set.Ioc_disjoint_Ioc_of_le (hidx (Nat.succ_le_of_lt h))).symm
    exact Set.disjoint_left.2 fun x hx hx' ↦
      Set.disjoint_left.1 hIoc hx.1 hx'.1
  · -- the integral computation
    intro ω
    rw [ElementaryPredictableSet.integral_indicator_apply,
      Finset.sum_image fun k hk l hl h ↦ hinj hk hl h]
    refine (Finset.sum_congr rfl fun k hk ↦ ?_).trans
      (Finset.sum_subset (Finset.filter_subset _ _) fun k hk hkK ↦ ?_)
    · -- per-term equality on K
      have hex : ∃ k' ∈ K, (idx k', idx (k' + 1)) = (idx k, idx (k + 1)) := ⟨k, hk, rfl⟩
      have hchoose : hex.choose = k := hinj hex.choose_spec.1 hk hex.choose_spec.2
      have hst : ∀ j, stoppedProcess X (fun _ ↦ (t : WithTop ι)) (idx j) ω = X (idx j) ω :=
        fun j ↦ stoppedProcess_eq_of_le (by exact_mod_cast hidxt j)
      simp only [dif_pos hex, hchoose]
      rcases hW01 k (hKmem hk).1 ω with h0 | h1
      · rw [Set.indicator_of_notMem (by simp [h0]), h0, zero_mul]
      · rw [Set.indicator_of_mem (by simp [h1]), h1, one_mul]
        simp [ContinuousLinearMap.mul_apply', hst]
    · -- terms outside K vanish
      have hno : ¬ idx k < idx (k + 1) := fun h ↦ hkK (by simp [hK, Finset.mem_range.1 hk, h])
      have heq : idx (k + 1) = idx k :=
        le_antisymm (not_lt.1 hno) (hidx k.le_succ)
      rw [heq, sub_self, mul_zero]

end Bridge

/-- If `X` is an adapted integrable stochastic process such that the sets
`{𝔼[(𝟙_A ● X) t] | A elementary predicatable}` is bounded for any t, then it has a modification `Y`
which has left and right limits everywhere and is right continuous on a co-countable set
`s : Set ι`. -/
lemma exists_modification_left_right_limit [IsFiniteMeasure μ]
    (hX : StronglyAdapted 𝓕 X) (hXint : ∀ t, Integrable (X t) μ)
    (hXbdd : ∀ t : ι, ∃ C, ∀ S : ElementaryPredictableSet 𝓕, μ[(S.indicator (1 : ℝ) ● X) t] ≤ C) :
    ∃ Y : ι → Ω → ℝ, (∀ t, Y t =ᵐ[μ] X t) ∧
      (∀ x ω, ∃ l, Tendsto (Y · ω) (𝓝[<] x) (𝓝 l)) ∧ -- left limit
      (∀ x ω, ∃ l, Tendsto (Y · ω) (𝓝[>] x) (𝓝 l)) ∧ -- right limit
      ∃ s : Set ι, s.Countable ∧ ∀ x ∉ s, ∀ ω, ContinuousWithinAt (Y · ω) (Set.Ioi x) x := by
  sorry

/-- If `X` is an adapted integrable stochastic process which is right continuous in probability,
and is such that the set `{𝔼[(𝟙_A ● X) t] | A elementary predicatable}` is bounded for any t,
then it admits a cadlag modification. -/
lemma exists_modification_isCadlag [IsFiniteMeasure μ]
    (hX : StronglyAdapted 𝓕 X) (hXint : ∀ t, Integrable (X t) μ)
    (hXRC : ∀ t, TendstoInMeasure μ X (𝓝[>] t) (X t))
    (hXbdd : ∀ t : ι, ∃ C, ∀ S : ElementaryPredictableSet 𝓕, μ[(S.indicator (1 : ℝ) ● X) t] ≤ C) :
    ∃ Y : ι → Ω → ℝ, (∀ t, Y t =ᵐ[μ] X t) ∧ (∀ t, Integrable (Y t) μ) ∧ ∀ ω, IsCadlag (Y · ω) := by
  classical
  obtain ⟨Y, hY, hYLL, hYRL, s, hs, hYCont⟩ := exists_modification_left_right_limit hX hXint hXbdd
  set S := ⋃ t ∈ s, {ω | ¬ ContinuousWithinAt (Y · ω) (Set.Ioi t) t} with hSdef
  have hS : ∀ᵐ ω ∂μ, ω ∉ S := by
    simp only [ae_iff, not_not, Set.setOf_mem_eq, hSdef, measure_biUnion_null_iff hs]
    refine fun t ht ↦ ae_iff.1 ?_
    choose l hl using hYRL t
    suffices l =ᵐ[μ] X t by
      have : ∀ᵐ ω ∂μ, Tendsto (fun x ↦ Y x ω) (𝓝[>] t) (𝓝 (X t ω)) := by
        filter_upwards [this] with ω hω using by simp [← hω, hl _]
      filter_upwards [this, hY t] with ω hω₁ hω₂ using by rwa [ContinuousWithinAt, hω₂]
    obtain ⟨_, hseq⟩ := exists_seq_tendsto (𝓝[>] t)
    exact tendstoInMeasure_ae_unique ((tendstoInMeasure_of_tendsto_ae
      (fun _ ↦ (hXint _).1.congr (hY _).symm)
      (ae_of_all _ <| fun ω ↦ (hl ω).comp hseq)).congr (fun _ ↦ hY _) (by rfl))
      ((hXRC t).comp hseq)
  set Z := fun t ω ↦ if ω ∈ S then 0 else Y t ω
  have hZ : ∀ t, Z t =ᵐ[μ] X t :=
    fun t ↦ EventuallyEq.trans
      (by filter_upwards [hS] with ω hω using by simp [Z, if_neg hω]) (hY t)
  refine ⟨Z, hZ, fun t ↦ (hXint t).congr <| (hZ _).symm,
    fun ω ↦ ⟨?_, fun x ↦ by_cases (p := ω ∈ S)
      (fun hω ↦ ⟨0, by simp [Z, if_pos hω, tendsto_const_nhds]⟩)
      (fun hω ↦ by simp [Z, if_neg hω, hYLL x ω])⟩⟩
  by_cases hω : ω ∈ S
  · simpa [Z, if_pos hω] using Function.isRightContinuous_const _
  · simp_rw [Z, if_neg hω]
    intro t
    simp only [hSdef, Set.mem_iUnion, Set.mem_setOf_eq, exists_prop, not_exists,
      not_and, not_not] at hω
    exact by_cases (p := t ∈ s) (fun ht ↦ hω _ ht) <| fun ht ↦ hYCont t ht ω

end ProbabilityTheory
