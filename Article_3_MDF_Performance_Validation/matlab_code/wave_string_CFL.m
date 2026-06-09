%% 02_wave_string_CFL.m
%  Vibrating string  u_tt - V^2 u_xx = 0,  V = sqrt(T/mu)
%  with u(0,t) = a0 sin(omega0 t), u(L,t) = 0, u(x,0) = 0, u_t(x,0) = 0.
%
%  Explicit centred scheme:
%       u(i, n+1) = 2 u(i,n) - u(i,n-1) + r*(u(i+1,n) - 2 u(i,n) + u(i-1,n))
%       r = (V dt/dx)^2     (CFL stable iff r <= 1)
%
%  Demonstrates:
%   (i)  the automatic dt rescaling when CFL is violated;
%   (ii) the discrete energy E(t) = 0.5*mu*u_t^2 + 0.5*T*u_x^2 integrated
%        by trapz, used as a validation invariant;
%   (iii) a stress test for r in {0.95, 1.0, 1.05}.
%
%  (Derived from test4_EDP_spatiotemporelles_2.m)
%
%  Author : M. JANANE ALLAH (Medium Article 3, Validation)

clc; clear; close all;

%% --- physical & numerical parameters ------------------------------------
L      = 1.0;
T_phys = 10.0;
mu     = 0.01;
V      = sqrt(T_phys/mu);
a0     = 0.1;
omega0 = 10*pi;
T_end  = 2.0;
Nx     = 80;
Nt     = 400;

dx     = L/(Nx-1);
dt     = T_end/Nt;
x      = linspace(0, L, Nx);

CFL    = V*dt/dx;
fprintf('Initial CFL = %.3f\n', CFL);

if CFL > 1
    dt  = 0.9*dx/V;
    Nt  = ceil(T_end/dt);
    CFL = V*dt/dx;
    fprintf('Re-scaled to dt = %.4f, CFL = %.3f\n', dt, CFL);
end

t = linspace(0, T_end, Nt+1);
r = (V*dt/dx)^2;

%% --- explicit centred scheme --------------------------------------------
u = zeros(Nx, Nt+1);

% Initial conditions (homogeneous + driven boundary)
u(1,1) = a0*sin(omega0*t(1));
u(Nx,1) = 0;

% First step using u_t = 0
for i = 2:Nx-1
    d2u_dx2 = (u(i+1,1) - 2*u(i,1) + u(i-1,1))/dx^2;
    u(i,2)  = u(i,1) + 0.5*V^2*d2u_dx2*dt^2;
end
u(1, 2)  = a0*sin(omega0*t(2));
u(Nx,2)  = 0;

% Time loop
for n = 2:Nt
    u(1, n+1) = a0*sin(omega0*t(n+1));
    u(Nx,n+1) = 0;
    for i = 2:Nx-1
        u(i, n+1) = 2*u(i,n) - u(i,n-1) + ...
                    r*(u(i+1,n) - 2*u(i,n) + u(i-1,n));
    end
end

%% --- discrete energy -----------------------------------------------------
E_cin = zeros(1, Nt+1);
E_pot = zeros(1, Nt+1);

for n = 1:Nt+1
    if n == 1
        du_dt = (u(:,2) - u(:,1))'/dt;
    elseif n == Nt+1
        du_dt = (u(:,end) - u(:,end-1))'/dt;
    else
        du_dt = (u(:,n+1) - u(:,n-1))'/(2*dt);
    end
    du_dx        = zeros(1, Nx);
    du_dx(2:Nx-1) = (u(3:Nx,n) - u(1:Nx-2,n))'/(2*dx);
    du_dx(1)     = (u(2,n)  - u(1,n))/dx;
    du_dx(Nx)    = (u(Nx,n) - u(Nx-1,n))/dx;

    E_cin(n) = 0.5*mu*trapz(x, du_dt.^2);
    E_pot(n) = 0.5*T_phys*trapz(x, du_dx.^2);
end
E_tot = E_cin + E_pot;

fprintf('Initial energy: %.4f J\n', E_tot(1));
fprintf('Final   energy: %.4f J\n', E_tot(end));
fprintf('Relative drift: %.2f %%\n', 100*abs(E_tot(end)-E_tot(1))/max(eps,E_tot(1)));

%% --- figures -------------------------------------------------------------
% Figure 1: snapshot
figure('Color', 'w', 'Position', [60 60 800 350]);
imagesc(t, x, u); colormap(jet); colorbar;
xlabel('time t'); ylabel('position x');
title(sprintf('Vibrating string  r = %.3f', r));

% Figure 2: energies
figure('Color', 'w', 'Position', [120 100 800 400]);
plot(t, E_cin, 'b', 'DisplayName', 'kinetic'); hold on; grid on; box on;
plot(t, E_pot, 'r', 'DisplayName', 'potential');
plot(t, E_tot, 'k', 'LineWidth', 1.8, 'DisplayName', 'total');
xlabel('time t'); ylabel('Energy (J)');
title('Discrete energy balance');
legend('Location', 'best');

%% --- CFL stress test -----------------------------------------------------
r_test = [0.95, 1.0, 1.05];
figure('Color', 'w', 'Position', [180 140 900 400]);
hold on; grid on; box on;

for rt = r_test
    dt_t = sqrt(rt) * dx / V;
    Nt_t = ceil(T_end/dt_t);
    t_t  = linspace(0, T_end, Nt_t+1);
    u_t  = zeros(Nx, Nt_t+1);
    u_t(1, 1) = a0*sin(omega0*t_t(1));
    for i = 2:Nx-1
        u_t(i,2) = u_t(i,1) + 0.5*V^2*(u_t(i+1,1) - 2*u_t(i,1) + u_t(i-1,1))/dx^2 * dt_t^2;
    end
    u_t(1,2) = a0*sin(omega0*t_t(2));

    for n = 2:Nt_t
        u_t(1, n+1) = a0*sin(omega0*t_t(n+1));
        for i = 2:Nx-1
            u_t(i,n+1) = 2*u_t(i,n) - u_t(i,n-1) + ...
                         rt*(u_t(i+1,n) - 2*u_t(i,n) + u_t(i-1,n));
        end
    end
    plot(t_t, max(abs(u_t), [], 1), 'LineWidth', 1.6, ...
         'DisplayName', sprintf('r = %.2f', rt));
end

set(gca, 'YScale', 'log');
xlabel('time t'); ylabel('max_i |u_i^n|  (log)');
title('CFL stress test: max amplitude vs time');
legend('Location', 'NorthWest');
