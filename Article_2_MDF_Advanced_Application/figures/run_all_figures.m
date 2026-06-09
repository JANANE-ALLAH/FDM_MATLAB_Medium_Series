% run_all_figures.m  (Article 2)
% Reproduce all figures of Article 2 and save them as PNG in this folder.

clc; clear; close all;

script_dir = fileparts(mfilename('fullpath'));
code_dir   = fullfile(script_dir, '..', 'matlab_code');
addpath(code_dir);

%% Run the orchestrator
close all;
riccati_all_methods;

%% Save the produced figures
figs = sort(findall(0, 'Type', 'figure'));
labels = {'fig1_riccati_solutions.png', ...
          'fig2_riccati_convergence.png', ...
          'fig3_riccati_residual_phase.png'};
for k = 1:min(numel(figs), numel(labels))
    print(figs(k), fullfile(script_dir, labels{k}), '-dpng', '-r150');
end

fprintf('\nAll Article 2 figures saved in:\n  %s\n', script_dir);
