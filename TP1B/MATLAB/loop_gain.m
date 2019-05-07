function [figure_handle] = loop_gain(close_figures, file_name, ...
    fig_title, size_percent, fig_color_order, ...
    prealocate_array_size, prealocate_array_count, ...
    mod_limits, mod_ticks, ...
    phase_limits, phase_ticks, legends)

if close_figures
    %Cierro las figuras existentes.
    close all;
end

%Tamaño de la figura.
% size_percent = 80;


%Cargo los datos
[Data_raw, DataCount] = load_parametric_bode_data(...
    file_name,...
    prealocate_array_size, prealocate_array_count);

% Calculo el tamaño y la posición de la imagen.
pict_size = size_percent/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure_handle = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);

% Create subplot
subplot1 = subplot(2, 1, 1, 'Parent', figure_handle);
hold(subplot1,'on');

% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure_handle);
hold(subplot2,'on');

% Create ylabel
ylabel(subplot1, 'Módulo de la ganancia de lazo');

% Create xlabel
xlabel(subplot1, 'Frecuencia [Hz]');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'XGrid','on','XMinorTick','on','XScale','log','YGrid','on',...
    'YMinorTick','on','ColorOrder', fig_color_order, 'YTick', ...
    mod_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot1,'manual');
ylim(subplot1, mod_limits);


% Create ylabel
ylabel(subplot2, 'Fase de la ganancia de lazo [º]');

% Create xlabel
xlabel(subplot2, 'Frecuencia [Hz]');

box(subplot2,'on');
% Set the remaining axes properties
set(subplot2,'XGrid','on','XMinorTick','on','XScale','log','YGrid','on',...
    'YMinorTick','on','ColorOrder', fig_color_order, 'YTick',phase_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot2,'manual');
ylim(subplot2, phase_limits);


% Create title
title(subplot1, fig_title);



time_index = 1;
module_index = 2;
phase_index = 3;

[sz1, sz2, sz3] = size(Data_raw);

Data = zeros(sz1, sz2 + 1, sz3);

PM_indexes = zeros(sz3);
GM_indexes = zeros(sz3);

module_plots = zeros(sz3);
phase_plots = zeros(sz3);

for idx = (1: DataCount)
    
    Data(:, time_index, idx) = ...
        Data_raw(:, 1, idx); % Time.
    
    Data(:, module_index, idx) = ...
        abs(Data_raw(:, 2, idx)); % Module.
    
    Data(:, phase_index, idx) = ...
        unwrap(angle(Data_raw(:, 2, idx))); % Phase (radians).
    
    
    [PM_index, GM_index] = find_margins(...
        Data(:, module_index, idx), Data(:, phase_index, idx));
    
    PM_indexes(idx) = PM_index;
    
    GM_indexes(idx) = GM_index;
    
    % Create plot
    module_plot = semilogx(Data(:, time_index, idx), ...
        mag2db(Data(:, module_index, idx)), 'Parent', subplot1);
    
    module_plots(idx) = module_plot;
    
    % Create plot
    phase_plot = semilogx(Data(:, time_index, idx), ...
        rad2deg(Data(:, phase_index, idx)), 'Parent', subplot2);
    
    phase_plots(idx) = phase_plot;
    
end


legend(subplot1, 'show', legends);

legend(subplot2, 'show', legends);

% , 'Location','best'


%Agrego datatips customizados.


dcm_obj = datacursormode(figure_handle);

customtitles = cell(DataCount + 1);
customtitlesindexes = zeros(DataCount);

for idx = (1: DataCount)   
    
    
    hdtip(PM_indexes(idx)) = dcm_obj.createDatatip(handle(phase_plots(idx)));
    
    set(hdtip(PM_indexes(idx)), 'MarkerSize',5, 'MarkerFaceColor','none', ...
        'MarkerEdgeColor',fig_color_order(idx,:), 'Marker','o', 'HitTest','off');
    
    YValue = [Data(PM_indexes(idx), time_index, 1) , ...
        rad2deg(Data(PM_indexes(idx), phase_index, 1)) , 1];
    
    set(hdtip(PM_indexes(idx)), 'Position', YValue, ...
        'Orientation','topright');
    
       
    customtitles{idx + 1} = '*** Margen ***';
    
    customtitlesindexes(idx) = PM_indexes(idx);
    
    
    % %%%%%
    
    
end




set(dcm_obj, 'UpdateFcn', {@customDatatipFunction1, customtitles, ...
    customtitlesindexes, ...
    Data(:, time_index, 1), Data(:, module_index, 1), ...
    Data(:, phase_index, 1)})

updateDataCursors(dcm_obj);

drawnow;


function output_txt = customDatatipFunction1(~, evt, customtitles, ...
    customtitlesindexes, time, module, phase_angle ...
    )

idx = get(evt,'DataIndex');

idx_f = find(customtitlesindexes == idx, 1);

if (isempty(idx_f))
    idx_f = 1;
end

output_txt = {sprintf(strjoin(...
    {'%s\nFrec:      ',...
    '%.2f Hz\n|a.f|:         ',...
    '%.4f dB\n ang(a.f): %.4f º'}), ...
    customtitles{idx_f}, time(idx), ...
    mag2db(module(idx)), ...
    rad2deg(phase_angle(idx)))};





