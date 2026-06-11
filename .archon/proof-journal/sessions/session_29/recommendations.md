# Recommendations for Iteration 030

## High-Priority Notes

- The preprocessed attempt stream for iter-029 again reported `no_prover_lane: true`, but `meta.json`, `prover.jsonl`, and the Doob-Meyer task result show a completed `gpt-5.5` prover lane. The next planner should use the task result/raw log as recovered evidence and treat the preprocessor as unreliable for this route until fixed.
- Marker sync is current for iter-029 and made zero changes. The closed deterministic-modulus and eventual-modulus blueprint blocks still lack `\leanok`; review did not touch `\leanok`. Investigate sync/parsing before using those markers as proof-status evidence.
- The prover added `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_sup_modulus` in Lean, but there is no corresponding blueprint block. If this helper remains part of the intended route, add a bounded prose block and wire later uses through it.

## Closest Target

Prioritize `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The next target should be a mesh-to-largest-increment helper feeding:

`MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_sup_modulus`.

State it with explicit deterministic partitions and an explicit mesh/refinement hypothesis. It should prove that continuity on `[⊥, t]` gives, for a.e. `ω`, convergence to zero of

```lean
fun n => (((Finset.range (m n)).sup fun i =>
  ‖N (u n (i + 1)) ω - N (u n i) ω‖₊ : NNReal) : ℝ)
```

If the general ordered Polish time index makes mesh construction awkward, isolate that construction in its own helper instead of changing public theorem signatures.

## Do Not Retry Blindly

Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one opaque proof. It still bundles predictable-jump removal, bounded localization, deterministic partition construction, mesh-to-modulus conversion, and the bounded-continuous square-integral argument.

Do not infer a deterministic modulus uniform in `ω` from pathwise continuity. The now-closed route accepts sample-point moduli, and the finite-max helper is the clean bridge from continuity along deterministic partitions.

Do not use pathwise finite variation alone as a dominated-convergence dominator. Keep the deterministic variation bound `V` and remove it only through stopped/localized variation levels.

Do not assert `N t - N s` is `𝓕' s`-measurable from strong predictability unless the specific predictable-past/section statement has been proved.

## Reusable Patterns

- Pathwise modulus inside an a.e. event:
  `filter_upwards [hvar_bound, hinc_modulus] with ω hω_var hω_modulus`, choose `δω`, apply `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound`, then `simpa [Real.norm_eq_abs, sq_abs]`.
- Finite maximum to modulus:
  use `((Finset.range (m n)).sup fun i => ‖...‖₊ : NNReal)` as the nonnegative modulus; each increment is bounded by `Finset.le_sup`, and `exact_mod_cast` bridges back to real norms.
- Terminal zero-square-integral endpoint:
  call `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`, then use `MeasureTheory.ae_eq_zero_of_integral_sq_eq_zero` in the a.e.-zero core.

## Deferred

Keep `QuadraticVariation.lean` deferred unless the Doob-Meyer route stalls structurally. Its `IsLocalMartingale.isLocalSubmartingale_sq_norm` statement is still overgeneral for the known route and likely needs finite-measure/usual localization plus a bounded-stopping/local square-integrability refinement.
