%% 07_riccati_all_methods.m
%  Run the six FDM schemes on u' = 1 + u^2, compare with the analytical
%  solution and produce side-by-side plots + convergence study.
%
%  This is the orchestrator script; the schemes themselves are in the
%  individual *.m files of this folder.
%
%  Author : M. JANANE ALLAH (Medium Article 2, Nonlinear FDM)

clc; clear; close all;

%% Add this folder to the path
this_dir = fileparts(mfilename('fullpath'));
addpath(this_dir);

%% Common setup
S = riccati_setup('u0', 1.0, 'N', 100, 'safety', 0.8);

%% Run the six schemes
u_euler    = riccati_euler_explicit(S);
u_implicit = riccati_euler_implicit_newton(S);
[u_rk2, u_rk4] = riccati_RK2_RK4(S);
u_pc       = riccati_predictor_corrector(S);
u_lin      = riccati_local_linearisation(S);

%% Errors
methods    = {'Euler explicit', 'Euler implicit (Newton)', ...
              'RK2 (Heun)', 'RK4', 'Predictor-Corrector', ...
              'Local linearisation'};
solutions  = {u_euler, u_implicit, u_rk2, u_rk4, u_pc, u_lin};
err_max    = zeros(1, numel(methods));
err_L2     = zeros(1, numel(methods));
for k = 1:numel(methods)
    err_max(k) = max(abs(solutions{k} - S.u_exact));
    err_L2(k)  = sqrt(sum((solutions{k} - S.u_exact).^2) * S.dx);
end

fprintf('\n=== Error summary ===\n');
fprintf('  %-30s  err_max     err_L2\n', 'Method');
fprintf('  %s\n', repmat('-', 1, 60));
for k = 1:numel(methods)
    fprintf('  %-30s  %.3e   %.3e\n', methods{k}, err_max(k), err_L2(k));
end

%% Figure 1: solutions overlay
figure('Color', 'w', 'Position', [80 60 900 600]);
plot(S.x, S.u_exact, 'k-', 'LineWidth', 2.2, 'DisplayName', 'Analytical');
hold on; grid on; box on;
plot(S.x, u_euler,    'b--');
plot(S.x, u_implicit, 'r-.');
plot(S.x, u_rk2,      'g:');
plot(S.x, u_rk4,      'm-');
plot(S.x, u_pc,       'c-');
plot(S.x, u_lin,      'y-');
xlabel('x'); ylabel('u(x)');
title(sprintf('Riccati u'' = 1 + u^2,  u(0) = %.1f,  x_{sing} = %.4f', S.u0, S.x_sing));
legend(['Analytical', methods], 'Location', 'NorthWest');

%% Figure 2: log-log error vs dx (convergence)
N_values  = [10, 20, 40, 80, 160, 320];
err_euler = zeros(size(N_values));
err_rk2v  = zeros(size(N_values));
err_rk4v  = zeros(size(N_values));
err_pcv   = zeros(size(N_values));
dx_values = zeros(size(N_values));

for k = 1:numel(N_values)
    Sk = riccati_setup('u0', 1.0, 'N', N_values(k), 'safety', 0.8);
    dx_values(k) = Sk.dx;

    err_euler(k) = max(abs(riccati_euler_explicit(Sk) - Sk.u_exact));
    [rk2k, rk4k] = riccati_RK2_RK4(Sk);
    err_rk2v(k)  = max(abs(rk2k - Sk.u_exact));
    err_rk4v(k)  = max(abs(rk4k - Sk.u_exact));
    err_pcv(k)   = max(abs(riccati_predictor_corrector(Sk) - Sk.u_exact));
end

figure('Color', 'w', 'Position', [120 100 900 600]);
loglog(dx_values, err_euler, 'bo-', 'LineWidth', 1.8, 'DisplayName', 'Euler explicit');
hold on; grid on; box on;
loglog(dx_values, err_rk2v,  'gs-', 'LineWidth', 1.8, 'DisplayName', 'RK2 (Heun)');
loglog(dx_values, err_pcv,   'cd-', 'LineWidth', 1.8, 'DisplayName', 'Predictor-Corrector');
loglog(dx_values, err_rk4v,  'm^-', 'LineWidth', 1.8, 'DisplayName', 'RK4');
loglog(dx_values, 0.1*dx_values,   'k--', 'DisplayName', 'Reference O(dx)');
loglog(dx_values, 0.1*dx_values.^2,'k-.', 'DisplayName', 'Reference O(dx^2)');
loglog(dx_values, 0.1*dx_values.^4,'k:',  'DisplayName', 'Reference O(dx^4)');
xlabel('dx'); ylabel('max error');
title('Numerical convergence of four FDM schemes');
legend('Location', 'NorthWest');

%% Figure 3: residual & phase portrait for RK4
du_num   = gradient(u_rk4, S.dx);
residual = du_num - u_rk4.^2 - 1;

figure('Color', 'w', 'Position', [160 140 1200 400]);
subplot(1,2,1);
plot(S.x, residual, 'm-', 'LineWidth', 1.6); grid on; box on;
xlabel('x'); ylabel('du/dx - u^2 - 1');
title(sprintf('RK4 residual,  max = %.2e', max(abs(residual))));

subplot(1,2,2);
plot(S.u_exact, gradient(S.u_exact, S.dx), 'k-', 'LineWidth', 2.0,    'DisplayName', 'Analytical');
hold on; grid on; box on;
plot(u_rk4,    du_num,                     'm--', 'LineWidth', 1.6,   'DisplayName', 'RK4');
xlabel('u'); ylabel('du/dx');
title('Phase portrait (u, du/dx)');
legend('Location', 'NorthWest');
