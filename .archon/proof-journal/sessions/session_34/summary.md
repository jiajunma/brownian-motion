# Session 34 Summary

## Metadata

- Iteration: iter-034.
- Stage: prover review.
- Prover model reported in raw log: `gpt-5.5`.
- Structured attempt data: `.archon/proof-journal/current_session/attempts_raw.jsonl` contains only `{"no_prover_lane": true}`. This is again a preprocessing false positive: `.archon/logs/iter-034/meta.json`, `.archon/logs/iter-034/prover.jsonl`, and `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` show a completed prover lane.
- Sorry count before/after: 23 -> 23 textual `sorry`s project-wide.
- Main file: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

## Targets Attempted

### `ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt`

Status: solved at `DoobMeyer.lean:1607`.

Final proof:

```lean
filter_upwards [hτ.tendsto_top] with ω htop
simp only [tendsto_atTop_nhds] at htop
obtain ⟨n, hn⟩ := htop (Set.Ioi (t : WithTop κ)) (by simp) isOpen_Ioi
exact ⟨n, hn n le_rfl⟩
```

What was learned: the fixed-time localizing-sequence cover is a pure topology step. `hτ.tendsto_top` plus the open neighbourhood `Set.Ioi (t : WithTop κ)` gives, a.e., some `n` with `(t : WithTop κ) < τ n ω`.

### `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`

Status: solved at `DoobMeyer.lean:1621`.

Significant attempt from the raw prover log:

```lean
exact MeasureTheory.Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn
  (N := N) (τ := τ) hZ_mart hN_zero hu hu0 hut hus hC_nonneg hV_nonneg
  hbound_horizon hvar_bound hZ_cont hmesh (hτ.eventually_exists_gt t)
```

Lean first reported:

```text
Invalid field `eventually_exists_gt`: The environment does not contain
`ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt`
```

The helper had been placed under the wrong namespace for dot notation. Moving the helper to `_root_.ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt` fixed the field projection without changing the theorem statement or proof body.

Final proof structure:

```lean
have hZ_mart : ∀ n,
    Martingale
      (stoppedProcess (fun i ↦ {ω | (⊥ : κ) < τ n ω}.indicator (N i)) (τ n))
      𝓕' P' := by
  intro n
  exact hN.stoppedProcess_indicator (fun ω ↦ (hN_cadlag ω).right_continuous)
    (hτ.isStoppingTime n)
exact MeasureTheory.Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn
  (N := N) (τ := τ) hZ_mart hN_zero hu hu0 hut hus hC_nonneg hV_nonneg
  hbound_horizon hvar_bound hZ_cont hmesh (hτ.eventually_exists_gt t)
```

What was learned: this wrapper is bookkeeping only. It derives stopped true martingales from `Martingale.stoppedProcess_indicator`, right-continuity from càdlàg paths, stopping-time facts from `hτ.isStoppingTime`, and the a.e. cover from `hτ.eventually_exists_gt`; all deterministic bounds, variation bounds, continuity, partitions, and mesh hypotheses remain explicit assumptions.

### `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`

Status: not retried, by objective.

The declaration now starts at `DoobMeyer.lean:1694`, with the actual `sorry` at line 1730. The new localizing-sequence wrapper is an ingredient for this reduction, but the reduction still has to construct bounded/variation localizations, manage continuity and mesh hypotheses, and remove predictable jumps.

## Verification

Review reran:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: passes, with deprecated finset warnings and the two expected Doob-Meyer `sorry` warnings.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: passes, with the expected square-norm `sorry` warning.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: passes cleanly.
- `lake build`: passes (`3312 jobs`), with only known project `sorry` warnings and the two Doob-Meyer deprecation warnings.
- Project-wide textual `sorry` count: 23.

Review also ran `lean_verify` on both new declarations. Each depends only on `[propext, Classical.choice, Quot.sound]`, with no source-scan warnings.

Remaining active-chain proof debts:

- `DoobMeyer.lean:1694` declaration warning, actual `sorry` at line 1730: `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- `DoobMeyer.lean:1947` declaration warning, actual `sorry` at line 1952: original weak `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.
- `QuadraticVariation.lean:64` declaration warning, actual `sorry` at line 84: `IsLocalMartingale.isLocalSubmartingale_sq_norm`.

## Blueprint Markers Updated (Manual)

None.

The new localizing-sequence block already has the correct `\lean{...}` annotation in `blueprint/src/chapters/doob_meyer.tex`, and the reduction's `\uses{...}` list includes it. No Mathlib-backed aliases were reported, no renames were needed, and no stale `\notready` marker was found in the checked Doob-Meyer chapter. `sync_leanok` is current for iter-034 (`added: 0`, `removed: 0`); newly closed helper blocks still lack `\leanok`, so the marker-sync anomaly persists.

## Blueprint Doctor

The iter-034 blueprint doctor reported no structural findings: all chapters are included, all `\ref` / `\uses` targets resolve, annotations are non-empty, and no project `.lean` file contains an `axiom` declaration.

## Recommendations

Continue in `DoobMeyer.lean`, but do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one monolithic target.

The closest next split is a localization-construction helper that supplies the deterministic hypotheses needed by `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`: stopped-process horizon bounds, deterministic variation bounds, continuity on `[⊥, t]`, and the explicit mesh hypothesis. Keep predictable-jump removal separate.

Do not assert automatic deterministic mesh existence for arbitrary ordered Polish time, and do not remove the deterministic `V n` bounds without an explicit stopping/localization argument.
