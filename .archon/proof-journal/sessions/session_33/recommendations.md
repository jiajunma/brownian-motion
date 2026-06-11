# Session 33 Recommendations

## Prioritize Next

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The best next target is a localizing-sequence stopped-process wrapper that calls:

```lean
MeasureTheory.Martingale.eq_zero_of_stoppedProcess_bounded_continuous_finiteVariation_of_variation_bound_continuousOn
```

It should assume a localizing sequence `τ : ℕ → Ω' → WithTop κ` and derive the routine stopped-localization hypotheses:

- `hZ_mart` from `hN.stoppedProcess_indicator`, using right continuity from `hN_cadlag` and `hτ.isStoppingTime n`;
- `hcover : ∀ᵐ ω ∂P', ∃ n, (t : WithTop κ) < τ n ω` from `hτ.tendsto_top`;
- bottom normalization and terminal agreement using the stopped-process/indicator pattern closed in iter-033.

Keep the hard analytic hypotheses explicit for now: deterministic `C n`, deterministic `V n`, a.e. horizon bounds, a.e. variation bounds, continuity on `Set.Icc (⊥ : κ) t`, and the deterministic entourage-mesh hypothesis.

## Reusable Patterns

- Localized family transfer: for each `n`, apply `MeasureTheory.Martingale.eq_zero_on_event_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` to `Z n`, then use `MeasureTheory.ae_eq_zero_of_eventually_event_zero_exhaustion` to remove the countable event cover.
- Local `let` unfolding in stopped-process proofs: avoid `rw [Z, ...]` when `Z` is a local function-valued `let`; use `change stoppedProcess ... = ...` before rewriting.
- Indicator-zero branch: this Mathlib snapshot uses `Set.indicator_of_notMem`, and difficult branches may need the exact set supplied explicitly with `(s := {ω' : Ω' | ...})`.
- Terminal stopped-process agreement: from `htτ : (t : WithTop κ) < τ n ω`, derive `hbotτ` by `lt_of_le_of_lt (WithTop.coe_le_coe.2 bot_le) htτ`, then rewrite with `stoppedProcess_eq_of_le htτ.le` and `Set.indicator_of_mem`.

## Do Not Retry Yet

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one large proof. It still combines:

- predictable-jump removal via left limits/predictable past,
- bounded localization,
- deterministic variation-bound localization,
- deterministic mesh/continuity management.

The iter-033 helpers remove countable stopped-event bookkeeping, not those analytic construction steps.

## Tooling Notes

The attempt preprocessor again reported `no_prover_lane: true` even though `meta.json`, `prover.jsonl`, and the Doob-Meyer task result show the prover ran. Use raw logs and task results as recovered evidence when this recurs.

`sync_leanok` ran for iter-033 and reported zero marker changes. The closed new Doob-Meyer helper blocks have correct `\lean{...}` annotations but still lack `\leanok`; do not patch this manually.
