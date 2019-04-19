function power_supply_P07()

%Cierro las figuras existentes.
close all;

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData=importdata("../LTSPICE/power_supply_P07.txt");

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
ylabel('Corriente de salida máxima de la fuente de alimentación (I_{out}) [A]');

% Create xlabel
xlabel('Resistencia de ajuste de corriente máxima (R_{18}) [\Omega]');

% Create title
title('Corriente de salida de la fuente de alimentación en función de R_{18} (R_{9} = 10 K\Omega , R_{18} : 0 \Omega \rightarrow 18K\Omega, R_{L} = 0 \Omega)');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000 17000 18000],...
    'YGrid','on','YMinorTick','on','YTick',...
    [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3 2.4 2.5]);

xlim(axes1,'manual');
xlim([0 1.8E4]);

ylim(axes1,'manual');
ylim( [0 2.2]);


%Agrego datatips customizados.

dcm_obj = datacursormode(figure1);

customtitles = {''};
customtitlesindexes = 0;


min_index = 1;

hdtip(min_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(min_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(min_index) , Y1(min_index) , 1];
              
set(hdtip(min_index), 'Position', YValue, 'Orientation','topright')

customtitles{end + 1} = '*** Máxima corriente de salida ***';

customtitlesindexes = [customtitlesindexes, min_index];
                    


[max_index, ~] = size(X1);

hdtip(max_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(max_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(max_index) , Y1(max_index) , 1];
              
set(hdtip(max_index), 'Position', YValue, 'Orientation','bottomleft')


customtitles{end + 1} = '*** Mínima corriente de salida ***';

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
        
    output_txt = {sprintf('%s\nR18:    %.2f Ohms\nSalida: %.2f A', ...
        customtitles{idx_f}, pos(1), pos(2))};





