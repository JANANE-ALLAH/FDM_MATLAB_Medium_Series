%% 02_taylor_sin_2D.m
%  Compare sin(x)*sin(y) and its bivariate Taylor truncations of total
%  degree N = 2, 4, 6, on the square [-2, 2]^2. Also plot the absolute
%  error |f_exact - f_T| for each order.
%
%  (Derived from test_Taylor_fuctionsinus2D.m and Test_Taylor_fuction_Sinus2DN.m)
%
%  Author : M. JANANE ALLAH (Medium Article 1, FDM Fundamentals)

clc; close all;

%% 2D domain
x = linspace(-2, 2, 200);
y = linspace(-2, 2, 200);
[X, Y] = meshgrid(x, y);

%% Exact reference
f_exact = sin(X) .* sin(Y);

%% Truncations of total degree 2, 4 and 6
f_T2 = X .* Y;

f_T4 = X .* Y ...
     - (X.^3 .* Y) / factorial(3) ...
     - (X .* Y.^3) / factorial(3);

f_T6 = X .* Y ...
     - (X.^3 .* Y) / factorial(3) ...
     - (X .* Y.^3) / factorial(3) ...
     + (X.^3 .* Y.^3) / (factorial(3)*factorial(3));

%% Generic helper (alternative to the hand-tuned formulas above)
% Uncomment to use the reusable function:
%   f_T_generic = Taylor2D_sin(6, X, Y);

%% Figure 1: exact vs truncations
figure('Color', 'w', 'Position', [50 50 1100 800]);

subplot(2,2,1); surf(X, Y, f_exact); shading interp;
title('Exact: sin(x) sin(y)'); xlabel('x'); ylabel('y'); zlabel('f');

subplot(2,2,2); surf(X, Y, f_T2); shading interp;
title('Taylor order 2'); xlabel('x'); ylabel('y'); zlabel('f_{T_2}');

subplot(2,2,3); surf(X, Y, f_T4); shading interp;
title('Taylor order 4'); xlabel('x'); ylabel('y'); zlabel('f_{T_4}');

subplot(2,2,4); surf(X, Y, f_T6); shading interp;
title('Taylor order 6'); xlabel('x'); ylabel('y'); zlabel('f_{T_6}');

%% Figure 2: absolute errors
figure('Color', 'w', 'Position', [80 600 1200 350]);

subplot(1,3,1); surf(X, Y, abs(f_exact - f_T2)); shading interp;
title('|f_{exact} - f_{T_2}|'); xlabel('x'); ylabel('y');

subplot(1,3,2); surf(X, Y, abs(f_exact - f_T4)); shading interp;
title('|f_{exact} - f_{T_4}|'); xlabel('x'); ylabel('y');

subplot(1,3,3); surf(X, Y, abs(f_exact - f_T6)); shading interp;
title('|f_{exact} - f_{T_6}|'); xlabel('x'); ylabel('y');

%% Quantitative summary
fprintf('Maximum absolute error:\n');
fprintf('  order 2 : %.3e\n', max(abs(f_exact(:) - f_T2(:))));
fprintf('  order 4 : %.3e\n', max(abs(f_exact(:) - f_T4(:))));
fprintf('  order 6 : %.3e\n', max(abs(f_exact(:) - f_T6(:))));
