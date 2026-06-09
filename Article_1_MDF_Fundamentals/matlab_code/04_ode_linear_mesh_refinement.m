%% 04_ode_linear_mesh_refinement.m
%  Mesh-refinement study for
%       du/dx - u(x) = 0,    u(0) = 1,    x in [0, L]
%  whose exact solution is u(x) = exp(x).
%
%  Plot the explicit-Euler solution for N in {5, 10, 20, 40, 80} together
%  with the analytical exp(x) curve, then print the maximum error obtained
%  for each grid.
%
%  (Derived from test1_lineaire.m)
%
%  Author : M. JANANE ALLAH (Medium Article 1, FDM Fundamentals)

clc; clear; close all;

L        = 1;
N_values = [5, 10, 20, 40, 80];

figure('Color', 'w', 'Position', [100 100 900 550]);
hold on; grid on; box on;

errors_max = zeros(size(N_values));

for k = 1:numel(N_values)
    N = N_values(k);
    h = L / (N - 1);
    x = linspace(0, L, N);

    u    = zeros(1, N);
    u(1) = 1;
    for i = 1:N-1
        u(i+1) = (1 + h) * u(i);   % Explicit Euler
    end

    errors_max(k) = max(abs(u - exp(x)));
    plot(x, u, 'o-', 'LineWidth', 1.5, 'DisplayName', sprintf('N = %d', N));
end

% Analytical reference
x_ref = linspace(0, L, 300);
plot(x_ref, exp(x_ref), 'k', 'LineWidth', 2.2, 'DisplayName', 'Exact: e^x');

xlabel('x'); ylabel('u(x)');
title('Explicit Euler -- influence of the mesh size h = L/(N-1)');
legend('Location', 'NorthWest');

%% Convergence printout
fprintf('\nMesh refinement study  (du/dx = u, u(0)=1)\n');
fprintf('  N      h         err_max\n');
fprintf(' ---    ------    -----------\n');
for k = 1:numel(N_values)
    fprintf('  %-4d   %.4f    %.3e\n', N_values(k), L/(N_values(k)-1), errors_max(k));
end
