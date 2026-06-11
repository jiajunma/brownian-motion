# BrownianMotion/StochasticIntegral/DoobMeyer.lean

## ProbabilityTheory.IsLocalSubmartingale.doob_meyer_normalized (line 225)
### Attempt 1
- **Approach:** Strengthened the normalized layer in a separate section whose `Filtration` is parameterized under `[ConditionallyCompleteLinearOrderBot κ]`, avoiding the preorder diamond caused by adding that class to declarations already using the weaker global `[LinearOrder ι]` filtration context.
- **Result:** RESOLVED.
- **Key insight:** The local-martingale branch closes directly with `ProbabilityTheory.IsLocalMartingale.add_initial_of_hasLocallyIntegrableSup hA_prog hA_int`; the running-sup branch closes directly with `ProbabilityTheory.HasLocallyIntegrableSup.sub_initial hA_prog`.
- **Assumptions added to normalized layer:** `[ConditionallyCompleteLinearOrderBot κ] [BorelSpace κ] [PolishSpace κ] [IsFiniteMeasure P'] [Approximable 𝓕' P'] [𝓕'.IsComplete P'] [𝓕'.IsRightContinuous]`, with the existing topology/measurability/order-topology context retained. Lean synthesizes the second-countable and pseudo-metrizable requirements of the local-martingale helper from `PolishSpace`.

## ProbabilityTheory.IsLocalSubmartingale.martingalePart / predictablePart and accessors (lines 265-315)
### Attempt 1
- **Approach:** Moved the choice definitions and accessor lemmas into the same strengthened normalized section so they select from `doob_meyer_normalized`.
- **Result:** RESOLVED in `DoobMeyer.lean`.
- **Declarations updated:** `martingalePart`, `predictablePart`, `martingalePart_add_predictablePart`, `isLocalMartingale_martingalePart`, `cadlag_martingalePart`, `isStronglyProgressive_predictablePart`, `cadlag_predictablePart`, `hasLocallyIntegrableSup_predictablePart`, `monotone_predictablePart`, `predictablePart_bot_eq_zero`.

## Verification
### Attempt 1
- **Command:** `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`
- **Result:** PASSED. Only warning is the preserved original `doob_meyer` `sorry` at line 210.

### Attempt 2
- **Command:** `lake build`
- **Result:** PARTIAL. `DoobMeyer.lean` built successfully; build then failed in `BrownianMotion/StochasticIntegral/QuadraticVariation.lean:99`.
- **Downstream blocker:** `quadraticVariation` calls the strengthened `predictablePart` while `QuadraticVariation.lean` still has the weak global index context. Lean first reports missing `[ConditionallyCompleteLinearOrderBot ι]`, then an `IsCadlag` type mismatch because the existing path regularity proof is under the old `LinearOrder`-derived partial order while `predictablePart` expects the strengthened order context.
- **Next step:** Propagate the normalized Doob-Meyer usual assumptions through `QuadraticVariation.lean`, especially `quadraticVariation` and likely the surrounding squared-norm submartingale API: `[ConditionallyCompleteLinearOrderBot ι] [BorelSpace ι] [PolishSpace ι] [IsFiniteMeasure P] [Approximable 𝓕 P] [𝓕.IsComplete P] [𝓕.IsRightContinuous]`. Avoid adding the strong order class on top of an already-formed weak `Filtration`; put affected declarations in a strengthened section so the filtration is typed under the same order instance.
