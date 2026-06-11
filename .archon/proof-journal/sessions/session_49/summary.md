# Session 49 Summary

## Metadata

- Iteration/session: iter-049 / session_49.
- Stage reviewed: prover.
- Structured attempt file: `.archon/proof-journal/current_session/attempts_raw.jsonl` contains only `{"no_prover_lane": true}`. As in recent sessions, this is a preprocessing false positive: `.archon/logs/iter-049/meta.json`, `.archon/logs/iter-049/prover.jsonl`, and `.archon/task_results/BrownianMotion_StochasticIntegral_DoobMeyer.lean.md` show the prover ran.
- Sorry count before/after: 23 textual `sorry` occurrences under `BrownianMotion` before, 23 after.
- Targets attempted: `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.
- Git diff scope from `git diff HEAD~1 --stat`: the current tree has broad prior dirty state, with this iteration's relevant Lean work in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` and blueprint work in `blueprint/src/chapters/doob_meyer.tex`.

## Targets

### `Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot`

Status: solved at `DoobMeyer.lean:2726`.

The prover used the explicit nontriviality of `nhdsWithin t (Set.Iio t)` as a local `NeBot` instance, converted `self_mem_nhdsWithin` into the eventual predicate `x < t`, then applied `Filter.exists_seq_forall_of_frequently`:

```lean
haveI : NeBot (nhdsWithin t (Set.Iio t)) := hleft
have h_eventually : ∀ᶠ x in nhdsWithin t (Set.Iio t), x < t := by
  simpa only [Set.mem_Iio] using
    (self_mem_nhdsWithin : ∀ᶠ x in nhdsWithin t (Set.Iio t), x ∈ Set.Iio t)
obtain ⟨v, hv_tendsto, hv_lt⟩ :=
  Filter.exists_seq_forall_of_frequently h_eventually.frequently
exact ⟨v, hv_lt, hv_tendsto⟩
```

Lean error: none. The final goal closed. The important soundness point is that the lemma keeps `(nhdsWithin t (Set.Iio t)).NeBot` as an explicit hypothesis; it does not assert that every `⊥ < t` admits a strict left-approaching sequence.

### `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left`

Status: solved at `DoobMeyer.lean:2742`.

The prover destructed the sequence supplied by the new filter helper and passed it to the existing explicit-sequence stopped-bound terminal/left-limit zero theorem:

```lean
obtain ⟨v, hv_lt, hv_tendsto⟩ :=
  Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot hleft
exact hN.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn
  hN_cadlag hN_zero hN_pred hN_var hτ ht hv_lt hv_tendsto hu hu0 hut hus
  hC_nonneg hV_nonneg hZ_bound hZ_var_bound hZ_cont hmesh
```

Lean error: none. This wrapper constructs only the deterministic left-approaching sequence. Stopped-piece bounds, variation bounds, continuity, deterministic partitions, and mesh remain explicit assumptions.

## Open Sorries

- `DoobMeyer.lean:2813` declaration warning, actual `sorry` at line 2849: `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- `DoobMeyer.lean:3066` declaration warning, actual `sorry` at line 3071: public `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.
- `QuadraticVariation.lean:64` declaration warning, actual `sorry` at line 84: `IsLocalMartingale.isLocalSubmartingale_sq_norm`.

## Verification

Review reran:

- `lean_diagnostic_messages` on `DoobMeyer.lean:2726-2780`: no diagnostics.
- `lean_verify Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot`: only `[propext, Classical.choice, Quot.sound]`, no source-scan warnings.
- `lean_verify MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left`: only `[propext, Classical.choice, Quot.sound]`, no source-scan warnings.
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: passed with the two known deprecation warnings and two known Doob-Meyer `sorry` warnings.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: passed with the known square-norm `sorry` warning.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: passed.
- `lake build`: passed with only known project `sorry` warnings.

## Blueprint and Markers

Blueprint doctor for iter-049 reported no structural findings: all chapters are input, cross-references resolve, annotations are non-empty, and no project axioms are present.

Manual marker changes: none.

`sync_leanok` is current for iter-049 and reported `added: 0`, `removed: 0`, `chapters_touched: []`. The new Doob-Meyer blueprint blocks have correct `\lean{Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot}` and `\lean{MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left}` annotations, but no `\leanok`; review did not touch deterministic markers. No stale `\notready` was found in `doob_meyer.tex`.

## Blueprint markers updated (manual)

- None.

## Next Guidance

Use the new `_of_neBot_left` wrapper only for the nontrivial-left-filter branch. The full predictable finite-variation reduction still needs a separate left-isolated-time branch or explicit assumption handling, plus actual stopped-piece bounds, stopped variation bounds, stopped continuity inputs, deterministic partitions, and mesh.

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one monolithic target. The next useful target should remove exactly one of the remaining explicit hypotheses or prove a branch lemma that handles one missing case.

## Subagents

No review subagents are currently enabled for this project. None were dispatched.
