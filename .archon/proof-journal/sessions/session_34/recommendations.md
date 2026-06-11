# Recommendations

## Prioritize

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The next target should be a narrow helper that feeds the new theorem
`MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`.
It should construct or package the stopped-process deterministic horizon bounds, deterministic variation bounds, path continuity on `[⊥, t]`, and explicit mesh assumptions.

## Do Not Retry Monolithically

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a single proof. The same structural blockers remain: predictable-jump removal, bounded/variation localization, continuity transfer, deterministic mesh management, and the final application of the bounded-continuous bridge.

## Reusable Patterns

- Fixed-time localizing-sequence cover:

```lean
filter_upwards [hτ.tendsto_top] with ω htop
simp only [tendsto_atTop_nhds] at htop
obtain ⟨n, hn⟩ := htop (Set.Ioi (t : WithTop κ)) (by simp) isOpen_Ioi
exact ⟨n, hn n le_rfl⟩
```

- Stopped-process true martingales from a true martingale with càdlàg paths:

```lean
exact hN.stoppedProcess_indicator
  (fun ω ↦ (hN_cadlag ω).right_continuous)
  (hτ.isStoppingTime n)
```

For dot notation, keep the cover helper under `_root_.ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt`.

## Tooling Notes

The attempt preprocessor again emitted only `no_prover_lane: true` even though the prover ran and passed verification. Continue checking `meta.json`, `prover.jsonl`, and task results when this mismatch appears.

`sync_leanok` is current for iter-034 and made zero changes. Newly closed Doob-Meyer helper blocks still lack `\leanok`; review agents should not patch those markers manually.
