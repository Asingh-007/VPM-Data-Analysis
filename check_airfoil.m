function check_airfoil(x_boundary, y_boundary, x_control, y_control, delta, panel_lengths, boundary_points, plot_title, export_figures)

f = figure;
hold on
plot(x_boundary,y_boundary);                      % Plot Boundary Curve
fill(x_boundary,y_boundary,'r');

arrow_size = zeros(1,max(size(x_control)));
X_arrow = arrow_size;
Y_arrow = arrow_size;

for i = 1:max(size(x_control))           
    arrow_size(i) = panel_lengths(i)*boundary_points/10;
    X_arrow(i) = x_control(i) + cosd(delta(i)) * arrow_size(i);
    Y_arrow(i) = y_control(i) + sind(delta(i)) * arrow_size(i);
    plot([x_control(i) X_arrow(i)], [y_control(i) Y_arrow(i)]);   % Plot Normal Vectors
end

title(plot_title + ' Panel Check');
plot(x_control,y_control,'.');     % Plot Control Points
xlabel('X');
ylabel('Y');
xlim([-0.1,1.1]);
ylim([-0.5,0.5]);


if export_figures

    exportgraphics(f, 'Output\' + plot_title + '_Panel_Check.png');

end

