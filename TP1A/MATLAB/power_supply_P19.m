function power_supply_P19()

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData = importdata("../LTSPICE/power_supply_P19.txt");

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
plot1=plot(X1,Y1);

% Create ylabel
ylabel('Corriente de salida de la fuente de alimentación (I_{out}) [A]');

% Create xlabel
xlabel('Tensión de entrada de la fuente de alimentación (V_{in}) [V]');

% Create title
title('Corriente de salida de la fuente en función de la tensión de entrada (salida en cortocircuito)');

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30],...
    'YGrid','on','YMinorTick','on','YTick',...
    [-2 -1.5 -1 -0.5 0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 10.5 11 11.5 12],...
    'YTickLabel',...
    {'-2','-1.5','-1','-0.5','0','0.5','1','1.5','2','2.5','3','3.5','4','4.5','5','5.5','6','6.5','7','7.5','8','8.5','9','9.5','10','10.5','11','11.5','12'});

xlim(axes1,'manual');
xlim([0 30]);

ylim(axes1,'manual');
ylim( [-0.5 3.5]);

%Agrego datatips customizados.

dcm_obj = datacursormode(figure1);

customtitles = {};
customtitlesindexes = [];

indexesX =  find(X1 >= 5);

indexesY = find(Y1 > (99/100)*2.048);

knee_index = indexesY(find(indexesY >= indexesX(1), 1));

hdtip(knee_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(knee_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(knee_index) , Y1(knee_index) , 1];
              
set(hdtip(knee_index), 'Position', YValue, 'Orientation','topleft')

customtitles{end + 1} = '*** Comienzo de la regulación de corriente ***';

customtitlesindexes = [customtitlesindexes, knee_index];
                    


[~,max_index] = max(Y1);

hdtip(max_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(max_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(max_index) , Y1(max_index) , 1];
              
set(hdtip(max_index), 'Position', YValue, 'Orientation','topright')


customtitles{end + 1} = '*** Limitación de corriente por Q15 ***';

customtitlesindexes = [customtitlesindexes, max_index];



set(dcm_obj, 'UpdateFcn', {@customDatatipFunction, customtitles, ...
    customtitlesindexes})

updateDataCursors(dcm_obj);




function output_txt = customDatatipFunction(~,evt, customtitles, ...
    customtitlesindexes)
    pos = get(evt,'Position');
    idx = get(evt,'DataIndex');
    
    idx_f = find(customtitlesindexes == idx, 1);
    
    
    output_txt = {sprintf('%s\nEntrada: %.2f V\nSalida: %.2f A', ...
        customtitles{idx_f}, pos(1), pos(2))};



