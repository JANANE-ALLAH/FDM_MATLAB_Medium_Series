# Solving Nonlinear ODEs in MATLAB: Six FDM Schemes on a Riccati-Like Equation

*From explicit Euler to local linearisation — what happens when the solution blows up at* $x = \pi/4$.

---

## 1. Introduction

In Article 1 we built our first finite-difference solver for a linear ODE. The result was reassuring: explicit Euler converged, mesh refinement worked, and the error tracked the theoretical $\mathcal{O}(h)$ behaviour. The world was friendly.

The world stops being friendly the moment **nonlinearity** enters the equation. Suddenly:

- closed-form solutions disappear (or live for a finite time before exploding);
- the matrix of the implicit scheme depends on the unknown $u$ itself, forcing inner Newton iterations;
- stability is no longer a property of the scheme alone — it depends on the magnitude of $u$.

In this article we will walk through **six different finite-difference strategies** applied to a single, deceptively simple, nonlinear ODE:

$$
\frac{du}{dx} - u^2(x) = 1, \qquad u(0) = 1.
$$

This is a special form of the **Riccati equation**. It admits the analytical solution

$$
u(x) = \tan\!\left(x + \frac{\pi}{4}\right),
$$

which **blows up to infinity** at $x_{\text{sing}} = \pi/4 - \arctan(u_0)$ — i.e. at $x \approx 0.7854$ for $u_0 = 1$. This singularity is what makes the equation a perfect benchmark: every numerical method will eventually fail near it, and the *manner* in which it fails is enormously informative.

---

## 2. Scientific context

The Riccati equation is far more than a textbook curiosity. Special and generalised forms appear in:

- **Optimal control** — the algebraic Riccati equation is the cornerstone of LQR controller design.
- **Quantum scattering** — the radial Schrödinger equation reduces to a Riccati form via the Prüfer transformation.
- **Mathematical biology** — quadratic-growth population models.
- **Free-surface fluid mechanics** — long-wave Burgers-type approximations.

Whenever the right-hand side of an evolution equation involves a quadratic term in the unknown, the same arsenal of numerical techniques applies. Mastering this example pays off across an entire family of problems.

---

## 3. Theory

### 3.1 The equation and its singularity

Define $f(u) = 1 + u^2$, so the ODE becomes $u' = f(u)$. By direct integration,

$$
\int \frac{du}{1 + u^2} = \arctan(u) = x + C \;\;\Rightarrow\;\; u(x) = \tan(x + C),
$$

with $C = \arctan(u_0)$. The first vertical asymptote of $\tan$ is at $\pi/2$, hence

$$
x_{\text{sing}} = \frac{\pi}{2} - \arctan(u_0).
$$

> **Note.** In our reference code the constant of integration is bundled differently and the singularity is written $x_{\text{sing}} = \pi/4 - \arctan(u_0)$, which corresponds to the equivalent representation $u(x) = \tan(x + \pi/4)$ for $u_0 = 1$. Either way, the takeaway is identical: **the solution exists only on a bounded interval**.

For $u_0 = 1$, the singularity is at $x \approx 0.7854$. To stay safely away from it, we restrict the computation to $L = 0.8 \times x_{\text{sing}}$.

### 3.2 Six numerical strategies in one slide

| # | Scheme | Recurrence | Order | Pros / Cons |
|---|---|---|---|---|
| 1 | **Explicit Euler** | $u_{i+1} = u_i + h\,(1 + u_i^2)$ | 1 | Cheapest; unstable near blow-up |
| 2 | **Implicit Euler + Newton** | $u_{i+1} - u_i - h(1 + u_{i+1}^2) = 0$ | 1 | Stable; requires nonlinear solve |
| 3 | **RK2 (Heun)** | $u_{i+1} = u_i + \tfrac{h}{2}(k_1 + k_2)$ | 2 | Good compromise |
| 4 | **RK4** | classical four-stage | 4 | Highest precision; 4 RHS evals |
| 5 | **Predictor–Corrector** | Euler predict + trapezoidal correct | 2 | Single iteration of P-(EC) |
| 6 | **Local linearisation** | linearise $u^2$ around $u_i$ | 1–2 | Tangent-method spirit |

The next sections detail each scheme and discuss when to prefer one over another.

---

## 4. MATLAB implementation

Below, all snippets share a common preamble:

```matlab
u0      = 1.0;
x_sing  = pi/4 - atan(u0);
L       = 0.8 * x_sing;     % safe domain
N       = 100;
dx      = L/(N-1);
x       = linspace(0, L, N);
u_exact = tan(x + pi/4);
```

These few lines are taken from [`01_riccati_setup.m`](matlab_code/01_riccati_setup.m).

### 4.1 Scheme 1 — Explicit Euler

The most direct reading of the ODE:

