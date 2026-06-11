/-
Copyright (c) 2025 Rémy Degenne. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Rémy Degenne
-/
module

public import BrownianMotion.Gaussian.BrownianMotion
public import BrownianMotion.StochasticIntegral.QuadraticVariation

/-! # Quadratic variation of Brownian motion

-/

@[expose] public section

open MeasureTheory Filter Filtration
open scoped ENNReal NNReal

namespace ProbabilityTheory

/-- The natural filtration of the canonical Brownian motion. -/
noncomputable abbrev brownianNaturalFiltration :
    Filtration ℝ≥0 (inferInstance : MeasurableSpace (ℝ≥0 → ℝ)) :=
  natural brownian fun t ↦ (measurable_brownian t).stronglyMeasurable

/-- The canonical Brownian motion has càdlàg paths. -/
lemma isCadlag_brownian (ω : ℝ≥0 → ℝ) : IsCadlag (brownian · ω) :=
  Continuous.isCadlag (continuous_brownian ω)

/-- The canonical Brownian motion is a martingale with respect to its natural filtration. -/
lemma martingale_brownian :
    Martingale brownian brownianNaturalFiltration gaussianLimit := by
  haveI : IsFilteredPreBrownian brownian brownianNaturalFiltration gaussianLimit :=
    IsPreBrownian.isFilteredPreBrownian (X := brownian) (P := gaussianLimit) measurable_brownian
  exact IsPreBrownian.isMartingale brownian brownianNaturalFiltration gaussianLimit

/-- The canonical Brownian motion is a local martingale with respect to its natural filtration. -/
lemma isLocalMartingale_brownian :
    IsLocalMartingale brownian brownianNaturalFiltration gaussianLimit :=
  Martingale.IsLocalMartingale martingale_brownian isCadlag_brownian

/-- The quadratic variation process attached to the canonical Brownian motion. -/
noncomputable abbrev brownianQuadraticVariation : ℝ≥0 → (ℝ≥0 → ℝ) → ℝ :=
  quadraticVariation isLocalMartingale_brownian isCadlag_brownian

end ProbabilityTheory
