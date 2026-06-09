function fT = Taylor2D_sin(N, X, Y)
% TAYLOR2D_SIN  Bivariate Taylor expansion of sin(x)*sin(y) around (0,0).
%
%   fT = TAYLOR2D_SIN(N, X, Y) evaluates the truncated Taylor series of
%   total degree N for the function f(x,y) = sin(x)*sin(y), on grids
%   X, Y produced by meshgrid.
%
%   Mathematical identity used:
%       sin(x) sin(y) = sum_{p+q<=N} [sin^(p)(0) * sin^(q)(0) /(p! q!)] x^p y^q
%
%   See also SIN_DERIVATIVE_AT_0.
%
%   Author : M. JANANE ALLAH (Medium Article 1, FDM Fundamentals).

    fT = zeros(size(X));
    for p = 0:N
        for q = 0:(N - p)
            dx    = sin_derivative_at_0(p);
            dy    = sin_derivative_at_0(q);
            coeff = (dx * dy) / (factorial(p) * factorial(q));
            if coeff ~= 0
                fT = fT + coeff .* X.^p .* Y.^q;
            end
        end
    end
end
