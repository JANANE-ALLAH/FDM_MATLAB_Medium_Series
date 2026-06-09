%% 06_run_all_figures.m
%  Reproduce all figures of Article 1 in one batch and save PNG files
%  in the current ./figures/ directory.
%
%  Author : M. JANANE ALLAH (Medium Article 1, FDM Fundamentals)

clc; clear; close all;

% Make sure the matlab_code helpers are on the path
this_dir = fileparts(mfilename('fullpath'));
addpath(fullfile(this_dir, '..', 'matlab_code'));

out_dir = this_dir;
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

%% Figure 1 — 1D Taylor expansion of sin
fig1 = local_run_then_capture('01_taylor_sin_1D');
print(fig1, fullfile(out_dir, 'fig1_taylor_sin_1D.png'), '-dpng', '-r150');

%% Figure 2 — 2D Taylor surfaces  &  Figure 3 — 2D Taylor errors
%  (02_taylor_sin_2D.m opens two figures; capture both)
close all;
run(fullfile(this_dir, '..', 'matlab_code', '02_taylor_sin_2D.m'));
all_figs = findall(0, 'Type', 'figure');
all_figs = sort(all_figs);
print(all_figs(1), fullfile(out_dir, 'fig2_taylor_sin_2D_surfaces.png'), '-dpng', '-r150');
print(all_figs(2), fullfile(out_dir, 'fig3_taylor_sin_2D_errors.png'),   '-dpng', '-r150');

%% Figure 4 — Linear ODE: mesh refinement
fig4 = local_run_then_capture('04_ode_linear_mesh_refinement');
print(fig4, fullfile(out_dir, 'fig4_ode_linear_refinement.png'), '-dpng', '-r150');

fprintf('\nAll figures saved in: %s\n', out_dir);

%% --- helper ---
function fh = local_run_then_capture(script_name)
    close all;
    run(script_name);
    fh = gcf;
end
