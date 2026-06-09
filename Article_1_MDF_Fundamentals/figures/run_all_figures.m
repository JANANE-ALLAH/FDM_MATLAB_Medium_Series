% run_all_figures.m  (Article 1)
% Reproduce all figures of Article 1 and save them as PNG in this folder.
%
% Usage from MATLAB :  run_all_figures
% Usage from PowerShell :
%     cd <this folder>
%     matlab -batch run_all_figures

clc; clear; close all;

script_dir = fileparts(mfilename('fullpath'));
code_dir   = fullfile(script_dir, '..', 'matlab_code');
addpath(code_dir);

%% Figure 1 : 1D Taylor expansion of sin
close all;
taylor_sin_1D;
print(gcf, fullfile(script_dir, 'fig1_taylor_sin_1D.png'), '-dpng', '-r150');

%% Figures 2 and 3 : 2D Taylor surfaces and errors
close all;
taylor_sin_2D;
figs = sort(findall(0, 'Type', 'figure'));
if numel(figs) >= 1
    print(figs(1), fullfile(script_dir, 'fig2_taylor_sin_2D_surfaces.png'), '-dpng', '-r150');
end
if numel(figs) >= 2
    print(figs(2), fullfile(script_dir, 'fig3_taylor_sin_2D_errors.png'),   '-dpng', '-r150');
end

%% Figure 4 : linear ODE mesh refinement
close all;
ode_linear_mesh_refinement;
print(gcf, fullfile(script_dir, 'fig4_ode_linear_refinement.png'), '-dpng', '-r150');

fprintf('\nAll Article 1 figures saved in:\n  %s\n', script_dir);
