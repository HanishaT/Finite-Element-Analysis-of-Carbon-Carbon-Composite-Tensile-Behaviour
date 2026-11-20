clc;
clear;
close all;

%% Carbon-Carbon Composite Tensile FEM Model

A = 200e-6;      % Area (m^2)
L = 0.10;        % Length (m)
E = 60e9;        % Young's modulus (Pa)
P = 18130;       % Load (N)

%% Main FEM Analysis

nElem = 10;
nNode = nElem + 1;
Le = L/nElem;

K = zeros(nNode);

for e = 1:nElem

    ke = (E*A/Le)*[1 -1;
                  -1 1];

    K(e:e+1,e:e+1) = K(e:e+1,e:e+1) + ke;

end

F = zeros(nNode,1);
F(end) = P;

Kred = K(2:end,2:end);
Fred = F(2:end);

u = Kred\Fred;
u = [0;u];

stress = zeros(nElem,1);

for e = 1:nElem
    stress(e) = E*(u(e+1)-u(e))/Le;
end

x = linspace(0,L,nNode);

%% Displacement Plot

figure
plot(x,u*1000,'o-','LineWidth',2)
xlabel('Length (m)')
ylabel('Displacement (mm)')
title('FEM Prediction of CCC Tensile Deformation')
grid on

exportgraphics(gcf,'ccc_displacement.png','Resolution',300)

%% Stress Plot

figure
bar(stress/1e6)
xlabel('Element Number')
ylabel('Stress (MPa)')
title('Element Stress Distribution')
grid on

exportgraphics(gcf,'ccc_stress_distribution.png','Resolution',300)

fprintf('Maximum Stress = %.2f MPa\n',max(stress)/1e6);

%% Mesh Convergence Study

mesh_sizes = [2 4 8 16 32];

tip_disp = zeros(size(mesh_sizes));
max_stress = zeros(size(mesh_sizes));

for i = 1:length(mesh_sizes)

    nElem = mesh_sizes(i);
    nNode = nElem + 1;
    Le = L/nElem;

    K = zeros(nNode);

    for e = 1:nElem

        ke = (E*A/Le)*[1 -1;
                      -1 1];

        K(e:e+1,e:e+1) = K(e:e+1,e:e+1) + ke;

    end

    F = zeros(nNode,1);
    F(end) = P;

    Kred = K(2:end,2:end);
    Fred = F(2:end);

    u = Kred\Fred;
    u = [0;u];

    stress = zeros(nElem,1);

    for e = 1:nElem
        stress(e) = E*(u(e+1)-u(e))/Le;
    end

    tip_disp(i) = u(end);
    max_stress(i) = max(stress);

end

ref_disp = tip_disp(end);
ref_stress = max_stress(end);

disp_error = abs(tip_disp-ref_disp)/abs(ref_disp)*100;
stress_error = abs(max_stress-ref_stress)/abs(ref_stress)*100;

results = table( ...
    mesh_sizes', ...
    tip_disp'*1000, ...
    max_stress'/1e6, ...
    disp_error', ...
    stress_error', ...
    'VariableNames', ...
    {'Elements',...
     'TipDisplacement_mm',...
     'MaxStress_MPa',...
     'DisplacementError_pct',...
     'StressError_pct'});

disp(results)

%% Convergence Plot

figure

plot(mesh_sizes,disp_error,'-o',...
    'LineWidth',2,...
    'MarkerSize',8)

hold on

plot(mesh_sizes,stress_error,'-s',...
    'LineWidth',2,...
    'MarkerSize',8)

xlabel('Number of Elements')
ylabel('Error (%)')

title('Mesh Convergence Study')

legend('Displacement Error',...
       'Stress Error')

grid on

exportgraphics(gcf,'mesh_convergence.png','Resolution',300)

disp('Convergence study completed')
