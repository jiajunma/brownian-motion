# Session 45 Recommendations

## Priority

Continue on `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with the stopped/original event-transfer step:

- Prove that on `{ω | (t : WithTop κ) < τ ω}`, the stopped/indicator process agrees with `N` near `t` from the left.
- Use that agreement to transfer `Function.leftLim Z t` to `Function.leftLim (N · ω) t` on the same event.
- Then combine this with `MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound` to get event-restricted jump removal for the original process.

The likely lemma shape should keep the event implication explicit, for example an a.e. statement of the form `ω ∈ {ω | (t : WithTop κ) < τ ω} → ...`, rather than immediately trying to discharge the localizing cover.

## Do Not Retry Yet

Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one proof. It still lacks several assembled inputs: stopped/original left-limit transfer, bounded and variation localization, continuity transfer in the final form, deterministic left-approaching sequences, and mesh/refinement data.

Do not infer stopped/original left-limit agreement from a single equality at `t`. The proof needs eventual agreement along the left-neighborhood filter, using `(t : WithTop κ) < τ ω` to find a neighborhood of times below `t` that still stop before `τ ω`.

Do not use `ProbabilityTheory.IsLocalizingSequence.eventually_exists_gt t` as a substitute for the event-transfer lemma. The cover only says some stopped process reaches past `t`; it does not identify its left limit with the original one without the separate filter argument.

## Reusable Patterns

- For stopped/indicator jump removal, define `Z`, transfer `Martingale`, `IsStronglyPredictable`, `LocallyBoundedVariationOn`, and the horizon bound, then call `MeasureTheory.Martingale.ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability`.
- The localizing-sequence family version is pointwise in `n`; use `hτ.isStoppingTime n`, `C n`, `hC_nonneg n`, and `hbound_horizon n`.
- Keep the deterministic left-approaching sequence and deterministic a.e. horizon bound explicit. Iter-045 did not construct either from localization or predictability.

## Tooling Notes

The preprocessed attempt file again reported `no_prover_lane: true`, but `meta.json`, the raw prover log, and the Doob-Meyer task result show a completed prover lane. Continue recovering evidence from raw logs/task results until the attempt preprocessor is fixed.

`sync_leanok` was current for iter-045 and made zero marker changes. Review should continue not patching `\leanok` manually.
