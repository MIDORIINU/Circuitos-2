function [figure_handle] = aab_loop_gain(file_name, ...
    fig_title, size_percent, fig_color_order, ...
    prealocate_array_size, prealocate_array_count, ...
    mod_limits, mod_ticks, ...
    phase_limits, phase_ticks, legends)


%Tamaño de la figura.
% size_percent = 80;


%Cargo los datos
[Data_raw, DataCount] = aac_load_parametric_bode_data(...
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
subplot_module = subplot(2, 1, 1, 'Parent', figure_handle);
hold(subplot_module,'on');

% Create subplot
subplot_phase = subplot(2, 1, 2, 'Parent', figure_handle);
hold(subplot_phase,'on');

% Create ylabel
ylabel(subplot_module, 'Módulo de la ganancia de lazo [dB]');

% Create xlabel
xlabel(subplot_module, 'Frecuencia [Hz]');

box(subplot_module,'on');
% Set the remaining axes properties
set(subplot_module,'XGrid','on','XMinorTick','on','XScale','log', ...
    'YGrid','on',...
    'YMinorTick','on','ColorOrder', fig_color_order, 'YTick', ...
    mod_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot_module,'manual');
ylim(subplot_module, mod_limits);


% Create ylabel
ylabel(subplot_phase, 'Fase de la ganancia de lazo [º]');

% Create xlabel
xlabel(subplot_phase, 'Frecuencia [Hz]');

box(subplot_phase,'on');
% Set the remaining axes properties
set(subplot_phase,'XGrid','on','XMinorTick','on','XScale','log', ...
    'YGrid','on',...
    'YMinorTick','on','ColorOrder', fig_color_order, 'YTick',phase_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot_phase,'manual');
ylim(subplot_phase, phase_limits);


% Create title
title(subplot_module, fig_title, 'Interpreter', 'latex');



freq_index = 1;
module_index = 2;
phase_index = 3;

[sz1, sz2, sz3] = size(Data_raw);

Data = zeros(sz1, sz2 + 1, sz3);

PM_indexes = zeros(sz3);
GM_indexes = zeros(sz3);

for idx = (1: DataCount)
    
    Data(:, freq_index, idx) = ...
        Data_raw(:, 1, idx); % Time.
    
    Data(:, module_index, idx) = ...
        abs(Data_raw(:, 2, idx)); % Module.
    
    Data(:, phase_index, idx) = ...
        unwrap(angle(Data_raw(:, 2, idx))); % Phase (radians).
    
    
    [PM_index, GM_index] = aac_find_margins(...
         Data(:, freq_index, idx), ...
        Data(:, module_index, idx), Data(:, phase_index, idx));
    
    PM_indexes(idx) = PM_index;
    
    GM_indexes(idx) = GM_index;
    
    % Create plot
    semilogx(Data(:, freq_index, idx), ...
        mag2db(Data(:, module_index, idx)), 'Parent', subplot_module);
    
    %     plot(Data(PM_index, freq_index, idx), ...
    %         mag2db(Data(PM_index, module_index, idx)), ...
    %         '-c', 'MarkerSize', 5, ...
    %         'Color', fig_color_order(idx,:), ...
    %         'HandleVisibility','off', ...
    %         'Parent', subplot_module);
    
    % Create plot
    semilogx(Data(:, freq_index, idx), ...
        rad2deg(Data(:, phase_index, idx)), 'Parent', subplot_phase);
    
end

hline = refline(subplot_module, 0, 0);
set(hline, 'Color', [0 0 0]);
set(hline, 'Clipping', 'on');
set(hline, 'DisplayName', '0dB');
set(hline, 'HandleVisibility','off');

hline = refline(subplot_phase, 0, -180);
set(hline, 'Color', [0 0 0]);
set(hline, 'Clipping', 'on');
set(hline, 'DisplayName', '180º');
set(hline, 'HandleVisibility','off');

% set(get(get(hline,'Annotation'), 'LegendInformation'), ...
%     'IconDisplayStyle','off');

% Add vertical lines and annotations.
for idx = (1: DataCount)
    plot(subplot_module, ...
        [Data(PM_indexes(idx), freq_index, idx), ...
        Data(PM_indexes(idx), freq_index, idx)], [mod_limits(1) 0], ...
        'Color','cyan','LineStyle','-.', ...
        'HandleVisibility','off');
    
    plot(subplot_module, ...
        [Data(GM_indexes(idx), freq_index, idx), ...
        Data(GM_indexes(idx), freq_index, idx)], ...
        [mod_limits(1) ...
        mag2db(Data(GM_indexes(idx), module_index, idx))], ...
        'Color', [0.7 0.7 0],'LineStyle','-.', ...
        'HandleVisibility','off');    
    
    plot(subplot_module, ...
        [Data(GM_indexes(idx), freq_index, idx), ...
        Data(GM_indexes(idx), freq_index, idx)], ...
        [mag2db(Data(GM_indexes(idx), module_index, idx)) ...
        0], ...
        'Color', [0.7 0.7 0],'LineStyle','-', ...
        'HandleVisibility','off');      
    
    
    
     plot(subplot_phase, ...
        [Data(GM_indexes(idx), freq_index, idx), ...
        Data(GM_indexes(idx), freq_index, idx)], [-180 phase_limits(2)], ...
        'Color', [0.7 0.7 0],'LineStyle','-.', ...
        'HandleVisibility','off');   
        
    plot(subplot_phase, ...
        [Data(PM_indexes(idx), freq_index, idx), ...
        Data(PM_indexes(idx), freq_index, idx)],  ...
        [rad2deg(Data(PM_indexes(idx), phase_index, idx)) ...
        phase_limits(2)], ...
        'Color','cyan','LineStyle','-.', ...
        'HandleVisibility','off');
    
    plot(subplot_phase, ...
        [Data(PM_indexes(idx), freq_index, idx), ...
        Data(PM_indexes(idx), freq_index, idx)],  ...
        [-180 ...
        rad2deg(Data(PM_indexes(idx), phase_index, idx))], ...
        'Color','cyan','LineStyle','-', ...
        'HandleVisibility','off');   
    
    
    
    annotation(figure_handle,'textbox',...
        [0.50 (0.30 - idx*0.04) 0 0],...
        'Color',fig_color_order(idx,:),...
        'String',{sprintf('Margen de fase (%s): %.2fº', ...
        legends{idx}, ...
        rad2deg(Data(PM_indexes(idx), phase_index, idx)) + 180)},...
        'LineStyle',':',...
        'FontWeight','bold',...
        'FitBoxToText','on',...
        'EdgeColor',fig_color_order(idx,:));
    
    
    annotation(figure_handle,'textbox',...
        [0.50 (0.775 - idx*0.04) 0 0],...
        'Color',fig_color_order(idx,:),...
        'String',{sprintf('Margen de ganancia (%s): %.2fdB', ...
        legends{idx}, ...
        -mag2db(Data(GM_indexes(idx), module_index, idx)))},...
        'LineStyle',':',...
        'FontWeight','bold',...
        'FitBoxToText','on',...
        'EdgeColor',fig_color_order(idx,:));
    
   
end


phase_plots = findobj(subplot_phase, 'type', 'line');
phase_plots = flip(phase_plots(end - DataCount + 1:end));


module_plots = findobj(subplot_module, 'type', 'line');
module_plots = flip(module_plots(end - DataCount + 1:end));


% Limit legends to my plots.
legend(phase_plots, 'show', legends);
legend(module_plots, 'show', legends);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Agrego datatips customizados.

dcm_obj = datacursormode(figure_handle);

customtitles_phase = cell(1, DataCount + 1);
customtitles_phase{1} = '';

customtitles_phase_indexes = zeros(DataCount + 1);

tip_directions1 = {'bottomleft', 'topright', 'topleft', 'bottomright'};
[~, sztd] = size(tip_directions1);


hdtip1 = zeros();

for idx = (1: DataCount)
    
    hdtip1(PM_indexes(idx)) = ...
        dcm_obj.createDatatip(handle(phase_plots(idx)));
    
    set(hdtip1(PM_indexes(idx)), 'MarkerSize',5, 'MarkerFaceColor', ...
        'none', 'MarkerEdgeColor',fig_color_order(idx,:), ...
        'Marker','o', 'HitTest','off');
    
    YValue = [Data(PM_indexes(idx), freq_index, idx) , ...
        rad2deg(Data(PM_indexes(idx), phase_index, idx)) , 1];
    
    
    set(hdtip1(PM_indexes(idx)), 'Position', YValue, ...
        'Orientation', tip_directions1{mod(idx, sztd)});
    
    
    customtitles_phase{idx + 1} = ...
        sprintf('PM: (%s)', ...
        legends{idx});
    
    customtitles_phase_indexes(idx + 1) = PM_indexes(idx);
    
    setappdata(phase_plots(idx),'figtype','phase');
    
    setappdata(phase_plots(idx),'figindex',idx);
    
    setappdata(phase_plots(idx),'tiplabels', customtitles_phase);
    
    setappdata(phase_plots(idx),'tiplabelsindexes', ...
        customtitles_phase_indexes);
    
    
end


customtitles_module = cell(1, DataCount + 1);
customtitles_module{1} = '';

customtitles_module_indexes = zeros(DataCount + 1);


tip_directions2 = {'bottomleft', 'topright', 'bottomright', 'topleft'};
[~, sztd] = size(tip_directions2);

hdtip2 = zeros();


for idx = (1: DataCount)
    
    hdtip2(GM_indexes(idx)) = ...
        dcm_obj.createDatatip(handle(module_plots(idx)));
    
    set(hdtip2(GM_indexes(idx)), 'MarkerSize',5, 'MarkerFaceColor', ...
        'none', 'MarkerEdgeColor',fig_color_order(idx,:), ...
        'Marker','o', 'HitTest','off');
    
    YValue = [Data(GM_indexes(idx), freq_index, idx) , ...
        mag2db(Data(GM_indexes(idx), module_index, idx)) , 1];
    
    
    set(hdtip2(GM_indexes(idx)), 'Position', YValue, ...
        'Orientation', tip_directions2{mod(idx, sztd)});
    
    
    customtitles_module{idx + 1} = ...
        sprintf('GM: (%s)', ...
        legends{idx});
    
    customtitles_module_indexes(idx + 1) = GM_indexes(idx);
    
    setappdata(module_plots(idx),'figtype','module');
    
    setappdata(module_plots(idx),'figindex',idx);
    
    setappdata(module_plots(1),'specialindex',0);
    
    setappdata(module_plots(1),'speciallabelindex',1);    
    
    setappdata(module_plots(idx),'tiplabels', customtitles_module);
    
    setappdata(module_plots(idx),'tiplabelsindexes', ...
        customtitles_module_indexes);
    
    
end


%%%% Datatip low freq. gain.

[~, low_freq_index] = min(abs(Data(:, freq_index, 1) - 1E-1));

hdtip3(low_freq_index) = ...
    dcm_obj.createDatatip(handle(module_plots(1)));

set(hdtip3(low_freq_index), 'MarkerSize',5, 'MarkerFaceColor', ...
    'none', 'MarkerEdgeColor','k', ...
    'Marker','o', 'HitTest','off');

YValue = [Data(low_freq_index, freq_index, 1) , ...
    mag2db(Data(low_freq_index, module_index, 1)) , 1];


set(hdtip3(low_freq_index), 'Position', YValue, ...
    'Orientation', 'bottomright');


customtitles_module{DataCount + 2} = ...
    'Ganancia de lazo a bajas frecuencias:';

customtitles_module_indexes(DataCount + 2) = low_freq_index;


setappdata(module_plots(1),'figtype','module');

setappdata(module_plots(1),'figindex',1);

setappdata(module_plots(1),'specialindex',low_freq_index);

setappdata(module_plots(1),'speciallabelindex',DataCount + 2);

setappdata(module_plots(1),'tiplabels', customtitles_module);

setappdata(module_plots(1),'tiplabelsindexes', ...
    customtitles_module_indexes);


%%%%%%%%%%


set(dcm_obj, 'UpdateFcn', {@customDatatipFunction1, ...
    Data(:, freq_index, :), Data(:, module_index, :), ...
    Data(:, phase_index, :)})



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
            '%s\n%.2fdB', ...
            customtitles{special_label_index}, ...
            mag2db(module(idx, fig_index)))};
    else
        output_txt = '';
    end
else
    output_txt = {sprintf(...
        'freq: %.2f\nmod: %.2f dB\n', ...
        freq(idx, fig_index),...
        mag2db(module(idx, fig_index)))};
    
end

end




