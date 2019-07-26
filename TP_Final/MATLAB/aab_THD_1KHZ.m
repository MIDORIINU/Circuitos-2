
THD=[0 0.000137 0.000231 0.000528 0.001996 0.001918 0.001970 0.002052 0.002162 0.002301 0.002349 0.002482 0.002758];

freq=[0 0.5 1 5 12 30 35 40 45 50 51.49 55 60 ];

%Close images.
close all;

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create area
area(freq,THD,'FaceColor',[0.678431391716003 0.921568632125854 1]);

% Create ylabel
ylabel('Distorsión armónica total (THD) [%]');

% Create xlabel
xlabel('Potencia de salida [W]');

% Create title
title('THD en función de la potencia de salida a 1 KHz');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 0.003]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0 5 10 15 20 25 30 35 40 45 50 55 60],'YGrid','on','YMinorTick','on',...
    'YTick',...
    [0 0.00025 0.0005 0.00075 0.001 0.00125 0.0015 0.00175 0.002 0.00225 0.0025 0.00275 0.003]);


axes1.YAxis.Exponent = 0;