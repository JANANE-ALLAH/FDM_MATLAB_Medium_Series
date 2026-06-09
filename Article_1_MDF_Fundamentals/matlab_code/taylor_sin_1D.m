%% 01_taylor_sin_1D.m
%  Plot sin(x) and its Taylor truncations of order 1 and order 100.
%  (Derived from test_Taylor_fuctionsinus.m)
%
%  Pedagogical message:
%   - low order -> visible divergence outside a small interval
%   - very high order -> machine precision dominates; eventually overflow
%
%  Author : M. JANANE ALLAH (Medium Article 1, FDM Fundamentals)

clc; clear; close all;

%% Domain and exact reference
x       = linspace(-2*pi, 2*pi, 1000);
f_exact = sin(x);

%% Truncation orders to test
orders = [1, 100];

%% Plot
figure('Color', 'w', 'Position', [100 100 900 500]);
hold on; grid on; box on;
plot(x, f_exact, 'k', 'LineWidth', 2.2, 'DisplayName', 'sin(x) exact');

colors = {[0 0.45 0.74], [0.85 0.33 0.10]};
for idx = 1:length(orders)
    n        = orders(idx);
    f_taylor = zeros(size(x));
    for k = 0:floor(n/2)
        f_taylor = f_taylor + (-1)^k * x.^(2*k+1) / factorial(2*k+1);
    end
    plot(x, f_taylor, 'LineWidth', 1.5, 'Color', colors{idx}, ...
         'DisplayName', sprintf('Taylor order %d', n));
end

ylim([-1.5, 1.5]);
xlabel('x');
ylabel('f(x)');
title('Taylor truncations of sin(x) on [-2\pi, 2\pi]');
legend('Location', 'best');

%% Optional save
% print(gcf, '../figures/fig1_taylor_sin_1D.png', '-dpng', '-r150');
