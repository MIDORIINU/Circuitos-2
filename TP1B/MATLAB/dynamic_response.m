function [figure_handle] = dynamic_response(file_name, ...
    fig_title, size_percent, fig_color_order, ...
    time_limits, time_ticks, ...    
    voltage_limits, voltage_ticks, ...
    current_limits, current_ticks)
%DYNAMIC_RESPONSE Plots a temporal graphic of the step response.

%Cargo los datos
TableData = importdata(file_name);

time = TableData.data(:,1);

Vout = TableData.data(:,2);

Iout = TableData.data(:,3);



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
plot(time, Vout, 'Parent', subplot1, 'Color', fig_color_order(1,:));

% Create ylabel
ylabel(subplot1, strjoin({'Tensión de salida de la fuente',...
    ' de alimentación (V_{out}) [V]'}, ''));

% Create xlabel
xlabel(subplot1, 'Tiempo [S]');

% Create title
title(subplot1, fig_title, 'Interpreter', 'latex');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'XGrid','on','XMinorTick','on','XTick',...
    time_ticks,...
    'YGrid','on','YMinorTick','on','YTick',...
    voltage_ticks);


subplot1.XAxis.Exponent = -3;

xlim(subplot1,'manual');
xlim(subplot1,time_limits);

ylim(subplot1,'manual');
ylim(subplot1,voltage_limits);


%%%%%%


% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure_handle);
hold(subplot1,'on');

% Create plot
plot(time, Iout, 'Parent', subplot2, 'Color', fig_color_order(2,:));

% Create ylabel
ylabel(subplot2, strjoin({'Coriente de salida de la fuente',...
    ' de alimentación (I_{out})) [A]'}, ''));

% Create xlabel
xlabel(subplot2, 'Tiempo [S]');

box(subplot2,'on');
% Set the remaining axes properties
set(subplot2,'XGrid','on','XMinorTick','on','XTick',...
    time_ticks,...
    'YGrid','on','YMinorTick','on','YTick',...
    current_ticks);


%subplot1.XAxis.Exponent = -3;

xlim(subplot2,'manual');
xlim(subplot2,time_limits);

ylim(subplot2,'manual');
ylim(subplot2,current_limits);



end

