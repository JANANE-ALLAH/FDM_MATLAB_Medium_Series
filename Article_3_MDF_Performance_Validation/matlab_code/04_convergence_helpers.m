%% 04_convergence_helpers.m
%  Reusable utilities for the convergence and validation pipeline.
%  Each helper is a small function packaged in this single file.
%
%  Author : M. JANANE ALLAH (Medium Article 3, Validation)

function order = estimate_order(err_list, h_list)
% ESTIMATE_ORDER  Vector of numerical convergence orders between
%                 successive grids.
%
%     order(k) = log(err(k+1)/err(k)) / log(h(k+1)/h(k))
%
%   Inputs:  err_list, h_list  -- same length, strictly positive
%   Output:  order             -- length(err_list)-1

    err_list = err_list(:);
    h_list   = h_list(:);
    order    = log(err_list(2:end) ./ err_list(1:end-1)) ./ ...
               log(h_list(2:end)   ./ h_list(1:end-1));
end


function print_convergence_table(N_list, h_list, err_list, label)
% PRINT_CONVERGENCE_TABLE  Pretty-print a convergence table to the
%                          MATLAB console.

    if nargin < 4, label = 'Method'; end
    orders = estimate_order(err_list, h_list);
    fprintf('\nConvergence table (%s):\n', label);
    fprintf('  N      h         err_max     order\n');
    fprintf('  -----  --------  -----------  ------\n');
    fprintf('  %-5d  %.4f    %.3e    --\n', N_list(1), h_list(1), err_list(1));
    for k = 2:numel(N_list)
        fprintf('  %-5d  %.4f    %.3e    %.2f\n', ...
                N_list(k), h_list(k), err_list(k), orders(k-1));
    end
end


function [C, p] = fit_error_law(h_list, err_list)
% FIT_ERROR_LAW  Least-squares fit of  err ~ C * h^p  in log-log space.

    L = log(h_list(:));
    E = log(err_list(:));
    A = [L, ones(size(L))];
    sol = A \ E;
    p = sol(1);
    C = exp(sol(2));
end


function fh = plot_convergence(h_list, err_list, ref_order, label)
% PLOT_CONVERGENCE  Plot err vs h on log-log and overlay reference slope.

    if nargin < 3, ref_order = 2;        end
    if nargin < 4, label    = 'method'; end

    fh = figure('Color', 'w', 'Position', [100 100 800 500]);
    loglog(h_list, err_list, 'bo-', 'LineWidth', 1.8, 'DisplayName', label);
    hold on; grid on; box on;
    loglog(h_list, err_list(1) * (h_list/h_list(1)).^ref_order, 'r--', ...
           'LineWidth', 1.5, 'DisplayName', sprintf('O(h^%d)', ref_order));
    xlabel('h'); ylabel('error');
    title(sprintf('Observed convergence  ~  O(h^{%d})', ref_order));
    legend('Location', 'NorthWest');
end


function check_residual(u_num, dx, rhs_handle, threshold)
% CHECK_RESIDUAL  Print max & mean residual of a generic 1D ODE
%                 du/dx - rhs(u) = 0.

    if nargin < 4, threshold = 1e-6; end
    du = gradient(u_num, dx);
    r  = du - rhs_handle(u_num);
    fprintf('Residual check:  max = %.3e  mean = %.3e  %s\n', ...
            max(abs(r)), mean(abs(r)), ...
            char(string(max(abs(r)) < threshold)*"PASS" + ...
                 string(max(abs(r)) >= threshold)*"FAIL"));
end
