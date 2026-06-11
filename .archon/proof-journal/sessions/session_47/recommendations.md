# Recommendations for Iteration 048

## Prioritize

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but do not assign the full predictable finite-variation reduction as a single theorem. The closest useful route is to integrate the new wrapper into the next bounded/localized subcase where all of its explicit hypotheses are already available or can be introduced honestly.

The new endpoint is:

- `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn`

It should replace any local proof pattern that separately derives `N t = 0`, proves `N t = N_{t-}`, and then manually composes to `N_{t-}=0`.

## Reusable Pattern

For terminal and left-limit zero under explicit localizing hypotheses:

```lean
have hzero : N t =ᵐ[P'] 0 :=
  hN.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn
    hN_cadlag hN_zero hτ hu hu0 hut hus hC_nonneg hV_nonneg hbound_horizon
    hvar_bound hN_cont hmesh
have hjump : N t =ᵐ[P'] fun ω => Function.leftLim (N · ω) t :=
  hN.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound
    hN_cadlag hN_pred hN_var hτ ht hv_lt hv_tendsto hC_nonneg hbound_horizon
exact ⟨hzero, hjump.symm.trans hzero⟩
```

## Do Not Retry Yet

- `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` remains too broad for a direct retry. It still lacks construction of deterministic left-approaching sequences, bounded/variation localization, continuity inputs, deterministic partitions, and mesh/refinement hypotheses.
- `ProbabilityTheory.IsLocalSubmartingale.doob_meyer` should remain deferred until the predictable finite-variation bridge closes.
- `IsLocalMartingale.isLocalSubmartingale_sq_norm` remains a separate QuadraticVariation dependency and was not advanced in this iteration.

## Verification Baseline

The next plan can rely on the following checks from review:

- `lean_verify` for the new wrapper reported only `[propext, Classical.choice, Quot.sound]`.
- `lake env lean` passed for `DoobMeyer.lean`, `QuadraticVariation.lean`, and `QuadraticVariationBrownian.lean`.
- `lake build` passed.
- Blueprint doctor reported no structural issues.
