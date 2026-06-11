# Recommendations for Iteration 044

## Priority Target

Stay in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but keep the next target below the full predictable finite-variation reduction.

The closest useful target is a bounded-horizon jump-integrability helper that removes the explicit `hjump_int` hypothesis from the new wrapper under the same a.e. deterministic horizon bound. A likely shape is:

```lean
Integrable (fun ω => N t ω - Function.leftLim (N · ω) t) P'
```

from `0 ≤ C`, `∀ᵐ ω, ∀ r ∈ Set.Icc (⊥ : κ) t, ‖N r ω‖ ≤ C`, `hu_lt`, `hu_tendsto`, and finite-variation left-limit convergence. The proof should bound `N t` directly by `C`, bound the left limit by passing the bound along `N (u n) -> leftLim`, then use integrability by domination by a constant on a finite measure.

## Promising Follow-Up

After jump integrability is packaged, prove a wrapper combining it with:

- `Filter.Tendsto.eventually_const_le_of_nhdsWithin_Iio`
- `MeasureTheory.norm_sub_le_two_mul_of_Icc_bound`
- `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound`

This should give bounded predictable-jump removal from just the explicit left-approaching sequence and deterministic a.e. horizon bound.

## Do Not Retry Yet

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic proof. The new bounded wrapper still needs separate sequence existence, jump-integrability, localization, and deterministic mesh inputs before the main reduction can be finished honestly.

Do not use the old fixed-earlier-time measurability shortcut. The sound route remains past-sigma measurability plus generated-past set-integral uniqueness plus dominated left-limit passage.

Do not infer domination from local bounded variation alone. The iter-043 wrapper uses a deterministic a.e. horizon bound by `C`; localization must provide that bound explicitly.

## Reusable Patterns

- A left-approaching sequence is eventually above each fixed strict-past time by pulling back `Set.Ioi s` through `nhdsWithin_le_nhds` and `Ioi_mem_nhds`.
- A deterministic horizon bound controls every terminal increment by `norm_sub_le` and the two endpoint bounds, giving `‖N t - N u‖ ≤ 2 * C`.
- Restricted-event domination can be obtained with `MeasureTheory.ae_restrict_of_ae hbound_horizon`, then discharged pointwise with the deterministic increment bound.

## Blueprint and Tooling

Blueprint doctor found no structural issues in iter-043.

`attempts_raw.jsonl` again reported `no_prover_lane: true` despite a completed prover lane. Continue using `meta.json`, raw prover logs, and task results as recovery evidence when this mismatch appears.
