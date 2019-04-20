function power_supply_P20()

%Cierro las figuras existentes.
close all;

%Tamaño de la figura.
size_percent = 80;

%Cargo los datos
%%TableData = importdata("../LTSPICE/power_supply_P13.txt");

%Cargo los datos
TableData = importdata("../LTSPICE/power_supply_P20.txt");

time = TableData.data(:,1);

Vin = TableData.data(:,2);

Vout = TableData.data(:,3);


Vin_min = min(Vin);

Vin_ripple = Vin - Vin_min;

Vout_min = min(Vout);

Vout_ripple = Vout - Vout_min;

% rms(Vin_ripple)
% sqrt(mean((Vin_ripple.^2)))
% rms(Vout_ripple)
% sqrt(mean((Vout_ripple.^2)))

% 
% min(Vin_ripple)
% max(Vin_ripple)
% 
% min(Vout)

Ripple_rejection_db1 = -20*log10(...
    rms(Vout_ripple(round(size(Vout_ripple)/5):end)) / ...
    sqrt(rms(Vin_ripple(round(size(size(Vin_ripple)/5):end)))));


measure_index_max = 818;
measure_index_min = 820;

Vout_peak = Vout_ripple(measure_index_max) - Vout_ripple(measure_index_min);
Vin_peak = Vin_ripple(measure_index_max) - Vin_ripple(measure_index_min);





Ripple_rejection_db2 = -20*log10(Vout_peak/Vin_peak);


fprintf("La relación de rechazo de ripple calculada con valores rms es de: %.2f dB\n", ...
    Ripple_rejection_db1);


fprintf("La relación de rechazo de ripple calculada con valores pico es de: %.2f dB\n", ...
    Ripple_rejection_db2);


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
plot1 = plot(time, Vin_ripple, 'Parent', subplot1, 'Color', [1 0 0]);


% Create ylabel
ylabel('Ripple en la tensión de entrada (V_{in} - Avg(V_{in})) [V]');

% Create xlabel
xlabel('Tiempo [s]');

% Create title
title('Ripples de entrada y salida');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'XGrid','on','XMinorTick','on','XTick',...
    [0.01934 0.02184 0.02434 0.02684 0.02934 0.03184 0.03434 0.03684 0.03934 0.04151],...
    'YGrid','on','YMinorTick','on','YTick',...
    [-0.5 -0.25 0 0.25 0.5 0.75 1 1.25 1.5 1.75 2 2.25 2.5]);

xlim(subplot1,'manual');
xlim(subplot1,[0.01934 0.04151]);

ylim(subplot1,'manual');
ylim(subplot1, [-0.5 2.5]);


% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure1);

plot2 = plot(time, Vout_ripple, 'Parent', subplot2, 'Color', [0 0 1]);


% Create ylabel
ylabel('Ripple en la tensión de salida (V_{out} - Avg(V_{out})) [V]');

% Create xlabel
xlabel('Tiempo [s]');


box(subplot2,'on');
% Set the remaining axes properties
set(subplot2,'XGrid','on','XMinorTick','on','XTick',...
    [0.01934 0.02184 0.02434 0.02684 0.02934 0.03184 0.03434 0.03684 0.03934 0.04151],...
    'YGrid','on','YMinorTick','on','YTick',...
    [-0.0005 -0.00025 0 0.00025 0.0005 0.00075 0.001 0.00125 0.0015 0.00175 0.002 0.00225 0.0025]);

xlim(subplot2,'manual');
xlim(subplot2,[0.01934 0.04151]);

ylim(subplot2,'manual');
ylim(subplot2, [-5E-4 25E-4]);


%Agrego datatips customizados.

dcm_obj = datacursormode(figure1);

customtitles = {''};
customtitlesindexes = 0;

hdtip(measure_index_max) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(measure_index_max), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [time(measure_index_max) , Vin_ripple(measure_index_max) , 1];
              
set(hdtip(measure_index_max), 'Position', YValue, 'Orientation','topright')

% customtitles{end + 1} = '*** Resistencia de salida (frec ~= 0) ***';
% 
% customtitlesindexes = [customtitlesindexes, min_index];
                    

% %%%%%

hdtip(measure_index_max) = dcm_obj.createDatatip(handle(plot2));

set(hdtip(measure_index_max), 'MarkerSize',5, 'MarkerFaceColor','none', ...
                  'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
              
YValue = [time(measure_index_max) , Vout_ripple(measure_index_max) , 1];
              
set(hdtip(measure_index_max), 'Position', YValue, 'Orientation','topright')

% customtitles{end + 1} = '*** Resistencia de salida (frec ~= 0) ***';
% 
% customtitlesindexes = [customtitlesindexes, min_index];
                    

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
        
    output_txt = {sprintf('%s\nVoltage: %.4E V\nTime:      %.4E s', ...
        customtitles{idx_f}, pos(2), pos(1))};



    

