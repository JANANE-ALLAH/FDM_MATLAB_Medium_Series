%% 08_run_all_figures.m
%  Wrapper that reproduces all figures of Article 2.
%
%  Author : M. JANANE ALLAH (Medium Article 2, Nonlinear FDM)

clc; clear; close all;
this_dir = fileparts(mfilename('fullpath'));
addpath(fullfile(this_dir, '..', 'matlab_code'));

out_dir = this_dir;
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

run(fullfile(this_dir, '..', 'matlab_code', '07_riccati_all_methods.m'));
all_figs = sort(findall(0, 'Type', 'figure'));
labels   = {'fig1_riccati_solutions.png', ...
            'fig2_riccati_convergence.png', ...
            'fig3_riccati_residual_phase.png'};
for k = 1:min(numel(all_figs), numel(labels))
    print(all_figs(k), fullfile(out_dir, labels{k}), '-dpng', '-r150');
end
fprintf('\n3 figures saved in %s\n', out_dir);
