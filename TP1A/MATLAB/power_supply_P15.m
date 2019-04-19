function power_supply_P15()

%Cierro las figuras existentes.
close all;

%Tama�o de la figura.
size_percent = 80;

%Cargo los datos
TableData=importdata("../LTSPICE/power_supply_P15.txt");

X1 = TableData.data(:,3);

Y1 = TableData.data(:,2);


% Calculo el tama�o y la posici�n de la imagen.
pict_size = size_percent/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tama�o de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot1 = plot(X1,Y1);

% Create ylabel
ylabel('Tensi�n de salida de la fuente de alimentaci�n (V_{out}) [V]');

% Create xlabel
xlabel('Corriente de salida de la fuente de alimentaci�n (I_{out}) [A]');

% Create title
title('Tensi�n de salida de la fuente de alimentaci�n en funci�n de la corriente de salida (R_{9} = 10K\Omega, R_{18} = 0\Omega, R_{L} : 100 \Omega \rightarrow 0 \Omega)');

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


%Agrego datatips customizados.

dcm_obj = datacursormode(figure1);

customtitles = {''};
customtitlesindexes = 1;

voltage_index = find( Y1 >= 2.028, 1);

hdtip(voltage_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(voltage_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(voltage_index) , Y1(voltage_index) , 1];
              
set(hdtip(voltage_index), 'Position', YValue, 'Orientation','bottomright')

customtitles{end + 1} = '*** En regulaci�n de tensi�n ***';

customtitlesindexes = [customtitlesindexes, voltage_index];


current_indexes = find( X1 >= 2.045);

voltage_indexes =  find(Y1 >= 1);

current_index = current_indexes(...
    find(current_indexes >= voltage_indexes(1), 1));

hdtip(current_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(current_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [X1(current_index) , Y1(current_index) , 1];
              
set(hdtip(current_index), 'Position', YValue, 'Orientation','bottomleft')

customtitles{end + 1} = '*** En regulaci�n de corriente ***';

customtitlesindexes = [customtitlesindexes, current_index];


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
    
    output_txt = {sprintf('%s\nCorriente: %.2f A\nTensi�n:   %.2f V', ...
        customtitles{idx_f}, pos(1), pos(2))};
    
    
 


