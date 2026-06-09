# References & Source Mapping — Article 1

## 1. Source files used (in this folder's parent directory)

| Article concept | Source file | Used as |
|---|---|---|
| 1D Taylor expansion of `sin(x)` | `test_Taylor_fuctionsinus.m` | base for `matlab_code/01_taylor_sin_1D.m` |
| 2D Taylor coefficient helper | `sin_derivative_at_0.m` | base for `matlab_code/sin_derivative_at_0.m` |
| Generic 2D Taylor function | `Taylor2D_sin.m` | base for `matlab_code/Taylor2D_sin.m` |
| 2D Taylor visualisation (orders 2, 4, 6) | `test_Taylor_fuctionsinus2D.m` | base for `matlab_code/02_taylor_sin_2D.m` |
| 2D Taylor generic-order visualisation | `Test_Taylor_fuction_Sinus2DN.m` | reference for `matlab_code/02_taylor_sin_2D.m` |
| Linear 1st-order ODE example | `SE2_Exemple1_MDF.m` | base for `matlab_code/03_ode_linear_basic.m` |
| Mesh-refinement study | `test1_lineaire.m` | base for `matlab_code/04_ode_linear_mesh_refinement.m` |
| Full multi-scheme pipeline | `test1_lineaire2.m` | partial inspiration (most material reserved for Article 2 & 3) |

## 2. Theoretical references

1. **L. F. Richardson (1922).** *Weather Prediction by Numerical Process.* Cambridge University Press. The first practical use of finite differences for solving a partial differential equation.
2. **R. Courant, K. Friedrichs, H. Lewy (1928).** "Über die partiellen Differenzengleichungen der mathematischen Physik," *Mathematische Annalen*, 100, 32–74. Foundational CFL paper.
3. **G. Strang (2007).** *Computational Science and Engineering.* Wellesley–Cambridge Press. Excellent modern reference, MATLAB-friendly.
4. **R. J. LeVeque (2007).** *Finite Difference Methods for Ordinary and Partial Differential Equations.* SIAM. The canonical graduate textbook on FDM.
5. **U. M. Ascher, L. R. Petzold (1998).** *Computer Methods for Ordinary Differential Equations and Differential-Algebraic Equations.* SIAM. Reference for explicit/implicit Euler analysis.

## 3. Online resources

- MATLAB official documentation — `linspace`, `factorial`, `meshgrid`, `surf`, `gammaln`.
- MathWorks community examples on Taylor series visualisation.
- Wikipedia — *Finite Difference, Taylor's Theorem, Explicit Euler Method* (cross-checked against the textbooks above).

## 4. Suggested follow-up readings (for Medium "Further Reading" section)

- **Trefethen, L. N.** *Spectral Methods in MATLAB.* SIAM, 2000 — if you want to see how Taylor expansions push to global polynomial interpolation.
- **Hairer, Nørsett, Wanner.** *Solving Ordinary Differential Equations I and II.* Springer — the encyclopedia of time-marching schemes.
- **Quarteroni, Saleri, Gervasio.** *Scientific Computing with MATLAB and Octave.* Springer — friendly, code-rich, French-author flavour.

## 5. Citation block (for academic reuse)

```bibtex
@misc{Janane2025_FDM_Part1,
  author       = {Mohamed JANANE ALLAH},
  title        = {From Taylor Series to Finite Differences:
                  A Hands-On MATLAB Introduction to the FDM},
  year         = {2026},
  howpublished = {Medium series, Article 1 of 3},
  note         = {Source code released under academic-use licence}
}
```

## 6. License & reuse

The MATLAB scripts derived for this article are released for **academic and educational reuse**, with attribution to the author. Commercial reuse should be discussed beforehand.
