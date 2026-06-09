% run_all_figures.m  (Article 3)
% Reproduce all figures of Article 3 and save them as PNG in this folder.

clc; clear; close all;

script_dir = fileparts(mfilename('fullpath'));
code_dir   = fullfile(script_dir, '..', 'matlab_code');
addpath(code_dir);

%% Test case A : Poisson 2D (solution + convergence)
close all;
poisson_dirichlet_sparse;
figs = sort(findall(0, 'Type', 'figure'));
if numel(figs) >= 1
    print(figs(1),   fullfile(script_dir, 'fig2_poisson_solution_error.png'), '-dpng', '-r150');
end
if numel(figs) >= 2
    print(figs(end), fullfile(script_dir, 'fig1_poisson_convergence.png'),    '-dpng', '-r150');
end

%% Test case B : vibrating string + CFL stress test
close all;
wave_string_CFL;
figs = sort(findall(0, 'Type', 'figure'));
labels_b = {'fig3_wave_snapshot.png', 'fig4_wave_energy.png', 'fig5_wave_cfl_stress.png'};
for k = 1:min(numel(figs), numel(labels_b))
    print(figs(k), fullfile(script_dir, labels_b{k}), '-dpng', '-r150');
end

%% Test case C : forced harmonic oscillator
close all;
oscillator_stability_energy;
figs = sort(findall(0, 'Type', 'figure'));
labels_c = {'fig6_oscillator_position.png', 'fig7_oscillator_energy.png', ...
            'fig8_oscillator_stability.png', 'fig9_oscillator_error.png'};
for k = 1:min(numel(figs), numel(labels_c))
    print(figs(k), fullfile(script_dir, labels_c{k}), '-dpng', '-r150');
end

fprintf('\nAll Article 3 figures saved in:\n  %s\n', script_dir);
