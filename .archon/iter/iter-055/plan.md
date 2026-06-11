# Iteration 055 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-054/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed and cleared the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_left_branch`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `3035` and the actual `sorry` at line `3071`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3293`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` region. The new objective is Archon-original localizing-sequence bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of the closed original-bound branch wrapper at `DoobMeyer.lean:2955`, the active reduction at `DoobMeyer.lean:3035`, and Mathlib's `ProbabilityTheory.isLocalizingSequence_const_top` at `.lake/packages/mathlib/Mathlib/Probability/Process/LocalProperty.lean:70`.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, and `blueprint/src/chapters/doob_meyer.tex`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-silent fallback executed

Iter 054 said that if the original-bound branch wrapper closes, continue toward the active reduction by choosing the next honest construction step, not the full reduction: either package an explicit-input endpoint that uses supplied localizing sequence, original bounds, variation bounds, continuity, mesh, and branch disjunction, or prove deterministic partition/mesh existence only under strong enough hypotheses.

I chose the bounded-level endpoint. The closed wrapper still expects a localizing sequence and indexed deterministic levels. The new objective removes those bookkeeping inputs in the bounded deterministic-level case by using the constant-top localizing sequence and constant level families \(C_n=C\), \(V_n=V\). This packages a real input pattern while leaving bounds, variation levels, partitions, mesh, and branch data explicit.

I did not choose the order/topology branch-helper path this iteration. Source search found useful order-topology ingredients for deriving a greatest predecessor from a collapsed left-neighborhood filter, but the existing left-isolated connector also needs a previous-time zero statement. A pure order/topology lemma would not supply that zero input, and turning it into predecessor induction would require additional well-founded/discrete-time assumptions not currently present.

## Soundness Check

The new objective assumes a single original horizon bound and a single original variation bound:

- `∀ᵐ ω ∂P', ∀ s ∈ Set.Icc (⊥ : κ) t, ‖N s ω‖ ≤ C`;
- `∀ᵐ ω ∂P', BoundedVariationOn (N · ω) (Set.Icc (⊥ : κ) t) ∧ (eVariationOn (N · ω) (Set.Icc (⊥ : κ) t)).toReal ≤ V`.

It only repeats these supplied bounds at each index of the constant-top localizing sequence and calls the closed original-bound branch wrapper. It does not derive deterministic bounds, variation levels, deterministic partitions, mesh, branch alternatives, predecessor existence, or predecessor-zero induction from local bounded variation, cadlag paths, or topology.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_left_branch`

The corresponding blueprint block was added to `blueprint/src/chapters/doob_meyer.tex` with label:

- `lem:Martingale.eq_zero_of_bound_variation_bound_original_continuousOn_of_left_branch`

No `\leanok`, `\mathlibok`, or semantic marker edits were made.

## Fallback if no user response

No user response is needed. If the bounded-level endpoint closes, continue toward the active reduction by choosing one missing input-construction step rather than assigning the full reduction: either construct an explicit branch disjunction under additional honest hypotheses, or package deterministic bound/variation localization only from stated stopping-time or level assumptions. Do not infer mesh existence, branch trichotomy, or predecessor-zero induction without separate proved assumptions.
