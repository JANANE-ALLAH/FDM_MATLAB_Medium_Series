%% 03_oscillator_stability_energy.m
%  Forced harmonic oscillator  x'' + omega^2 x = gamma0 sin(omega0 t)
%
%  Second-order centred scheme:
%     x(n+1) = 2 x(n) - x(n-1) - omega^2 dt^2 x(n) + gamma0 dt^2 sin(omega0 t(n))
%
%  Validates:
%   - amplitude bound (stability) iff dt < 2/omega
%   - energy conservation E = 0.5*v^2 + 0.5*omega^2 x^2  (free case)
%   - reproduces TP4_Master_FST.m results that were saved in
%     oscillateur_results.mat and rapport_oscillateur.txt.
%
%  (Derived from TP4_Master_FST.m and test4_EDP_spatiotemporelles_1.m)
%
%  Author : M. JANANE ALLAH (Medium Article 3, Validation)

clc; close all;

%% --- parameters (same as the production rapport) ------------------------
omega   = 2*pi;     % natural pulsation        ~ 6.28 rad/s
omega0  = 3*pi;     % driving pulsation        ~ 9.42 rad/s
gamma0  = 2.0;      % driving amplitude (m/s^2)
x0      = 0.1;
v0      = 0.0;

T_end   = 15.0;
dt      = 0.005;
N       = floor(T_end/dt);
t       = linspace(0, T_end, N+1);

dt_lim  = 2/omega;
fprintf('dt = %.4f,  dt_lim = 2/omega = %.4f  -> %s\n', ...
        dt, dt_lim, char(string(dt < dt_lim)*"stable" + string(dt >= dt_lim)*"unstable"));

%% --- analytical reference (omega ~= omega0) -----------------------------
A = x0;
B = v0/omega - gamma0*omega0/(omega*(omega^2 - omega0^2));
C = gamma0/(omega^2 - omega0^2);
x_anal = A*cos(omega*t) + B*sin(omega*t) + C*sin(omega0*t);

%% --- centred-difference scheme ------------------------------------------
x_num = zeros(1, N+1);
x_num(1) = x0;
x_num(2) = x0 + v0*dt - 0.5*omega^2*x0*dt^2;
for n = 2:N
    x_num(n+1) = 2*x_num(n) - x_num(n-1) ...
               - omega^2*dt^2*x_num(n) ...
               + gamma0*dt^2*sin(omega0*t(n));
end

v_num = gradient(x_num, dt);
err   = abs(x_num - x_anal);
E_tot = 0.5*v_num.^2 + 0.5*omega^2*x_num.^2;

fprintf('max error: %.2e m,   RMS error: %.2e m\n', max(err), sqrt(mean(err.^2)));

%% --- spectral-radius stability diagram ----------------------------------
dt_range = linspace(0, 0.5, 500);
rho      = zeros(size(dt_range));
for k = 1:numel(dt_range)
    a_k = 2 - omega^2*dt_range(k)^2;
    D_k = a_k^2 - 4;
    if D_k >= 0
        rho(k) = max(abs([ (a_k + sqrt(D_k))/2, (a_k - sqrt(D_k))/2 ]));
    else
        rho(k) = 1;  % complex conjugate roots of modulus 1
    end
end

%% --- figures ------------------------------------------------------------
% Figure 1: positions
figure('Color', 'w', 'Position', [60 60 900 380]);
plot(t, x_num,  'b-',  'LineWidth', 1.6, 'DisplayName', 'Numerical (centred MDF)'); hold on;
plot(t, x_anal, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Analytical');
grid on; box on;
xlabel('time t (s)'); ylabel('x(t) (m)');
title('Forced harmonic oscillator');
legend('Location', 'best');

% Figure 2: energy
figure('Color', 'w', 'Position', [120 100 900 350]);
plot(t, E_tot, 'k', 'LineWidth', 1.6); grid on; box on;
xlabel('time t (s)'); ylabel('E(t) (J/kg)');
title(sprintf('Total energy   mean = %.3f J/kg', mean(E_tot)));

% Figure 3: spectral radius stability
figure('Color', 'w', 'Position', [180 140 900 400]);
plot(dt_range, rho, 'b', 'LineWidth', 1.6); hold on; grid on; box on;
plot([dt_lim dt_lim], [0 max(rho)], 'r--', 'LineWidth', 1.5);
xlabel('dt (s)'); ylabel('spectral radius rho');
title('Centred-MDF stability:  rho <= 1  iff  dt < 2/omega');
legend('rho(dt)', sprintf('dt_{lim} = %.3f s', dt_lim), 'Location', 'NorthWest');

% Figure 4: error
figure('Color', 'w', 'Position', [240 180 900 350]);
plot(t, err, 'm', 'LineWidth', 1.5); grid on; box on;
xlabel('time t (s)'); ylabel('|x_{num} - x_{anal}|');
title(sprintf('Numerical error  max = %.2e m  RMS = %.2e m', max(err), sqrt(mean(err.^2))));

%% --- save the rapport in the spirit of TP4_Master_FST.m ----------------
this_dir = fileparts(mfilename('fullpath'));
save(fullfile(this_dir, 'oscillator_validation.mat'), ...
     't', 'x_num', 'x_anal', 'v_num', 'E_tot', 'err', 'dt', 'dt_lim');

fid = fopen(fullfile(this_dir, 'oscillator_validation.txt'), 'w');
fprintf(fid, '====================================================\n');
fprintf(fid, ' OSCILLATOR VALIDATION REPORT  (Article 3, MDF)\n');
fprintf(fid, '====================================================\n');
fprintf(fid, ' omega   = %.2f rad/s\n', omega);
fprintf(fid, ' omega0  = %.2f rad/s\n', omega0);
fprintf(fid, ' gamma0  = %.2f m/s^2\n', gamma0);
fprintf(fid, ' dt      = %.4f s\n', dt);
fprintf(fid, ' dt_lim  = %.4f s   (= 2/omega)\n', dt_lim);
fprintf(fid, ' max err = %.2e m\n', max(err));
fprintf(fid, ' RMS err = %.2e m\n', sqrt(mean(err.^2)));
fprintf(fid, ' mean E  = %.4f J/kg\n', mean(E_tot));
fprintf(fid, '====================================================\n');
fclose(fid);

fprintf('\nReport saved to %s\n', fullfile(this_dir, 'oscillator_validation.txt'));
