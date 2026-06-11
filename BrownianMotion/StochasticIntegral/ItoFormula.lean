/-
Copyright (c) 2026 Jia-Jun Ma. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Jia-Jun Ma
-/
module

public import BrownianMotion.Gaussian.BrownianMotion
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs

/-! # Itô's formula for Brownian motion: statement layer

This file fixes the *statements* of Itô's formula for Itô processes driven by a scalar
Brownian motion, following the explicit route: the stochastic integral is constructed
directly against `B` (simple processes → Itô isometry → `L²` extension → continuous
version → localization), so that no Doob–Meyer decomposition is involved anywhere.
All quadratic-variation-like quantities appearing in the statements are explicit
Lebesgue integrals.

The definition `stochasticIntegral` is a placeholder (`sorry`): this file pins down the
interfaces and the final statements; constructions and proofs are supplied in subsequent
files.

## Main definitions

- volume on `ℝ≥0`: Lebesgue measure, pulled back from `ℝ`, used for the `ds`-integrals.
- `ProbabilityTheory.IsCompleteFiltration`: every `𝓕 t` contains the `P`-null sets.
  This (and not right-continuity) is the only "usual conditions" ingredient needed:
  the continuous version of the stochastic integral is adapted only up to null sets.
- `ProbabilityTheory.stochasticIntegral`: the process `(H ⋅ B)`, placeholder.
- `ProbabilityTheory.IsItoProcess`: `X = X₀ + ∫₀ᵗ b ds + (σ ⋅ B)ₜ` with progressively
  measurable `b, σ` and a.s. locally integrable `|b| + σ²`.

## Main statements

- `ProbabilityTheory.ito_formula_brownian`: warm-up version, `f ∈ C²(ℝ)` time-independent,
  `X = B`.
- `ProbabilityTheory.ito_formula`: for an Itô process `X` and `f ∈ C²(ℝ × ℝ)` (first
  variable: time),
  `f(t, Xₜ) = f(0, X₀) + ∫₀ᵗ (∂ₜf + ∂ₓf b + ½ ∂ₓₓf σ²) ds + ((∂ₓf(·, X) σ) ⋅ B)ₜ`,
  as an indistinguishability of processes.

## Implementation notes

- Time is indexed by `ℝ≥0` (matching `IsBrownian`), but `f` is defined on all of `ℝ × ℝ`
  to avoid differentiability on a manifold with boundary; times are coerced.
- `f` is jointly `C²`; we do not introduce an anisotropic `C^{1,2}` class. Open-domain
  versions (e.g. for `log` and geometric Brownian motion) are deferred.
- The three `ds`-terms are grouped into a single Lebesgue integral: only one
  integrability argument is needed, the integrand being continuous in `s` after stopping.
-/

@[expose] public section

open MeasureTheory Filter Function
open scoped NNReal ENNReal

/-- Lebesgue measure on `ℝ≥0`, pulled back from `ℝ` along the (measurable-embedding)
coercion. Gives meaning to `∫ s in Set.Iic t, f s` for `t : ℝ≥0`. -/
noncomputable instance : MeasureSpace ℝ≥0 :=
  ⟨(volume : Measure ℝ).comap (↑)⟩

namespace ProbabilityTheory

variable {Ω : Type*} {mΩ : MeasurableSpace Ω} {P : Measure Ω}
  {𝓕 : Filtration ℝ≥0 mΩ} {B X b σ H : ℝ≥0 → Ω → ℝ} {X₀ : Ω → ℝ}

/-- A filtration is **complete** for `P` if every `𝓕 t` contains all `P`-null measurable
sets. We never assume right-continuity of the filtration: every process in this
development has continuous paths. -/
def IsCompleteFiltration (𝓕 : Filtration ℝ≥0 mΩ) (P : Measure Ω) : Prop :=
  ∀ t : ℝ≥0, ∀ s : Set Ω, MeasurableSet s → P s = 0 → MeasurableSet[𝓕 t] s

/-- The stochastic integral `(H ⋅ B)ₜ` of a progressively measurable process `H` against a
Brownian motion `B`: defined for simple processes as `∑ ξᵢ (B_{t_{i+1}} - B_{t_i})`,
extended to `L²(ds × dP)` integrands by the Itô isometry, upgraded to a process with
continuous paths via Doob's `L²` maximal inequality, and extended by localization (with
the hitting times `τ_n = inf {t | ∫₀ᵗ H² ds ≥ n}`) to all progressively measurable `H`
with `∫₀ᵗ H² ds < ∞` a.s. for all `t`. Junk value `0` outside this class.

