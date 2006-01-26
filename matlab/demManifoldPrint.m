function demManifoldPrint(pcs, digits);

% DEMMANIFOLDPRINT Print the principal components of the artificial digits data set.

% OXFORD

if nargin < 2
  digits = 'all'
  if nargin < 1
    pcs = [2 3];
  end
end

colordef white
load demManifold
X = X(:, pcs);
Y = uint8(-(double(Y-255)));
axesWidth = 0.05;
clf

switch digits
 case 'all'
  indices = 1:20:size(X, 1); 
  indRed = 1:size(X, 1);
  indBlue = [];
 case 'sixnine'
  indices = [260:20:360 20];
  indices = [indices 80:20:200];
  indRed = [1:20 260:360];
  indBlue = [80:200];
end
  
  

a = plot(X(indRed, 1), X(indRed, 2), 'rx');
hold on
a= [a; plot(X(indBlue, 1), X(indBlue, 2), 'bx')];
set(gca, 'xlim', [-60 60]);
set(gca, 'ylim', [-60 60]);
set(gca, 'xtick', [-60 -40 -20 0 20 40 60])
set(gca, 'ytick', [-60 -40 -20 0 20 40 60])
axis equal
set(a, 'markersize', 12);
set(a, 'linewidth', 2);
set(gca, 'fontname', 'helvetica')
set(gca, 'fontsize', 20)
xlabel(['PC no ' num2str(pcs(1))]);
ylabel(['PC no ' num2str(pcs(2))]);
plotAxes = gca;
xPrime = normalisedPoint(X(indices(1), :), plotAxes);

imageAxes = axes('position', [xPrime axesWidth axesWidth]);
im = imagesc(reshape(Y(indices(1), :), [64 64]));
axis off
axis image
colormap gray
for i = indices
  x = X(i, :);
  xPrime = normalisedPoint(x, plotAxes);
  imageAxes = axes('position', [xPrime axesWidth axesWidth]);
    
  imagesc(reshape(Y(i, :), [64 64]));
  axis off 
  axis image
  pause(0.1) 
end

paperPos = get(gcf, 'paperPosition');
%paperPos(3) = paperPos(3)*2;
%paperPos(4) = paperPos(4)*2;
set(gcf, 'paperPosition', paperPos);

function y = normalisedPoint(x, plotAxes);

% NORMALISEDPOINT Helper function for getting the normalised point.

pos = get(plotAxes, 'position');
xLim = get(plotAxes, 'xlim');
yLim = get(plotAxes, 'ylim');
scaleX = pos(3)/(xLim(2) - xLim(1));
scaleY = pos(4)/(yLim(2) - yLim(1));
y(1) = (x(1)-xLim(1))*scaleX + pos(1);
y(2) = (x(2)-yLim(1))*scaleY + pos(2);
