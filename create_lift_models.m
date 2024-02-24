function[fitresult1, fitresult2] =  create_lift_models(x_data, plot1, plot2, export_figures, plot_title)

[xData, yData] = prepareCurveData( x_data, plot1 );

[xData2, yData2] = prepareCurveData( x_data, plot2 );

% Degree 4 Polynomial Regression
ft = fittype( 'poly4' );

[fitresult1, gof1] = fit( xData, yData, ft );
[fitresult2, gof2] = fit( xData2, yData2, ft );


f = figure;
plot(fitresult1, xData, yData, "r.");
hold on
plot(fitresult2, xData2, yData2, "b.");
hold off
xlabel('Angle of Attack [°]');
ylabel('C_L');
title( 'Coefficent of Lift Over Angle of Attack');
lg = legend(["Pressure Distribution", "", "Kutta-Joukowski", ""]);
lg.Location = "northwest";
grid


if export_figures

    exportgraphics(f, 'Output\' + plot_title + '_CL_Plot.png');

end


