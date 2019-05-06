function loop_gain(close_figures, file_name, fig_title, ...
    prealocate_array_size, prealocate_array_count, ...
    mod_limits, mod_ticks, ...
    phase_limits, phase_ticks, legends)

if close_figures
    %Cierro las figuras existentes.
    close all;
end

%Tamaño de la figura.
size_percent = 80;


%Cargo los datos
[Data, DataCount] = load_parametric_bode_data(...
    file_name,...
    prealocate_array_size, prealocate_array_count);

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

% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure1);
hold(subplot2,'on');

for idx = (1: DataCount)
    
    X = Data(:, 1, idx);
    
    Y1 = 20*log10(abs(Data(:, 2, idx)));
    
    Y2 = rad2deg(unwrap(angle(Data(:, 2, idx))));
    
    % Create plot
    plot1 = semilogx(X, Y1, 'Parent', subplot1);
    % , 'Color', [1 0 0]
    
    
    
    plot2 = semilogx(X, Y2, 'Parent', subplot2);
    
end

% Create ylabel
ylabel(subplot1, 'Módulo de la ganancia de lazo');

% Create xlabel
xlabel(subplot1, 'Frecuencia [Hz]');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'XGrid','on','XMinorTick','on','XScale','log','YGrid','on',...
    'YMinorTick','on','ColorMap', colormap(jet), 'YTick', ...
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
    'YMinorTick','on','YTick',phase_ticks);

% xlim(subplot2,'manual');
% xlim(subplot2,[0.1 200000]);
%
ylim(subplot2,'manual');
ylim(subplot2, phase_limits);


% Create title
title(subplot1, fig_title);


legend(subplot1, 'show', legends);

legend(subplot2, 'show', legends);


drawnow;




return

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





