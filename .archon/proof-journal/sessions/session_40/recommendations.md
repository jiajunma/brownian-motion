# Recommendations for Iteration 041

## Prioritize

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The closest useful target is a conditional-expectation-zero lemma for a predictable jump known to be strongly measurable with respect to
`⨆ s : {s : κ // s < t}, 𝓕' s`.

The new closed package provides:

- `MeasureTheory.Martingale.stronglyMeasurable_leftLim_past_of_left_approach`
- `MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach`

Use these to feed the jump-removal part of
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

## Do Not Retry Without a Structural Change

- Do not try to derive `StronglyMeasurable[𝓕' (u n)] (N t - N (u n))` from strong predictability. The honest statement available from predictability is past-sigma measurability, and iter-040 formalized exactly that package.
- Do not assign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a monolithic proof. It still needs the past conditional-expectation argument, localization/bounded-variation packaging, deterministic mesh handling, and assembly.

## Reusable Pattern

For a deterministic left-approaching sequence `u n < t`, set
`mPast := ⨆ s : {s : κ // s < t}, 𝓕' s`. Lift each `hN.stronglyMeasurable (u n)` to `mPast` using
`le_iSup (fun s : {s : κ // s < t} => 𝓕' s) ⟨u n, hu_lt n⟩`, then use
`stronglyMeasurable_of_tendsto` with `tendsto_pi_nhds` and
`(tendsto_leftLim_of_tendsto ((hN_var ω).exists_tendsto_left_univ t)).comp hu_tendsto`.

## Verification State

Review reran `lake build`; it passed. The project still has 23 textual `sorry`s. The active Doob-Meyer `sorry` lines are now 2085 and 2307.
