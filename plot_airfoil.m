function plot_airfoil(x_upper, y_upper, x_lower, y_lower, plot_title, export_figures)

f = figure;
plot(x_upper,y_upper,x_lower,y_lower, 0.5*(x_lower+x_upper), 0.5*(y_lower+y_upper));   % Plot Airfoil Surface and Camber Line
title(plot_title);
xlabel('X');
ylabel('Y');
xlim([-0.1,1.1]);
ylim([-0.5,0.5]);
legend(["Upper Surface","Lower Surface","Camber Line"])

if export_figures

    exportgraphics(f, 'Output\' + plot_title + '_Plot.png');

end

