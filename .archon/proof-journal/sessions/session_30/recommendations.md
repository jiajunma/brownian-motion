# Recommendations for Iteration 031

## High-Priority Notes

- The preprocessed attempt stream for iter-030 again reported `no_prover_lane: true`, but `prover.jsonl` and the Doob-Meyer task result show a completed `gpt-5.5` prover lane. Use raw logs/task results as recovered evidence until the preprocessor is fixed.
- Marker sync is current for iter-030 and made zero changes. The newly closed Doob-Meyer helper blocks still lack `\leanok`; review did not touch `\leanok`. Investigate sync/parsing before treating those markers as proof-status evidence.
- The prover added `ContinuousOn.uniformContinuousOn_Icc` in Lean, but there is no blueprint block for it. Add a short block if the next plan uses it as a named step.

## Closest Target

Prioritize `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The next target should be a bounded-continuous/variation-bounded square-integral helper that combines:

- `ContinuousOn.uniformContinuousOn_Icc` to convert path continuity on `[⊥, t]` into pathwise `UniformContinuousOn`.
- `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_uniformContinuousOn` to obtain `Integrable (fun ω => N t ω ^ 2) P' ∧ ∫ ω, N t ω ^ 2 ∂P' = 0`.

Keep the deterministic partition mesh as an explicit hypothesis unless the partition construction itself is the assigned target. If the general ordered Polish time index makes deterministic mesh construction awkward, isolate that construction in a separate helper rather than changing public theorem signatures.

## Do Not Retry Blindly

Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one opaque proof. It still bundles predictable-jump removal, bounded localization, deterministic partition construction, compact continuity to uniform continuity, variation-level localization, and the bounded-continuous square-integral argument.

Do not infer a deterministic modulus uniform in `ω` from pathwise continuity. The now-closed route uses pathwise uniform continuity plus deterministic mesh and then converts finite maxima to a sample-point modulus.

Do not use pathwise finite variation alone as a dominated-convergence dominator. Keep the deterministic variation bound `V` and remove it only through stopped/localized variation levels.

Do not assert `N t - N s` is `𝓕' s`-measurable from strong predictability unless the specific predictable-past/section statement has been proved.

## Reusable Patterns

- Uniform-continuity mesh to finite maximum:
  open `Uniformity`, use `Metric.tendsto_nhds`, pull back the real entourage from `Metric.mem_uniformity_dist`, rewrite `UniformContinuousOn`, then use `Filter.mem_inf_principal` and `Finset.sup_lt_iff`.
- Compact interval Heine-Cantor:
  under `[CompactIccSpace κ]`, close `ContinuousOn f (Set.Icc a b) -> UniformContinuousOn f (Set.Icc a b)` with `isCompact_Icc.uniformContinuousOn_of_continuous`.
- Martingale wrapper:
  build the a.e. max-increment convergence by `filter_upwards with ω` and apply `(hN_unif ω).finite_partition_sup_nnnorm_sub_tendsto_zero hus hmesh`, then delegate to `..._variation_bound_sup_modulus`.

## Deferred

Keep `QuadraticVariation.lean` deferred unless the Doob-Meyer route stalls structurally. Its `IsLocalMartingale.isLocalSubmartingale_sq_norm` statement is still overgeneral for the known route and likely needs finite-measure/usual localization plus a bounded-stopping/local square-integrability refinement.
