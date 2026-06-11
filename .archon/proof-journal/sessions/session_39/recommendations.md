# Recommendations For Iteration 040

## Prioritize

- Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`.
- Target the construction that lets the new lemma be used inside `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`: produce, under honest hypotheses, a deterministic left-approaching sequence `u n < t` and the measurability facts `StronglyMeasurable[𝓕' (u n)] (N t - N (u n))`.
- If deriving that directly from `IsStronglyPredictable 𝓕' N` is too large, split off a lower-level lemma that assumes an explicit predictable-past or announcing-sequence approximation hypothesis and proves the required `hinc_meas` package.

## Do Not Retry

- Do not retry `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as one full proof. The current `sorry` still hides multiple analytic constructions.
- Do not infer `𝓕' (u n)`-measurability of `N t - N (u n)` from strong predictability without a proved section/announcing-sequence lemma.
- Do not add another stopped/indicator or left-limit wrapper unless it removes a new hypothesis from the active reduction.

## Reusable Pattern

For left-approaching jump removal with explicit earlier-time measurability:

1. Use `hN.eq_zero_of_predictable_finiteVariation_past_measurable_zero_increment (le_of_lt (hu_lt n)) (hinc_meas n)` for each `n`.
2. Combine the countably many a.e. equalities with `ae_all_iff.2`.
3. On the full-measure event, build the constant limit with `tendsto_const_nhds.congr'` and `sub_eq_zero.mp`.
4. Build the left-limit convergence with `(tendsto_leftLim_of_tendsto ((hN_var ω).exists_tendsto_left_univ t)).comp hu_tendsto`.
5. Close with `tendsto_nhds_unique`.

## Still Open

- `DoobMeyer.lean:2033`: predictable finite-variation bounded-continuous reduction.
- `DoobMeyer.lean:2255`: original weak local Doob-Meyer theorem.
- `QuadraticVariation.lean:84`: overgeneral square-norm local-submartingale helper.

The quadratic-variation gap remains downstream; keep focus on the Doob-Meyer uniqueness bridge unless a structural refactor is planned for the overgeneral square-norm statement.
