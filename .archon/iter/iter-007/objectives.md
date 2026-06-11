# Iteration 007 Objectives

## Prover Assignment

**File:** `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

**Blueprint:** `blueprint/src/chapters/doob_meyer.tex`, especially
`lem:Martingale.add_const_fun`, `lem:runningSup_norm_sub_const_le`,
`lem:HasIntegrableSup.sub_const_fun`,
`lem:HasLocallyIntegrableSup.sub_initial`, and
`thm:local_doobMeyer_normalized`.

## Target

Work only on the normalized Doob-Meyer route. The immediate target is the
first remaining gap inside
`ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`:

`IsLocalMartingale (M + C) 𝓕 P`, where `C t ω = A ⊥ ω`.

The integrable-sup branch should not be reproved. It is already reduced to the
compiled usual-condition helper
`ProbabilityTheory.HasLocallyIntegrableSup.sub_initial`; applying it to the
protected theorem is currently blocked by missing assumptions.

## Suggested Route

Use a common localization of the local martingale witness for `M` and the
locally integrable running-sup witness for `A`, preferably with pointwise
minimum of same-index localizing stops. For each localized process, reduce the
martingale statement to a stopped martingale plus the time-constant random
variable
\[
  \mathbf 1_{\{\bot<\tau_n\}} A_\bot .
\]
Strong progressivity of `A` gives bottom-time measurability; integrability
comes from the stopped running supremum at `⊥`; the martingale closure is
`MeasureTheory.Martingale.add_const_fun`.

If this does not fit the current theorem context, add the smallest compiled
helper under the exact needed assumptions and report the resulting signature
blocker. Do not add new sorries or change existing protected signatures.

## Verification

Run `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`.
Run `lake build` if the theorem gap closes or a new helper is added.
