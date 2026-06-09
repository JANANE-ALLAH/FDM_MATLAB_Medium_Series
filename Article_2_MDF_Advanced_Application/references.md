# References & Source Mapping — Article 2

## 1. Source files used

| Article concept | Source file | Used as |
|---|---|---|
| Single-method Euler on `u' - u² = 1` | `Test2_nonlineaire.m` | inspiration for `matlab_code/02_riccati_euler_explicit.m` |
| Six-method comparison pipeline | `Test2_nonlineaire2.m` | base for the entire `matlab_code/` set |
| Stability analysis & convergence study | `Test2_nonlineaire2.m` | used in Section 5 of the article |
| Linear ODE multi-scheme pipeline | `test1_lineaire2.m` | secondary reference for matrix-form Euler |

## 2. Theoretical references

1. **W. T. Reid (1972).** *Riccati Differential Equations.* Academic Press. The reference monograph on the Riccati equation in all its variants.
2. **C. W. Gear (1971).** *Numerical Initial Value Problems in Ordinary Differential Equations.* Prentice-Hall. The first systematic treatment of stiff problems, BDF and predictor-corrector families.
3. **E. Hairer, S. P. Nørsett, G. Wanner (1993).** *Solving Ordinary Differential Equations I — Nonstiff Problems.* Springer. The canonical text on Runge–Kutta methods.
4. **E. Hairer, G. Wanner (1996).** *Solving ODEs II — Stiff and Differential-Algebraic Problems.* Springer. The reference for implicit methods and Newton solvers.
5. **U. M. Ascher, L. R. Petzold (1998).** *Computer Methods for ODEs and DAEs.* SIAM. A balanced introduction to predictor-corrector and quasi-linearisation.
6. **J. C. Butcher (2008).** *Numerical Methods for Ordinary Differential Equations.* 2nd ed., Wiley. Most thorough discussion of order conditions, RK4 and its cousins.

## 3. MATLAB ecosystem references

- MathWorks documentation — `ode45`, `ode15s`, `ode23s`, `decic`, function handles.
- Shampine, L. F., Reichelt, M. W. (1997). *The MATLAB ODE Suite.* SIAM J. Sci. Comput., 18(1), 1–22 — the paper behind `ode45` & friends.

## 4. Suggested further reading

- **Strogatz, S. H.** *Nonlinear Dynamics and Chaos.* Westview Press — for the qualitative side: phase portraits, fixed points, bifurcations.
- **Iserles, A.** *A First Course in the Numerical Analysis of Differential Equations.* Cambridge — accessible bridge between theory and code.
- **Boyd, S., Vandenberghe, L.** *Convex Optimization.* Cambridge — Riccati equations in optimal control & LQR.

## 5. Citation block

```bibtex
@misc{Janane2025_FDM_Part2,
  author       = {Mohamed JANANE ALLAH},
  title        = {Solving Nonlinear ODEs in MATLAB:
                  Six FDM Schemes on a Riccati-Like Equation},
  year         = {2026},
  howpublished = {Medium series, Article 2 of 3},
  note         = {Source code released under academic-use licence}
}
```

## 6. License

Code and figures released for academic and educational reuse, with attribution.
