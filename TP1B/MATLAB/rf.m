function [figure_handle] = rf(file_name, ...
    fig_title, size_percent, fig_color_order, ...
    prealocate_array_size, prealocate_array_count, ...
    mod_limits, mod_ticks, ...
    phase_limits, phase_ticks, legends)


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
subplot_module = subplot(2, 1, 1, 'Parent', figure_handle);
hold(subplot_module,'on');

% Create subplot
subplot_phase = subplot(2, 1, 2, 'Parent', figure_handle);
hold(subplot_phase,'on');

% Create ylabel
ylabel(subplot_module, 'Módulo de la respuesta en frecuencia');

% Create xlabel
xlabel(subplot_module, 'Frecuencia [Hz]');

box(subplot_module,'on');
% Set the remaining axes properties
set(subplot_module,'XGrid','on','XMinorTick','on','XScale','log','YGrid','on',...
    'YMinorTick','on','ColorOrder', fig_color_order, 'YTick', ...
    mod_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot_module,'manual');
ylim(subplot_module, mod_limits);


% Create ylabel
ylabel(subplot_phase, 'Fase de la respuesta en frecuencia [º]');

% Create xlabel
xlabel(subplot_phase, 'Frecuencia [Hz]');

box(subplot_phase,'on');
% Set the remaining axes properties
set(subplot_phase,'XGrid','on','XMinorTick','on','XScale','log','YGrid','on',...
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

CF_indexes = zeros(sz3);

for idx = (1: DataCount)
    
    Data(:, freq_index, idx) = ...
        Data_raw(:, 1, idx); % Time.
    
    Data(:, module_index, idx) = ...
        abs(Data_raw(:, 2, idx)); % Module.
    
    Data(:, phase_index, idx) = ...
        unwrap(angle(Data_raw(:, 2, idx))); % Phase (radians).
    
    
    CF_index = find_cutoff_freq(...
        Data(:, module_index, idx), Data(:, phase_index, idx));
    
    CF_indexes(idx) = CF_index;
    
    % Create plot
    semilogx(Data(:, freq_index, idx), ...
        mag2db(Data(:, module_index, idx)), 'Parent', subplot_module);
    
    % Create plot
    semilogx(Data(:, freq_index, idx), ...
        rad2deg(Data(:, phase_index, idx)), 'Parent', subplot_phase);
    
end


hline = refline(subplot_module, 0, ...
    mag2db(Data(1, module_index, 1)) -3);
set(hline, 'Color', [0 0 0]);
set(hline, 'Clipping', 'on');
set(hline, 'DisplayName', '-3dB');
set(hline, 'HandleVisibility','off');


% Add annotations.
for idx = (1: DataCount)
    
    freq_val = ...
        Data(CF_indexes(idx), freq_index, idx);
    
    if (freq_val > 1e6)
        freq_val = freq_val /1e6;
        freq_unit='MHz';
    elseif (freq_val > 1e3)
        freq_val = freq_val /1e3;
        freq_unit='MHz';
    else
        freq_unit='Hz';
    end  
    
    annotation(figure_handle,'textbox',...
        [0.50 (0.775 - idx*0.04) 0 0],...
        'Color',fig_color_order(idx,:),...
        'String',{sprintf('Ancho de banda (%s): %.2f%s', ...
        legends{idx}, ...
        freq_val, freq_unit)},...
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

customtitles_module = cell(1, DataCount + 1);
customtitles_module{1} = '';

customtitles_module_indexes = zeros(DataCount + 1);


tip_directions2 = {'bottomleft', 'topright', 'bottomright', 'topleft'};
[~, sztd] = size(tip_directions2);

hdtip2 = zeros();


for idx = (1: DataCount)
    
    hdtip2(CF_indexes(idx)) = ...
        dcm_obj.createDatatip(handle(module_plots(idx)));
    
    set(hdtip2(CF_indexes(idx)), 'MarkerSize',5, 'MarkerFaceColor', ...
        'none', 'MarkerEdgeColor',fig_color_order(idx,:), ...
        'Marker','o', 'HitTest','off');
    
    YValue = [Data(CF_indexes(idx), freq_index, idx) , ...
        mag2db(Data(CF_indexes(idx), module_index, idx)) , 1];
    
    
    set(hdtip2(CF_indexes(idx)), 'Position', YValue, ...
        'Orientation', tip_directions2{mod(idx, sztd)});
    
    
    customtitles_module{idx + 1} = ...
        sprintf('Frec. de corte: (%s)', ...
        legends{idx});
    
    customtitles_module_indexes(idx + 1) = CF_indexes(idx);
    
    setappdata(module_plots(idx),'figtype','module');
    
    setappdata(module_plots(idx),'figindex',idx);
    
    setappdata(module_plots(idx),'tiplabels', customtitles_module);
    
    setappdata(module_plots(idx),'tiplabelsindexes', ...
        customtitles_module_indexes);
    
    
end


set(dcm_obj, 'UpdateFcn', {@customDatatipFunction1, ...
    Data(:, freq_index, :), Data(:, module_index, :), ...
    Data(:, phase_index, :)})



alldatacursors = findall(figure_handle, 'type', 'hggroup');
set(alldatacursors, 'FontSize', 8);
set(alldatacursors, 'FontName', 'Times');
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
% customtitles = getappdata(target,'tiplabels');
customtitlesindexes = getappdata(target,'tiplabelsindexes');
%
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
    output_txt = '';
else
    output_txt = {sprintf(...
        'freq: %.2f\nmod: %.2f dB\n', ...
        freq(idx, fig_index),...
        mag2db(module(idx, fig_index)))};
    
end




end