Placeholder: the construction is supplied in a later file. -/
noncomputable def stochasticIntegral (𝓕 : Filtration ℝ≥0 mΩ) (P : Measure Ω)
    (H B : ℝ≥0 → Ω → ℝ) : ℝ≥0 → Ω → ℝ :=
  sorry

/-- `X` is an **Itô process** with initial value `X₀`, drift `b` and diffusion `σ`, driven
by the Brownian motion `B`, with respect to the filtration `𝓕`:
`X t = X₀ + ∫₀ᵗ b s ds + (σ ⋅ B) t` for all `t`, almost surely. -/
structure IsItoProcess (𝓕 : Filtration ℝ≥0 mΩ) (P : Measure Ω)
    (X : ℝ≥0 → Ω → ℝ) (X₀ : Ω → ℝ) (b σ B : ℝ≥0 → Ω → ℝ) : Prop where
  isBrownian : IsBrownian B P
  isFilteredPreBrownian : IsFilteredPreBrownian B 𝓕 P
  measurable_init : Measurable[𝓕 0] X₀
  progressive_drift : IsStronglyProgressive 𝓕 b
  progressive_diffusion : IsStronglyProgressive 𝓕 σ
  integrable : ∀ᵐ ω ∂P, ∀ t : ℝ≥0,
    IntegrableOn (fun s : ℝ≥0 ↦ |b s ω| + σ s ω ^ 2) (Set.Iic t)
  eq : ∀ᵐ ω ∂P, ∀ t : ℝ≥0,
    X t ω = X₀ ω + (∫ s in Set.Iic t, b s ω) + stochasticIntegral 𝓕 P σ B t ω

/-- **Itô's formula for Brownian motion** (warm-up, time-independent version).
For `f ∈ C²(ℝ)` and a Brownian motion `B`,
`f(Bₜ) = f(B₀) + ((f' ∘ B) ⋅ B)ₜ + ½ ∫₀ᵗ f''(Bₛ) ds`
holds for all `t` simultaneously, almost surely. -/
theorem ito_formula_brownian [IsProbabilityMeasure P]
    (hB : IsBrownian B P) (hB𝓕 : IsFilteredPreBrownian B 𝓕 P)
    (h𝓕 : IsCompleteFiltration 𝓕 P)
    {f : ℝ → ℝ} (hf : ContDiff ℝ 2 f) :
    ∀ᵐ ω ∂P, ∀ t : ℝ≥0, f (B t ω) = f (B 0 ω)
      + stochasticIntegral 𝓕 P (fun s ω ↦ deriv f (B s ω)) B t ω
      + (1 / 2) * ∫ s in Set.Iic t, iteratedDeriv 2 f (B s ω) := by
  sorry

/-- **Itô's formula**. Let `X = X₀ + ∫ b ds + (σ ⋅ B)` be an Itô process and let
`f : ℝ × ℝ → ℝ` be `C²` (first variable: time). Then, almost surely, for all `t`,
`f(t, Xₜ) = f(0, X₀) + ∫₀ᵗ (∂ₜf(s, Xₛ) + ∂ₓf(s, Xₛ) bₛ + ½ ∂ₓₓf(s, Xₛ) σₛ²) ds
+ ((∂ₓf(·, X) σ) ⋅ B)ₜ`.

No Doob–Meyer decomposition is involved: the quadratic variation of `(σ ⋅ B)` is the
explicit process `∫₀ᵗ σ² ds`. -/
theorem ito_formula [IsProbabilityMeasure P]
    (hX : IsItoProcess 𝓕 P X X₀ b σ B) (h𝓕 : IsCompleteFiltration 𝓕 P)
    {f : ℝ → ℝ → ℝ} (hf : ContDiff ℝ 2 ↿f) :
    ∀ᵐ ω ∂P, ∀ t : ℝ≥0, f t (X t ω) = f 0 (X₀ ω)
      + (∫ s in Set.Iic t,
          (deriv (f · (X s ω)) s
            + deriv (f s) (X s ω) * b s ω
            + (1 / 2) * iteratedDeriv 2 (f s) (X s ω) * σ s ω ^ 2))
      + stochasticIntegral 𝓕 P (fun s ω ↦ deriv (f s) (X s ω) * σ s ω) B t ω := by
  sorry

end ProbabilityTheory
