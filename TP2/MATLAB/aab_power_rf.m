function [figure_handle] = aab_power_rf(file_name, ...
    fig_title, size_percent, fig_colors, ...
    mod_limits, mod_ticks, ...
    phase_limits, phase_ticks)

%Cargo los datos
fileID = fopen(file_name);
TableData = textscan(fileID,'%f %f,%f', 'HeaderLines', 1);
fclose(fileID);

freq = TableData{1};

complex_response = complex(TableData{2}, TableData{3});

% Calculo el tamaño y la posición de la imagen.
pict_size = size_percent/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure_handle = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);

% Create subplot
subplot_module = subplot(2, 1, 1, 'Parent', figure_handle);
hold(subplot_module,'on');

% Create subplot
subplot_phase = subplot(2, 1, 2, 'Parent', figure_handle);
hold(subplot_phase,'on');

% Create ylabel
ylabel(subplot_module, ...
    "M\'{o}dulo de la respuesta en frecuencia de potencia [W]",...
    'Interpreter', 'latex');

% Create xlabel
xlabel(subplot_module, 'Frecuencia [Hz]', ...
    'Interpreter', 'latex');

box(subplot_module,'on');
% Set the remaining axes properties
set(subplot_module,'XGrid','on','XMinorTick','on','XScale','log',...
    'YGrid','on',...
    'YMinorTick','on','ColorOrder', fig_colors(1, :), 'YTick', ...
    mod_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot_module,'manual');
ylim(subplot_module, mod_limits);


% Create ylabel
ylabel(subplot_phase, ...
    'Fase de la respuesta en frecuencia de potencia [${}^\circ$]', ...
    'Interpreter', 'latex');

% Create xlabel
xlabel(subplot_phase, 'Frecuencia [Hz]', ...
    'Interpreter', 'latex');

box(subplot_phase,'on');
% Set the remaining axes properties
set(subplot_phase,'XGrid','on','XMinorTick','on','XScale','log',...
    'YGrid','on',...
    'YMinorTick','on','ColorOrder', fig_colors(2, :), 'YTick',phase_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot_phase,'manual');
ylim(subplot_phase, phase_limits);


% Create title
title(subplot_module, fig_title, 'Interpreter', 'latex');



phase_angle = unwrap(angle(complex_response));

module = abs(complex_response);


[CF_index_low, CF_index_high, max_mod, ~] = ...
    aac_find_cutoff_freq(module, phase_angle, freq);

% Create plot
semilogx(freq, ...
    module, 'Parent', subplot_module);

% Create plot
semilogx(freq, ...
    rad2deg(phase_angle), 'Parent', subplot_phase);


hline = refline(subplot_module, 0, ...
    max_mod/2);
set(hline, 'Color', [0 0 0]);
set(hline, 'Clipping', 'on');
set(hline, 'DisplayName', '-3dB');
set(hline, 'HandleVisibility','off');



% Add annotations.


freq_val = ...
    freq(CF_index_high) - freq(CF_index_low);

if (freq_val > 1e6)
    freq_val = freq_val /1e6;
    freq_unit='MHz';
elseif (freq_val > 1e3)
    freq_val = freq_val /1e3;
    freq_unit='KHz';
else
    freq_unit='Hz';
end

annotation(figure_handle,'textbox',...
    [0.40 (0.775 - 0.04) 0 0],...
    'Color',fig_colors(1,:),...
    'String',{sprintf('Ancho de banda: %.2f%s', ...
    freq_val, freq_unit)},...
    'LineStyle',':',...
    'FontWeight','bold',...
    'FitBoxToText','on',...
    'EdgeColor',fig_colors(1,:));





phase_plots = findobj(subplot_phase, 'type', 'line');
% phase_plots = flip(phase_plots(end - 2:end));


module_plots = findobj(subplot_module, 'type', 'line');
% module_plots = flip(module_plots(end - 2:end));


% Limit legends to my plots.
% legend(phase_plots, 'show', legends);
% legend(module_plots, 'show', legends);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Agrego datatips customizados.

%%% High.

dcm_obj = datacursormode(figure_handle);

customtitles_module = cell(1, 2);
customtitles_module{1} = '';

customtitles_module_indexes = zeros(2);

hdtip2 = zeros();

hdtip2(CF_index_high) = ...
    dcm_obj.createDatatip(handle(module_plots(1)));

set(hdtip2(CF_index_high), 'MarkerSize',5, 'MarkerFaceColor', ...
    'none', 'MarkerEdgeColor',fig_colors(1,:), ...
    'Marker','o', 'HitTest','off');

YValue = [freq(CF_index_high) , ...
    module(CF_index_high) , 1];


set(hdtip2(CF_index_high), 'Position', YValue, ...
    'Orientation', 'topright');


customtitles_module{2} = 'Frec. de corte superior:';

