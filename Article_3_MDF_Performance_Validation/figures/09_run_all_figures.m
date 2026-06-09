%% 09_run_all_figures.m
%  Wrapper that reproduces all figures of Article 3.
%
%  Author : M. JANANE ALLAH (Medium Article 3, Validation)

clc; clear; close all;

this_dir = fileparts(mfilename('fullpath'));
addpath(fullfile(this_dir, '..', 'matlab_code'));

out_dir = this_dir;
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

%% Test case A — Poisson 2D (convergence)
close all;
run(fullfile(this_dir, '..', 'matlab_code', '01_poisson_dirichlet_sparse.m'));
figs = sort(findall(0, 'Type', 'figure'));
print(figs(end), fullfile(out_dir, 'fig1_poisson_convergence.png'), '-dpng', '-r150');
print(figs(1),   fullfile(out_dir, 'fig2_poisson_solution_error.png'), '-dpng', '-r150');

%% Test case B — vibrating string + CFL stress test
close all;
run(fullfile(this_dir, '..', 'matlab_code', '02_wave_string_CFL.m'));
figs = sort(findall(0, 'Type', 'figure'));
print(figs(1), fullfile(out_dir, 'fig3_wave_snapshot.png'), '-dpng', '-r150');
print(figs(2), fullfile(out_dir, 'fig4_wave_energy.png'),  '-dpng', '-r150');
print(figs(3), fullfile(out_dir, 'fig5_wave_cfl_stress.png'), '-dpng', '-r150');

%% Test case C — forced oscillator
close all;
run(fullfile(this_dir, '..', 'matlab_code', '03_oscillator_stability_energy.m'));
figs = sort(findall(0, 'Type', 'figure'));
print(figs(1), fullfile(out_dir, 'fig6_oscillator_position.png'), '-dpng', '-r150');
print(figs(2), fullfile(out_dir, 'fig7_oscillator_energy.png'),   '-dpng', '-r150');
print(figs(3), fullfile(out_dir, 'fig8_oscillator_stability.png'),'-dpng', '-r150');
print(figs(4), fullfile(out_dir, 'fig9_oscillator_error.png'),    '-dpng', '-r150');

fprintf('\nAll figures saved in %s\n', out_dir);
