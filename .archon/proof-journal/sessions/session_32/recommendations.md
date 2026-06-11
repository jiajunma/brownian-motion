# Session 32 Recommendations

## Prioritize Next

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.

The best next target is a bounded/stopped localization helper that packages the hypotheses needed by:

```lean
MeasureTheory.Martingale.eq_zero_on_event_of_bounded_continuous_finiteVariation_of_variation_bound_continuousOn
```

Concretely, build a statement for a localized martingale `Z n`, original process `N`, and event `E n` that supplies:

- deterministic bounds `C n` and `V n`,
- pathwise continuity for `Z n` on `Set.Icc (⊥ : κ) t`,
- the explicit deterministic entourage-mesh hypothesis,
- terminal agreement `omega in E n -> Z n t omega = N t omega`,
- and a.e. coverage `exists n, omega in E n`.

Then finish with:

```lean
MeasureTheory.ae_eq_zero_of_eventually_event_zero_exhaustion
```

## Reusable Patterns

- Event transfer: prove `Z t =ᵐ[P'] 0` globally, then use `filter_upwards [hZ_terminal, hagree]` to obtain `omega in E -> N t omega = 0`.
- Countable exhaustion: use `ae_all_iff.2 hzero` to make all local zero statements hold simultaneously a.e., combine with `hcover`, choose the covering index, and apply that local implication.

## Do Not Retry Yet

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one large proof. It still combines at least four separate jobs:

- predictable-jump removal,
- bounded localization,
- deterministic variation-bound localization,
- deterministic mesh/continuity management.

The new helpers remove only the terminal event-transfer and countable-exhaustion bookkeeping parts.

## Tooling Notes

The attempt preprocessor again reported `no_prover_lane: true` even though `meta.json`, `prover.jsonl`, and the Doob-Meyer task result show the prover ran. Use raw logs and task results as recovered evidence when this recurs.

`sync_leanok` ran for iter-032 and reported zero marker changes. The closed new Doob-Meyer helper blocks have correct `\lean{...}` annotations but still lack `\leanok`; do not patch this manually.
