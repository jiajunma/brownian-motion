# Session 35 Summary

## Metadata

- Iteration: iter-035.
- Stage: prover review.
- Prover model reported in raw log: `gpt-5.5`.
- Structured attempt data: `.archon/proof-journal/current_session/attempts_raw.jsonl` contains only `{"no_prover_lane": true}`. This is again a preprocessing false positive: `.archon/logs/iter-035/meta.json`, `.archon/logs/iter-035/prover.jsonl`, and `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` show a completed prover lane.
- Sorry count before/after: 23 -> 23 textual `sorry`s project-wide under `BrownianMotion`.
- Main file: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

## Targets Attempted

### `MeasureTheory.stoppedProcess_indicator_bound_on_Icc`

Status: solved at `DoobMeyer.lean:516`.

Recovered attempt:

```lean
intro s hs
by_cases hω : (⊥ : κ) < τ ω
· let g : κ := (min (↑s : WithTop κ) (τ ω)).untopA
  ...
  rw [Set.indicator_of_mem hmem]
  exact hbound g hg_mem
· rw [Set.indicator_of_notMem hnotmem]
  simpa using hC_nonneg
```

What was learned: the deterministic horizon bound needs no measurability or stopping-time hypothesis. The true branch proves the stopped time stays in `Set.Icc ⊥ t` using `WithTop.untopA_le_iff`; the false branch is just the zero indicator plus `0 ≤ C`.

### `BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_Icc`

Status: solved at `DoobMeyer.lean:545`.

Recovered attempt:

```lean
rw [eVariationOn]
refine iSup_le ?_
rintro ⟨n, v, hv, hvs⟩
by_cases hω : (⊥ : κ) < τ ω
· let g : κ → κ := fun s => (min (↑s : WithTop κ) (τ ω)).untopA
  have hsum := eVariationOn.sum_le (f := (N · ω)) (s := Set.Icc (⊥ : κ) t)
    (n := n) (u := fun i => g (v i)) ...
  ...
· have hsum_zero : ... = 0 := by
    rw [Set.indicator_of_notMem hnotmem, Set.indicator_of_notMem hnotmem]
```

What was learned: the variation comparison is pathwise. In the true branch, every partition is pushed through the monotone map `s ↦ (min (s : WithTop κ) (τ ω)).untopA`, and `eVariationOn.sum_le` bounds the resulting increment sum. In the false branch, all stopped/indicator increments are zero.

### `BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc`

Status: solved at `DoobMeyer.lean:614`.

Recovered attempt:

```lean
have hle := BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_Icc
  (N := N) (τ := τ) ω t
have hstop_var : BoundedVariationOn ... :=
  ne_top_of_le_ne_top hvar hle
refine ⟨hstop_var, ?_⟩
exact le_trans (ENNReal.toReal_mono hvar hle) hV
```

What was learned: once the extended-variation inequality is available, bounded variation transfers by `ne_top_of_le_ne_top`, and the deterministic real bound transfers with `ENNReal.toReal_mono`.

### `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc`

Status: solved at `DoobMeyer.lean:637`.

Recovered attempt:

```lean
refine ⟨?_, ?_⟩
· filter_upwards [hbound] with ω hω_bound
  exact MeasureTheory.stoppedProcess_indicator_bound_on_Icc
    (N := N) (τ := τ) (ω := ω) hC_nonneg hω_bound
· filter_upwards [hvar_bound] with ω hω_var
  exact BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc
    (N := N) (τ := τ) (ω := ω) hω_var.1 hω_var.2
```

What was learned: the optional a.e. wrapper is clean filter bookkeeping over the two deterministic pathwise transfers.

### `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`

Status: not retried, by objective.

The declaration now starts at `DoobMeyer.lean:1843`, with the actual `sorry` at line 1879. The new stopped/indicator support helps supply the bounded and variation hypotheses for stopped processes, but the reduction still needs predictable-jump removal, construction of localizing bounds, continuity transfer, deterministic mesh handling, and the final bridge invocation.

## Verification

Review reran:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: passes, with deprecated finset warnings and expected `sorry` warnings at lines 1843 and 2096.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: passes, with the expected square-norm `sorry` warning at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: passes cleanly.
- `lake build`: passes (`3312 jobs`), with only known project `sorry` warnings and the two Doob-Meyer deprecation warnings.
- Project-wide textual `sorry` count under `BrownianMotion`: 23.

Review also ran `lean_verify` on all four new declarations. Each depends only on `[propext, Classical.choice, Quot.sound]`, with no source-scan warnings.

Remaining active-chain proof debts:

- `DoobMeyer.lean:1843` declaration warning, actual `sorry` at line 1879: `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- `DoobMeyer.lean:2096` declaration warning, actual `sorry` at line 2101: original weak `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.
- `QuadraticVariation.lean:64` declaration warning, actual `sorry` at line 84: `IsLocalMartingale.isLocalSubmartingale_sq_norm`.

## Blueprint Markers Updated (Manual)

None.

The three planned helper blocks already have correct `\lean{...}` annotations in `blueprint/src/chapters/doob_meyer.tex`, and the reduction's `\uses{...}` list includes the new bound and variation-bound lemmas. The optional a.e. wrapper has no blueprint block yet. No Mathlib-backed aliases were reported, no renames were needed, and no stale `\notready` marker was found in the checked Doob-Meyer chapter. `sync_leanok` is current for iter-035 (`added: 0`, `removed: 0`); newly closed helper blocks still lack `\leanok`, so the marker-sync anomaly persists and was not patched manually.

## Blueprint Doctor

The iter-035 blueprint doctor reported no structural findings: all chapters are included, all `\ref` / `\uses` targets resolve, annotations are non-empty, and no project `.lean` file contains an `axiom` declaration.

## Recommendations

Continue in `DoobMeyer.lean`, but do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one monolithic target.

The closest next split is a stopped/localizing wrapper that uses `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc` for each localizing time to feed the bound and variation hypotheses of `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`. Keep continuity on `[⊥, t]`, deterministic partitions, and explicit mesh as assumptions.

Do not assert automatic continuity of stopped càdlàg pieces or automatic deterministic mesh existence. Predictable-jump removal should remain a separate target.
