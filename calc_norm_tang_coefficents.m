function [normal_coefficent_1, normal_coefficent_2, tangent_coefficent_1, tangent_coefficent_2] = calc_norm_tang_coefficents(x_control_points, y_control_points, x_boundary, y_boundary, phi, panel_lengths)

phi = phi * pi/180; % Radians Conversion

normal_coefficent_1 = zeros(max(size(x_control_points)), max(size(x_control_points))); % Vector Initialization
normal_coefficent_2 = normal_coefficent_1;
tangent_coefficent_1 = normal_coefficent_1;
tangent_coefficent_2 = normal_coefficent_1;

for i = 1:max(size(x_control_points))  
    for j = 1:max(size(x_control_points))
        if j ~= i % Only runs if i is not equal to j
            C1 = -cos(phi(i) - phi(j));
            C2 = (x_control_points(i) - x_boundary(j)) * cos(phi(i)) + (y_control_points(i) - y_boundary(j))* sin(phi(i));
            C3 = -cos(phi(j)) * (x_control_points(i) - x_boundary(j)) - sin(phi(j)) * (y_control_points(i) - y_boundary(j));
            C4 = (x_control_points(i) - x_boundary(j))^2 + (y_control_points(i) - y_boundary(j))^2;
            C5 = sqrt(C4 - (C3^2));
            C6 = sin(phi(j) - phi(i));
            C7 = (x_control_points(i) - x_boundary(j)) * sin(phi(i)) - (y_control_points(i) - y_boundary(j)) * cos(phi(i));

            C8 = 0.5 * (C2 - 2 * C1 * C3);
            C9 = log((panel_lengths(j)^2 + 2 * C3 * panel_lengths(j) + C4) / C4);
            C10 = (C1 * (C4 - 2 * C3^2) + C2 * C3) / C5;
            C11 = atan2((C3 + panel_lengths(j)), C5) - atan2(C3, C5);
            C12 = 0.5* (C7 - 2 * C6 * C3);
            C13 = (C6 * (C4 - 2 * C3^2) + C7 * C3) / C5;

            normal_coefficent_2(i,j) = -C1 - C8 * C9 / panel_lengths(j) + C10 * C11 / panel_lengths(j);
            normal_coefficent_1(i,j) = -0.5 * C1 * C9 - ((C2 - C1 * C3) / C5) * C11 - normal_coefficent_2(i,j);

            tangent_coefficent_2(i,j) = -C6 - C12 * C9 / panel_lengths(j) + C13 * C11 / panel_lengths(j);
            tangent_coefficent_1(i,j) = -0.5 * C6 * C9 - ((C7 - C6 * C3) / C5) * C11 - tangent_coefficent_2(i, j);

        else

            normal_coefficent_2(i,j) = 1;
            normal_coefficent_1(i,j) = -1;

            tangent_coefficent_2(i,j) = 0.5 * pi;
            tangent_coefficent_1(i,j) = 0.5 * pi;


        end
    end
end


         


