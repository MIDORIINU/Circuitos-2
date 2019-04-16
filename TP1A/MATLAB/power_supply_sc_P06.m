function power_supply_sc_P06()

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData=importdata("../LTSPICE/power_supply_sc_P06.txt");

X1=TableData.data(:,1);

Y1=TableData.data(:,2);

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
xlabel('Resistencia de ajuste de tensión (R_{9}) [\Omega]');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0 4000 8000 12000 16000 20000 24000 28000 32000 36000 40000 44000 48000 52000 56000 60000 64000 68000 72000 76000 80000 84000 88000 90000],...
    'YGrid','on','YMinorTick','on','YTick',...
    [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]);




