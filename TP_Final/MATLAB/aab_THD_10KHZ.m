
THD=[0 0.001095 0.001967 0.004481 0.005093 0.005119 0.005190 0.005258 0.005379 0.005541 0.005600 0.005787 0.006296];

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
title('THD en función de la potencia de salida a 10 KHz');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 0.003]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0 5 10 15 20 25 30 35 40 45 50 55 60],'YGrid','on','YMinorTick','on',...
    'YTick',...
    [0 0.00025 0.0005 0.00075 0.001 0.00125 0.0015 0.00175 0.002 0.00225 0.0025 0.00275 0.003 0.00325 0.0035 0.00375 0.004 0.00425 0.0045 0.00475 0.005 0.00525 0.0055 0.00575 0.006 0.00625 0.0065 0.00675 0.007]);


axes1.YAxis.Exponent = 0;