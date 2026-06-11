/-
Copyright (c) 2025 Rémy Degenne. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Rémy Degenne
-/
module

public import BrownianMotion.StochasticIntegral.ClassD

/-! # Doob-Meyer decomposition theorem

-/

@[expose] public section

open MeasureTheory Filter
open scoped ENNReal

namespace ProbabilityTheory

variable {ι Ω : Type*} [LinearOrder ι] [OrderBot ι] [TopologicalSpace ι] [OrderTopology ι]
  {mΩ : MeasurableSpace Ω} {P : Measure Ω} {X : ι → Ω → ℝ} {𝓕 : Filtration ι mΩ}
  [MeasurableSpace ι]

omit [TopologicalSpace ι] [OrderTopology ι] [MeasurableSpace ι] in
/-- Adding an integrable `𝓕_⊥`-measurable random variable as a time-constant process preserves
the martingale property.  This is the non-local closure fact needed after localization in the
normalized Doob-Meyer proof. -/
lemma _root_.MeasureTheory.Martingale.add_const_fun [SigmaFiniteFiltration P 𝓕]
    {M : ι → Ω → ℝ} {Z : Ω → ℝ} (hM : Martingale M 𝓕 P)
    (hZ_meas : StronglyMeasurable[𝓕 ⊥] Z) (hZ_int : Integrable Z P) :
    Martingale (M + fun _ ↦ Z) 𝓕 P := by
  exact hM.add (martingale_const_fun 𝓕 P hZ_meas hZ_int)

omit [OrderBot ι] [TopologicalSpace ι] [OrderTopology ι] [MeasurableSpace ι] in
/-- Pathwise running-sup estimate for subtracting a time-constant random variable. -/
lemma runningSup_norm_sub_const_le (A : ι → Ω → ℝ) (Z : Ω → ℝ) (t : ι) (ω : Ω) :
    (⨆ s ≤ t, ‖A s ω - Z ω‖ₑ) ≤ (⨆ s ≤ t, ‖A s ω‖ₑ) + ‖Z ω‖ₑ := by
  refine iSup₂_le fun s hs ↦ ?_
  calc
    ‖A s ω - Z ω‖ₑ ≤ ‖A s ω‖ₑ + ‖Z ω‖ₑ := by
      simpa [sub_eq_add_neg] using enorm_add_le (A s ω) (-Z ω)
    _ ≤ (⨆ u ≤ t, ‖A u ω‖ₑ) + ‖Z ω‖ₑ :=
      add_le_add (le_iSup₂_of_le s hs le_rfl) le_rfl

namespace IsLocalSubmartingale

