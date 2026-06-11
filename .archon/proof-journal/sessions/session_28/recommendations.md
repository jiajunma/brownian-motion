# Recommendations for Iteration 029

## High-Priority Notes

- The preprocessed attempt stream for iter-028 incorrectly reported `no_prover_lane: true`. The raw prover log, meta file, and task result show a completed `gpt-5.5` prover lane. The next planner should trust the task result/raw log for this iteration and avoid interpreting the proof journal as a real skipped prover round.
- Marker sync is current for iter-028 but did not add `\leanok` to the closed helper block for `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound`. Review did not touch `\leanok`; investigate sync/parsing before treating the blueprint marker state as authoritative for this helper.

## Closest Target

Prioritize `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The next target should be `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation`, or an even smaller helper whose only content is deterministic partition/modulus construction on `[⊥, t]`. The closed helper
`MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound`
is ready to consume:

- monotone deterministic partitions from `⊥` to `t`;
- an a.e. horizon bound;
- an a.e. deterministic total-variation bound `V`;
- a deterministic increment modulus `δ n → 0`.

## Do Not Retry Blindly

Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one opaque proof. It still bundles predictable-jump removal, bounded localization, deterministic partition/modulus construction, and the bounded-continuous square-integral argument. Split those before assigning the full reduction again.

Do not use pathwise finite variation alone as a dominated-convergence dominator. The successful route requires a deterministic variation bound first, obtained from stopping/localizing at variation levels.

Do not assert `N t - N s` is `𝓕' s`-measurable from strong predictability unless the specific past/section measurability statement has been proved. Keep using the predictable-past and left-limit package.

## Reusable Patterns

- Horizon bound to partition bound:
  `filter_upwards [hbound_horizon] with ω hω k; exact hω (u n k) (hus n k)`.
- Square-increment convergence bridge:
  use `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound`, then `simpa [Real.norm_eq_abs, sq_abs]`.
- Terminal zero-square-integral endpoint:
  call `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_refining_partitions`, then use `MeasureTheory.ae_eq_zero_of_integral_sq_eq_zero` in the a.e.-zero core.

## Deferred

Keep `QuadraticVariation.lean` deferred unless the Doob-Meyer route stalls structurally. Its `IsLocalMartingale.isLocalSubmartingale_sq_norm` statement is still overgeneral for the known proof route and likely needs the finite-measure/usual localization context plus a bounded-stopping/local square-integrability refinement.
