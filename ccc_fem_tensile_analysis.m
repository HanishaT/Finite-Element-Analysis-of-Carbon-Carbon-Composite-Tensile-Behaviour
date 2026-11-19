clc;
clear;
close all;

%% Carbon-Carbon Composite Tensile FEM Model

% Experimental values from thesis

A = 200e-6;      % 200 mm² -> m²
L = 0.10;        % 100 mm gauge length

E = 60e9;        % Assumed modulus (Pa)

P = 18130;       % Average tensile load from thesis (N)

%% Mesh

nElem = 10;
nNode = nElem + 1;

Le = L/nElem;

%% Global stiffness matrix

K = zeros(nNode);

for e = 1:nElem

    ke = (E*A/Le)*[1 -1;
                  -1 1];

    K(e:e+1,e:e+1)=K(e:e+1,e:e+1)+ke;

end

%% Force vector

F = zeros(nNode,1);

F(end)=P;

%% Boundary condition

Kred = K(2:end,2:end);
Fred = F(2:end);

%% Solve

u = Kred\Fred;

u = [0;u];

%% Stress

stress=zeros(nElem,1);

for e=1:nElem

    stress(e)=E*(u(e+1)-u(e))/Le;

end

%% Position

x=linspace(0,L,nNode);

%% Plot displacement

figure

plot(x,u*1000,'o-','LineWidth',2)

xlabel('Length (m)')
ylabel('Displacement (mm)')

title('FEM Prediction of CCC Tensile Deformation')

grid on

exportgraphics(gcf,...
'ccc_displacement.png',...
'Resolution',300)

%% Plot stress

figure

bar(stress/1e6)

xlabel('Element Number')

ylabel('Stress (MPa)')

title('Element Stress Distribution')

grid on

exportgraphics(gcf,...
'ccc_stress_distribution.png',...
'Resolution',300)

disp('Maximum Stress (MPa)')
disp(max(stress)/1e6)