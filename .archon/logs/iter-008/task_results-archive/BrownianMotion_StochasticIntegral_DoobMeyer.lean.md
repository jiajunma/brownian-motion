# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## IsLocalMartingale.add_initial_of_hasLocallyIntegrableSup (line 111)
### Attempt 1
- **Approach:** Proved the planned common-localization helper. Used the pointwise minimum of the localizing sequence from `hM : IsLocalMartingale M 𝓕 P` and the localizing sequence from `hA_int : HasLocallyIntegrableSup A 𝓕 P`. Stability of stopped martingales gives the localized martingale branch; stability of `HasIntegrableSup` gives integrability of the stopped initial value at `⊥`; then `MeasureTheory.Martingale.add_const_fun` closes each localized martingale.
- **Result:** RESOLVED.
- **Final assumptions:** `[SecondCountableTopology ι] [BorelSpace ι] [PseudoMetrizableSpace ι] [IsFiniteMeasure P] [Approximable 𝓕 P]`, plus existing file assumptions `[LinearOrder ι] [OrderBot ι] [TopologicalSpace ι] [OrderTopology ι] [MeasurableSpace ι]`.
- **Key lemmas used:** `ProbabilityTheory.isStable_martingale`, `ProbabilityTheory.isStable_hasIntegrableSup`, `MeasureTheory.Martingale.add_const_fun`, `MeasureTheory.integrable_enorm_iff`, `MeasureTheory.stoppedProcess_indicator_comm`, `MeasureTheory.stoppedProcess_stoppedProcess`.

## IsLocalSubmartingale.doob_meyer_normalized (line 217)
### Attempt 1
- **Approach:** Tried to apply the new local-martingale shift helper to the first normalization gap, `IsLocalMartingale (M + C) 𝓕 P` where `C t ω = A ⊥ ω`.
- **Result:** PARTIAL / BLOCKED. The helper is compiled and exactly matches the mathematical need, but the protected theorem context does not provide `[SecondCountableTopology ι] [BorelSpace ι] [PseudoMetrizableSpace ι] [IsFiniteMeasure P] [Approximable 𝓕 P]`.
- **Next step:** If the normalized theorem signature is allowed to assume those usual hypotheses, the first gap should close directly with `hM.add_initial_of_hasLocallyIntegrableSup hA_prog hA_int`.

### Attempt 2
- **Approach:** Rechecked the second normalization gap, `HasLocallyIntegrableSup (A - C) 𝓕 P`, against the existing helper `HasLocallyIntegrableSup.sub_initial`.
- **Result:** BLOCKED by signature. `HasLocallyIntegrableSup.sub_initial` requires the usual running-sup measurability hypotheses: `[ConditionallyCompleteLinearOrderBot ι] [BorelSpace ι] [PolishSpace ι] [IsFiniteMeasure P] [𝓕.IsComplete P] [𝓕.IsRightContinuous]`. The protected theorem context has only the weaker order/topology/measurable-space assumptions.

## IsLocalSubmartingale.doob_meyer (line 210)
### Attempt 1
- **Approach:** Not targeted this iteration; focus was the normalized local-martingale shift route.
- **Result:** UNCHANGED. Existing `sorry` remains.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean` succeeded. Warnings are the existing `sorry`s at lines 210 and 217.
- `lake build` succeeded. The project still reports pre-existing `sorry` warnings in other files and the two Doob-Meyer declarations above.
