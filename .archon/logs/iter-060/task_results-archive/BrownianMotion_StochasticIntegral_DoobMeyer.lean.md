# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## BoundedVariationOn.eVariationOn_stoppedProcess_indicator_le_closed_pre_stop_Icc (line 689)
### Attempt 1
- **Approach:** Adapted the existing `eVariationOn_stoppedProcess_indicator_le_Icc` partition comparison to the closed pre-stop set `{r | r ∈ Set.Icc (⊥ : κ) t ∧ (r : WithTop κ) ≤ τ ω}`.
- **Result:** RESOLVED.
- **Key insight:** On the active branch, the partition map `s ↦ (min (↑s : WithTop κ) (τ ω)).untopA` is monotone by `WithTop.untopA_mono`; its image lies in the closed pre-stop horizon using `WithTop.untopA_eq_untop`/`WithTop.coe_untop` and `min_le_right`.

## BoundedVariationOn.stoppedProcess_indicator_variation_bound_on_Icc_of_closed_pre_stop_bound (line 766)
### Attempt 1
- **Approach:** Used the closed-pre-stop extended-variation comparison to transfer finiteness with `ne_top_of_le_ne_top`, then transferred the real bound with `ENNReal.toReal_mono`.
- **Result:** RESOLVED.
- **Key insight:** This is the same finiteness/toReal argument as the older full-horizon `stoppedProcess_indicator_variation_bound_on_Icc`, with only the source variation set changed to the closed pre-stop set.

## MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc_of_pre_stop_bound (line 791)
### Attempt 1
- **Approach:** Combined the existing a.e. pre-stop/stop-value horizon-bound wrapper with the new pointwise closed-pre-stop variation transfer under `filter_upwards`.
- **Result:** RESOLVED.
- **Key insight:** The bound component remains strict pre-stop plus finite stop-value; only the variation component uses the closed pre-stop set with `≤ τ ω`.

## Remaining Open Declarations
### MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction
- **Status:** OPEN, unchanged.
- **Declaration warning line:** 3397.
- **Actual `sorry` line:** 3433.

### ProbabilityTheory.IsLocalSubmartingale.doob_meyer
- **Status:** OPEN, unchanged.
- **Declaration warning line:** 3650.
- **Actual `sorry` line:** 3655.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: PASS. Existing warnings only: deprecated `integrable_finset_sum` at line 1941, deprecated `integral_finset_sum` at line 1956, and the two known `sorry` declarations above.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: PASS. Existing warning: `sorry` at line 64 / actual `sorry` body at line 84.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: PASS with no output.
- `lake build`: PASS. Existing project-wide `sorry` warnings remain; no new errors or long-line warnings from this task.
