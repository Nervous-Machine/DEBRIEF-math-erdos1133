# DEBRIEF-math-erdos1133

A DEBRIEF mission record (protocol https://github.com/Nervous-Machine/DEBRIEF) for **The claimed solution of Erdős Problem #1133 (polynomials agreeing with bounded data at most nodes)**.

This claim is on the public claims board, https://math-board.nervousmachine.com, which shows its stage, who has contributed, and what it needs next.

<!-- standing:begin -->
**Standing, 17 Nov 2026.** Stage: Registered. Needs next: No formal deduction exists for the claimed proof ([what would close it](ASKS.md)).

| certified | accepted | refuted | open gaps | cycles filed | last cycle |
|---|---|---|---|---|---|
| 0 | 0 | 0 | 2 | 0 | 17 Nov 2026 |

| | |
|---|---|
| checked by machine | no Lean to check |
| read by a person | nobody yet; no reading guide yet |
| elsewhere | [DeepMind formal-conjectures](https://github.com/google-deepmind/formal-conjectures/blob/6751c0f043985ac6647db28a45a63afdf21acffe/FormalConjectures/ErdosProblems/1133.lean): solved · [erdosproblems.com](https://www.erdosproblems.com/): open |
| related | — |
| tooling | GPT-6 Astra · tier: unknown (stated by the claimant as GPT-6 without a variant or tier; GPT-6 Astra reached Plus and higher plans from 3 to 4 September, the Pro variant on Pro, Business and Enterprise) |

Rendered from `ledger/` at regeneration; the full record is `SCORECARD.md`, what is owed is `ASKS.md`. Standing words: nothing has standing yet.
<!-- standing:end -->

## The problem

Fix a bound C. The conjecture is that there is a small epsilon such that, for n large and any n nodes in [-1,1], one can pick target values in [-1,1] so that every polynomial of degree below (1 + epsilon) n which hits at least (1 - epsilon) n of the targets exceeds C in absolute value somewhere on [-1,1]. Erdős proved a related statement with the roles of degree and node count exchanged and said he could not prove the conjectured one even when the counts are equal.

Source: https://www.erdosproblems.com/1133 (posed: Erdős (1967)).

A third-party formalization of the problem statement exists: `FormalConjectures/ErdosProblems/1133.lean` in github.com/google-deepmind/formal-conjectures at commit `e028240a61822d970c933f4656f51da025cf200b` (blob `3b747d71a2aead4c6f40411ccde8758ee76b376a`). It is the natural reference for whether a claimant's Lean theorem states this problem.

## The claim

**Jia-Qi Yang**, using GPT-6 (as listed by the claimant), submitted 2026-09-13 at https://www.erdosproblems.com/forum/thread/1133/proof-claims.

The claim proves the conjectured statement and more: the obstruction holds for sign data with any prescribed pointwise tolerance below one, the optimal exponential order of the obstruction parameter is determined, and for the full Chebyshev–Lobatto grids a sharp leading exponential coefficient is identified. The author cites a quantitative interpolation estimate of Olevskii and Ulanovskii for the arbitrary-node case, and describes the submission as a quantitative refinement of an earlier draft.

Artifacts, pinned:

- a public repository: github.com/JiaqiYang-Fdu/erdos1133 at commit 8c3b428feae8ddfb19d25a0fa76516d2c9b5d79d (2026-09-13); no licence file; 0 Lean files; no lakefile at the root
- a PDF write-up: https://github.com/JiaqiYang-Fdu/erdos1133/blob/main/robust_polynomial_interpolation.pdf (330518 bytes, git blob 589fbd5123afeaedd50977b45778c817bff81ea2 at the pinned commit)

Status on the problem page as of 2026-11-14: listed as one proof claim; not marked accepted by the site.

## What is owed

Each open gap is in `ASKS.md` with what closes it and who could act. In order:

1. **No formal deduction exists for the claimed proof** (EG1): A formalization of the main theorem, with the statement written by someone other than the prover.
2. **No independent mathematician has reported reading the proof, and there is no referee report** (EG2): Someone in the field reads it and says, under their name, what holds and what does not.

## Contributing

- **Rerun** (if there is a Lean development): copy `prereg_rerun.yaml`, fill in your predictions, register it with `tools/prereg.py register` from the protocol repository and commit it *before* running anything. Run. Report with the **Rerun report** issue form; it becomes a `rerun` cycle under your name.
- **Read**: a trace (reading guide) does not exist yet. Writing one is itself a `trace` cycle. Once it exists, the **Semantic read** form takes signatures and refusals.
- **Anything else**: open a plain issue.

Rules and templates: https://github.com/Nervous-Machine/DEBRIEF/blob/main/CONTRIBUTING.md. Every contribution is one dated cycle under your own name and goes into `CITATION.cff` and the next release.

## Layout

```
ledger/erdos1133.json   the ledger (protocol 0.1.0)
claim.yaml            the pinned claim this record was opened from
SCORECARD.md / ASKS.md  generated from the ledger
prereg_rerun.yaml     a pre-registration template for the first rerun (unregistered)
cycles/               contributed cycles, one file each
```

## Words

This record never calls the claim proved, verified or a theorem. It records what was claimed, what was checked by whom under what rule, and what is still open. Nothing here has standing until a cycle gives it one.
