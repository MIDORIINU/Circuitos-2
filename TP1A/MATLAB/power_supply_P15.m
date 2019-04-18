function power_supply_P15()

%Cierro las figuras existentes.
close all;

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData=importdata("../LTSPICE/power_supply_P15.txt");

X1 = TableData.data(:,3);

X2 = TableData.data(:,1);

Y1 = TableData.data(:,2);


% Calculo el tamaño y la posición de la imagen.
pict_size = size_percent/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(X1,Y1);

% Create ylabel
ylabel('Tensión de salida de la fuente de alimentación (V_{out}) [V]');

% Create xlabel
xlabel('Corriente de salida de la fuente de alimentación (I_{out}) [A]');

% Create title
title('Tensión de salida de la fuente de alimentación en función de la corriente de salida (R_{9} = 10K\Omega, R_{18} = 0\Omega)');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 2.1]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 2.1]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1],...
    'YGrid','on','YMinorTick','on','YTick',...
    [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2]);

xlim(axes1,'manual');
xlim([0 2.1]);

ylim(axes1,'manual');
ylim( [0 2.1]);


