# Iteration 003 Objectives

## Prover objective

**File:** `BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`

**Blueprint:** `blueprint/src/chapters/stochastic_integral.tex`, especially
`lem:martingale_brownian_sq_sub_time` and `lem:quadraticVariation_brownian`.

**Primary check:** If normalized Doob-Meyer predictable-part uniqueness is
already available, add and prove
`ProbabilityTheory.quadraticVariation_brownian` as
`brownianQuadraticVariation = fun t _ => (t : Real)`.

**Expected fallback:** If that final equality is blocked, add and prove
`ProbabilityTheory.martingale_brownian_sq_sub_time`:
the process `fun t omega => brownian t omega ^ 2 - (t : Real)` is a martingale with
respect to `brownianNaturalFiltration` and `gaussianLimit`.

**Mathematical route:** For `s <= t`, set `Delta = brownian t - brownian s`.
Use independent increments to show `E[Delta | F_s] = 0` and
`E[Delta^2 | F_s] = t - s`; expand
`B_t^2 - t = B_s^2 - s + 2 B_s Delta + (Delta^2 - (t-s))`; use that `B_s` is
`F_s`-measurable to kill the mixed term by conditional expectation.

**Verified local/API hints:** `condExp_indep_eq`, `condExp_add`,
`condExp_of_stronglyMeasurable`, `variance_id_gaussianReal`,
`centralMoment_two_eq_variance`, `centralMoment_two_mul_gaussianReal`,
`MemLp.integrable_norm_pow'`, and the proof pattern in
`ProbabilityTheory.IsPreBrownian.isMartingale`.

**Constraints:** Preserve all existing signatures, do not add assumptions, and
do not use the choice-based `predictablePart` to fake uniqueness. Do not edit
`QuadraticVariation.lean` this iteration. Verify with both
`lake env lean BrownianMotion/StochasticIntegral/QuadraticVariationBrownian.lean`
and `lake build`.
