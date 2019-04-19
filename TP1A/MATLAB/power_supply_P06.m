function power_supply_P06()

%Cierro las figuras existentes.
close all;

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData = importdata("../LTSPICE/power_supply_P06.txt");

X1 = TableData.data(:,1);

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
plot1 = plot(X1,Y1);

% Create ylabel
ylabel('Tensión de salida de la fuente de alimentación (V_{out}) [V]');

% Create xlabel
xlabel('Resistencia de ajuste de tensión (R_{9}) [\Omega]');

% Create title
title('Tensión de salida de la fuente de alimentación en función de R_{9} (R_{9} : 0 \Omega \rightarrow 90K\Omega, R_{18} = 0 \Omega, R_{L} = 1 M\Omega)');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0 4000 8000 12000 16000 20000 24000 28000 32000 36000 40000 44000 48000 52000 56000 60000 64000 68000 72000 76000 80000 84000 88000 90000],...
    'YGrid','on','YMinorTick','on','YTick',...
    [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11]);

xlim(axes1,'manual');
xlim([0 9E4]);

ylim(axes1,'manual');
ylim( [0 11]);


%Agrego datatips customizados.

dcm_obj = datacursormode(figure1);

customtitles = {''};
customtitlesindexes = 0;


min_index = 1;

hdtip(min_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(min_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(min_index) , Y1(min_index) , 1];
              
set(hdtip(min_index), 'Position', YValue, 'Orientation','bottomright')

customtitles{end + 1} = '*** Mínima tensión de salida ***';

customtitlesindexes = [customtitlesindexes, min_index];
                    


[max_index, ~] = size(X1);

hdtip(max_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(max_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(max_index) , Y1(max_index) , 1];
              
set(hdtip(max_index), 'Position', YValue, 'Orientation','topleft')


customtitles{end + 1} = '*** Máxima tensión de salida ***';

customtitlesindexes = [customtitlesindexes, max_index];



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
        
    output_txt = {sprintf('%s\nR9:      %.2f Ohms\nSalida: %.2f V', ...
        customtitles{idx_f}, pos(1), pos(2))};



