function[CL, CD, CM, CL_k] = lift_drag_moment_calc(aoa_vector, pressure_coefficient, panel_lengths, delta, gamma, x_control, y_control, uniform_flow_velocity, aoa_index)

for i = 1:size(aoa_vector,2)

    % Lift, Drag, and Moment Calculations
    CN{i} = -pressure_coefficient{i}.*panel_lengths.*sind(delta);
    CA{i} = -pressure_coefficient{i}.*panel_lengths.*cosd(delta);

    CL{i} = sum(CN{i}.*cosd(aoa_vector(i))) - sum(CA{i}.*sind(aoa_vector(i))); % Center of Pressure Distribution Lift Coefficent
    CD{i} = sum(CN{i}.*sind(aoa_vector(i))) + sum(CA{i}.*cosd(aoa_vector(i)));
    CM{i} = -sum(-pressure_coefficient{i}.*(x_control-0.25).*panel_lengths.*sind(delta)) + sum(-pressure_coefficient{i}.*y_control.*panel_lengths.*cosd(delta));

    CL_k{i} = sum(4*pi*gamma{i}(1:end-1)'.*panel_lengths)/ uniform_flow_velocity; % Kutta Joukovsky Lift Coefficent

     
end

subtitle(['C_L = ' , num2str(CL{aoa_index}) , ' C_LK = ' , num2str(CL_k{aoa_index}) ,' C_D = ' , num2str(CD{aoa_index}), ' C_M = ' , num2str(CM{aoa_index})]); % Label Coefficients for Corresponding Angle of Attack
  
% Convert cells to mzatrixes to plot
CL = cell2mat(CL); 
CL_k = cell2mat(CL_k);
CD = cell2mat(CD);
CM = cell2mat(CM);