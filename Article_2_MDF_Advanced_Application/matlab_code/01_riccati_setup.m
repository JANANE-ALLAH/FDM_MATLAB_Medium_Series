function S = riccati_setup(varargin)
% RICCATI_SETUP  Return a parameter struct for the Riccati benchmark
%                u' - u^2 = 1,  u(0) = u0,  exact: u(x) = tan(x + pi/4) when u0 = 1.
%
%   S = riccati_setup() uses default values.
%   S = riccati_setup('u0', 0.5, 'N', 200, 'safety', 0.9) overrides them.
%
%   Fields of S:
%       u0       initial condition u(0)
%       x_sing   theoretical singularity x = pi/4 - atan(u0)  (for u0 = 1)
%       L        safe domain length (= safety * x_sing)
%       N        number of grid points
%       dx       spatial step
%       x        column vector of grid coordinates
%       u_exact  analytical reference  tan(x + atan(u0))
%
%   Author : M. JANANE ALLAH (Medium Article 2, Nonlinear FDM)

    p = inputParser;
    addParameter(p, 'u0',     1.0);
    addParameter(p, 'N',      100);
    addParameter(p, 'safety', 0.8);
    parse(p, varargin{:});

    S.u0     = p.Results.u0;
    S.x_sing = pi/4 - atan(S.u0);
    if S.x_sing <= 0
        S.L = 0.5;
    else
        S.L = p.Results.safety * S.x_sing;
    end
    S.L = max(S.L, 0.1);
    S.N = p.Results.N;

    S.dx      = S.L / (S.N - 1);
    S.x       = linspace(0, S.L, S.N);
    S.u_exact = tan(S.x + atan(S.u0));

    fprintf('Riccati setup: u0=%.2f, x_sing=%.4f, L=%.4f, N=%d, dx=%.5f\n', ...
        S.u0, S.x_sing, S.L, S.N, S.dx);
end
