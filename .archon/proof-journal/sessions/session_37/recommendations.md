# Recommendations

Prioritize a Doob-Meyer localization wrapper that uses `MeasureTheory.stoppedProcess_indicator_continuousOn_Icc` to discharge the current explicit stopped-process continuity hypothesis from original-path continuity. This would remove a real proof obligation rather than adding another bound-transfer wrapper.

Keep these hypotheses explicit in that wrapper: deterministic horizon bounds, deterministic variation bounds, deterministic partition endpoints, and entourage mesh/refinement. The new lemma proves only continuity transfer from already continuous paths; it does not turn càdlàg paths into continuous paths.

Do not reassign `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction` as a single target yet. It remains blocked on predictable-jump removal, bounded and variation localization, deterministic mesh construction or hypotheses, and assembly of the square-integral zero bridge.

Reusable pattern from iter-037: split stopped/indicator path goals on `(⊥ : κ) < τ ω`; handle the inactive branch with `Set.indicator_of_notMem` and `continuousOn_const`; handle `τ ω = ⊤` by congruence with the original path; handle finite `τ ω = a` using `WithTop.ne_top_iff_exists`, `Continuous.min`, `ContinuousOn.comp'`, `WithTop.coe_min`, and `WithTop.untopA_coe`.
