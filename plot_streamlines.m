function plot_streamlines(x_grid, y_grid, x_vals, y_vals, stream_step, phi, max_vertices, panel_lengths, stream_grid_percent, x_boundary, y_boundary, uniform_flow_velocity, aoa_vector, gamma, aoa_index, export_figures, plot_title)


y_stream_start = linspace(y_vals(1), y_vals(2), floor((stream_grid_percent / 100) * y_grid))';  % Grid Point Generation

x_grid_points = linspace(x_vals(1), x_vals(2), x_grid)';
y_grid_points = linspace(y_vals(1), y_vals(2), y_grid)';
[x_mesh, y_mesh] = meshgrid(x_grid_points, y_grid_points);

x_velocity = zeros(x_grid, y_grid);  % Velocity Initialization
y_velocity = zeros(x_grid, y_grid);

for i = 1:1:x_grid  % Solve for X & Y Velocities

    for j = 1:1:y_grid

        x_point = x_mesh(i,j);
        y_point = y_mesh(i,j);

        [x_integral_1, x_integral_2, y_integral_1, y_integral_2] = compute_stream_integrals(x_point, y_point, x_boundary, y_boundary, phi, panel_lengths);

        x_n = zeros(size(x_integral_1, 1) + 1, size(x_integral_1, 1) + 1);
        y_n = zeros(size(x_integral_1, 1), size(x_integral_1, 1) + 1);

        for k = 1:size(x_integral_1, 1)

            x_n(k, 1) = x_integral_1(k,1);
            x_n(k, size(x_integral_1, 1) + 1) = x_integral_2(k, size(x_integral_1, 1));

            y_n(k, 1) = y_integral_1(k,1);
            y_n(k, size(y_integral_1, 1) + 1) = y_integral_2(k, size(y_integral_1, 1));

            for l = 2:size(x_integral_1, 1)

                x_n(k,l) = x_integral_1(k,l) + x_integral_2(k, l-1);
                y_n(k,l) = y_integral_1(k,l) + y_integral_2(k, l-1);
               
            end
          
        end

        x_n(size(x_integral_1, 1) + 1, :) = [0 zeros(1, size(x_integral_1, 1) - 1) 0];
        y_n(size(x_integral_1, 1) + 1, :) = [0 zeros(1, size(x_integral_1, 1) - 1) 0];


        [in, on] = inpolygon(x_point, y_point, x_boundary, y_boundary);  % Checks if points are inside or outside of Airfoil

        if(in == 1 || on == 1)

            x_velocity(i,j) = 0;   % Zero Velocity inside Airfoil
            y_velocity(i,j) = 0;

        else

            x_velocity(i,j) = uniform_flow_velocity * cosd(aoa_vector(aoa_index + 1 - aoa_vector(1))) + sum(gamma{aoa_index + 1 - aoa_vector(1)}' * x_n);  % Solve for velocity with given Angle of Attack
            y_velocity(i,j) = uniform_flow_velocity * sind(aoa_vector(aoa_index + 1 - aoa_vector(1))) + sum(gamma{aoa_index + 1 - aoa_vector(1)}' * y_n);

        end

    end

end


% Plot Streamlines
f = figure;

cla;
hold on;
grid on;

for i = 1:1:length(y_stream_start)

    stream_line = streamline(x_mesh, y_mesh, x_velocity, y_velocity, x_vals(1), y_stream_start(i), [stream_step, max_vertices]);
    set(stream_line, 'LineWidth', 1);

end

fill(x_boundary, y_boundary, 'r');
title(strcat(['Stream Lines at ', num2str(aoa_index), '° Angle of Attack']));
xlabel('X');
ylabel('Y');
xlim(x_vals);
axis equal;
ylim(y_vals);


if export_figures

    exportgraphics(f, 'Output\' + plot_title + '_Stream_Lines_Plot.png');

end

                


