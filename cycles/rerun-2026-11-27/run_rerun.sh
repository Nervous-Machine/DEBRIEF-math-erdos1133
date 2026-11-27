#!/bin/sh
# Nervous Machine rerun-2026-11-27 of peilinliu66-dev/jsp940-erdos1133-formalization at 83ab7d38. Runs inside the VM.
set -u
R=$HOME/untrusted/erdos1133/repo; L=$HOME/untrusted/erdos1133/logs; mkdir -p "$L"
export PATH=$HOME/.elan/bin:$PATH
cd "$R" || exit 9
echo "START $(date -u +%FT%TZ)" > "$L/progress.log"
git rev-parse HEAD > "$L/HEAD.txt"; cat lean-toolchain > "$L/toolchain.txt"
echo "R1 cache get $(date -u +%FT%TZ)" >> "$L/progress.log"
/usr/bin/time -v lake exe cache get > "$L/R1_cache.log" 2> "$L/R1_cache.time"; echo "rc=$?" >> "$L/R1_cache.log"
echo "R1 build $(date -u +%FT%TZ)" >> "$L/progress.log"
/usr/bin/time -v lake build > "$L/R1_build.log" 2> "$L/R1_build.time"; RC=$?; echo "rc=$RC" >> "$L/R1_build.log"; echo "R1 rc=$RC $(date -u +%FT%TZ)" >> "$L/progress.log"
echo "R2 scan $(date -u +%FT%TZ)" >> "$L/progress.log"
grep -rn -E "\bsorry\b|\badmit\b|^\s*axiom\b|native_decide|\bunsafe\b" --include=*.lean . | grep -v "^./.lake" > "$L/R2_escape_hatches.log"; echo "matches=$(wc -l < "$L/R2_escape_hatches.log")" >> "$L/R2_escape_hatches.log"
echo "R3R4 compare $(date -u +%FT%TZ)" >> "$L/progress.log"
cp "$HOME/untrusted/erdos1133/NM_Compare.lean" ./NM_Compare.lean
/usr/bin/time -v lake env lean NM_Compare.lean > "$L/R3R4_compare.log" 2> "$L/R3R4_compare.time"; echo "rc=$?" >> "$L/R3R4_compare.log"
echo "R5 check $(date -u +%FT%TZ)" >> "$L/progress.log"
/usr/bin/time -v lake env lean Check.lean > "$L/R5_check.log" 2> "$L/R5_check.time"; echo "rc=$?" >> "$L/R5_check.log"
python3 - <<'PY' > "$L/R4_text_compare.log" 2>&1
import re
a=open("Erdos1133/Main.lean").read(); i=a.index("theorem erdos_1133 :"); j=a.index(":=", i); s1=a[i:j]
s2='''theorem erdos_1133 :
    ∀ C > (0 : ℝ), ∃ ε > (0 : ℝ), ∀ᶠ n : ℕ in atTop,
      ∀ x : Fin n → Icc (-1 : ℝ) 1,
        ∃ y : Fin n → Icc (-1 : ℝ) 1,
          ∀ P : Polynomial ℝ,
            (P.natDegree : ℝ) < (1 + ε) * (n : ℝ) →
            ((Finset.univ.filter (fun i ↦ P.eval (x i : ℝ) = (y i : ℝ))).card : ℝ) ≥
              (1 - ε) * (n : ℝ) →
            ∃ z ∈ Icc (-1 : ℝ) 1, |P.eval z| > C '''
n=lambda s: re.sub(r"\s+"," ",s.replace("=>","↦")).replace(" ","")
print("identical_after_normalisation:", n(s1)==n(s2)); print("repo:", re.sub(r"\s+"," ",s1)); print("fc:  ", re.sub(r"\s+"," ",s2))
PY
sha256sum Erdos1133/*.lean Erdos1152/V5/*.lean Check.lean NM_Compare.lean lakefile.toml lake-manifest.json lean-toolchain > "$L/MANIFEST.sha256" 2>/dev/null
echo "END $(date -u +%FT%TZ)" >> "$L/progress.log"
