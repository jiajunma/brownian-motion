# Iteration 002 Objectives

## Prover objective

**File:** `BrownianMotion/StochasticIntegral/QuadraticVariation.lean`

**Blueprint:** `blueprint/src/chapters/stochastic_integral.tex`, especially `lem:stoppedProcess_indicator_sq_norm` and `lem:IsLocalMartingale.isLocalSubmartingale_sq_norm`; this is upstream of `def:quadraticVariation` and blueprint Lemma 13.40 `lem:quadraticVariation_brownian`.

**Target:** close the remaining sorry in
`ProbabilityTheory.IsLocalMartingale.isLocalSubmartingale_sq_norm`.

**Mathematical route:** refine the localizing sequence for the càdlàg local martingale so the stopped, indicator-truncated martingales are square integrable; apply `ProbabilityTheory.IsSquareIntegrable.submartingale_sq_norm`; then rewrite with `ProbabilityTheory.stoppedProcess_indicator_sq_norm` to obtain the localized submartingale property for `fun t ω => ‖X t ω‖ ^ 2`.

**Constraints:** preserve all theorem signatures, do not add assumptions, do not use escape hatches. If the statement needs a genuine local square-integrability hypothesis, leave honest partial progress and report the smallest exact missing theorem or hypothesis.
