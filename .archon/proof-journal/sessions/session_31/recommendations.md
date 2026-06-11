# Recommendations for Iteration 032

## High-Priority Notes

- The preprocessed attempt stream for iter-031 again reported `no_prover_lane: true`, but `meta.json`, `prover.jsonl`, and the Doob-Meyer task result show a completed `gpt-5.5` prover lane. Use raw logs/task results as recovered evidence until the preprocessor is fixed.
- Marker sync is current for iter-031 and made zero changes. The newly closed Doob-Meyer helper blocks still lack `\leanok`; review did not touch `\leanok`. Investigate sync/parsing before using those markers as proof-status evidence.
- The two continuous-path explicit-mesh wrappers are now closed. The remaining hard part is no longer continuity-to-uniform-continuity; it is localization plus honest handling of mesh and predictable jumps.

## Closest Target

Prioritize `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The next target should be a bounded/localized wrapper that uses:

- `MeasureTheory.Martingale.eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` for the terminal a.e.-zero conclusion under deterministic `C`, deterministic `V`, pathwise continuity on `[⊥, t]`, and explicit entourage mesh.
- The existing left-limit scaffold in `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` only as context, not as a monolithic proof target.

Keep deterministic partition mesh as an explicit hypothesis unless the assigned helper is specifically a mesh-existence theorem under new honest assumptions such as dense/connected ordered time. The current general ordered Polish setting still admits discrete counterexamples to automatic mesh existence.

## Do Not Retry Blindly

Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one opaque proof. It still bundles predictable-jump removal, bounded localization, deterministic partition or mesh construction, variation-level localization, and application of the bounded-continuous square-integral bridge.

Do not infer a deterministic modulus uniform in `ω` from pathwise continuity. The closed route uses pathwise uniform continuity plus deterministic mesh, then converts finite maxima to a sample-point modulus.

Do not use pathwise finite variation alone as a dominated-convergence dominator. Keep the deterministic variation bound `V` and remove it only through stopped/localized variation levels.

Do not assert `N t - N s` is `𝓕' s`-measurable from strong predictability unless the specific predictable-past or predictable-section statement has been proved.

## Reusable Patterns

- Continuous path to explicit-mesh square integral:
  use `fun ω => (hN_cont ω).uniformContinuousOn_Icc` to supply `hN_unif`, then delegate to `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_uniformContinuousOn`.
- Terminal a.e. zero:
  destructure the square-integral result into `hN_sq_int` and `hN_sq_zero`, then apply `MeasureTheory.ae_eq_zero_of_integral_sq_eq_zero`.
- Uniformity notation:
  keep `open scoped Uniformity` whenever statements use `𝓤`; otherwise Lean reports `Unknown identifier 𝓤` with `autoImplicit` disabled.

## Deferred

Keep `QuadraticVariation.lean` deferred unless the Doob-Meyer route stalls structurally. Its `IsLocalMartingale.isLocalSubmartingale_sq_norm` statement is still overgeneral for the known route and likely needs finite-measure/usual localization plus a bounded-stopping/local square-integrability refinement.
