function power_supply_P21_P16()

%Cierro las figuras existentes.
close all;

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData = importdata("../LTSPICE/power_supply_P21-P16.txt");

time = TableData.data(:,1);

Vout = TableData.data(:,2);

Iout = TableData.data(:,3);

% Calculo el tamaño y la posición de la imagen.
pict_size = size_percent/100;
pict_pos = (1 - pict_size)/2;


measure_index_1 = 2;
measure_index_2 = 150;


Vout1 = Vout(measure_index_1);
Vout2 = Vout(measure_index_2);

Iout1 = Iout(measure_index_1);
Iout2 = Iout(measure_index_2);


Ro = (Vout1 - Vout2)/(Iout2 - Iout1);

fprintf("El salto de tensión es de %.4E V.\n", (Vout1 - Vout2));

fprintf("El salto de corriente es de %.4E A.\n", (Iout2 - Iout1));

fprintf("La resistencia de salida estimada es de %.4f uOhms.\n", Ro*1E6);



% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);

% Create subplot
subplot1 = subplot(2, 1, 1, 'Parent', figure1);
hold(subplot1,'on');

% Create plot
plot1 = plot(time, Vout, 'Parent', subplot1, 'Color', [1 0 0]);


% Create ylabel
ylabel('Tensión de salida (V_{in}) [V]');

% Create xlabel
xlabel('Tiempo [s]');

% Create title
title('Tensión de salida durante los saltos en la carga, en 20ms y 50ms');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'XGrid','on','XMinorTick','on','XTick',...
    [0.0199995 0.02 0.0200005 0.020001 0.0200015 0.020002 0.0200025 0.020003 0.0200035 0.020004 0.0200045 0.020005],...
    'YGrid','on','YMinorTick','on','YTick',...
    [1.4 1.45 1.5 1.55 1.6 1.65 1.7 1.75 1.8 1.85 1.9 1.95 2 2.05 2.1 2.15 2.2 2.25 2.3]);

ax = gca;
ax.XAxis.Exponent = -3;

xlim(subplot1,'manual');
xlim(subplot1,[0.0199995 0.020005]);

ylim(subplot1,'manual');
ylim(subplot1,[1.4 2.3]);

% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure1);

plot2 = plot(time, Vout, 'Parent', subplot2, 'Color', [1 0 0]);


% Create ylabel
ylabel('Tensión de salida (V_{in}) [V]');

% Create xlabel
xlabel('Tiempo [s]');


box(subplot2,'on');
% Set the remaining axes properties
set(subplot2,'XGrid','on','XMinorTick','on','XTick',...
    [0.0498 0.0499 0.05 0.0501 0.0502 0.0503 0.0504 0.0505 0.0506 0.0507 0.0508 0.0509 0.051 0.0511 0.0512 0.0513 0.0514 0.0515 0.0516 0.0517 0.0518 0.0519 0.052],...
    'YGrid','on','YMinorTick','on','YTick',...
    [1.8 1.9 2 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3 3.1 3.2]);

ax = gca;
ax.XAxis.Exponent = -3;

xlim(subplot2,'manual');
xlim(subplot2,[0.0498 0.052]);

ylim(subplot2,'manual');
ylim(subplot2,[1.8 3.2]);



% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure2 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);

% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');

% Create plot
plot3 = plot(time, Vout, 'Parent', axes2, 'Color', [1 0 0]);

% Create ylabel
ylabel('Tensión de salida (V_{in}) [V]');

% Create xlabel
xlabel('Tiempo [s]');

% Create title
title('Variación de la tensión de salida luego de un salto en la carga');

box(axes2,'on');
% Set the remaining axes properties
set(axes2,'XGrid','on','XMinorTick','on','XTick',...
    (0.010:0.005: 0.055),...
    'YGrid','on','YMinorTick','on','YTick',...
    [1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3 2.4 2.5 2.6 2.7 2.8 2.9 3 3.1]);

ax = gca;
ax.XAxis.Exponent = -3;

xlim(axes2,'manual');
xlim(axes2,[0.010 0.055]);

ylim(axes2,'manual');
ylim(axes2,[1.4 3.1]);



%Agrego datatips customizados.

dcm_obj = datacursormode(figure2);

customtitles = {''};
customtitlesindexes = 0;

hdtip(measure_index_1) = dcm_obj.createDatatip(handle(plot3));

set(hdtip(measure_index_1), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [time(measure_index_1) , Vout(measure_index_1) , 1];
              
set(hdtip(measure_index_1), 'Position', YValue, 'Orientation','topright')
                   

% %%%%%

hdtip(measure_index_2) = dcm_obj.createDatatip(handle(plot3));

set(hdtip(measure_index_2), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [time(measure_index_2) , Vout(measure_index_2) , 1];
              
set(hdtip(measure_index_2), 'Position', YValue, 'Orientation','topright')



set(dcm_obj, 'UpdateFcn', {@customDatatipFunction, customtitles, ...
    customtitlesindexes})

updateDataCursors(dcm_obj);


function output_txt = customDatatipFunction(~,evt, customtitles, ...
    customtitlesindexes)
    pos = get(evt,'Position');
    idx = get(evt,'DataIndex');
    
    idx_f = find(customtitlesindexes == idx, 1);
    
    if (isempty(idx_f))
        idx_f = 1;
    end
        
    output_txt = {sprintf('%s\nVoltage: %.5f V\nTime:      %.4G s', ...
        customtitles{idx_f}, pos(2), pos(1))};



    

