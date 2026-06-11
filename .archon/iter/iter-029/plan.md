# Iteration 029 Plan

## State Collected

- No user hints were supplied this iteration.
- The previous sidecar `.archon/iter/iter-028/plan.md` has no `## Fallback if no user response` section, so no user-silent fallback was executed.
- The prior blueprint-doctor block in the invocation had no live structural findings to act on.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound`.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now at `DoobMeyer.lean:1280` with the `sorry` at line 1316. The original weak local Doob-Meyer theorem remains at `DoobMeyer.lean:1533` with the `sorry` at line 1538.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line 84. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read the local sources available for this route: `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` section. The only file under `references/` is `summary.md`; there is still no local original Beiglböck--Schachermayer--Veliyev source file to quote. The new helper prose is project-bespoke and carries no fabricated citation.
- Proof-journal session 28 records the same mathematical result, but its current-session preprocessor still incorrectly reports `no_prover_lane: true`; I used the task result/raw review as the reliable evidence.
- No subagents are enabled for this project, so none were dispatched.

## Soundness Check

The just-closed helper assumes a deterministic increment modulus `δ n` that works almost surely for all paths. That is sound for the helper itself, but it is too strong to be the direct consequence of pathwise continuity in the broader bounded-continuous finite-variation theorem: continuity on a compact interval gives each sample path its own modulus along a refining deterministic partition, not a deterministic modulus uniform in `ω`.

The next safe split is therefore a variation-bounded helper with a sample-point-dependent modulus. It keeps the deterministic total-variation bound `V`, which is still needed for dominated convergence, but lets the increment modulus be existential inside the a.e. event. This matches what the continuity step can plausibly supply later.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, not `QuadraticVariation.lean`, for this iteration. The Doob-Meyer bridge is still making clean progress and the next checkpoint is a small generalization of a closed proof, not a speculative attack on the full reduction.

I updated `blueprint/src/chapters/doob_meyer.tex` to insert
`lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound_eventual_modulus`
between the deterministic-modulus helper and the broader bounded-continuous finite-variation lemma. The prover objective asks first for the corresponding Lean helper. If that closes quickly, the prover should only begin the next helper that converts supplied deterministic refining partitions plus pathwise continuity into the a.e. path-dependent modulus; it should not retry the full predictable finite-variation reduction monolithically.

The cheapest signal to reverse course would be if the path-dependent-modulus helper cannot be stated without changing public theorem signatures or adding nonlocal topology assumptions to the main bridge. In that case the next plan should pivot to a structural refactor of the bounded-continuous layer or to the queued `QuadraticVariation.lean` context repair.

## State Updates

- Updated `task_pending.md` with current Doob-Meyer line numbers and the new path-dependent-modulus split.
- Appended the closed deterministic-modulus helper to `task_done.md`.
- Updated `STRATEGY.md` to reflect that the active uniqueness phase now needs path-dependent moduli and variation-level localization, not a deterministic uniform modulus.
- Updated `PROGRESS.md` with the new prover objective and verified local/Mathlib topology names relevant to a possible compact-continuity follow-up.
- Updated `blueprint/src/chapters/doob_meyer.tex` with the new helper block and adjusted the broader bounded-continuous lemma to use it.
