function [figure_handle] = aab_loop_gain(file_name, ...
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
ylabel(subplot_module, 'Módulo de la ganancia de lazo [dB]');

% Create xlabel
xlabel(subplot_module, 'Frecuencia [Hz]');

box(subplot_module,'on');
% Set the remaining axes properties
set(subplot_module,'XGrid','on','XMinorTick','on','XScale','log', ...
    'YGrid','on',...
    'YMinorTick','on','ColorOrder', fig_colors(1, :), 'YTick', ...
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
    'YMinorTick','on','ColorOrder', fig_colors(2, :), 'YTick',phase_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot_phase,'manual');
ylim(subplot_phase, phase_limits);


% Create title
title(subplot_module, fig_title, 'Interpreter', 'latex');


mod_data = ...
    abs(complex_response); % Module.

angle_data = ...
    unwrap(angle(complex_response)); % Phase (radians).

[PM_index, GM_index] = aac_find_margins(...
    freq, ...
    mod_data, angle_data);


% Create plot
semilogx(freq, ...
    mag2db(mod_data), 'Parent', subplot_module);

%     plot(Data(PM_index, freq_index, idx), ...
%         mag2db(Data(PM_index, module_index, idx)), ...
%         '-c', 'MarkerSize', 5, ...
%         'Color', fig_color_order(idx,:), ...
%         'HandleVisibility','off', ...
%         'Parent', subplot_module);

% Create plot
semilogx(freq, ...
    rad2deg(angle_data), 'Parent', subplot_phase);



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

plot(subplot_module, ...
    [freq(PM_index), ...
    freq(PM_index)], [mod_limits(1) 0], ...
    'Color','cyan','LineStyle','-.', ...
    'HandleVisibility','off');

plot(subplot_module, ...
    [freq(GM_index), ...
    freq(GM_index)], ...
    [mod_limits(1) ...
    mag2db(mod_data(GM_index))], ...
    'Color', [0.7 0.7 0],'LineStyle','-.', ...
    'HandleVisibility','off');

plot(subplot_module, ...
    [freq(GM_index), ...
    freq(GM_index)], ...
    [mag2db(mod_data(GM_index)) ...
    0], ...
    'Color', [0.7 0.7 0],'LineStyle','-', ...
    'HandleVisibility','off');



plot(subplot_phase, ...
    [freq(GM_index), ...
    freq(GM_index)], [-180 phase_limits(2)], ...
    'Color', [0.7 0.7 0],'LineStyle','-.', ...
    'HandleVisibility','off');

plot(subplot_phase, ...
    [freq(PM_index), ...
    freq(PM_index)],  ...
    [rad2deg(angle_data(PM_index)) ...
    phase_limits(2)], ...
    'Color','cyan','LineStyle','-.', ...
    'HandleVisibility','off');

plot(subplot_phase, ...
    [freq(PM_index), ...
    freq(PM_index)],  ...
    [-180 ...
    rad2deg(angle_data(PM_index))], ...
    'Color','cyan','LineStyle','-', ...
    'HandleVisibility','off');



annotation(figure_handle,'textbox',...
    [0.50 0.23 0 0],...
    'Color',fig_colors(2, :),...
    'String',{sprintf('Margen de fase: %.2fº', ...
    rad2deg(angle_data(PM_index)) + 180)},...
    'LineStyle',':',...
    'FontWeight','bold',...
    'FitBoxToText','on',...
    'EdgeColor',fig_colors(2, :));


annotation(figure_handle,'textbox',...
    [0.50 0.670 0 0],...
    'Color',fig_colors(1, :),...
    'String',{sprintf('Margen de ganancia: %.2fdB', ...
    -mag2db(mod_data(GM_index)))},...
    'LineStyle',':',...
    'FontWeight','bold',...
    'FitBoxToText','on',...
    'EdgeColor',fig_colors(1, :));





phase_plots = findobj(subplot_phase, 'type', 'line');
% phase_plots = flip(phase_plots(end - 2:end));


module_plots = findobj(subplot_module, 'type', 'line');
% module_plots = flip(module_plots(end - 2:end));
% 
% 
% % Limit legends to my plots.
% legend(phase_plots, 'show', legends);
% legend(module_plots, 'show', legends);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Agrego datatips customizados.

dcm_obj = datacursormode(figure_handle);

customtitles_phase = cell(1, 2);
customtitles_phase{1} = '';

customtitles_phase_indexes = zeros(2);

hdtip1 = zeros();


hdtip1(PM_index) = ...
    dcm_obj.createDatatip(handle(phase_plots(1)));

set(hdtip1(PM_index), 'MarkerSize',5, 'MarkerFaceColor', ...
    'none', 'MarkerEdgeColor',fig_colors(2,:), ...
    'Marker','o', 'HitTest','off');

YValue = [freq(PM_index) , ...
    rad2deg(angle_data(PM_index)) , 1];


set(hdtip1(PM_index), 'Position', YValue, ...
    'Orientation', 'bottomleft');


customtitles_phase{2} = 'PM:';

customtitles_phase_indexes(2) = PM_index;

setappdata(phase_plots(1),'figtype','phase');

setappdata(phase_plots(1),'figindex',1);

setappdata(phase_plots(1),'tiplabels', customtitles_phase);

setappdata(phase_plots(1),'tiplabelsindexes', ...
    customtitles_phase_indexes);

    



customtitles_module = cell(1, 2);
customtitles_module{1} = '';

customtitles_module_indexes = zeros(2);


hdtip2 = zeros();




hdtip2(GM_index) = ...
    dcm_obj.createDatatip(handle(module_plots(1)));

set(hdtip2(GM_index), 'MarkerSize',5, 'MarkerFaceColor', ...
    'none', 'MarkerEdgeColor',fig_colors(1,:), ...
    'Marker','o', 'HitTest','off');

YValue = [freq(GM_index) , ...
    mag2db(mod_data(GM_index)) , 1];


set(hdtip2(GM_index), 'Position', YValue, ...
    'Orientation', 'bottomleft');


customtitles_module{2} = 'GM';

customtitles_module_indexes(2) = GM_index;

setappdata(module_plots(1),'figtype','module');

setappdata(module_plots(1),'figindex',1);

setappdata(module_plots(1),'specialindex',0);

setappdata(module_plots(1),'speciallabelindex',1);

setappdata(module_plots(1),'tiplabels', customtitles_module);

setappdata(module_plots(1),'tiplabelsindexes', ...
    customtitles_module_indexes);




%%%% Datatip low freq. gain.

[~, mid_freq_index] = max(mod_data);

hdtip3(mid_freq_index) = ...
    dcm_obj.createDatatip(handle(module_plots(1)));

set(hdtip3(mid_freq_index), 'MarkerSize',5, 'MarkerFaceColor', ...
    'none', 'MarkerEdgeColor','k', ...
    'Marker','o', 'HitTest','off');

YValue = [freq(mid_freq_index) , ...
    mag2db(mod_data(mid_freq_index)) , 1];


set(hdtip3(mid_freq_index), 'Position', YValue, ...
    'Orientation', 'topright');


customtitles_module{3} = ...
    'Ganancia de lazo a frecuencias medias:';

customtitles_module_indexes(3) = mid_freq_index;


setappdata(module_plots(1),'figtype','module');

setappdata(module_plots(1),'figindex',1);

setappdata(module_plots(1),'specialindex',mid_freq_index);

setappdata(module_plots(1),'speciallabelindex',3);

setappdata(module_plots(1),'tiplabels', customtitles_module);

setappdata(module_plots(1),'tiplabelsindexes', ...
    customtitles_module_indexes);


%%%%%%%%%%


set(dcm_obj, 'UpdateFcn', {@customDatatipFunction1, ...
    freq, mod_data, ...
    angle_data})



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