theorem doob_meyer (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    ∃ (M A : ι → Ω → ℝ), X = M + A ∧ IsLocalMartingale M 𝓕 P ∧ (∀ ω, IsCadlag (M · ω)) ∧
      IsStronglyProgressive 𝓕 A ∧ (∀ ω, IsCadlag (A · ω)) ∧ (HasLocallyIntegrableSup A 𝓕 P)
      ∧ (∀ ω, Monotone (A · ω)) := by
  sorry

/-- A normalized local Doob-Meyer decomposition whose predictable part starts from zero. -/
theorem doob_meyer_normalized (hX : IsLocalSubmartingale X 𝓕 P)
    (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    ∃ (M A : ι → Ω → ℝ), X = M + A ∧ IsLocalMartingale M 𝓕 P ∧
      (∀ ω, IsCadlag (M · ω)) ∧ IsStronglyProgressive 𝓕 A ∧
      (∀ ω, IsCadlag (A · ω)) ∧ HasLocallyIntegrableSup A 𝓕 P ∧
      (∀ ω, Monotone (A · ω)) ∧ (∀ ω, A ⊥ ω = 0) := by
  classical
  rcases hX.doob_meyer hX_cadlag with
    ⟨M, A, hXA, hM, hM_cadlag, hA_prog, hA_cadlag, hA_int, hA_mono⟩
  let C : ι → Ω → ℝ := fun _ ω => A ⊥ ω
  have hC_prog : IsStronglyProgressive 𝓕 C := by
    intro i
    exact ((hA_prog.stronglyAdapted ⊥).mono (𝓕.mono bot_le)).comp_measurable measurable_snd
  have hC_cadlag : ∀ ω, IsCadlag (C · ω) := by
    intro ω
    exact (continuous_const : Continuous fun _ : ι => A ⊥ ω).isCadlag
  refine ⟨M + C, A - C, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · ext t ω
    rw [hXA]
    simp only [Pi.add_apply, Pi.sub_apply, C]
    ring
  · -- Missing closure: adding the time-constant initial value to a local martingale.
    -- After simultaneous localization, this should reduce to
    -- `MeasureTheory.Martingale.add_const_fun`; the current theorem signature does not provide the
    -- optional-stopping/stability assumptions needed to put the martingale and integrable-sup
    -- localizing sequences on the same stopped process.
    sorry
  · intro ω
    exact (hM_cadlag ω).add (hC_cadlag ω)
  · simpa only [Pi.sub_apply] using hA_prog.sub hC_prog
  · intro ω
    have hnegC : IsCadlag fun t : ι => (-1 : ℝ) • C t ω := (hC_cadlag ω).const_smul (-1)
    have hadd : IsCadlag ((fun t : ι => A t ω) + fun t => (-1 : ℝ) • C t ω) :=
      (hA_cadlag ω).add hnegC
    simpa [sub_eq_add_neg, C] using hadd
  · -- Missing closure: subtracting the initial value preserves locally integrable supremum.
    -- The pathwise domination needed for the integrability half is isolated in
    -- `runningSup_norm_sub_const_le`; the remaining issue is transporting the strongly measurable
    -- running-sup process under this shift with the current weak assumptions.
    sorry
  · intro ω i j hij
    exact sub_le_sub_right (hA_mono ω hij) (A ⊥ ω)
  · intro ω
    simp [C]

/-- The local martingale part of the Doob-Meyer decomposition of the local submartingale. -/
noncomputable
def martingalePart (X : ι → Ω → ℝ)
    (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    ι → Ω → ℝ :=
  (hX.doob_meyer_normalized hX_cadlag).choose

/-- The predictable part of the Doob-Meyer decomposition of the local submartingale. -/
noncomputable
def predictablePart (X : ι → Ω → ℝ)
    (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    ι → Ω → ℝ :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose

lemma martingalePart_add_predictablePart
    (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    X = hX.martingalePart X hX_cadlag + hX.predictablePart X hX_cadlag :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose_spec.1

lemma isLocalMartingale_martingalePart
    (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    IsLocalMartingale (hX.martingalePart X hX_cadlag) 𝓕 P :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose_spec.2.1

lemma cadlag_martingalePart (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    ∀ ω, IsCadlag (hX.martingalePart X hX_cadlag · ω) :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose_spec.2.2.1

lemma isStronglyProgressive_predictablePart
    (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    IsStronglyProgressive 𝓕 (hX.predictablePart X hX_cadlag) :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose_spec.2.2.2.1

lemma cadlag_predictablePart (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    ∀ ω, IsCadlag (hX.predictablePart X hX_cadlag · ω) :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose_spec.2.2.2.2.1

lemma hasLocallyIntegrableSup_predictablePart
    (hX : IsLocalSubmartingale X 𝓕 P) (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    HasLocallyIntegrableSup (hX.predictablePart X hX_cadlag) 𝓕 P :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose_spec.2.2.2.2.2.1

lemma monotone_predictablePart (hX : IsLocalSubmartingale X 𝓕 P)
    (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    ∀ ω, Monotone (hX.predictablePart X hX_cadlag · ω) :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose_spec.2.2.2.2.2.2.1

lemma predictablePart_bot_eq_zero (hX : IsLocalSubmartingale X 𝓕 P)
    (hX_cadlag : ∀ ω, IsCadlag (X · ω)) :
    ∀ ω, hX.predictablePart X hX_cadlag ⊥ ω = 0 :=
  (hX.doob_meyer_normalized hX_cadlag).choose_spec.choose_spec.2.2.2.2.2.2.2

end IsLocalSubmartingale

end ProbabilityTheory
