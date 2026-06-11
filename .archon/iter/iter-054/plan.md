# Iteration 054 Plan

## State Collected

- No user hints were supplied this iteration.
- The prior sidecar `.archon/iter/iter-053/plan.md` contains a `## Fallback if no user response` section, so that fallback was executed this iteration; see below.
- The injected prior blueprint-doctor report has no structural findings to act on.
- Processed and cleared the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.eq_zero_of_localizingSequence_bounded_continuous_finiteVariation_of_variation_bound_original_continuousOn_of_left_branch`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, with the declaration warning at line `2984` and the actual `sorry` at line `3020`. The public weak local Doob-Meyer theorem remains open with the actual `sorry` at line `3242`.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line `84`.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only known project `sorry` warnings and pre-existing Doob-Meyer deprecation warnings.
- Reference check: re-read `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` region. The next lemma is Archon-original stopped/indicator bookkeeping, so no external citation block was added.
- API/context checks this iteration: source reads confirmed the current signatures of `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc` at `DoobMeyer.lean:646`, the closed original-process terminal-zero transfer wrapper at `DoobMeyer.lean:2493`, the original-continuity wrapper at `DoobMeyer.lean:2539`, the closed branch connector at `DoobMeyer.lean:2907`, and the active reduction at `DoobMeyer.lean:2984`.
- `archon-protected.yaml` contains no protected declarations, so the new helper objective does not touch a frozen signature.
- No subagents are enabled for this project, so none were dispatched.
- Updated `task_pending.md`, `task_done.md`, `PROGRESS.md`, `STRATEGY.md`, and `blueprint/src/chapters/doob_meyer.tex`.
- The worktree already contains dirty files outside this plan edit. I did not revert unrelated changes.

## User-Silent Fallback Executed

Iter 053 said that if the explicit branch connector closes, continue toward the active reduction by choosing one missing hypothesis-construction wrapper rather than assigning the full reduction: either package stopped-piece bounds/variation bounds from a localizing sequence under honest explicit level assumptions, or package deterministic mesh/partition existence only under sufficiently strong ordered compactness assumptions.

I chose the bound/variation transfer wrapper. Mesh existence remains order-topological and risks false generality if stated for arbitrary ordered Polish time. The bound/variation transfer is already backed by the closed stopped/indicator transfer lemma and the existing original-bound zero wrappers, so it constructs a real missing input while keeping deterministic levels explicit.

## Soundness Check

The new objective assumes original-process horizon bounds and original-process variation bounds:

- `∀ n, ∀ᵐ ω ∂P', ∀ s ∈ Set.Icc (⊥ : κ) t, ‖N s ω‖ ≤ C n`;
- `∀ n, ∀ᵐ ω ∂P', BoundedVariationOn (N · ω) (Set.Icc (⊥ : κ) t) ∧ (eVariationOn (N · ω) (Set.Icc (⊥ : κ) t)).toReal ≤ V n`.

It only transfers these explicit hypotheses to stopped/indicator inputs via `MeasureTheory.ae_stoppedProcess_indicator_bound_variation_on_Icc` and then calls the closed branch connector. It does not derive deterministic bounds, deterministic variation levels, partitions, mesh, branch alternatives, predecessor existence, or predecessor-zero induction from local bounded variation, cadlag paths, or topology.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean` with:

- `MeasureTheory.Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_left_branch`

The corresponding blueprint block was added to `blueprint/src/chapters/doob_meyer.tex` with label:

- `lem:Martingale.eq_zero_of_localizingSequence_of_bound_variation_bound_original_continuousOn_of_left_branch`

No `\leanok`, `\mathlibok`, or semantic marker edits were made.

## Fallback if no user response

No user response is needed. If the original-bound branch wrapper closes, continue toward the active reduction by choosing the next honest construction step, not the full reduction: either package an explicit-input endpoint that uses a supplied localizing sequence, original bounds, variation bounds, continuity, mesh, and branch disjunction, or prove a deterministic partition/mesh helper only under hypotheses strong enough to justify it. Do not infer deterministic levels, mesh, branch trichotomy, or greatest predecessors without separate proved assumptions.
