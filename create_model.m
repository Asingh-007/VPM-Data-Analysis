function [fitresult] = create_model(x_data, plot1, xlabel1, ylabel1, plot_title, export_figures, export_title)


[xData, yData] = prepareCurveData( x_data, plot1);

% Degree 4 Polynomial Regression
ft = fittype( 'poly4' );


[fitresult, gof] = fit( xData, yData, ft );


f = figure;
plot(fitresult, xData, yData, "b.")
xlabel(xlabel1);
ylabel(ylabel1);
title(plot_title);
lg = legend(["Data", "Polynomial Model"]);
lg.Location = "northwest";
grid

if export_figures

    ylabel1 = strrep(ylabel1,"_", "");

    exportgraphics(f, 'Output\' + export_title + '_' + ylabel1 + '_Plot.png');

end



