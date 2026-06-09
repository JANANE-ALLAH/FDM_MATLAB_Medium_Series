# Article 2 — SEO & Editorial Metadata

## SEO Title (Medium-ready, < 60 chars)

**Solving Nonlinear ODEs in MATLAB: 6 FDM Schemes Compared**

Alternative variants:
1. *Riccati Meets MATLAB: A Side-by-Side Benchmark of 6 ODE Schemes*
2. *When Your ODE Blows Up: Choosing the Right FDM Scheme*
3. *Explicit, Implicit, RK4, Predictor–Corrector: One Nonlinear Equation, Six Strategies*

## SEO Subtitle (< 140 chars)

A pragmatic MATLAB comparison of explicit Euler, implicit Euler with Newton, RK2, RK4, predictor-corrector and local linearisation on a Riccati equation.

## SEO Summary / Meta description (150–160 chars)

Benchmark six finite-difference schemes on the nonlinear ODE du/dx = 1 + u². Accuracy, stability, and behaviour near the blow-up — all in MATLAB.

## Target reader

- Researchers and engineers building nonlinear time-marching codes
- Students moving from "Euler explicit" to "real numerical analysis"
- MATLAB users who want a deeper understanding of `ode45`, `ode15s` and friends
- Anyone investigating singularities, blow-ups or stiff dynamics

## Estimated reading time

15–18 minutes.

## Recommended Medium Tags (max 5)

1. `MATLAB`
2. `Nonlinear Dynamics`
3. `Numerical Methods`
4. `Scientific Computing`
5. `Computational Physics`

## Useful hashtags

`#MATLAB` `#NumericalAnalysis` `#NonlinearODE` `#RungeKutta` `#Riccati`
`#FiniteDifferences` `#NewtonRaphson` `#Engineering` `#STEM`

## Content stats

- **Word count target:** 3 500 – 4 500 words
- **Code blocks:** 6 (one per scheme)
- **Equations:** ~10
- **Tables:** 2 (schemes summary + final error comparison)
- **Figures:** 3 (solutions overlay, loglog convergence, residual / phase portrait)

## Article hierarchy

```
H1   Title
H2   1. Introduction
H2   2. Scientific context
H2   3. Theory
 H3    3.1 Equation and singularity
 H3    3.2 Six numerical strategies in one slide
H2   4. MATLAB implementation
 H3    4.1 Explicit Euler
 H3    4.2 Implicit Euler + Newton
 H3    4.3 RK2 and RK4
 H3    4.4 Predictor-Corrector
 H3    4.5 Local linearisation
H2   5. Numerical results
 H3    5.1 Phase portrait
 H3    5.2 Residual validation
H2   6. Critical analysis
H2   7. Optimisations
H2   8. Conclusion
H2   9. References
```

## Key one-liners

> "Nonlinearity is the test that separates 'numerical methods' from 'numerical analysis'."

> "Implicit Euler is not automatically better — on a non-stiff nonlinear problem it pays the price of Newton with no gain in accuracy."

> "RK4 wins by six orders of magnitude. The only thing it cannot beat is the singularity itself."

## TL;DR (for Medium preview)

We benchmark six finite-difference schemes (explicit/implicit Euler, RK2/RK4, predictor–corrector, local linearisation) on a Riccati-like ODE u' = 1 + u² whose solution blows up at π/4. Each method is implemented in MATLAB, with code, errors, convergence rates and a discussion of when each fails near the singularity.

## Cross-references

- Article 1 — From Taylor to Finite Differences in MATLAB.
- Article 3 — Performance, stability and validation best practices.
