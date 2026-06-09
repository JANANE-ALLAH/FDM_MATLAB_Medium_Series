%% 03_ode_linear_basic.m
%  Solve the linear first-order ODE
%       du/dx - u(x) = a,    u(0) = T0,    x in [0, L]
%  by the explicit Euler scheme derived from a first-order Taylor expansion.
%  Compare against the analytical solution u(x) = (T0 + a)*exp(x) - a.
%
%  (Derived from SE2_Exemple1_MDF.m)
%
%  Author : M. JANANE ALLAH (Medium Article 1, FDM Fundamentals)

clc; clear; close all;

%% Physical parameters
L  = 1;          % domain length
a  = 2;          % RHS constant
T0 = 1;          % initial condition u(0)

%% Numerical parameters
N = 10;                  % number of grid nodes
h = L / (N - 1);         % spatial step
x = linspace(0, L, N);

%% Allocation and initial condition
U = zeros(1, N);
U(1) = T0;

%% Explicit Euler scheme  ->  U(i+1) = (1 + h)*U(i) + a*h
for i = 1:N-1
    U(i+1) = (1 + h) * U(i) + a*h;
end

%% Analytical reference
T_exact = (T0 + a) * exp(x) - a;

%% Plot
figure('Color', 'w', 'Position', [100 100 800 500]);
plot(x, U,        'bo-', 'LineWidth', 1.6, 'MarkerFaceColor', 'b'); hold on;
plot(x, T_exact,  'r--', 'LineWidth', 2.0);
grid on; box on;
xlabel('x'); ylabel('u(x)');
legend('Numerical (Euler explicit)', 'Analytical reference', 'Location', 'NorthWest');
title('Linear 1st-order ODE solved by the Finite Difference Method');

%% Quantitative error
err_max = max(abs(U - T_exact));
fprintf('Maximum absolute error : %.3e\n', err_max);
