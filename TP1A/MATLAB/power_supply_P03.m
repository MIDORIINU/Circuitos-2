function power_supply_P03()

%Cierro las figuras existentes.
close all;

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData = importdata("../LTSPICE_AUX/SWITCH/OR-Q7-9-10-11.txt");

time = TableData.data(:,1);

Vin1 = TableData.data(:,2);

Vin2 = TableData.data(:,3);

Vout = TableData.data(:,4);


% Calculo el tamaño y la posición de la imagen.
pict_size = size_percent/100;
pict_pos = (1 - pict_size)/2;


% Create figure
% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(time, [Vin1 Vin2 Vout],'Parent',axes1);
set(plot1(1),'DisplayName','V_{in_{1}}','Color',[0 0 1]);
set(plot1(2),'DisplayName','V_{in_{2}}','Color',[0 1 0]);
set(plot1(3),'DisplayName','V_{out}','Color',[1 0 0]);

% Create ylabel
ylabel('Tensión de las entradas y la salida (V_{in_{1}}/V_{in_{2}}/V_{out}) [V]');

% Create xlabel
xlabel('Tiempo [s]');

% Create title
title('Tensión en las entradas y la salida de la llave');


box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0.0025 0.00275 0.003 0.00325 0.0035 0.00375 0.004 0.00425 0.0045 0.00475 0.005 0.00525 0.0055 0.00575 0.006 0.00625 0.0065],...
    'YGrid','on','YMinorTick','on','YTick',...
    [-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5]);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.654293836089225 0.118401700308239 0.123072073928711 0.18317452669673]);

xlim(axes1,[0.0025 0.0065]);
ylim(axes1,[-0.5 1.5]);



