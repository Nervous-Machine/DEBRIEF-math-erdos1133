# Reading guide: Erdős Problem #1133

An automated second reading of meaning by claude-opus-5-5 via Claude Code, written after a hashed pre-registration (`prereg_review.yaml`). It sets the problem as posed beside each formal statement and lists every difference the reviewer saw. It is a reading, not a check, and not a human signature; it changes no standing. Leave your own reasoning with the **Reasoning note** form, or sign or refuse with the **Semantic read** form.

**Summary.** The main theorem `erdos_1133` matches the problem: the quantifier order is C, then ε, then eventually n, then ∀x, ∃y, ∀P. The degree bound, the match count and the sup condition are encoded faithfully. The one point that depends on reading is that the nodes x may repeat, which can make the formal claim strictly stronger than a distinct-node reading. The second theorem, `erdos_1133.variants.weaker`, is a separate, weaker result taken from the site's commentary. It is not part of the problem as posed, and it matches that commentary. (reviewer's confidence: high)

## A. The problem as posed

Source: https://www.erdosproblems.com/1133.

> Let $C>0$. There exists $\epsilon>0$ such that if $n$ is sufficiently large the following holds. For any $x_1,\ldots,x_n\in [-1,1]$ there exist $y_1,\ldots,y_n\in [-1,1]$ such that, if $P$ is a polynomial of degree $m<(1+\epsilon)n$ with $P(x_i)=y_i$ for at least $(1-\epsilon)n$ many $1\leq i\leq n$, then\[\max_{x\in [-1,1]}\lvert P(x)\rvert >C.\]

## B. The formal statements

### B1. google-deepmind/formal-conjectures FormalConjectures/ErdosProblems/1133.lean at `e028240`

Source: https://raw.githubusercontent.com/google-deepmind/formal-conjectures/e028240a61822d970c933f4656f51da025cf200b/FormalConjectures/ErdosProblems/1133.lean. Not registered with Palomar.

<details><summary>The file, verbatim</summary>

```lean
/-
Copyright 2026 The Formal Conjectures Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-/
module

public import FormalConjecturesUtil

/-!
# Erdős Problem 1133

*References:*
- [erdosproblems.com/1133](https://www.erdosproblems.com/1133)
- [Er67] Erdős, P., Problems and results on the convergence and divergence properties of the
  Lagrange interpolation polynomials and some extremal problems. Mathematica (Cluj) (1967), 65-73.
- [Ya26] Yang, J.-Q., *Erdős's Robust Polynomial Interpolation Problem: the Optimal Exponential
  Scale*. [arXiv:2609.14769](https://arxiv.org/abs/2609.14769) (2026).
-/

@[expose] public section

open Filter Set

namespace Erdos1133

/--
Let $C>0$. There exists $\epsilon>0$ such that if $n$ is sufficiently large the following holds.

For any $x_1,\ldots,x_n\in [-1,1]$ there exist $y_1,\ldots,y_n\in [-1,1]$ such that, if $P$ is a
polynomial of degree $m<(1+\epsilon)n$ with $P(x_i)=y_i$ for at least $(1-\epsilon)n$ many
$1\leq i\leq n$, then $$\max_{x\in [-1,1]}\lvert P(x)\rvert >C.$$

Yang [Ya26, Theorem 2.1] proved this, including repeated nodes, by taking $\rho=0$.
-/
@[category research solved, question, AMS 26 41]
theorem erdos_1133 :
    ∀ C > (0 : ℝ), ∃ ε > (0 : ℝ), ∀ᶠ n : ℕ in atTop,
      ∀ x : Fin n → Icc (-1 : ℝ) 1,
        ∃ y : Fin n → Icc (-1 : ℝ) 1,
          ∀ P : Polynomial ℝ,
            (P.natDegree : ℝ) < (1 + ε) * (n : ℝ) →
            ((Finset.univ.filter (fun i ↦ P.eval (x i : ℝ) = (y i : ℝ))).card : ℝ) ≥
              (1 - ε) * (n : ℝ) →
            ∃ z ∈ Icc (-1 : ℝ) 1, |P.eval z| > C := by
  sorry

/--
Erdős proved that, for any $C>0$, there exists $\epsilon>0$ such that if $n$ is sufficiently
large and $m=\lfloor (1+\epsilon)n\rfloor$ then for any $x_1,\ldots,x_m\in [-1,1]$ there is a
polynomial $P$ of degree $n$ such that $\lvert P(x_i)\rvert\leq 1$ for $1\leq i\leq m$ and
$\max_{x\in [-1,1]}\lvert P(x)\rvert>C$. The robust interpolation statement above also implies
this result. Erdős in [Er67] could not prove the robust statement even for $m=n$.
-/
@[category research solved, AMS 26 41]
theorem erdos_1133.variants.weaker :
    ∀ C > (0 : ℝ), ∃ ε > (0 : ℝ), ∀ᶠ n : ℕ in atTop,
      let m := ⌊(1 + ε) * (n : ℝ)⌋₊;
      ∀ x : Fin m → Icc (-1 : ℝ) 1,
        ∃ P : Polynomial ℝ,
          P.natDegree = n ∧
          (∀ i : Fin m, |P.eval (x i : ℝ)| ≤ 1) ∧
          ∃ z ∈ Icc (-1 : ℝ) 1, |P.eval z| > C := by
  sorry

end Erdos1133
```

