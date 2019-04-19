function power_supply_P13()

%Cierro las figuras existentes.
close all;

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
%%TableData = importdata("../LTSPICE/power_supply_P13.txt");

fileID = fopen("../LTSPICE/power_supply_P13.txt");
%%C_text = textscan(fileID, '%s', 1);
TableData = textscan(fileID,'%f %f,%f', 'HeaderLines', 1);
fclose(fileID); 

X1 = TableData{1};

Y1 = complex(TableData{2}, TableData{3});

% Calculo el tamaño y la posición de la imagen.
pict_size = size_percent/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);

% Create subplot
subplot1 = subplot(2, 1, 1, 'Parent', figure1);
hold(subplot1,'on');

% Create plot
plot1 = semilogx(X1, abs(Y1), 'Parent', subplot1, 'Color', [1 0 0]);


% Create ylabel
ylabel('Módulo de la impedancia (|Z_{out}|) [\Omega]');

% Create xlabel
xlabel('Frecuencia [Hz]');

% Create title
title('Impedancia en el nodo de salida de la fuente de alimentación (R_{9} : 10 K\Omega, R_{18} = 0 \Omega, R_{L} = 100 \Omega)');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'XGrid','on','XMinorTick','on','XScale','log','YGrid','on',...
    'YMinorTick','on','YTick',...
    [0 0.04 0.08 0.12 0.16 0.2 0.24 0.28 0.32 0.36 0.4 0.44 0.48 0.52 0.56 0.6]);

xlim(subplot1,'manual');
xlim(subplot1,[0.1 200000]);

ylim(subplot1,'manual');
ylim(subplot1, [0 0.6]);

% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure1);

plot2 = semilogx(X1, rad2deg(angle(Y1)), 'Parent', subplot2, 'Color', [0 0 1]);


% Create ylabel
ylabel('Fase de la impedancia (\angle Z_{out}) [º]');

% Create xlabel
xlabel('Frecuencia [Hz]');

box(subplot2,'on');
% Set the remaining axes properties
set(subplot2,'XGrid','on','XMinorTick','on','XScale','log','YGrid','on',...
    'YMinorTick','on','YTick',...
    [0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150]);

xlim(subplot2,'manual');
xlim(subplot2,[0.1 200000]);

ylim(subplot2,'manual');
ylim(subplot2, [0 150]);


%Agrego datatips customizados.

dcm_obj = datacursormode(figure1);

customtitles = {''};
customtitlesindexes = 0;


min_index = 1;

hdtip(min_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(min_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(min_index) , abs(Y1(min_index)) , 1];
              
set(hdtip(min_index), 'Position', YValue, 'Orientation','topright')

customtitles{end + 1} = '*** Resistencia de salida (frec ~= 0) ***';

customtitlesindexes = [customtitlesindexes, min_index];
                    

% %%%%%

hdtip(min_index) = dcm_obj.createDatatip(handle(plot2));

set(hdtip(min_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(min_index) , angle(Y1(min_index)) , 1];
              
set(hdtip(min_index), 'Position', YValue, 'Orientation','topright')

customtitles{end + 1} = '*** Resistencia de salida (frec ~= 0) ***';

customtitlesindexes = [customtitlesindexes, min_index];
                    

set(dcm_obj, 'UpdateFcn', {@customDatatipFunction1, customtitles, ...
    customtitlesindexes, X1, Y1})

updateDataCursors(dcm_obj);


function output_txt = customDatatipFunction1(~, evt, customtitles, ...
    customtitlesindexes, X1, Y1)
    
    idx = get(evt,'DataIndex');
    
    idx_f = find(customtitlesindexes == idx, 1);
    
    if (isempty(idx_f))
        idx_f = 1;
    end
        
    output_txt = {sprintf('%s\nFrec:      %.2f Hz\n|Z|:         %.2E Ohms\n ang(Z): %.2f º', ...
        customtitles{idx_f}, X1(idx), abs(Y1(idx)), rad2deg(angle(Y1(idx))))};



    

