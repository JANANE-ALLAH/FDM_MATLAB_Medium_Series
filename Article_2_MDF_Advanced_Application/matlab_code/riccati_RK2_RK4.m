function [u_rk2, u_rk4] = riccati_RK2_RK4(S)
% RICCATI_RK2_RK4  Runge-Kutta order 2 (Heun) and order 4 schemes.
%
%   [u_rk2, u_rk4] = riccati_RK2_RK4(S)
%
%   RHS handle:  f(u) = 1 + u^2.
%
%   Author : M. JANANE ALLAH (Medium Article 2, Nonlinear FDM)

    f = @(u) 1 + u.^2;

    u_rk2 = zeros(1, S.N);
    u_rk4 = zeros(1, S.N);
    u_rk2(1) = S.u0;
    u_rk4(1) = S.u0;

    for i = 1:S.N-1
        %% --- Heun (RK2) ---
        k1 = f(u_rk2(i));
        u_tmp = u_rk2(i) + S.dx * k1;
        k2 = f(u_tmp);
        u_rk2(i+1) = u_rk2(i) + 0.5*S.dx*(k1 + k2);

        %% --- classical RK4 ---
        k1 = f(u_rk4(i));
        k2 = f(u_rk4(i) + 0.5*S.dx*k1);
        k3 = f(u_rk4(i) + 0.5*S.dx*k2);
        k4 = f(u_rk4(i) + S.dx*k3);
        u_rk4(i+1) = u_rk4(i) + (S.dx/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
end
