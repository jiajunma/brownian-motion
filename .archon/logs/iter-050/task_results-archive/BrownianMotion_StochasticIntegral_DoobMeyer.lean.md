# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot (line 2726)
### Attempt 1
- **Approach:** Use the nontrivial left-neighborhood filter as a local `NeBot` instance, turn `self_mem_nhdsWithin` into the frequent predicate `x < t`, and apply `Filter.exists_seq_forall_of_frequently`.
- **Result:** RESOLVED.
- **Key lemmas:** `self_mem_nhdsWithin`, `Filter.Eventually.frequently`, `Filter.exists_seq_forall_of_frequently`; the `SecondCountableTopology` instance supplies the countably generated within-neighborhood filter.

## MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn_of_neBot_left (line 2742)
### Attempt 1
- **Approach:** Destruct the sequence from `Filter.exists_seq_lt_tendsto_nhdsWithin_Iio_of_neBot hleft`, then call the existing explicit-sequence theorem `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` with all stopped-piece hypotheses unchanged.
- **Result:** RESOLVED.
- **Key insight:** This wrapper constructs only the deterministic left-approaching sequence. It does not infer stopped-piece boundedness, variation bounds, continuity, partitions, or mesh.

## MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction (line 2813)
### Attempt 1
- **Approach:** Not targeted this iteration per `PROGRESS.md`.
- **Result:** PARTIAL / OPEN.
- **Next step:** Use the new `..._of_neBot_left` wrapper when the reduction has explicit stopped-piece hypotheses plus a nontrivial left-neighborhood filter; the full bounded-continuous reduction still needs the localization/partition construction.

## ProbabilityTheory.IsLocalSubmartingale.doob_meyer (line 3066)
### Attempt 1
- **Approach:** Not targeted this iteration.
- **Result:** OPEN.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` passed.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` passed with the known `IsLocalMartingale.isLocalSubmartingale_sq_norm` sorry warning at line 64.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean` passed.
- `lake build` passed.

## Remaining DoobMeyer warnings
- `BrownianMotion/StochasticIntegral/DoobMeyer.lean:1701`: deprecated `MeasureTheory.integrable_finset_sum`.
- `BrownianMotion/StochasticIntegral/DoobMeyer.lean:1716`: deprecated `MeasureTheory.integral_finset_sum`.
- `BrownianMotion/StochasticIntegral/DoobMeyer.lean:2813`: declaration uses `sorry` in `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.
- `BrownianMotion/StochasticIntegral/DoobMeyer.lean:3066`: declaration uses `sorry` in `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.
