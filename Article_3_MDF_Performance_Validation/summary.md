# Article 3 — SEO & Editorial Metadata

## SEO Title (Medium-ready, < 60 chars)

**Numerical Analysis Done Right: FDM Convergence & Validation in MATLAB**

Alternative variants:
1. *CFL, Spectral Radius, Energy: A MATLAB Validation Playbook for FDM*
2. *From Working Solver to Trustworthy Solver: FDM Best Practices in MATLAB*
3. *Three PDEs, One Toolkit: Validating Your MATLAB FDM Code*

## SEO Subtitle (< 140 chars)

Master the three pillars of trustworthy numerical solvers — convergence, stability, validation — through Poisson 2D, the vibrating string and the harmonic oscillator.

## SEO Summary / Meta description (150–160 chars)

A hands-on MATLAB guide to validating finite-difference solvers: O(h²) convergence on Poisson 2D, CFL on the wave equation, energy conservation on the oscillator.

## Target reader

- PhD students and post-docs who must publish, defend or peer-review numerical work
- R&D engineers maintaining in-house FDM/FEM codes
- Teachers preparing a "validation" lecture for an MSc programme
- MATLAB developers moving from prototype to production

## Estimated reading time

18–22 minutes.

## Recommended Medium Tags (max 5)

1. `MATLAB`
2. `Scientific Computing`
3. `Numerical Methods`
4. `Applied Mathematics`
5. `Engineering`

## Useful hashtags

`#MATLAB` `#FDM` `#NumericalAnalysis` `#SciComp` `#CFL` `#PDE` `#ScientificComputing`
`#Validation` `#Reproducibility` `#STEM` `#OpenScience`

## Content stats

- **Word count target:** 4 500 – 5 500 words
- **Code blocks:** 8
- **Equations:** ~14
- **Tables:** 3 (canonical trilogy, convergence printout, optimisation matrix)
- **Figures:** 4 (Poisson convergence, CFL stability, energy conservation, stability spectrum)

## Article hierarchy

```
H1   Title
H2   1. Introduction
H2   2. Scientific context
H2   3. Test case A — Poisson 2D & convergence
 H3    3.1 Equation and discrete operator
 H3    3.2 Sparse assembly with kron + spdiags
 H3    3.3 Convergence numerical experiment
H2   4. Test case B — Vibrating string & CFL
 H3    4.1 Equation
 H3    4.2 CFL condition
 H3    4.3 Instability
 H3    4.4 Energy conservation
H2   5. Test case C — Forced oscillator
 H3    5.1 Equation
 H3    5.2 Analytical reference
 H3    5.3 Spectral radius stability
 H3    5.4 Energy conservation stress test
H2   6. Best practices
 H3    6.1 Numerical
 H3    6.2 Validation
 H3    6.3 Software engineering
H2   7. Optimisations
H2   8. Critique
H2   9. Conclusion
H2  10. References
```

## Key one-liners

> "A working solver is the first 30 % of the work. The remaining 70 % is convincing yourself, your reviewer, and your future self that it is correct."

> "Sparse is not an optimisation. It is the only way to solve a 2D Poisson problem at engineering scale."

> "CFL is not a guideline — it is a physical statement: information cannot travel faster on the grid than on the continuum."

> "Energy conservation is the single best stress-test for long-time mechanical simulations."

## TL;DR (Medium preview)

How to turn a working FDM solver into a trustworthy one. Three canonical test cases — Poisson 2D (elliptic), vibrating string (hyperbolic) and forced oscillator (ODE) — illustrate convergence order measurement, CFL stability, spectral radius analysis, sparse matrix assembly, energy conservation tracking, and software-engineering best practices. All MATLAB, all reproducible.

## Cross-references

- Article 1 — Taylor & first FDM solver
- Article 2 — Six schemes on a nonlinear ODE
