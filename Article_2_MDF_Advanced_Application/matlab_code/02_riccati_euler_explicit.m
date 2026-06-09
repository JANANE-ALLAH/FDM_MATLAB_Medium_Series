function u = riccati_euler_explicit(S)
% RICCATI_EULER_EXPLICIT  Explicit Euler scheme for u' = 1 + u^2.
%
%   u = riccati_euler_explicit(S) where S is produced by riccati_setup.
%
%   Recurrence:    u(i+1) = u(i) + dx * (1 + u(i)^2)
%
%   Order : 1  (first-order forward difference)
%
%   Author : M. JANANE ALLAH (Medium Article 2, Nonlinear FDM)

    u = zeros(1, S.N);
    u(1) = S.u0;
    for i = 1:S.N-1
        u(i+1) = u(i) + S.dx * (1 + u(i)^2);
    end
end
