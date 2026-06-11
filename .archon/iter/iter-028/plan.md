# Iteration 028 Plan

## State Collected

- User hint directs this iteration to keep the loop focused on the `QuadraticVariationBrownian.lean` dependency chain: `QuadraticVariationBrownian.lean`, `QuadraticVariation.lean`, and the active predictable finite-variation bridge in `DoobMeyer.lean`. It also asks the prover harness to use the strongest available GPT settings, `gpt-5.5` with `effort: xhigh`, if exposed by the loop configuration.
- Processed the prover result for `BrownianMotion/StochasticIntegral/DoobMeyer.lean`. The prover closed `MeasureTheory.Martingale.integral_sq_terminal_eq_zero_of_refining_partitions` using the finite square expansion, the bounded-variation square-increment estimate, and dominated convergence.
- The active Doob-Meyer gap is still `MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`, now starting at `DoobMeyer.lean:1235` with its `sorry` at line 1271. The original weak local Doob-Meyer theorem remains at line 1488 with its `sorry` at line 1493.
- `QuadraticVariation.lean` still has the generic square-norm local-submartingale gap at `IsLocalMartingale.isLocalSubmartingale_sq_norm`, with the actual `sorry` at line 84. `QuadraticVariationBrownian.lean` has no internal `sorry`, but its fixed-time theorem still depends transitively on the Doob-Meyer uniqueness bridge, the generic square-norm helper, and the weak Doob-Meyer theorem.
- The prover reported `lake env lean BrownianMotion/StochasticIntegral/DoobMeyer.lean`, `QuadraticVariation.lean`, `QuadraticVariationBrownian.lean`, and `lake build` all passing, with only the known project `sorry` warnings and pre-existing deprecation warnings.
- Reference check: re-read the project-local sources available for this route: `README.md`, `blueprint/src/content.tex`, and the relevant `doob_meyer.tex` section. There is still no local original Beiglböck--Schachermayer--Veliyev source file in `references/`; the new helper prose is project-bespoke and carries no fabricated source citation.
- Proof-journal session summaries and recommendations are absent. The only live proof-journal file is `proof-journal/current_session/attempts_raw.jsonl`, which contains the no-prover-lane summary record.
- No subagents are enabled for this project, so none were dispatched.

## Soundness Check

The just-closed refining-partition lemma is sound only because it has an explicit deterministic total-variation bound \(V\). The earlier broad prose "bounded continuous finite variation" still needs a localization step: pathwise finite variation alone does not give an integrable deterministic dominator for the square-increment sums.

The next safe split is therefore a variation-bounded/uniform-increment helper. It should assume deterministic partitions, a deterministic variation bound, and a deterministic increment modulus \(\delta_n \to 0\). That helper is a direct mathematical consequence of the closed refining-partition lemma and `BoundedVariationOn.sq_increment_sum_tendsto_zero_of_uniform_bound`. The broader bounded-continuous theorem can then focus only on constructing the deterministic partitions/modulus and localizing variation levels.

## Decision Made

Continue in `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, not `QuadraticVariation.lean`, for this iteration. The predictable finite-variation bridge is still converging and just closed a load-bearing dominated-convergence endpoint; the next checkpoint is small enough to state honestly and close without changing public theorem statements.

I updated `blueprint/src/chapters/doob_meyer.tex` to insert
`lem:Martingale.integral_sq_terminal_eq_zero_of_bounded_continuous_finiteVariation_of_variation_bound`
between the refining-partition endpoint and the broader bounded-continuous finite-variation lemma. The prover objective now asks first for the corresponding Lean helper, then for the broader bounded-continuous square-integral-zero lemma if the helper lands quickly.

The cheapest signal to reverse this route is a prover report showing that even the variation-bounded/uniform-increment helper requires changing theorem signatures or adding nonlocal infrastructure outside `DoobMeyer.lean`. If that happens, the next plan should pivot to a structural split of deterministic partition/modulus construction or return to the usual-condition square-norm repair before the uniqueness bridge.

## State Updates

- Updated `task_done.md` with the closed refining-partition dominated-convergence helper.
- Updated `task_pending.md` with the current Doob-Meyer line numbers and the next variation-bound split.
- Updated `STRATEGY.md` only where the live predictable finite-variation milestone changed.
- Updated `PROGRESS.md` with one prover lane, `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, scoped to the Brownian quadratic-variation dependency chain.
