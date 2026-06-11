# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## HasIntegrableSup.sub_const_fun (line 49)
### Attempt 1
- **Approach:** Prove the non-local closure lemma for subtracting an integrable `𝓕_⊥`-measurable time-constant random variable. Use `IsStronglyProgressive.hasStronglyMeasurableSupProcess` for the shifted running-sup measurability, and `runningSup_norm_sub_const_le` plus `Integrable.mono_enorm` for finite integral.
- **Result:** RESOLVED.
- **Key assumptions isolated:** `ConditionallyCompleteLinearOrderBot`, `BorelSpace`, `PolishSpace`, `IsFiniteMeasure P`, `𝓕.IsComplete P`, and `𝓕.IsRightContinuous`.

## HasLocallyIntegrableSup.sub_initial (line 80)
### Attempt 1
- **Approach:** Reuse the localizing sequence from `hA_int`. For each stop `τ n`, rewrite the stopped shifted process as the stopped process for `A` shifted by `Zn = {ω | ⊥ < τ n ω}.indicator (fun ω => A ⊥ ω)`. Prove `Zn` is `𝓕_⊥`-strongly measurable from strong progressivity, and prove its integrability from the stopped running supremum at `⊥`.
- **Result:** RESOLVED under the same usual-condition assumptions as `HasIntegrableSup.sub_const_fun`.
- **Key insight:** The equality between the stopped shifted process and `Xn - fun _ => Zn` is pointwise after a split on `⊥ < τ n ω`.

## doob_meyer_normalized (line 117)
### Attempt 1
- **Approach:** Try to close the second gap `HasLocallyIntegrableSup (A - C) 𝓕 P` using the helper route above.
- **Result:** PARTIAL. The helper closes exactly the intended argument, but the protected theorem signature lacks the assumptions needed to transport strong progressivity to the strongly measurable running-sup process.
- **Remaining blocker:** Current theorem context has only `[LinearOrder ι]`, `[OrderBot ι]`, `[TopologicalSpace ι]`, `[OrderTopology ι]`, and `[MeasurableSpace ι]`. The compiled helper additionally needs `ConditionallyCompleteLinearOrderBot ι`, `BorelSpace ι`, `PolishSpace ι`, `[IsFiniteMeasure P]`, `[𝓕.IsComplete P]`, and `[𝓕.IsRightContinuous]`.
- **Dead-end warning:** The pathwise domination alone proves only the finite-integral side. It does not provide the `HasStronglyMeasurableSupProcess` component under the current weak signature.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` succeeds with the two existing `sorry` warnings.
- `lake build` succeeds.
