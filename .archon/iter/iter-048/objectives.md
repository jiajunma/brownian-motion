# Iteration 048 Objectives

## Prover Lane

1. `BrownianMotion/StochasticIntegral/DoobMeyer.lean`

   Blueprint: `blueprint/src/chapters/doob_meyer.tex`

   New blueprint blocks:

   - `lem:Martingale.ae_eq_leftLim_stoppedProcess_indicator_of_left_approach_of_stopped_bound`
   - `lem:Martingale.ae_eq_leftLim_on_event_of_left_approach_of_stopped_bound`
   - `lem:Martingale.ae_eq_leftLim_localizingSequence_of_left_approach_of_stopped_bound`
   - `lem:Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn`

   Task: prove the stopped-bound analogue of the current original-bound jump/zero wrappers. First prove jump removal for a stopped/indicator process under a direct stopped-process horizon bound. Then transfer that jump identity back to the original process on `{ω | (t : WithTop κ) < τ ω}`. Then globalize along a localizing sequence. Finally compose the resulting stopped-bound jump-removal theorem with `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` to obtain both terminal zero and left-limit zero.

   Non-targets: do not fill `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` this round, and do not touch `ProbabilityTheory.IsLocalSubmartingale.doob_meyer`.

   Verification requested: run `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, then `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean`, `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`, and `lake build`.
