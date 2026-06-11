# BrownianMotion/StochasticIntegral/QuadraticVariation.lean

## Locally.isSquareIntegrable_submartingale_sq_norm (line 57)
### Attempt 1
- **Approach:** Isolate the transport step from local square integrability to the localized squared-norm submartingale.
- **Result:** RESOLVED.
- **Key insight:** If the stopped/indicator-truncated process is `IsSquareIntegrable`, then `IsSquareIntegrable.submartingale_sq_norm` proves the squared stopped process is a submartingale, and `stoppedProcess_indicator_sq_norm` rewrites it to the stopped/indicator-truncated squared norm.
- **Lemmas used:** `IsSquareIntegrable.submartingale_sq_norm`, `stoppedProcess_indicator_sq_norm`.

## IsLocalMartingale.isLocalSubmartingale_sq_norm (line 66)
### Attempt 1
- **Approach:** Follow the blueprint localization route and use the new transport helper after refining the localizing sequence to make the localized martingales square-integrable.
- **Result:** PARTIAL.
- **Remaining gap:** The current theorem statement has no `[SigmaFiniteFiltration P 𝓕]`, but the conditional Jensen route behind `IsSquareIntegrable.submartingale_sq_norm` requires it. The statement also lacks the usual infrastructure assumptions needed to construct the square-integrability refinement of a cadlag local martingale (for example finite measure / complete right-continuous filtration / Polish or approximable time index, depending on the chosen stopping-time construction).
- **Next step:** Prove a separate localization lemma under appropriate hypotheses, e.g. `IsLocalMartingale.locally_isSquareIntegrable` for cadlag local martingales, then use `Locally.isSquareIntegrable_submartingale_sq_norm` to close the submartingale component.
- **Dead end warning:** Without adding assumptions to this protected theorem, `inferInstance` cannot supply `SigmaFiniteFiltration P 𝓕`; this is not a naming issue.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`: PASS, with the remaining `sorry` warning at line 64.
- `lake build`: PASS, with existing project-wide `sorry` warnings and the remaining warning in `QuadraticVariation.lean`.
