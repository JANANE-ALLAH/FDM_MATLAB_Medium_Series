%% 01_poisson_dirichlet_sparse.m
%  Solve  -Delta u = f  on (0,1)^2 with Dirichlet BC, using a sparse
%  5-point centred stencil and assembling A = (I (x) T + T (x) I)/h^2
%  with kron/spdiags. Compare with the exact reference
%  u(x,y) = sin(pi x) sin(pi y), f = -2 pi^2 sin(pi x) sin(pi y),
%  then run a mesh-refinement loop to demonstrate O(h^2) convergence.
%
%  (Derived from test3_poisson_Direclch.m)
%
%  Author : M. JANANE ALLAH (Medium Article 3, Validation)

clc; clear; close all;

%% --- single-grid solve at N = 100 ----------------------------------------
N = 100;
h = 1/(N-1);
x = linspace(0, 1, N);
y = linspace(0, 1, N);
[X, Y] = meshgrid(x, y);

u_exact = sin(pi*X) .* sin(pi*Y);
f       = -2*pi^2 * sin(pi*X) .* sin(pi*Y);

% Sparse Laplacian on the interior n x n grid
n = N - 2;
e = ones(n,1);
T = spdiags([e -4*e e], [-1 0 1], n, n);
I = speye(n);
A = (kron(I,T) + kron(T,I)) / h^2;

% Interior right-hand side  (Dirichlet BC = 0 on boundary so no BC term to add)
F = f(2:N-1, 2:N-1);
b = F(:);

% Solve and reshape
u_int = A \ b;
u_num = zeros(N, N);
u_num(2:N-1, 2:N-1) = reshape(u_int, n, n);

% Quick error
err_max = max(abs(u_num(:) - u_exact(:)));
fprintf('Single-grid: N = %d, h = %.4f, max error = %.3e\n', N, h, err_max);

% Visual check
figure('Color', 'w', 'Position', [60 60 1200 350]);
subplot(1,3,1); surf(X, Y, u_num); shading interp; title('Numerical');
subplot(1,3,2); surf(X, Y, u_exact); shading interp; title('Exact');
subplot(1,3,3); surf(X, Y, abs(u_num - u_exact)); shading interp; title('Error');

%% --- mesh-refinement convergence study -----------------------------------
N_list = [20, 30, 40, 50, 60];
err_list = zeros(size(N_list));
h_list   = zeros(size(N_list));

for k = 1:numel(N_list)
    Nk = N_list(k);
    hk = 1/(Nk-1);
    [Xk, Yk] = meshgrid(linspace(0,1,Nk), linspace(0,1,Nk));
    fk = -2*pi^2 * sin(pi*Xk) .* sin(pi*Yk);
    uxk = sin(pi*Xk) .* sin(pi*Yk);
    nk  = Nk - 2;
    ek  = ones(nk,1);
    Tk  = spdiags([ek -4*ek ek], [-1 0 1], nk, nk);
    Ik  = speye(nk);
    Ak  = (kron(Ik,Tk) + kron(Tk,Ik)) / hk^2;
    Fk  = fk(2:Nk-1, 2:Nk-1);
    uk  = zeros(Nk, Nk);
    uk(2:Nk-1, 2:Nk-1) = reshape(Ak \ Fk(:), nk, nk);
    err_list(k) = max(abs(uk(:) - uxk(:)));
    h_list(k)   = hk;
end

% Numerical order estimator
orders = log(err_list(2:end) ./ err_list(1:end-1)) ./ ...
         log(h_list(2:end)   ./ h_list(1:end-1));

fprintf('\nConvergence table (Poisson 2D Dirichlet):\n');
fprintf('  N    h        err_max     order\n');
fprintf('  ---  -------  ----------  ------\n');
fprintf('  %-4d %.4f  %.3e    --\n', N_list(1), h_list(1), err_list(1));
for k = 2:numel(N_list)
    fprintf('  %-4d %.4f  %.3e    %.2f\n', ...
        N_list(k), h_list(k), err_list(k), orders(k-1));
end

% Convergence figure
figure('Color', 'w', 'Position', [120 60 700 500]);
loglog(h_list, err_list, 'bo-', 'LineWidth', 1.8, 'MarkerSize', 8, ...
       'DisplayName', 'MDF max error');
hold on; grid on; box on;
loglog(h_list, 5*h_list.^2, 'r--', 'LineWidth', 1.5, ...
       'DisplayName', 'Reference O(h^2)');
xlabel('h'); ylabel('Max error');
title('Poisson 2D Dirichlet -- observed O(h^2) convergence');
legend('Location', 'NorthWest');
