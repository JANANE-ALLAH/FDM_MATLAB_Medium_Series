function u = riccati_euler_implicit_newton(S, max_iter, tol)
% RICCATI_EULER_IMPLICIT_NEWTON  Implicit Euler scheme + inner Newton.
%
%   u = riccati_euler_implicit_newton(S)
%   u = riccati_euler_implicit_newton(S, max_iter, tol)
%
%   At each step, solve the scalar nonlinear equation
%       F(v) = v - u(i) - dx*(1 + v^2) = 0
%   by Newton iteration:  v <- v - F(v)/F'(v),  F'(v) = 1 - 2*dx*v.
%
%   Falls back to an explicit Euler step if Newton stalls (|F'| too small
%   or no convergence within max_iter iterations).
%
%   Order : 1  (backward difference)
%
%   Author : M. JANANE ALLAH (Medium Article 2, Nonlinear FDM)

    if nargin < 2, max_iter = 50;    end
    if nargin < 3, tol      = 1e-10; end

    u = zeros(1, S.N);
    u(1) = S.u0;

    for i = 1:S.N-1
        v         = u(i);
        converged = false;
        for it = 1:max_iter
            Fv = v - u(i) - S.dx*(1 + v^2);
            dF = 1 - 2*S.dx*v;
            if abs(dF) < 1e-12
                break;
            end
            v_new = v - Fv/dF;
            if abs(v_new - v) < tol
                v = v_new; converged = true; break;
            end
            v = v_new;
        end
        if converged
            u(i+1) = v;
        else
            u(i+1) = u(i) + S.dx*(1 + u(i)^2);   % fallback
        end
    end
end
