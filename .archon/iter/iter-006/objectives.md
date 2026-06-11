# Iteration 006 Objectives

## Assigned File

`BrownianMotion/StochasticIntegral/DoobMeyer.lean`

## Objective

Close one normalization gap inside
`ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized`, prioritizing the `HasLocallyIntegrableSup (A - C) 𝓕 P` branch.

## Concrete Target

Prove the locally integrable-sup closure for the shifted predictable part
`A - C`, where `C t ω = A ⊥ ω`.

Use the localizing sequence from `hA_int`. For each localizing time `τ n`, the stopped shifted process should be treated as the stopped process for `A` shifted by
`Z n ω = {ω | ⊥ < τ n ω}.indicator (fun ω => A ⊥ ω) ω`. The pathwise estimate is already available as
`ProbabilityTheory.runningSup_norm_sub_const_le`.

The integrability side should come from the stopped running supremum for `A` and the fact that `Z n` is controlled at time `⊥`. The hard point to resolve is the `HasStronglyMeasurableSupProcess` component for the shifted stopped process.

## Constraints

- Preserve the signatures of `doob_meyer`, `doob_meyer_normalized`, `martingalePart`, `predictablePart`, and all existing accessor lemmas.
- Do not add new `sorry`s, axioms, or statement weakenings.
- Do not work on Brownian independent increments, `QuadraticVariationBrownian.lean`, Standard Borel, or unrelated foundation tasks.
- Do not add the full predictable-part uniqueness theorem unless the finite-variation local-martingale zero theorem is already available.

## Fallback

If the `HasLocallyIntegrableSup` branch cannot be closed under the current theorem signature, prove the smallest compiled helper in `DoobMeyer.lean` that isolates the obstruction under exact assumptions, preferably a `HasIntegrableSup` or `HasLocallyIntegrableSup` shift lemma using `runningSup_norm_sub_const_le`.

Only after closing that branch or isolating its exact missing assumptions should you revisit the local martingale shift branch using the compiled helper
`MeasureTheory.Martingale.add_const_fun`.
