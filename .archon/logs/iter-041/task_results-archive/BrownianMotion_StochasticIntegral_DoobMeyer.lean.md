# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.Martingale.stronglyMeasurable_leftLim_past_of_left_approach (line 880)
### Attempt 1
- **Approach:** Followed the blueprint's deterministic left-approach route. Set the past sigma-algebra `mPast := iSup (fun s : {s // s < t} => F s)`. For each `n`, enlarged `hN.stronglyMeasurable (u n)` from `F (u n)` to `mPast` using `le_iSup` at the subtype index `<u n, hu_lt n>`. Then applied `stronglyMeasurable_of_tendsto` for `atTop`, with pointwise convergence supplied by `tendsto_pi_nhds` and `(tendsto_leftLim_of_tendsto ((hN_var omega).exists_tendsto_left_univ t)).comp hu_tendsto`.
- **Result:** RESOLVED.
- **Key insight:** No fixed earlier-time measurability is needed; each approximating value is only enlarged into the generated past sigma-algebra.

## MeasureTheory.Martingale.stronglyMeasurable_jump_leftLim_past_of_left_approach (line 909)
### Attempt 1
- **Approach:** Used `MeasureTheory.IsStronglyPredictable.stronglyMeasurable_past hN_pred ht` for `N t`, the new left-limit measurability lemma for `N_{t-}`, and closed by `hNt.sub hleft`.
- **Result:** RESOLVED.
- **Key insight:** Strong predictability is used only for past-sigma measurability of `N t`; the left limit is obtained as the pointwise limit of earlier martingale values.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction (declaration line 2049, sorry line 2085)
### Attempt 1
- **Approach:** Not targeted this iteration, per `PROGRESS.md`. The new past-sigma jump-measurability package is now available for the next conditional-expectation jump-removal split.
- **Result:** PARTIAL (dependency improved) - the theorem still contains its existing `sorry`.
- **Next step:** Prove the conditional-expectation-zero step for the past-measurable jump, without replacing past-sigma measurability by `F (u n)` measurability.

## ProbabilityTheory.doob_meyer (declaration line 2302, sorry line 2307)
### Attempt 1
- **Approach:** Not targeted this iteration.
- **Result:** OPEN - original weak local Doob-Meyer theorem still contains its existing `sorry`.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed.
  - Remaining warnings in this file: deprecated `MeasureTheory.integrable_finset_sum` at line 1202, deprecated `MeasureTheory.integral_finset_sum` at line 1217, `sorry` at lines 2085 and 2307.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed.
  - Existing `sorry` warning remains at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed cleanly.
- `lake build` passed successfully.
