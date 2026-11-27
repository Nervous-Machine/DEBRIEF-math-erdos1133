import Erdos1133.Main

/-! Nervous Machine, rerun-2026-11-27, check R4 and R3. The example below is formal-conjectures' statement of Erdős 1133
(FormalConjectures/ErdosProblems/1133.lean at 9097e2f9), copied verbatim, closed by the formalization's endpoint. -/

open Filter Set

example :
    ∀ C > (0 : ℝ), ∃ ε > (0 : ℝ), ∀ᶠ n : ℕ in atTop,
      ∀ x : Fin n → Icc (-1 : ℝ) 1,
        ∃ y : Fin n → Icc (-1 : ℝ) 1,
          ∀ P : Polynomial ℝ,
            (P.natDegree : ℝ) < (1 + ε) * (n : ℝ) →
            ((Finset.univ.filter (fun i ↦ P.eval (x i : ℝ) = (y i : ℝ))).card : ℝ) ≥
              (1 - ε) * (n : ℝ) →
            ∃ z ∈ Icc (-1 : ℝ) 1, |P.eval z| > C := Erdos1133.erdos_1133

#print axioms Erdos1133.erdos_1133
#print axioms Erdos1133.erdos_1133_with_threshold
