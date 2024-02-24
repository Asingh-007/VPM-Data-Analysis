function[resultant_matrix, gamma, tangent_velocity, pressure_coefficient] = kutta_cp_system_solver(normal_coefficent_1, normal_coefficent_2, tangent_coefficent_1, tangent_coefficent_2, x_boundary, aoa_vector, beta, uniform_flow_velocity)

normal_matrix = zeros(size(normal_coefficent_1,1) + 1, size(normal_coefficent_1,1) + 1);
tangent_matrix = zeros(size(normal_coefficent_1,1), size(normal_coefficent_1,1)+1);

for i = 1:size(normal_coefficent_1, 1)  % Creating Left Side of Equation
    normal_matrix(i,1) = normal_coefficent_1(i,1);
    normal_matrix(i, size(normal_coefficent_1, 1) + 1) = normal_coefficent_2(i, size(normal_coefficent_1, 1));

    tangent_matrix(i,1) = tangent_coefficent_1(i,1);
    tangent_matrix(i, size(tangent_coefficent_1, 1) + 1) = normal_coefficent_2(i, size(tangent_coefficent_1, 1));

    for j = 2:size(normal_coefficent_1, 1)
        normal_matrix(i,j) = normal_coefficent_1(i,j) + normal_coefficent_2(i,j-1);
        tangent_matrix(i,j) = tangent_coefficent_1(i,j) + tangent_coefficent_2(i,j-1);

    end

end

normal_matrix(size(normal_coefficent_1, 1) + 1, :) = [1 zeros(1, size(normal_coefficent_1, 1) - 1) 1]; % Kutta Condition Row Creation
tangent_matrix(size(normal_coefficent_1, 1) + 1, :) = [1 zeros(1, size(tangent_coefficent_1, 1) - 1) 1]; 


for i = 1:size(aoa_vector, 2)
    
    for j = 1:max(size(x_boundary)) - 1
        resultant_matrix{i}(j) = -uniform_flow_velocity * cosd(beta{i}(j)); % Creating Right Side of Equation

    end
        resultant_matrix{i}(end + 1) = 0; % Kutta Condition

    gamma{i} = normal_matrix \ resultant_matrix{i}'; % Solving the Equation
    
    for j = 1:size(normal_coefficent_1, 1)
        tangent_velocity{i}(j) = uniform_flow_velocity * sind(beta{i}(j));

        for k = 1:1:(size(normal_coefficent_1, 1) +1)
             tangent_velocity{i}(j) = tangent_velocity{i}(j) + gamma{i}(k) * tangent_matrix(j,k);
             pressure_coefficient{i}(j) = 1 - (tangent_velocity{i}(j) / uniform_flow_velocity)^2;
        end   

    end

end

    


