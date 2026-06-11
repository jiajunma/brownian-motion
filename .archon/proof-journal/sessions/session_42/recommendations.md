# Recommendations for Iteration 043

Prioritize `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The closest useful next target is a packaging lemma that feeds the new dominated jump set-integral result into
`MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero`. It should keep the remaining analytic/localization assumptions explicit:

```lean
∀ s : {s : κ // s < t}, ∀ A, MeasurableSet[𝓕' s] A →
  ∫ ω in A, (N t ω - Function.leftLim (N · ω) t) ∂P' = 0
```

The new helper
`MeasureTheory.Martingale.setIntegral_jump_leftLim_eq_zero_of_left_approach_of_dominated`
requires three concrete inputs for each strict-past `s` and set `A`: a deterministic `u n < t` tending to `t` from the left, an eventual proof of `s.1 ≤ u n`, and an integrable dominator for `‖N t - N (u n)‖` on `P'.restrict A`.

In the bounded/localized horizon subcase, try to prove a small dominator lemma first: from `∀ r ∈ Set.Icc (⊥ : κ) t, ‖N r ω‖ ≤ C`, derive `‖N t ω - N (u n) ω‖ ≤ 2 * C` whenever `u n ∈ Set.Icc (⊥ : κ) t`. On a finite measure, the constant bound should be integrable on `P'.restrict A`. Keep the nonnegativity hypothesis on `C` explicit.

Do not retry the fixed-earlier-time measurability shortcut. Iter-040 proved only past-sigma jump measurability, iter-041 converted past-sigma measurability plus zero generator integrals to a.e. zero, and iter-042 supplies zero generator integrals only under an explicit left-limit domination hypothesis.

Do not assign the full
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`
until the left-approach sequence package, restricted dominator package, bounded/localized horizon assumptions, and final call to
`ae_eq_leftLim_of_left_approach_past_setIntegral_zero` are separated.

Reusable pattern from this iteration: for martingale finite increments over an earlier event, lift `hA : MeasurableSet[𝓕' s] A` to `MeasurableSet[𝓕' u] A` by `𝓕'.mono`, apply `hN.setIntegral_eq`, then rewrite the increment integral with `MeasureTheory.integral_sub`.

The deterministic blueprint doctor found no structural issues. No manual blueprint marker changes are needed from review.
