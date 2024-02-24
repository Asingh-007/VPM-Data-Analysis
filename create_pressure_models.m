function[fitresult1, fitresult2] = createFit3(x_control, pressure_coefficient, aoa_vector, aoa_index, export_figures, plot_title)

% Transpose Matrix to allign elements
x_control_tranpose = transpose(x_control);

% Get Pressure Matrix for specified Angle of Attack
pressure_matrix =  pressure_coefficient{aoa_index + 1 - aoa_vector(1)};

% Upper Surface Data
[xData, yData] = prepareCurveData(x_control_tranpose((end/2+1):end)' , pressure_matrix((end/2+1):end));

% Lower Surface Data
[xData2, yData2] = prepareCurveData(x_control_tranpose(1:(end/2))', pressure_matrix(1:(end/2)));

% Degree 9 Polynomial Regression
ft1 = fittype( 'poly9' );

% Top & Bottom Degree 5 Rational Regression
ft2 = fittype( 'rat55' );

[fitresult1, gof1] = fit( xData, yData, ft1 );
[fitresult2, gof2] = fit( xData2, yData2, ft2, 'StartPoint', [1, 1, 1, 1, 1, 1, 1, 1 ,1 ,1 ,1]); % Starting Point for Rational Regression


f = figure;
plot(fitresult1, xData, yData, "r.");
hold on
plot(fitresult2, xData2, yData2, "b.");
hold off
xlabel('C');
ylabel('C_P');
title(strcat([ 'Pressure Coefficent over Airfoil at ', num2str(aoa_index), '° Angle of Attack' ]));
set(gca,'Ydir', 'reverse')
legend(["Upper Surface", "", "Lower Surface", ""]);
grid

if export_figures

    exportgraphics(f, 'Output\' + plot_title + '_CP_Plot.png');

end
