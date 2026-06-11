# Session 28 Summary

## Metadata

- Iteration: `iter-028`
- Session: `session_28`
- Prover model in raw log: `gpt-5.5`
- Target file: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- Current global textual `sorry` count: 23.
- Sorry delta this session: 23 -> 23. The prover added one closed helper, not a replacement for an existing `sorry`.

## Input Consistency

The preprocessed attempt stream at `.archon/proof-journal/current_session/attempts_raw.jsonl` contains only:

```json
{"type":"summary","no_prover_lane":true,"iter":28,"reason":"No prover lane this iter — either an intentional skip (see plan-validate marker / iter sidecar) or the prover phase produced no parsed logs."}
```

This conflicts with `.archon/logs/iter-028/meta.json`, `.archon/logs/iter-028/prover.jsonl`, and `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md`, which show a completed prover lane. I treated `attempts_raw.jsonl` as the primary structured source and recorded the parser mismatch, then recovered the actual mathematical attempt details from the raw prover log and task result.

## Targets

### `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound`

Status: solved at `DoobMeyer.lean:1209`.

Code tried:

```lean
have hpartition_bound : ∀ n, ∀ᵐ ω ∂P', ∀ k, ‖N (u n k) ω‖ ≤ C := by
  intro n
  filter_upwards [hbound_horizon] with ω hω k
  exact hω (u n k) (hus n k)
have hF_tendsto : ∀ᵐ ω ∂P',
    Tendsto
      (fun n => ∑ i ∈ Finset.range (m n),
        (N (u n (i + 1)) ω - N (u n i) ω) ^ 2)
      atTop (nhds 0) := by
  filter_upwards [hvar_bound, hinc_bound] with ω hω_var hω_inc
  have hnorm_tendsto :
      Tendsto
        (fun n => ∑ i ∈ Finset.range (m n),
          ‖N (u n (i + 1)) ω - N (u n i) ω‖ ^ 2)
        atTop (nhds 0) :=
    hω_var.1.sq_increment_sum_tendsto_zero_of_uniform_bound hu hus hδ_nonneg
      hδ_tendsto hω_inc
  simpa [Real.norm_eq_abs, sq_abs] using hnorm_tendsto
exact hN.integral_sq_terminal_eq_zero_of_refining_partitions hN_zero hu hu0 hut hus
  hC_nonneg hV_nonneg hpartition_bound hvar_bound hF_tendsto
```

Lean result: success. `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passes, and after rebuilding the module, `#print axioms` for the helper reports only `[propext, Classical.choice, Quot.sound]`, with no `sorryAx`.

Important diagnostic detail: an early import-level `#check` through `lean --stdin` failed with `Unknown constant` because it saw the stale built `.olean`. After `lake build`, the same import-level check succeeded.

Key proof structure: the horizon bound supplies the partition-point bound required by the closed refining-partition lemma; `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound` supplies a.e. convergence of norm-square sums; `simpa [Real.norm_eq_abs, sq_abs]` converts that to the real square sums.

### `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`

Status: partial. The existing `sorry` remains at `DoobMeyer.lean:1316`.

The preserved scaffold still has the useful left-limit and orthogonal-increment pieces:

```lean
have hleftLim_exists :
    ∀ ω, ∃ l, Tendsto (N · ω) (nhdsWithin t (Set.Iio t)) (nhds l) := fun ω =>
  (hN_var ω).exists_tendsto_left_univ t
have horthogonal_increments :
    ∀ {a b c d : κ}, a ≤ b → b ≤ c → c ≤ d →
      Integrable (fun ω => (N b ω - N a ω) * (N d ω - N c ω)) P' →
      ∫ ω, (N b ω - N a ω) * (N d ω - N c ω) ∂P' = 0 := by
  intro a b c d hab hbc hcd hprod
  exact hN.integral_increment_mul_increment_eq_zero hab hbc hcd hprod
```

No Lean error blocks this scaffold; the file passes with the intentional `sorry` warning. The remaining work is still too broad for a direct retry: predictable-jump removal, bounded localization, deterministic partition/modulus construction, and applying the bounded-continuous square-integral bridge.

### `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`

Status: not started in this session. The original weak local Doob-Meyer theorem still has its existing `sorry` at `DoobMeyer.lean:1538`.

## Verification

The prover reported all requested checks passing:

- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
- `lake build`

Remaining focused warnings:

- `DoobMeyer.lean`: existing deprecations at lines 925 and 940; `sorry` declarations at lines 1280 and 1533.
- `QuadraticVariation.lean`: existing `sorry` warning at line 64.

## Blueprint Markers Updated (Manual)

- None.

Blueprint doctor for iter-028 reports no structural findings: no orphan chapters, no broken references, no malformed annotations, and no project-local `axiom` declarations.

Marker sync state is current for iter-028 and reports `added: 0`, `removed: 0`, `chapters_touched: []`. However, the new closed helper's blueprint block at `blueprint/src/chapters/doob_meyer.tex:1991` has the correct `\lean{...}` but no `\leanok`. I did not edit `\leanok` manually, per review-agent rules; this should be treated as a marker-sync anomaly to investigate rather than headline laundering.

Existing `\notready` markers remain in other chapters, but the inspected blocks are still unformalized and do not carry matching `\lean{...}` declarations, so no stale `\notready` was removed.

## Recommendations

Continue in `DoobMeyer.lean`, but do not assign the full reduction as one monolithic target. The next useful target is the broader bounded-continuous square-integral-zero lemma or a smaller deterministic partition/modulus construction helper feeding the new variation-bound lemma.

Do not rely on pathwise finite variation alone for dominated convergence. The formal route still needs deterministic variation bounds via stopped/localized subcases before removing the localization.

The attempt preprocessor should be checked: it emitted a no-prover-lane summary even though the raw prover lane completed and wrote a task result.
