# Recommendations For Iteration 056

## Closest Target

Continue on `BrownianMotion/StochasticIntegral/DoobMeyer.lean`, but do not
assign
`MeasureTheory.Martingale.eq_zero_of_predictable_finiteVariation_bounded_continuous_reduction`
as one monolithic theorem. The useful next step is another explicit-input
connector that constructs exactly one missing family of hypotheses.

## Promising Next Steps

- Package deterministic bound/variation localization from explicit stopping or
  level assumptions, if those assumptions can be stated without deriving false
  global boundedness from local bounded variation.
- Alternatively, build a branch-disjunction wrapper only under additional
  honest hypotheses that supply the branch alternative and, in the left-isolated
  case, the required previous-time zero statement.
- Keep deterministic partitions and mesh as explicit inputs unless the next
  plan adds strong enough ordered compactness/order-density assumptions to prove
  them.

## Do Not Retry

- Do not infer the left-branch trichotomy from topology. The current connector
  assumes the disjunction explicitly.
- Do not use the fixed-level endpoint unless the single a.e. horizon bound,
  single a.e. variation bound, original continuity, deterministic partitions,
  mesh, and branch disjunction are already present.
- Do not use bottom-immediacy or left-isolated predecessor lemmas as an induction
  principle. They require explicit bottom-immediacy or explicit predecessor plus
  previous-zero input.

## Reusable Pattern

For a bounded deterministic-level endpoint, define the localizing sequence by
`tau n omega = top`, prove it with
`ProbabilityTheory.isLocalizingSequence_const_top`, instantiate the indexed
wrapper with `(C := fun _ => C)` and `(V := fun _ => V)`, and pass the single
a.e. hypotheses as `fun _ => hbound_horizon` and `fun _ => hvar_bound`.

## Structural Checks

Blueprint doctor reported no orphan chapters, broken references, empty
annotations, or project `axiom` declarations. `sync_leanok` was current for
iter-055 and made no marker changes.
