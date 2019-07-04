function [] = GeneratePlot(Stab, a, y)
% Generate plot for the stability map.  A simple example code is presented
% here. 

figure
imagesc(a, y, Stab')
set(gca, 'YDir', 'normal');
colormap hot
cbar = colorbar();
hold on

set(gca,'TickLabelInterpreter','latex', 'Fontsize', 9);
xlabel('a (AU)','Interpreter','latex', 'Fontsize', 10);
ylabel('e','Interpreter','latex', 'Fontsize', 10);
set(cbar,'TickLabelInterpreter','latex', 'Fontsize', 9);
y = ylabel(cbar, 'Lifetime, $\log_{10}\left(\textrm{yr}\right)$','Interpreter','latex', 'Fontsize', 10, 'Rotation', 270);
y.Position(1) = y.Position(1) + 0.7

end

