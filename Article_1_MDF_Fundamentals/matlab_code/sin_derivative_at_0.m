function d = sin_derivative_at_0(n)
% SIN_DERIVATIVE_AT_0  n-th derivative of sin(x) evaluated at x = 0.
%
%   d = SIN_DERIVATIVE_AT_0(n) returns 0, 1, 0, -1 according to mod(n,4),
%   exploiting the fact that the cycle of derivatives of sin is
%   sin, cos, -sin, -cos and all even derivatives vanish at 0.
%
%   Used as a coefficient helper for the bivariate Taylor expansion of
%   sin(x)*sin(y) — see Taylor2D_sin.m.
%
%   Author : M. JANANE ALLAH (Medium Article 1, FDM Fundamentals).

    switch mod(n, 4)
        case 0
            d = 0;
        case 1
            d = 1;
        case 2
            d = 0;
        otherwise  % case 3
            d = -1;
    end
end