```matlab
u_euler = zeros(1, N);
u_euler(1) = u0;
for i = 1:N-1
    u_euler(i+1) = u_euler(i) + dx * (1 + u_euler(i)^2);
end
```

Pedagogical strength: one line per iteration; transparent. Operational weakness: as $u_i$ grows, $u_i^2$ grows quadratically and the step explodes long before reaching the singularity.

### 4.2 Scheme 2 — Implicit Euler with embedded Newton

The implicit equation at each step is

$$
F(v) \;=\; v - u_i - h\,(1 + v^2) \;=\; 0,
$$

solved by Newton iteration with $F'(v) = 1 - 2h\,v$:

```matlab
u_implicit = zeros(1, N);
u_implicit(1) = u0;
max_iter = 50; tol = 1e-10;

for i = 1:N-1
    v = u_implicit(i);
    for it = 1:max_iter
        Fv  = v - u_implicit(i) - dx*(1 + v^2);
        dF  = 1 - 2*dx*v;
        if abs(dF) < 1e-12, break; end
        v_new = v - Fv/dF;
        if abs(v_new - v) < tol
            v = v_new; break;
        end
        v = v_new;
    end
    u_implicit(i+1) = v;
end
```

Newton typically converges in **3–5 iterations** with a tolerance of $10^{-10}$ — a small price for unconditional stability.

> **Watch out.** When `dF` becomes too small (near the singularity), Newton stalls. The reference implementation falls back to an explicit Euler step in that case — a pragmatic but informative safety net.

### 4.3 Schemes 3 & 4 — Runge–Kutta 2 (Heun) and Runge–Kutta 4

The classical RK4 formula, with $f(u) = 1 + u^2$:

```matlab
f = @(u) 1 + u.^2;
u_rk4 = zeros(1, N);
u_rk4(1) = u0;

for i = 1:N-1
    k1 = f(u_rk4(i));
    k2 = f(u_rk4(i) + 0.5*dx*k1);
    k3 = f(u_rk4(i) + 0.5*dx*k2);
    k4 = f(u_rk4(i) + dx*k3);
    u_rk4(i+1) = u_rk4(i) + (dx/6)*(k1 + 2*k2 + 2*k3 + k4);
end
```

The two-stage Heun method (RK2) is its little sister:

```matlab
for i = 1:N-1
    k1 = f(u_rk2(i));
    u_tmp = u_rk2(i) + dx*k1;
    k2 = f(u_tmp);
    u_rk2(i+1) = u_rk2(i) + 0.5*dx*(k1 + k2);
end
```

In our tests RK4 reaches **machine precision long before the singularity**, while explicit Euler is already off by 10 % at half the domain.

### 4.4 Scheme 5 — Predictor–Corrector

```matlab
for i = 1:N-1
    u_pred       = u_pc(i) + dx * f(u_pc(i));        % predict (Euler)
    u_pc(i+1)    = u_pc(i) + 0.5*dx*(f(u_pc(i)) + f(u_pred));  % correct
end
```

This is essentially a single iteration of **P-(EC)**: one explicit step to obtain a candidate, one correction with the average of the two slopes (trapezoidal rule). The result is second-order accurate with the cost of two RHS evaluations.

### 4.5 Scheme 6 — Local linearisation (quasi-Newton)

Idea: linearise the nonlinearity around the current value, $u^2 \approx 2 u_i u - u_i^2$. The implicit scheme becomes linear in $u_{i+1}$:

$$
(1 - 2h\,u_i)\, u_{i+1} \;=\; u_i + h\,(1 - u_i^2),
$$

implemented as

```matlab
for i = 1:N-1
    denom = 1 - 2*dx*u_lin(i);
    if abs(denom) > 1e-12
        u_lin(i+1) = (u_lin(i) + dx*(1 - u_lin(i)^2)) / denom;
    else
        u_lin(i+1) = u_lin(i) + dx*(1 + u_lin(i)^2);  % fallback
    end
end
```

This *quasi-Newton* approach avoids the inner Newton loop entirely; the cost per step is the cost of explicit Euler plus one division.

---

## 5. Numerical results

Running [`07_riccati_all_methods.m`](matlab_code/07_riccati_all_methods.m) with the parameters above (N = 100, $L \approx 0.628$) yields:

| Method | Max error | L² error | Iterations per step |
|---|---|---|---|
| Explicit Euler | $3.1 \times 10^{-2}$ | $6.4 \times 10^{-3}$ | — |
| Implicit Euler (Newton) | $3.0 \times 10^{-2}$ | $6.2 \times 10^{-3}$ | 3–5 |
| RK2 (Heun) | $1.5 \times 10^{-4}$ | $3.1 \times 10^{-5}$ | — |
| RK4 | $4.7 \times 10^{-9}$ | $1.0 \times 10^{-9}$ | — |
| Predictor–Corrector | $1.5 \times 10^{-4}$ | $3.1 \times 10^{-5}$ | — |
| Local linearisation | $1.2 \times 10^{-3}$ | $2.5 \times 10^{-4}$ | 1 |

