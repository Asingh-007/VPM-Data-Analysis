function[x_boundary, y_boundary, x_control, y_control, delta, phi, beta, panel_lengths] = gen_panels(x_upper,y_upper,x_lower,y_lower, aoa_vector)

if x_upper(1) == x_lower(1)                     % Leading Edge Equality Check
    x_upper = x_upper(2:end);
    y_upper = y_upper(2:end);
end

x_boundary = [flip(x_lower);x_upper];
y_boundary = [flip(y_lower);y_upper];

x_control = zeros(1,max(size(x_boundary))-1);        % Vector Initialization
y_control = x_control;
panel_lengths = x_control;
phi = x_control;

    

for k = 1:max(size(x_boundary))-1             % Control Point Calculations   
    x_control(k) = 0.5*(x_boundary(k) + x_boundary(k+1));    
    y_control(k) = 0.5*(y_boundary(k) + y_boundary(k+1));
    deltaX = x_boundary(k+1) - x_boundary(k);
    deltaY = y_boundary(k+1) - y_boundary(k);
    panel_lengths(k) = sqrt(deltaX^2 + deltaY^2); % Panel Length
    phi(k) = atan2d(deltaY, deltaX);  % Panel Orientation with Respect to Normal
    if phi(k) < 0 
        phi(k) = phi(k) + 360;        % Angle Normalizations
    end
end

delta = phi + 90;                     % Normal Angle



for i=1:size(aoa_vector,2)            % Freestream Angle with Respect to Angle of Attack
    beta{i} = delta-aoa_vector(i);                                    
    beta{i}(beta{i}>360) = beta{i}(beta{i}>360)-360;           
end