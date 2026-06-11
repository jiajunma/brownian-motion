# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## doob_meyer_normalized (line 33)
### Attempt 1
- **Approach:** Followed the blueprint normalization: take `X = M + A`, define the time-constant process `C t ω = A ⊥ ω`, and use `M + C` with `A - C`.
- **Result:** PARTIAL. The theorem is added and compiles, but still contains two explicit `sorry` gaps.
- **Closed pieces:** Pointwise algebra for `X = (M + C) + (A - C)`, strong progressivity of `C` and `A - C`, càdlàg paths for `C`, `M + C`, and `A - C`, monotonicity of `A - C`, and `(A - C) ⊥ = 0`.
- **Remaining gap 1:** Prove `IsLocalMartingale (M + C) 𝓕 P`. A likely route is `hC : IsLocalMartingale C 𝓕 P` plus an `IsLocalMartingale.add` helper. The current available APIs are not directly enough under this theorem signature: `martingale_const_fun` needs `[SigmaFiniteFiltration P 𝓕]`, and `ProbabilityTheory.isStable_martingale` needs `[IsFiniteMeasure P] [Approximable 𝓕 P]` plus topology hypotheses not present in `doob_meyer`.
- **Remaining gap 2:** Prove `HasLocallyIntegrableSup (A - C) 𝓕 P`. This should be a local integrable-sup transport lemma for subtracting the initial value of a monotone càdlàg process. Existing `isStable_hasLocallyIntegrableSup` needs `[SecondCountableTopology ι]`, which is also absent from the current signature.
- **Dead-end warning:** Adding these missing assumptions to `doob_meyer_normalized`, `martingalePart`, or `predictablePart` would change existing signatures, so I did not do that.

## martingalePart / predictablePart accessors (lines 73-121)
### Attempt 1
- **Approach:** Retargeted `martingalePart` and `predictablePart` to choose from `doob_meyer_normalized`, then updated all existing accessor proof paths.
- **Result:** RESOLVED modulo the admitted normalized theorem. The existing accessor statements are preserved and compile.
- **Added:** `predictablePart_bot_eq_zero`, proved directly from the final component of the normalized witness.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`: PASSED with warnings for the original `doob_meyer` sorry and the new partial `doob_meyer_normalized` theorem.
- `lake build`: PASSED with the same project-wide sorry warnings.