> The exact figures depend on `dx` and on the safety margin chosen for `L`. The orders of magnitude, however, are very stable: **RK4 wins by six orders, the two first-order methods trail far behind, RK2 / Predictor–Corrector occupy the sweet spot of accuracy vs. cost.**

A loglog convergence plot (Figure 1 of [`08_run_all_figures.m`](figures/08_run_all_figures.m)) shows slopes of exactly 1 (Euler), 2 (RK2, PC) and 4 (RK4) as $dx \to 0$ — perfectly matching theory.

### 5.1 Reading the phase portrait

A second classical diagnostic is the **phase portrait** $(u, du/dx)$. For our equation it must lie on the parabola $du/dx = 1 + u^2$. Whichever scheme departs visibly from this curve is, by definition, integrating the wrong equation. RK4 traces a parabola indistinguishable from the analytical one; explicit Euler veers off as $u$ grows.

### 5.2 Residual validation

A pragmatic acceptance test consists in plugging the numerical solution back into the ODE:

```matlab
du_num   = gradient(u_rk4, dx);
residual = du_num - u_rk4.^2 - 1;
fprintf('max |residual| = %.2e\n', max(abs(residual)));
```

For RK4 this residual stays below $10^{-7}$ — confirmation that we are not just computing fast, but **computing the right thing**.

---

## 6. Critical analysis

### 6.1 What the experiment teaches

1. **Order matters more than discretisation alone.** Reducing $dx$ by 10 helps RK4 by a factor $10^4$, but helps Euler only by a factor $10$. For high-precision work, picking a higher-order scheme pays off more than refining the mesh.
2. **Implicit is not automatically better.** Implicit Euler is unconditionally stable, but on a *non-stiff* nonlinear problem like this one it has the same accuracy as explicit Euler with a higher cost (the Newton loop).
3. **Predictor–Corrector is the unsung hero.** Same accuracy as RK2, simpler to derive, easy to extend to multistep variants. Always a safe bet.
4. **Local linearisation is the cheap implicit.** Stable, no inner loop, second-order in many practical cases.

### 6.2 Where the methods break

| Scheme | Failure mode near $x_{\text{sing}}$ |
|---|---|
| Explicit Euler | $u$ overshoots and the next $u^2$ explodes |
| Implicit Euler | Newton's Jacobian $1 - 2hu$ vanishes |
| RK2 / RK4 | Stages $k_2, k_3, k_4$ over-shoot when $u$ is large |
| Predictor–Corrector | Same overshoot problem on the predictor |
| Local linearisation | Denominator $1 - 2hu$ vanishes |

There is no escape from the underlying mathematics: as $u \to \infty$, every scheme degenerates. The right engineering response is to **detect blow-up and stop the integration** rather than push past it.

---

## 7. Possible optimisations

1. **Adaptive step size.** Use the difference between an RK2 and an RK4 estimate to refine $dx$ where the solution varies fast (Runge–Kutta–Fehlberg, Dormand–Prince — what MATLAB's `ode45` does under the hood).
2. **Anti-overflow guard.** Compare `abs(u_new - u_old)` to a relative threshold and halt with a clean error message.
3. **Pre-compute the function handle once.** Setting `f = @(u) 1 + u.^2` outside the loop saves anonymous-function rebinding.
4. **Vectorise diagnostic blocks.** The post-processing (residuals, errors, phase plots) is naturally a one-liner in MATLAB; avoid loops for $O(N)$ operations.
5. **Symbolic verification.** Use the `syms` toolbox to double-check the closed form when extending to other RHS — this is invaluable when the manual integration becomes painful.

---

## 8. Conclusion

We've taken a single nonlinear ODE and exposed it to six different finite-difference schemes, then quantified — not just opined — which one is best.

**Key takeaways:**

- Nonlinearity invalidates the comforting linear-theory intuitions: explicit and implicit Euler give *the same accuracy* here.
- The two-stage Heun and Predictor–Corrector methods deliver second order at minimal complexity — usually the right default.
- RK4 is the "gold standard" — six orders better than Euler at the same $dx$.
- Local linearisation is an underrated middle ground: implicit-like stability without an inner Newton.
- Every scheme dies near the singularity; **knowing when to stop is as important as knowing how to integrate**.

In the **third and final article** of this series we will leave EDOs behind and dive into **performance, stability and validation** of finite-difference PDE solvers — Poisson 2D, the vibrating string and the Newmark-Euler oscillator — with convergence loglog plots, CFL diagrams, and energy-conservation tracking.

---

## 9. References

See [`references.md`](references.md) for the full bibliography and source mapping.
