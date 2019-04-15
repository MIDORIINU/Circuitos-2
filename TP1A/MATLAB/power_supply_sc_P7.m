function power_supply_sc_P7()

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData=importdata("../LTSPICE/power_supply_sc_P7.txt");

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
ylabel('Corriente de salida máxima de la fuente de alimentación (I_{out}) [A]');

% Create xlabel
xlabel('Resistencia de ajuste de corriente máxima (R_{18}) [\Omega]');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000 17000 18000],...
    'YGrid','on','YMinorTick','on','YTick',...
    [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2]);




