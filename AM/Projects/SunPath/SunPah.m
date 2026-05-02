% Coordenadas Geogr\'e1ficas de Sagres\
lat = deg2rad(37.0097);\
lon = deg2rad(-8.9408);\
\
% Malha (Meshgrid) para o Toro (Dias vs Minutos)\
d = 1:5:365;      % Amostragem a cada 5 dias para clareza\
m = 0:30:1410;    % Amostragem a cada 30 minutos\
[D, M] = meshgrid(d, m);\
\
% 1. Aproxima\'e7\'e3o Alta: Equa\'e7\'e3o do Tempo (E em minutos)\
B = (360/365) * (D - 81);\
E = 9.87*sin(deg2rad(2*B)) - 7.53*cos(deg2rad(B)) - 1.5*sin(deg2rad(B));\
\
% 2. Declina\'e7\'e3o (delta)\
delta = deg2rad(23.45 * sin(deg2rad((360/365)*(284 + D))));\
\
% 3. Tempo Solar e Angulo Horario (xomega)\
solar_time = (M/60) + (E/60); \
omega = deg2rad(15 * (solar_time - 12));\
\
% 4. C\'e1lculo da Altitude (alpha)\
sin_alpha = sin(lat)*sin(delta) + cos(lat)*cos(delta).*cos(omega);\
alpha = asin(sin_alpha);\
alpha(alpha < 0) = 0; % Noite: define altitude como 0\
\
% 5. Visualiza\'e7\'e3o no Toro\
R = 10; r = 4;\
theta = (D/365) * 2 * pi;\
phi = (M/1440) * 2 * pi;\
X = (R + r*cos(phi)) .* cos(theta);\
Y = (R + r*cos(phi)) .* sin(theta);\
Z = r * sin(phi);\
\
surf(X, Y, Z, rad2deg(alpha));\
shading interp; colorbar;\
title('Campo de Altitude Solar num Toro Discretizado');}