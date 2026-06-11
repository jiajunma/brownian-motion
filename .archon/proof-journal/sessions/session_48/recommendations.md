# Recommendations for Iteration 049

## Prioritize

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but assign a smaller target than the full `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`.

The closest useful next target is a wrapper that feeds the new stopped-bound endpoint:

- Inputs: a localizing sequence `τ`, deterministic left-approach sequence, deterministic partitions/mesh, stopped-piece horizon bounds, stopped-piece variation bounds, and stopped-piece continuity.
- Output: the terminal zero conclusion needed for the reduction, by applying `MeasureTheory.Martingale.eq_zero_and_leftLim_eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_continuousOn` and extracting the first component.

If that wrapper is already immediate, the next real work is to construct one of those inputs separately, not all of them at once.

## Use

- For direct stopped-process jump removal, define `Z` as the stopped/indicator process and call `ae_eq_leftLim_of_left_approach_past_setIntegral_zero_of_bound_no_integrability` after transferring martingale, predictability, and local bounded variation.
- For event transfer, combine `stoppedProcess_eq_of_le`, `Set.indicator_of_mem`, and `MeasureTheory.leftLim_stoppedProcess_indicator_eq_of_lt`.
- For localizing-sequence exhaustion, use `ae_all_iff.2` plus the cover derived from `hτ.tendsto_top` via `tendsto_atTop_nhds` and `isOpen_Ioi`.
- For terminal and left-limit zero, compose the terminal-zero theorem with the jump-removal theorem and close by `hjump.symm.trans hzero`.

## Do Not Retry

Do not ask the prover to close `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` in one step. It still lacks:

- construction of an explicit deterministic left-approaching sequence where the current sequence-based jump lemmas apply;
- construction of bounded/variation localizing stopping times with deterministic constants;
- stopped-piece continuity inputs;
- deterministic partitions and mesh;
- assembly into the bounded-continuous square-integral endpoint.

Do not infer deterministic stopped-piece bounds or deterministic variation bounds from `LocallyBoundedVariationOn` alone.

## Blueprint

Blueprint doctor reported no structural issues for iter-048. The new `doob_meyer.tex` stopped-bound blocks have the correct `\lean{...}` annotations. Marker sync is current for iter-048 and made no `\leanok` changes; review made no manual blueprint edits.

