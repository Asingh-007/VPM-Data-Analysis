function[x_upper, y_upper, x_lower, y_lower, plot_title] = naca4(type, boundary_points, export_af)

m = str2double(type(1)); % Camber
p = str2double(type(2)); % Position of Max Camber
t = str2double(type(3:4)); % Thickness

% NACA 4-Digit Function Constants

a0 = 0.2969;
a1 = -0.1260;
a2 = -0.3516;
a3 = 0.2843;
a4 = -0.1036; % Closed Trailing Edge
% a4 = -0.1015 % Open Trailing Edge

%% Airfoil Creation
% Percentages

M = m/100;
P = p/10;
T = t/100;

% Airfoil Grid

bet = linspace(0,pi,boundary_points);
x = 0.5*(1-cos(bet))';


% Camber and Gradient

yc = zeros(boundary_points,1);
dyc = yc;
theta = yc;

for i = 1:boundary_points
    if x(i) >= 0 && x(i) <P
        yc(i) = (M/P^2)*(2*P*x(i)-x(i)^2);
        dyc(i) = (2*M/(P^2))*(P-x(i));
    elseif x(i) >= P && x(i) <= 1
        yc(i) = (M/(1-P)^2)*(1-(2*P)+(2*P*x(i))-x(i)^2);
        dyc(i) = (2*M/(1-P)^2)*(P-x(i));
    end 
    theta(i) = atan(dyc(i));
end

% Thickness distribution

yt = zeros(boundary_points,1);
for i = 1:boundary_points
    term0 = a0*sqrt(x(i));
    term1 = a1*x(i);
    term2 = a2*x(i)^2;
    term3 = a3*x(i)^3;
    term4 = a4*x(i)^4;

    yt(i) = 5*T*(term0+term1+term2+term3+term4);
end

% Upper Surface Points
x_upper = zeros(boundary_points,1);
y_upper = x_upper;
for i = 1:boundary_points
    x_upper(i) = x(i) - yt(i)*sin(theta(i));
    y_upper(i) = yc(i) + yt(i)*cos(theta(i));
end

% Lower Surface Points
x_lower = zeros(boundary_points,1);
y_lower = x_lower;
for i = 1:boundary_points
    x_lower(i) = x(i) + yt(i)*sin(theta(i));
    y_lower(i) = yc(i) - yt(i)*cos(theta(i));
end

plot_title = strcat("NACA ", type);

if export_af
    export_airfoil(x_upper, y_upper, x_lower, y_lower, plot_title);
end