</details>

## C. Differences

| id | where | the problem says | the formal statement says | kind | could it change the meaning? | why |
|---|---|---|---|---|---|---|
| D1 | erdos_1133, `∀ x : Fin n → Icc (-1 : ℝ) 1` | For any x_1,…,x_n ∈ [-1,1] (it does not say whether the nodes are distinct) | `x` is any function `Fin n → Icc (-1 : ℝ) 1`; it need not be injective, so repeated nodes are allowed | scope | uncertain | Allowing repeated nodes gives a statement at least as strong as the distinct-node version, which it implies by restriction. With repeated nodes, y can take different values at copies of the same node, but the degree budget (1+ε)n is measured against n, not against the number of distinct nodes. So the repeated-node claim may be strictly stronger. The docstring says Yang's Theorem 2.1 covers repeated nodes. If Erdős meant interpolation nodes to be distinct, the formal statement asks for more than the problem. |
| D2 | erdos_1133, `(P.natDegree : ℝ) < (1 + ε) * (n : ℝ)` | P is a polynomial of degree m < (1+ε)n | `P.natDegree` < (1+ε)n, quantified over all `P : Polynomial ℝ`, including P = 0 (natDegree 0) | convention | no | natDegree equals degree for nonzero P. The zero polynomial is included, so y must be chosen so that 0 does not match (1-ε)n of the values. The y-chooser can always do this by taking y_i ≠ 0. A reading that also includes 0 would require the same thing. |
| D3 | erdos_1133, conclusion `∃ z ∈ Icc (-1 : ℝ) 1, \|P.eval z\| > C` | max_{x∈[-1,1]} \|P(x)\| > C | some z in [-1,1] has \|P(z)\| > C | encoding | no | [-1,1] is compact and P is continuous, so the maximum exists, and it exceeds C exactly when some point exceeds C. |
| D4 | erdos_1133, `P : Polynomial ℝ` | 'a polynomial', with no coefficient field stated | real-coefficient polynomials only | type | no | The nodes and target values are real. If a complex P matches some y_i, its real part Re P (a real polynomial of no larger degree) matches them too, and its sup on [-1,1] is no larger than that of P. So restricting to real P loses nothing. |
| D5 | erdos_1133, match count `((Finset.univ.filter (fun i ↦ P.eval (x i : ℝ) = (y i : ℝ))).card : ℝ) ≥ (1 - ε) * (n : ℝ)` | P(x_i)=y_i for at least (1-ε)n many 1≤i≤n | the number of indices i with exact real equality is at least (1-ε)n, compared in ℝ | encoding | no | This is a direct encoding, counting indices rather than distinct points, which is consistent with D1. A large ε (ε ≥ 1) would make the hypothesis trivially true and the statement false (P = 0 would be a counterexample). Since ε is existential, the prover chooses it, so this is harmless. |
| D6 | erdos_1133, `∀ᶠ n : ℕ in atTop` | if n is sufficiently large | the property holds for all n beyond some threshold that depends on C and ε | encoding | no | This is the standard encoding, and the quantifier dependencies match the problem: ε depends only on C, and y depends on x. |
| D7 | erdos_1133.variants.weaker (whole theorem) | not part of the problem as posed; the site's commentary describes Erdős's weaker result with m=⌊(1+ε)n⌋, nodes x_1..x_m, deg P = n, \|P(x_i)\|≤1, and max > C | `let m := ⌊(1 + ε) * (n : ℝ)⌋₊`, `P.natDegree = n`, `∀ i : Fin m, \|P.eval (x i : ℝ)\| ≤ 1`, `∃ z ∈ Icc (-1 : ℝ) 1, \|P.eval z\| > C` | scope | no | This is an extra theorem and does not change the main statement. It matches the commentary's wording. Nodes may repeat here as well, but repeating nodes only makes this statement easier, since it reduces the set of distinct constraints. |

## D. What this review did not check

- Whether either statement is true, and any proof
- The contents of the Yang 2026 arXiv paper and of Erdős [Er67]
- The docstring's claim that the robust statement implies the weaker variant
- Whether the file compiles against this version of FormalConjecturesUtil/Mathlib
- The original wording on erdosproblems.com beyond the text given here

## Sign-off checklist

Sign or refuse each item with the **Semantic read** form. Items marked optional may be left out.

- [ ] A1: Confirm that the quantifier structure of erdos_1133 (∀C>0 ∃ε>0 ∀ᶠn ∀x ∃y ∀P) and its encodings of degree, match count and max (D2, D3, D5, D6) say what the problem says.
- [ ] A2: Decide whether the intended problem allows repeated nodes x_i. If it requires distinct nodes, accept that the formal statement is a possibly stronger generalisation, or ask for an injectivity hypothesis on x (D1).
- [ ] A3: Accept that restricting to Polynomial ℝ loses nothing (real part argument) (D4).
- [ ] A0 (optional): Check against Yang [Ya26, Theorem 2.1] (arXiv:2609.14769) that the theorem covers repeated nodes with ρ=0, which the 'solved' tag relies on (D1).
- [ ] A4: Check that the weaker variant matches the commentary's statement of Erdős's result, and that it is labelled as separate from the posed problem (D7).
