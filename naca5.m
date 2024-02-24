function [x_upper, y_upper, x_lower, y_lower, plot_title] = naca5(type, boundary_points, export_af)

L = str2double(type(1))*3/20; % Camber Controller. It is the coefficent of lift times 3/20.
P = str2double(type(2))/20; % Position of Max Camber divided by 20
Q = str2double(type(3)); % 0: Normal Camber Line 1: Reflex Camber Line
XX = str2double(type(4:5)); % Maximum thickness as a percentage

% Thickness Constants

a0 = 0.2969;
a1 = -0.1260;
a2 = -0.3516;
a3 = 0.2843;
a4 = -0.1036; % Closed Trailing Edge
% a4 = -0.1015 % Open Trailing Edge

% Camber Constants

if Q == 0
    DATA = [10  0.058  361.1
            20  0.126  51.64
            30  0.2025 15.957
            40  0.29   6.643
            50  0.391  3.23];
else 
    DATA = [21  0.13  51.99  0.000764
            31  0.217 15.793 0.00677
            41  0.318 6.52   0.0303
            51  0.441 3.191  0.1355];
end

%% Airfoil Creation
NUMB = str2double(type(2:3));


r = interp1(DATA(:,1), DATA(:,2), NUMB);
k1 = interp1(DATA(:,1), DATA(:,3), NUMB) * (L/0.3);
if Q == 1
    k2k1 = interp1(DATA(:,1), DATA(:,4), NUMB);
end

% Airfoil Grid

 bet = linspace(0,pi,boundary_points);
 x_lower = 0.5*(1-cos(bet))';

% Camber and Gradient

yc = zeros(boundary_points,1);
dyc = yc;
theta = yc;

if Q == 0
    for i = 1:boundary_points
        if x_lower(i) >= 0 && x_lower(i) < r
            yc(i) = (k1/6)*(x_lower(i)^3 - 3*r*x_lower(i)^2 + (r^2)*(3-r)*x_lower(i));
            dyc(i) = (k1/6) * (3*x_lower(i)^2 - 6*r*x_lower(i) + (r^2)*(3-r));
        elseif x_lower(i) >= r && x_lower(i) <= 1
            yc(i) = (k1 * (r^3)/6) * (1-x_lower(i));
            dyc(i) = -k1*(r^3)/6;
        end
        theta(i) = atan(dyc(i));
    end
else
    for i = 1:boundary_points
        if x_lower(i) >= 0 && x_lower(i) < r
            yc(i) = (k1/6)*((x_lower(i)-r)^3 - k2k1*x_lower(i)*(1-r)^3 - x_lower(i)*r^3 + r^3);
            dyc(i) = (k1/6)*(3*(x_lower(i)-r)^2 - k2k1*(1-r)^3 - r^3);
        elseif x_lower(i) >= r && x_lower(i) <= 1
            yc(i) = (k1/6)*(k2k1*(x_lower(i)-r)^3 - k2k1*x_lower(i)*(1-r)^3 - x_lower(i)*r^3 + r^3);
            dyc(i) = (k1/6)*(3*k2k1*(x_lower(i)-r)^2 - k2k1*(1-r)^3 - r^3);
        end
        theta(i) = atan(dyc(i));
    end
end

% Thickness distribution

yt = zeros(boundary_points,1);
for i = 1:boundary_points
    term0 = a0*sqrt(x_lower(i));
    term1 = a1*x_lower(i);
    term2 = a2*x_lower(i)^2;
    term3 = a3*x_lower(i)^3;
    term4 = a4*x_lower(i)^4;
    T = XX/100;

    yt(i) = 5*T*(term0+term1+term2+term3+term4);
end

% Upper Surface Points
x_upper = zeros(boundary_points,1);
y_upper = x_upper;
for i = 1:boundary_points
    x_upper(i) = x_lower(i) - yt(i)*sin(theta(i));
    y_upper(i) = yc(i) + yt(i)*cos(theta(i));
end

% Lower Surface Points
xl = zeros(boundary_points,1);
y_lower = xl;
for i = 1:boundary_points
    xl(i) = x_lower(i) + yt(i)*sin(theta(i));
    y_lower(i) = yc(i) - yt(i)*cos(theta(i));
end

plot_title = strcat("NACA ", type);

if export_af
    export_airfoil(x_upper, y_upper, x_lower, y_lower, plot_title);
end

