# BrownianMotion/StochasticIntegral/QuadraticVariation.lean

## IsCadlag.continuous_comp (Cadlag.lean)
### Attempt 1
- **Approach:** Prove composition directly from the structure fields: right-continuity uses the existing `Function.IsRightContinuous.continuous_comp`; left limits use the left-limit witness and compose its `Tendsto` with `hg.tendsto`.
- **Result:** RESOLVED.
- **Key insight:** The argument order is `hf.continuous_comp hg`, so path hypotheses can use dot notation.

## quadraticVariation hX2_cadlag (line 71)
### Attempt 1
- **Approach:** Apply `IsCadlag.continuous_comp` to each path with the continuous map `fun x ↦ ‖x‖ ^ 2`.
- **Result:** RESOLVED.
- **Key lemmas:** `IsCadlag.continuous_comp`, `continuous_norm.pow 2`.

## IsLocalMartingale.isLocalSubmartingale_sq_norm (line 44)
### Attempt 1
- **Approach:** Reduce the proof to a local submartingale proof for `X2 := fun t ω ↦ ‖X t ω‖ ^ 2`; prove the càdlàg part by stability of càdlàg paths, and add stopped-process squared-norm conversion lemmas.
- **Result:** PARTIAL — the remaining `sorry` is isolated at the local submartingale / local square-integrability step.
- **Completed support lemmas:** `stoppedProcess_sq_norm`, `stoppedProcess_indicator_sq_norm`.
- **Concrete blocker:** To use `IsSquareIntegrable.submartingale_sq_norm`, each localized stopped martingale must be further localized to a square-integrable martingale. I did not find an existing theorem providing that localization under the current statement hypotheses.
- **Dead-end warning:** A plain `Locally.mono` from `IsLocalMartingale` is not enough: the localized process is a stopped/indicator martingale, while the target is the stopped/indicator squared-norm process. The conversion is handled by `stoppedProcess_indicator_sq_norm`, but square-integrability of the localized martingale is still missing.
- **Tool note:** `.claude/tools/archon-informal-agent.py` was not usable because no `OPENAI_API_KEY`, `GEMINI_API_KEY`, or `OPENROUTER_API_KEY` was present in the environment.

## Verification
- `lake env lean BrownianMotion/StochasticIntegral/QuadraticVariation.lean` succeeds with the remaining `sorry` warning at `IsLocalMartingale.isLocalSubmartingale_sq_norm`.
- `lake build` succeeds; project-wide existing `sorry` warnings remain.
