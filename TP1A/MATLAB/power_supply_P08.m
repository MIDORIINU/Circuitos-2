function power_supply_P08()

%Cierro las figuras existentes.
close all;

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
TableData=importdata("../LTSPICE/power_supply_P08.txt");

RL = TableData.data(:,1);

V_current_feedback = TableData.data(:,2);

V_voltage_feedback = TableData.data(:,3);

V_out = TableData.data(:,4);

% I_out = TableData.data(:,5);


% Calculo el tamaño y la posición de la imagen.
pict_size = size_percent/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);




% Create axes
axes1 = axes('Parent', figure1);
hold(axes1, 'on');

% Create subplot
subplot1 = subplot(2, 1, 1, 'Parent', figure1);
hold(subplot1, 'on');


% Create plot
plot1a = plot(RL, V_current_feedback, 'Parent', subplot1);

plot1b = plot(RL, V_voltage_feedback, 'Parent', subplot1);


% Create ylabel
ylabel('T. switch analog. (V_{current\_FB} \\ V_{voltage\_FB}) [V]');

% Create xlabel
xlabel('Resistencia de carga (R_{L}) [\Omega]');

% Create title
title('Tensiones de entrada del switch analógico en función de la resistencia de carga (R_{9} = 90K\Omega, R_{18} = 0\Omega, R_{L} : 100 \Omega \rightarrow 0 \Omega)');

box(subplot1, 'on');
% Set the remaining axes properties
set(subplot1,'XDir','reverse','XGrid','on','XMinorTick','on','XTick',...
    [-5 0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100],...
    'XTickLabel',...
    {'','0','5','10','15','20','25','30','35','40','45','50','55','60','65','70','75','80','85','90','95','100'},...
    'YGrid','on','YMinorTick','on','YTick',...
    [0 0.15 0.3 0.45 0.6 0.75 0.9 1.05 1.2]);
% Create legend
legend1 = legend(subplot1, 'show', {'V_{current\_FB}' 'V_{voltage\_FB}'});
set(legend1,...
    'Position', [0.176429569217241 0.723509933774835 0.131101811535896 0.0817849517627549]);



xlim(subplot1, 'manual');
xlim([-5 100]);

ylim(subplot1, 'manual');
ylim( [0 1.2]);




% %%% Second subplot

% Create axes
axes2 = axes('Parent', figure1);
hold(axes2, 'on');

% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure1);
hold(subplot2, 'on');


% Create plot
plot2 = plot(RL, V_out, 'Parent', subplot2);

% Create ylabel
ylabel('Tensión de salida de la fuente de alimentación (V_{out}) [V]');

% Create xlabel
xlabel('Resistencia de carga (R_{L}) [\Omega]');

% Create title
title('Tensión de salida de la fuente de alimentación en función de la resistencia de carga (R_{9} = 90K\Omega, R_{18} = 0\Omega, R_{L} : 100 \Omega \rightarrow 0 \Omega)');

box(subplot2, 'on');
% Set the remaining axes properties
set(subplot2,'XDir','reverse','XGrid','on','XMinorTick','on','XTick',...
    [-5 0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100],...
    'XTickLabel',...
    {'','0','5','10','15','20','25','30','35','40','45','50','55','60','65','70','75','80','85','90','95','100'},...
    'YGrid','on','YMinorTick','on','YTick',[0 1 2 3 4 5 6 7 8 9 10 11]);

xlim(subplot2, 'manual');
xlim([-5 100]);

ylim(subplot2, 'manual');
ylim( [0 11]);


% Find the intersection
f_current_FB = griddedInterpolant(RL, V_current_feedback);
f_voltage_FB = griddedInterpolant(RL, V_voltage_feedback);

intersect_value = fzero(@(x)f_current_FB(x)-f_voltage_FB(x), [0 RL(end)]);


%Agrego datatips customizados.

dcm_obj = datacursormode(figure1);

customtitles = {''};
customtitlesindexes = 1;

[~, intersect_index] = min(abs(RL - intersect_value));


hdtip(intersect_index) = dcm_obj.createDatatip(handle(plot1a));

set(hdtip(intersect_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [RL(intersect_index) , V_current_feedback(intersect_index) , 1];
              
set(hdtip(intersect_index), 'Position', YValue, 'Orientation','bottomright')

customtitles{end + 1} = '*** Valor de transición para RL ***';

customtitlesindexes = [customtitlesindexes, intersect_index];



set(dcm_obj, 'UpdateFcn', {@customDatatipFunction, customtitles, ...
    customtitlesindexes})

updateDataCursors(dcm_obj);
            
           
hdtip(intersect_index) = dcm_obj.createDatatip(handle(plot2));

set(hdtip(intersect_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [RL(intersect_index) , V_out(intersect_index) , 1];
              
set(hdtip(intersect_index), 'Position', YValue, 'Orientation','topright')

customtitles{end + 1} = '*** Valor de transición para RL ***';

customtitlesindexes = [customtitlesindexes, intersect_index];



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
    
    output_txt = {sprintf('%s\nRL:           %.2f Ohm\nTensión:%.2f V', ...
        customtitles{idx_f}, pos(1), pos(2))};
            
        
    
 


