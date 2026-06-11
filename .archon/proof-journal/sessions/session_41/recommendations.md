# Recommendations for Iteration 042

Prioritize `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The closest useful next target is the analytic missing hypothesis for
`MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero`:
prove that for every strict-past time `s < t` and every `A` measurable in `F' s`,

```lean
∫ omega in A, (N t omega - Function.leftLim (N · omega) t) ∂P' = 0
```

under explicit integrability/domination or localization assumptions. Keep this as a separate lemma. Do not assign the full
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` yet.

The promising route is to compare `N t - N_{t-}` with increments `N t - N (u n)` or `N (u n) - N s` on each earlier-filtration set, use martingale set-integral identities for the finite increments, and pass to the left limit. The limit step is the real work; state any needed domination, uniform integrability, bounded localization, or integrability of the jump explicitly.

Do not retry the fixed-earlier-time measurability shortcut. Iter-040 proved only past-sigma measurability of the jump, and iter-041 proved that past-sigma measurability plus zero set integrals implies a.e. zero. Neither result upgrades the jump or increments to arbitrary `F' (u n)` measurability.

Reusable pattern from this iteration: for a linearly ordered filtration, the class `{A | exists s<t, MeasurableSet[F' s] A}` is a pi-system, generates `iSup s<t, F' s`, and `MeasurableSpace.induction_on_inter` can extend identities from generator sets to all past-measurable sets. In the induction callbacks, annotate ambient measurability as `@MeasurableSet Ω' mΩ' A` before using ambient set-integral lemmas.

The deterministic blueprint doctor found no structural issues. No manual blueprint marker changes are needed from review.
