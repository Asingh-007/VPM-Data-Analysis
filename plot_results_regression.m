function[upper_model, lower_model, pressure_dist_model, kutta_model, drag_model, moment_model, export] = plot_results_regression(aoa_vector, x_control, pressure_coefficient, panel_lengths, y_control, gamma, delta, uniform_flow_velocity, aoa_index, export_data, plot_title, export_figures)


% Create Models of Pressure Coefficent Distribution on Upper and Lower Surfaces
[upper_model, lower_model] = create_pressure_models(x_control, pressure_coefficient, aoa_vector, aoa_index, export_figures, plot_title);

% Calculate lift, Drag, and Moment Coefficents
[CL, CD, CM, CL_k] = lift_drag_moment_calc(aoa_vector, pressure_coefficient, panel_lengths, delta, gamma, x_control, y_control, uniform_flow_velocity, aoa_index + 1 - aoa_vector(1));


% Plot regression models
if size(aoa_vector, 2) > 4

    [pressure_dist_model, kutta_model] = create_lift_models(aoa_vector, CL, CL_k, export_figures, plot_title);

    [drag_model] = create_model(aoa_vector, CD, 'Angle of Attack [°]', 'C_D', "Coefficent of Drag Over Angle of Attack", export_figures, plot_title);

    [moment_model] = create_model(aoa_vector, CM, 'Angle of Attack [°]', 'C_M', "Coefficent of Moment Over Angle of Attack", export_figures, plot_title);

    export = true;

% Don't Export if there isn't Sufficent Data
else

    pressure_dist_model = 0;
    kutta_model = 0;
    drag_model = 0;
    moment_model = 0;

    export = false;

end

if export_data 

    export_results(aoa_vector, x_control, pressure_coefficient, CL, CL_k, CD, CM, plot_title);

end

