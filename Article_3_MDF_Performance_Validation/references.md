# References & Source Mapping — Article 3

## 1. Source files used

| Article concept | Source file | Used as |
|---|---|---|
| Poisson 2D Dirichlet (compact sparse) | `test3_poisson_Direclch.m` | base for `matlab_code/01_poisson_dirichlet_sparse.m` |
| Poisson 2D Dirichlet (full pipeline + convergence) | `test3_poisson_Direclch2.m` | reference for the convergence study |
| Poisson 2D Neumann (mixed BC + null-space fix) | `test3_poisson_Neuman.m` | discussed as a robustness extension |
| Manual Gauss-Seidel Poisson (no `\`) | `testu.m` | mentioned as a pedagogical alternative |
| Vibrating string (wave equation, CFL) | `test4_EDP_spatiotemporelles_2.m` | base for `matlab_code/02_wave_string_CFL.m` |
| Forced oscillator (centred scheme + energy) | `TP4.m`, `TP4_Master_FST.m`, `test4_EDP_spatiotemporelles_1.m` | base for `matlab_code/03_oscillator_stability_energy.m` |
| Static Euler–Bernoulli beam (4th-order stencil) | `test_eulreberniolI_MDF.m` | further-reading reference |
| Dynamic Euler–Bernoulli beam (modal extraction) | `test_eulreberniolI_MDF_dynamique.m` | further-reading reference |
| Production rapport text + .mat | `oscillateur_results.mat`, `rapport_oscillateur.txt` | quoted verbatim in Section 5.3 |

## 2. Theoretical references

1. **R. Courant, K. Friedrichs, H. Lewy (1928).** "Über die partiellen Differenzengleichungen der mathematischen Physik," Math. Ann. 100, 32–74. The original CFL paper.
2. **G. Strang, G. Fix (1973).** *An Analysis of the Finite Element Method.* Prentice-Hall. The reference for the discrete energy framework used in Section 4.4.
3. **K. W. Morton, D. F. Mayers (2005).** *Numerical Solution of Partial Differential Equations.* Cambridge, 2nd ed. Excellent treatment of von Neumann stability.
4. **L. Trefethen, D. Bau III (1997).** *Numerical Linear Algebra.* SIAM. Sparse matrix theory and conditioning.
5. **R. J. LeVeque (2007).** *Finite Difference Methods for Ordinary and Partial Differential Equations.* SIAM. Used for the convergence order estimator and the Poisson convergence proof.
6. **B. Cochelin, N. Damil, M. Potier-Ferry (1994).** "A path-following technique via an asymptotic-numerical method," *Computers & Structures*, 53(5), 1181–1192. Background for high-order asymptotic stability arguments (extension topic).
7. **N. M. Newmark (1959).** "A method of computation for structural dynamics," *J. Eng. Mech.*, ASCE, 85, 67–94. The classical Newmark scheme cited for the harmonic-oscillator stability discussion.

## 3. MATLAB documentation

- `spdiags`, `kron`, `speye`, `decomposition`, `mldivide` (`\`)
- `gradient`, `trapz`, `cond`, `eig`, `eigs`
- `parfor`, `tic`/`toc`, `profile`
- `save`, `load`, format `-v7` vs `-v7.3`

## 4. Suggested further reading

- **Roache, P. J.** *Verification and Validation in Computational Science and Engineering.* Hermosa Publishers — the "V&V Bible."
- **Oberkampf, W., Roy, C.** *Verification and Validation in Scientific Computing.* Cambridge — modern follow-up.
- **Quarteroni, A., Sacco, R., Saleri, F.** *Numerical Mathematics.* Springer — full coverage of sparse linear solvers.
- **Press, Teukolsky, Vetterling, Flannery.** *Numerical Recipes.* Cambridge — pragmatic recipes for all of the above.

## 5. Citation block

```bibtex
@misc{Janane2025_FDM_Part3,
  author       = {Mohamed JANANE ALLAH},
  title        = {Numerical Analysis Done Right: Convergence,
                  Stability and Validation of FDM Solvers in MATLAB},
  year         = {2026},
  howpublished = {Medium series, Article 3 of 3},
  note         = {Source code released under academic-use licence}
}
```

## 6. License

Code and figures released for academic and educational reuse, with attribution.
