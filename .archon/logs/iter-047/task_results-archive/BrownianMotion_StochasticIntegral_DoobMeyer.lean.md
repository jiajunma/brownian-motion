# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## MeasureTheory.stoppedProcess_indicator_eventuallyEq_left_of_lt (line 1286)
### Attempt 1
- **Approach:** Used the open left-neighborhood `S = {s | (s : WithTop κ) < τ ω}` from `isOpen_Iio.preimage WithTop.continuous_coe`; on `S`, rewrote the stopped process with `stoppedProcess_eq_of_le` and discharged the localizing indicator from `(⊥ : κ) < τ ω`.
- **Result:** RESOLVED.
- **Key lemmas:** `mem_nhdsWithin_of_mem_nhds`, `stoppedProcess_eq_of_le`, `Set.indicator_of_mem`.

## MeasureTheory.leftLim_stoppedProcess_indicator_eq_of_lt (line 1307)
### Attempt 1
- **Approach:** Transferred the original left-limit convergence across the eventual equality from the first lemma. Handled the degenerate case `nhdsWithin t (Set.Iio t) = ⊥` separately using `leftLim_eq_of_eq_bot` and terminal agreement at `t`.
- **Result:** RESOLVED.
- **Key lemmas:** `LocallyBoundedVariationOn.exists_tendsto_left_univ`, `tendsto_leftLim_of_tendsto`, `Filter.Tendsto.congr'`, `leftLim_eq_of_tendsto`, `leftLim_eq_of_eq_bot`.

## MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_bound (line 1346)
### Attempt 1
- **Approach:** Applied the closed stopped/indicator jump-removal theorem, then rewrote the terminal stopped value and stopped left limit back to the original process under the event `(t : WithTop κ) < τ ω`.
- **Result:** RESOLVED.
- **Key lemmas:** `MeasureTheory.Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_bound`, `MeasureTheory.leftLim_stoppedProcess_indicator_eq_of_lt`, `stoppedProcess_eq_of_le`.

## MeasureTheory.Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_bound (line 1394)
### Attempt 1
- **Approach:** Applied the event version to each stopping time `τ n`, combined the countable a.e. implications with `ae_all_iff.2`, and used `hτ.tendsto_top` to get an a.e. index with `(t : WithTop κ) < τ n ω`.
- **Result:** RESOLVED.
- **Key lemmas:** `MeasureTheory.Martingale.ae_eq_leftLim_on_event_of_left_approach_of_bound`, `IsLocalizingSequence.isStoppingTime`, `ae_all_iff.2`, `tendsto_atTop_nhds`.

## Remaining open declarations
### MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction
- **Result:** UNCHANGED / OPEN.
- **Declaration warning line:** 2548.
- **Actual `sorry` line:** 2584.

### ProbabilityTheory.IsLocalSubmartingale.doob_meyer
- **Result:** UNCHANGED / OPEN.
- **Declaration warning line:** 2801.
- **Actual `sorry` line:** 2806.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: PASSED.
  - Existing warnings: deprecated `MeasureTheory.integrable_finset_sum` at line 1701 and `MeasureTheory.integral_finset_sum` at line 1716.
  - Expected `sorry` warnings: declarations at lines 2548 and 2801.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: PASSED with the known `sorry` at line 84.
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`: PASSED.
- `lake build`: PASSED.

## Notes
- The deterministic left-approaching sequence and deterministic a.e. horizon bounds remain explicit.
- I did not attempt the full bounded-continuous reduction or public weak local Doob-Meyer theorem in this round.
