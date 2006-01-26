function demGPCov2D(ind)

% DEMGPSCOV2D Simple demonstration of sampling from a covariance function.

% OXFORD

if nargin < 1
  ind = [1 2];
end
load demGPSample
K = K(ind, ind);
f = f(ind);
x = x(ind);
disp(K);
figure(1)
clf
[ax, cont, t] = basePlot(K, ind);

figure(2)
clf
[ax, cont, t] = basePlot(K, ind);
set(cont, 'linewidth', 2);

cont2 = line([f(1) f(1)], [-1 1]);
set(cont2, 'linewidth', 3)
set(cont2, 'linestyle', '--')

figure(3)
clf
[ax, cont, t] = basePlot(K, ind);
set(cont, 'linewidth', 2);

cont2 = line([f(1) f(1)], [-1 1]);
set(cont2, 'linewidth', 2)
set(cont2, 'linestyle', '--')

% Compute conditional mean and variance
f2Mean = K(1, 2)/K(1, 1)*f(1);
f2Var = K(2, 2) - K(1, 2)/K(1, 1)*K(1, 2);
yval = linspace(-1, 1, 200);
pdfVal = 1/sqrt(2*pi*f2Var)*exp(-0.5*(yval-f2Mean).*(yval-f2Mean)/f2Var);
pdf = line(pdfVal*0.25, yval);
set(pdf, 'linewidth', 3)
set(pdf, 'linestyle', ':')

for figNo = 1:3
  figure(figNo)
  print('-depsc', ['../tex/diagrams/demGPCov2D' num2str(ind(1)) '_' ...
                   num2str(ind(2)) ...
                   '_' num2str(figNo) ...
                   '.eps'])
end

function [ax, cont, t] = basePlot(K, ind)

% BASEPLOT Plot the contour of the covariance.

[U, V] = eig(K);
r = sqrt(diag(V));
theta = linspace(0, 2*pi, 200)';
xy = [r(1)*sin(theta) r(2)*cos(theta)]*U;
cont = line(xy(:, 1), xy(:, 2));
set(cont, 'linewidth', 3)

t = text(0.5, -0.2, ['f_{' num2str(ind(1)) '}']);
t =[t text(-0.2, -0.5, ['f_{' num2str(ind(2)) '}'])];


set(gca, 'xtick', [-1  0  1])
set(gca, 'ytick', [-1 0 1])

set(t, 'fontname', 'times')
set(t, 'fontsize', 24)
set(t, 'fontangle', 'italic')

zeroAxes(gca, 0.025, 18, 'times')

ax = gca;