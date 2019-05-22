function [figure_handle] = aab_impedance(file_name, ...
    fig_title, size_percent, fig_colors, ...
    freq_limits, freq_ticks, ...
    mod_limits, mod_ticks, ...
    phase_limits, phase_ticks, ...
    mod_exponent, freq_resistance)

%Cargo los datos
fileID = fopen(file_name);
%%C_text = textscan(fileID, '%s', 1);
TableData = textscan(fileID,'%f %f,%f', 'HeaderLines', 1);
fclose(fileID);

freq = TableData{1};

complex_impedance = complex(TableData{2}, TableData{3});

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

% Create plot
plot1 = semilogx(freq, abs(complex_impedance), 'Parent', ...
    subplot1, 'Color', fig_colors(1, :));


% Create ylabel
ylabel("M\'{o}dulo de la impedancia ($\left| Z \right|$) [$\Omega$]", ...
    'Interpreter', 'latex');

% Create xlabel
xlabel('Frecuencia [Hz]', 'Interpreter', 'latex');

% Create title
title(fig_title, 'Interpreter', 'latex');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'XGrid','on','XMinorTick','on','XScale','log', ...
    'XTick', freq_ticks, 'YGrid','on',...
    'YMinorTick','on','YTick', mod_ticks);

ax = gca;
ax.YAxis.Exponent = mod_exponent;

xlim(subplot1,'manual');
xlim(subplot1, freq_limits);

ylim(subplot1,'manual');
ylim(subplot1, mod_limits);

% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure_handle);

plot2 = semilogx(freq, rad2deg(angle(complex_impedance)), ...
    'Parent', subplot2, 'Color', fig_colors(2, :));


% Create ylabel
ylabel("Fase de la impedancia (\angle Z) [${}^\circ$]", ...
    'Interpreter', 'latex');

% Create xlabel
xlabel('Frecuencia [Hz]', 'Interpreter', 'latex');

box(subplot2,'on');
% Set the remaining axes properties
set(subplot2,'XGrid','on','XMinorTick','on','XScale','log', ...
    'XTick', freq_ticks, 'YGrid','on',...
    'YMinorTick','on','YTick', phase_ticks);

xlim(subplot2,'manual');
xlim(subplot2, freq_limits);

ylim(subplot2,'manual');
ylim(subplot2, phase_limits);


%Agrego datatips customizados.

dcm_obj = datacursormode(figure_handle);

customtitles = {''};
customtitlesindexes = 0;


resistance_index = find((freq - freq_resistance) > 0, 1);

hdtip(resistance_index) = dcm_obj.createDatatip(handle(plot1));

set(hdtip(resistance_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
    'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');

YValue = [freq(resistance_index) , ...
    abs(complex_impedance(resistance_index)) , 1];

set(hdtip(resistance_index), 'Position', YValue, 'Orientation','topright')

customtitles{end + 1} = '*** Resistencia a frecuencias medias ***';

customtitlesindexes = [customtitlesindexes, resistance_index];


% %%%%%
%
% hdtip(resistance_index) = dcm_obj.createDatatip(handle(plot2));
%
% set(hdtip(resistance_index), 'MarkerSize',5, 'MarkerFaceColor','none', ...
%                   'MarkerEdgeColor','r', 'Marker','o', 'HitTest','off');
%
% YValue = [freq(resistance_index) , ...
%     angle(complex_impedance(resistance_index)) , 1];
%
% set(hdtip(resistance_index), 'Position', YValue, 'Orientation','topright')
%
% customtitles{end + 1} = '*** Resistencia (frec ~= 0) ***';
%
% customtitlesindexes = [customtitlesindexes, resistance_index];


set(dcm_obj, 'UpdateFcn', {@customDatatipFunction1, customtitles, ...
    customtitlesindexes, freq, complex_impedance})

updateDataCursors(dcm_obj);

end

function output_txt = customDatatipFunction1(~, evt, customtitles, ...
    customtitlesindexes, X1, Y1)

idx = get(evt,'DataIndex');

idx_f = find(customtitlesindexes == idx, 1);

if (isempty(idx_f))
    idx_f = 1;
end

output_txt = {sprintf(strjoin({'%s\nFrec:      %.2f Hz\n|Z|:', ...
    '         %s\n ang(Z): %.2f º'}, ''), ...
    customtitles{idx_f}, X1(idx), ...
    get_resistance_in_correct_unit(abs(Y1(idx))), ...
    rad2deg(angle(Y1(idx))))};

end

function val = get_resistance_in_correct_unit(res)

if (res <= 1E-1)
    val = sprintf('%.2f mOhms', res * 1E3);
elseif (res >= 1E3)
    val = sprintf('%.2f KOhms', res / 1E3);
elseif (res >= 1E6)
    val = sprintf('%.2f MOhms', res / 1E6);
else
    val = sprintf('%.2f Ohms', res);
end


end


