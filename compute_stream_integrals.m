function[x_integral_1, x_integral_2, y_integral_1, y_integral_2] = compute_stream_integrals(x_point, y_point, x_boundary, y_boundary, phi, panel_lengths)


    x_integral_1 = zeros(max(size(x_boundary)) - 1, max(size(x_boundary)) - 1);
    x_integral_2 = x_integral_1;
    y_integral_1 = x_integral_1;
    y_integral_2 = x_integral_1;

        for i = 1:max(size(x_boundary)) - 1

                C1 = sin(phi(i));
                C2 = -(y_point - y_boundary(i));
                C3 = -cos(phi(i)) * (x_point - x_boundary(i)) - sin(phi(i)) * (y_point - y_boundary(i));
                C4 = (x_point - x_boundary(i))^2 + (y_point - y_boundary(i))^2;
                C5 = sqrt(C4 - (C3^2));
                C6 = -cos(phi(i));
                C7 = (x_point - x_boundary(i));

                C8 = 0.5 * (C2 - 2 * C1 * C3);
                C9 = log((panel_lengths(i)^2 + 2 * C3 * panel_lengths(i) + C4 / C4));
                C10 = (C1 * (C4 - 2 * C3^2) + C2 * C3) / C5;
                C11 = atan2((C3 + panel_lengths(i)), C5) - atan2(C3, C5);
                C12 = 0.5 * (C7 - 2 * C6 * C3);
                C13 = (C6 * (C4 - 2 * C3^2) + C7 * C3) / C5;

                x_integral_2(i) = -C1 - C8 * C9 / panel_lengths(i) + C10 * C11 / panel_lengths(i);
                x_integral_1(i) = -0.5 * C1 * C9 - ((C2 - C1 * C3) / C5) * C11 - x_integral_2(i);

                y_integral_2(i) = -C6 - C12 * C9 / panel_lengths(i) + C13 * C11 / panel_lengths(i);
                y_integral_1(i) = -0.5 * C6 * C9 - ((C7 - C6 * C3) / C5) * C11 - y_integral_2(i);

        end

