function u = riccati_local_linearisation(S)
% RICCATI_LOCAL_LINEARISATION  Quasi-Newton linearisation of u^2 around u(i).
%
%   u = riccati_local_linearisation(S)
%
%   Linearisation: u^2 ~ u(i)^2 + 2*u(i)*(u - u(i)) = 2*u(i)*u - u(i)^2
%   Implicit step then reduces to the linear update
%
%       u(i+1) = ( u(i) + dx*(1 - u(i)^2) ) / ( 1 - 2*dx*u(i) )
%
%   Falls back to explicit Euler when the denominator vanishes.
%
%   Author : M. JANANE ALLAH (Medium Article 2, Nonlinear FDM)

    u = zeros(1, S.N);
    u(1) = S.u0;
    for i = 1:S.N-1
        denom = 1 - 2*S.dx*u(i);
        if abs(denom) > 1e-12
            u(i+1) = (u(i) + S.dx*(1 - u(i)^2)) / denom;
        else
            u(i+1) = u(i) + S.dx*(1 + u(i)^2);   % fallback
        end
    end
end