customtitles_module_indexes(2) = CF_index_high;

setappdata(module_plots(1),'figtype','module');

setappdata(module_plots(1),'figindex',1);

setappdata(module_plots(1),'specialindex',0);

setappdata(module_plots(1),'speciallabelindex',1);

setappdata(module_plots(1),'tiplabels', customtitles_module);

setappdata(module_plots(1),'tiplabelsindexes', ...
    customtitles_module_indexes);


%%%% Low. 


hdtip3 = zeros();

hdtip3(CF_index_low) = ...
    dcm_obj.createDatatip(handle(module_plots(1)));

set(hdtip3(CF_index_low), 'MarkerSize',5, 'MarkerFaceColor', ...
    'none', 'MarkerEdgeColor',fig_colors(1,:), ...
    'Marker','o', 'HitTest','off');

YValue = [freq(CF_index_low) , ...
    module(CF_index_low) , 1];


set(hdtip3(CF_index_low), 'Position', YValue, ...
    'Orientation', 'topright');


customtitles_module{3} = 'Frec. de corte inferior:';

customtitles_module_indexes(3) = CF_index_low;

setappdata(module_plots(1),'figtype','module');

setappdata(module_plots(1),'figindex',1);

setappdata(module_plots(1),'specialindex',0);

setappdata(module_plots(1),'speciallabelindex',1);

setappdata(module_plots(1),'tiplabels', customtitles_module);

setappdata(module_plots(1),'tiplabelsindexes', ...
    customtitles_module_indexes);



%
% hdtip3(low_freq_index) = ...
%     dcm_obj.createDatatip(handle(module_plots(1)));
%
% set(hdtip3(low_freq_index), 'MarkerSize',5, 'MarkerFaceColor', ...
%     'none', 'MarkerEdgeColor','k', ...
%     'Marker','o', 'HitTest','off');
%
% YValue = [Data(low_freq_index, freq_index, 1) , ...
%     mag2db(Data(low_freq_index, module_index, 1)) , 1];
%
%
% set(hdtip3(low_freq_index), 'Position', YValue, ...
%     'Orientation', 'bottomright');
%
%
% customtitles_module{DataCount + 2} = ...
%     'Ganancia de lazo cerrado a bajas frecuencias:';
%
% customtitles_module_indexes(DataCount + 2) = low_freq_index;
%
%
% setappdata(module_plots(1),'figtype','module');
%
% setappdata(module_plots(1),'figindex',1);
%
% setappdata(module_plots(1),'specialindex',low_freq_index);
%
% setappdata(module_plots(1),'speciallabelindex',DataCount + 2);
%
% setappdata(module_plots(1),'tiplabels', customtitles_module);
%
% setappdata(module_plots(1),'tiplabelsindexes', ...
%     customtitles_module_indexes);


%%%%%%%%%%



set(dcm_obj, 'UpdateFcn', {@customDatatipFunction1, ...
    freq, module, ...
    phase_angle})



% alldatacursors = findall(figure_handle, 'type', 'hggroup');
% set(alldatacursors, 'FontSize', 8);
% set(alldatacursors, 'FontName', 'Times');
% set(alldatacursors, 'FontWeight', 'bold');



updateDataCursors(dcm_obj);

drawnow;

end

function output_txt = customDatatipFunction1(~,evt, freq, module, ...
    ~)

target = get(evt,'Target');
idx = get(evt,'DataIndex');
%
% fig_type = getappdata(target,'figtype');
fig_index = getappdata(target,'figindex');
customtitles = getappdata(target,'tiplabels');
customtitlesindexes = getappdata(target,'tiplabelsindexes');
%
special_index = getappdata(target,'specialindex');
special_label_index = getappdata(target,'speciallabelindex');

idx_f = find(customtitlesindexes == idx, 1);

% if (isempty(idx_f))
%     label_index = 1;
% else
%     label_index = fig_index + 1;
% end

% if strcmp('phase', fig_type)
%     output_txt = {sprintf(strjoin(...
%         {'%s\n%.2f º\n'}), ...
%         customtitles{label_index}, ...
%         rad2deg(phase_angle(idx, fig_index)) + 180.0)};
% elseif strcmp('module', fig_type)
%     output_txt = {sprintf(strjoin(...
%         {'%s\n%.2f dB\n'}), ...
%         customtitles{label_index}, ...
%         -mag2db(module(idx, fig_index)))};


if (~isempty(idx_f))
    if (special_index == idx)
        output_txt = {sprintf(...
            '%s\n%.2fW', ...
            customtitles{special_label_index}, ...
            module(idx, fig_index))};
    else
        output_txt = '';
    end
else
    output_txt = {sprintf(...
        'freq: %.2f\nmod: %.2fW\n', ...
        freq(idx, fig_index),...
        module(idx, fig_index))};
    
end

end




