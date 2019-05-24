function [] = GeneratePlot(Stab, a, e)

figure
colormap hot;
surf(a, e, Stab' ,'EdgeColor','None', 'facecolor', 'interp');
xlim([a(1), a(end)]);
ylim([e(1), e(end)]);
view(2); 

cbar = colorbar;

set(gca,'TickLabelInterpreter','latex');
xlabel('a [AU]','Interpreter','latex', 'FontSize', 10);
ylabel('e','Interpreter','latex', 'FontSize', 10);
y = ylabel(cbar, '$log_{10}(t)$','Interpreter','latex');


end

