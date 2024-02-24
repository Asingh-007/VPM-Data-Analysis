function plot_results(aoa_vector, x_control, pressure_coefficient, panel_lengths, y_control, gamma, delta, uniform_flow_velocity, aoa_index, export_data, plot_title, export_figures)


% Plot Pressure Coefficent Distributions for Specified Angle of Attack
f1 = figure;
hold on
plot(x_control((end/2+1):end)', pressure_coefficient{aoa_index + 1 - aoa_vector(1)}((end/2+1):end), 'r.'); 
set(gca,'Ydir', 'reverse')
plot(x_control(1:(end/2))', pressure_coefficient{aoa_index + 1 - aoa_vector(1)}(1:(end/2)), 'b.'); 
set(gca,'Ydir', 'reverse')
xlabel('C');
ylabel("C_P");
legend(["Upper Surface","Lower Surface"]);
title(strcat([ 'Pressure Coefficent over Airfoil at ', num2str(aoa_index), '° Angle of Attack' ]));


% Calculate lift, Drag, and Moment Coefficents
[CL, CD, CM, CL_k] = lift_drag_moment_calc(aoa_vector, pressure_coefficient, panel_lengths, delta, gamma, x_control, y_control, uniform_flow_velocity, aoa_index + 1 - aoa_vector(1));

% Plot Lift, Drag, and Moment Coefficents over Angle of Attack
if size(aoa_vector, 2) > 1 
    
   f2 = figure;
   plot(aoa_vector, CL, aoa_vector, CL_k);
   xlabel('Angle of Attack [°]');
   ylabel('C_L');
   title("Coefficent of Lift Over Angle of Attack");
   lg = legend(["Pressure Distribution", "Kutta Joukovsky"]);
   lg.Location = "northwest";
   grid;


   f3 = figure;
   plot(aoa_vector, CD)
   xlabel('Angle of Attack [°]');
   ylabel('C_D');
   title("Coefficent of Drag Over Angle of Attack");
   grid;

   f4 = figure;
   plot(aoa_vector, CM)
   xlabel('Angle of Attack [°]');
   ylabel('C_M');
   title("Coefficent of Moment Over Angle of Attack");
   grid;

  
end

if export_data

    export_results(aoa_vector, x_control, pressure_coefficient, CL, CL_k, CD, CM, plot_title);
    

end


if export_figures

    exportgraphics(f1, 'Output\' + plot_title + '_CP_Plot.png');
    exportgraphics(f2, 'Output\' + plot_title + '_CL_Plot.png');
    exportgraphics(f3, 'Output\' + plot_title + '_CD_Plot.png');
    exportgraphics(f4, 'Output\' + plot_title + '_CM_Plot.png');

end
