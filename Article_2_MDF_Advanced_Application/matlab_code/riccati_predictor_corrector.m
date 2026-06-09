function u = riccati_predictor_corrector(S)
% RICCATI_PREDICTOR_CORRECTOR  Single-step P-(EC) scheme.
%
%   u = riccati_predictor_corrector(S)
%
%   Step:
%       u_pred = u(i) + dx * f(u(i))                % Euler predictor
%       u(i+1) = u(i) + 0.5*dx*(f(u(i)) + f(u_pred))% trapezoidal corrector
%
%   Same accuracy as Heun's RK2 (order 2) with one inner evaluation.
%
%   Author : M. JANANE ALLAH (Medium Article 2, Nonlinear FDM)

    f = @(u) 1 + u.^2;
    u = zeros(1, S.N);
    u(1) = S.u0;
    for i = 1:S.N-1
        u_pred  = u(i) + S.dx * f(u(i));
        u(i+1)  = u(i) + 0.5*S.dx*(f(u(i)) + f(u_pred));
    end
end
