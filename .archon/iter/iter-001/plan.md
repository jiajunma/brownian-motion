# Iteration 001 Plan

## State collected

- No prover result files, proof-journal session, or project-status report exist
  yet, so there is no prior attempt history to merge.
- The baseline contains 23 sorries in ten Lean files and no discovered axiom
  declarations.
- The runner permits one objective file this iteration. The previous ten-file
  objective list therefore exceeded the actual dispatch envelope.

## Decision made

Dispatch `BrownianMotion/Auxiliary/StandardBorel.lean` first. It is the
smallest independent foundation, contains two closely related mechanical
proofs, and its completion removes infrastructure debt without waiting on any
stochastic-process theorem.

The mathematical statements pass a direct sanity check. For a binary
disjoint union, Borel sets are exactly sets with Borel fibers because the two
summand inclusions are clopen embeddings. For a countable dependent disjoint
union, the same argument reconstructs a set as a countable union of its fiber
images. The cheapest signal for reversing this choice would be a prover report
that current Mathlib cannot express the Borel-image argument without adding a
new reusable lemma; in that case the next plan should isolate that lemma rather
than repeatedly retrying local tactics.

## Blueprint work

Created
`blueprint/src/chapters/BrownianMotion_Auxiliary_StandardBorel.tex`, explicitly
covering the selected Lean file. It gives complete proofs for the two Borel
instances and explains how they support the already-complete standard Borel
instances. Added the chapter to `blueprint/src/content.tex`.

No external source was needed: these are project-local compatibility results
derived directly from the canonical topology and measurable-space
constructions.

## Prover scope

The prover should fill both sorries in the selected file in one lane, preserve
all signatures, and compile the file. The other nine pending files remain
queued, with the next intended chain being compact systems, uniform
integrability, optional sampling, and local submartingale stability.

## Verification

- `lake build` completed successfully; only the 23 known sorry warnings remain.
- `git diff --check` passed, the coverage path exists, and the objective block
  names exactly one Lean file.
- Blueprint PDF compilation could not start because the installed XeLaTeX
  format was built by a different executable version. This is an environment
  mismatch, not a source-level LaTeX diagnostic; temporary artifacts were
  cleaned.

## Subagent skips

- No subagents are enabled for this project, so the classic single-agent path
  is used.
