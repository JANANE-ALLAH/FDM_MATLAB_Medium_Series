# Medium Articles Series — Finite Difference Method (FDM) in MATLAB

A three-part series turning a research-grade MATLAB code base on the Finite Difference Method into publication-ready Medium articles. Each part is self-contained but the three together form a complete journey, from first principles to a trustworthy numerical solver.

> **Author:** Mohamed JANANE ALLAH
> **Source code:** see [`../`](../) — original 24 MATLAB scripts and the production rapport from `TP4_Master_FST.m`.

---

## Series at a glance

| # | Title | Reading time | Level |
|---|---|---|---|
| 1 | From Taylor Series to Finite Differences: A Hands-On MATLAB Introduction to the FDM | 12–15 min | Beginner |
| 2 | Solving Nonlinear ODEs in MATLAB: 6 FDM Schemes Compared on a Riccati-Like Equation | 15–18 min | Advanced |
| 3 | Numerical Analysis Done Right: Convergence, Stability and Validation of FDM Solvers in MATLAB | 18–22 min | Expert |

---

## Folder structure

```
Medium_Articles/
├── README.md                                    <-- this file
├── Article_1_MDF_Fundamentals/
│   ├── article.md                               full Medium article
│   ├── summary.md                               SEO title, tags, hashtags
│   ├── references.md                            bibliography + source mapping
│   ├── matlab_code/
│   │   ├── sin_derivative_at_0.m
│   │   ├── Taylor2D_sin.m
│   │   ├── 01_taylor_sin_1D.m
│   │   ├── 02_taylor_sin_2D.m
│   │   ├── 03_ode_linear_basic.m
│   │   └── 04_ode_linear_mesh_refinement.m
│   └── figures/
│       └── 06_run_all_figures.m
│
├── Article_2_MDF_Advanced_Application/
│   ├── article.md
│   ├── summary.md
│   ├── references.md
│   ├── matlab_code/
│   │   ├── 01_riccati_setup.m
│   │   ├── 02_riccati_euler_explicit.m
│   │   ├── 03_riccati_euler_implicit_newton.m
│   │   ├── 04_riccati_RK2_RK4.m
│   │   ├── 05_riccati_predictor_corrector.m
│   │   ├── 06_riccati_local_linearisation.m
│   │   └── 07_riccati_all_methods.m
│   └── figures/
│       └── 08_run_all_figures.m
│
└── Article_3_MDF_Performance_Validation/
    ├── article.md
    ├── summary.md
    ├── references.md
    ├── matlab_code/
    │   ├── 01_poisson_dirichlet_sparse.m
    │   ├── 02_wave_string_CFL.m
    │   ├── 03_oscillator_stability_energy.m
    │   └── 04_convergence_helpers.m
    └── figures/
        └── 09_run_all_figures.m
```

---

## How to read

- **Start at Article 1** if you are new to numerical methods or to the FDM. You'll learn the link between a Taylor expansion and a difference scheme, and you'll solve your first ODE.
- **Jump to Article 2** if you are already comfortable with Euler/RK methods and want to see how they behave on a nonlinear equation that *blows up*.
- **Go directly to Article 3** if you need a checklist of validation and best practices to convince a reviewer or auditor that your code is correct.

Each article is **self-contained**: it states its prerequisites, links to the others, and ships with reproducible MATLAB scripts in its own `matlab_code/` and `figures/` folders.

---

## How to reproduce the figures

1. Open MATLAB (R2014b or later — no toolbox needed).
2. Change directory to one of `Article_*/figures/`.
3. Run the corresponding `06_/08_/09_run_all_figures.m` script.
4. PNG files are saved next to the script.

Total runtime for the three articles together: **less than 2 minutes** on a regular laptop.

---

## Source-file mapping

The articles are *not* a verbatim reproduction of any single source file. They distill, refactor and re-document the original 24 MATLAB scripts of [`../`](../). The exact mapping per article is in each `references.md`.

| Original file | Used in |
|---|---|
| `test_Taylor_fuctionsinus.m` | Article 1 |
| `sin_derivative_at_0.m` | Article 1 |
| `Taylor2D_sin.m` | Article 1 |
| `test_Taylor_fuctionsinus2D.m` / `Test_Taylor_fuction_Sinus2DN.m` | Article 1 |
| `SE2_Exemple1_MDF.m` / `SE2_Exemple2_MDF.m` | Article 1 (linear) / Article 2 (nonlinear context) |
| `test1_lineaire.m` / `test1_lineaire2.m` | Article 1 |
| `Test2_nonlineaire.m` / `Test2_nonlineaire2.m` | **Article 2** |
| `test3_poisson_Direclch.m` / `test3_poisson_Direclch2.m` | Article 3 (test case A) |
| `test3_poisson_Neuman.m` / `testu.m` | Article 3 (extensions) |
| `test4_EDP_spatiotemporelles_1.m` | Article 3 (oscillator) |
| `test4_EDP_spatiotemporelles_2.m` | Article 3 (vibrating string) |
| `test_eulreberniolI_MDF.m` / `_dynamique.m` | Article 3 (further reading) |
| `TP4.m` / `TP4_Master_FST.m` | Article 3 (production rapport quoted) |
| `oscillateur_results.mat` / `rapport_oscillateur.txt` | Article 3 (validation artefacts) |

---

## License

All code released for **academic and educational reuse**, with attribution. Commercial reuse should be discussed.

```bibtex
@misc{Janane2026_FDM_Series,
  author       = {Mohamed JANANE ALLAH},
  title        = {Finite Difference Method in MATLAB --- A Three-Part Series},
  year         = {2026},
  howpublished = {Medium},
  note         = {Source code released under academic-use licence}
}
```

---

## Suggested publication order on Medium

1. Publish Article 1 first. Tag with `#MATLAB`, `#NumericalMethods`, `#TaylorSeries`.
2. One week later, publish Article 2. Cross-link to Article 1 in the introduction.
3. Two weeks later, publish Article 3 as the wrap-up. Cross-link both previous articles in the conclusion.

This spacing maximises algorithmic reach on Medium and gives readers time to absorb the previous instalment.
