function [figure_handle] = aab_dynamic_response(file_name, ...
    fig_title, size_percent, fig_color_order, ...
    time_limits, time_ticks, ...
    vin_limits, vin_ticks, vin_exp,...
    vout_limits, vout_ticks, vout_exp)
%DYNAMIC_RESPONSE Plots a temporal graphic of the step response.

%Cargo los datos
TableData = importdata(file_name);

time = TableData.data(:,1);

Vin = TableData.data(:,2);

Vout = TableData.data(:,3);



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
plot(time, Vin, 'Parent', subplot1, 'Color', fig_color_order(1,:));

% Create ylabel
ylabel(subplot1, strjoin({'Tensi\''{o}n de entrada ',...
    '($V_{out}$) [V]'}, ''), 'Interpreter', 'latex');

% Create xlabel
xlabel(subplot1, 'Tiempo [S]');

% Create title
title(subplot1, fig_title, 'Interpreter', 'latex');

box(subplot1,'on');
% Set the remaining axes properties
set(subplot1,'XGrid','on','XMinorTick','on','XTick',...
    time_ticks,...
    'YGrid','on','YMinorTick','on','YTick',...
    vin_ticks);

subplot1.XAxis.Exponent = -3;
subplot1.YAxis.Exponent = vin_exp;

xlim(subplot1,'manual');
xlim(subplot1,time_limits);

ylim(subplot1,'manual');
ylim(subplot1,vin_limits);


%%%%%%


% Create subplot
subplot2 = subplot(2, 1, 2, 'Parent', figure_handle);
hold(subplot1,'on');

% Create plot
plot(time, Vout, 'Parent', subplot2, 'Color', fig_color_order(2,:));

% Create ylabel
ylabel(subplot2, strjoin({'Tensi\''{o}n de salida ',...
    '($V_{out}$) [V]'}, ''), 'Interpreter', 'latex');

% Create xlabel
xlabel(subplot2, 'Tiempo [S]');

box(subplot2,'on');
% Set the remaining axes properties
set(subplot2,'XGrid','on','XMinorTick','on','XTick',...
    time_ticks,...
    'YGrid','on','YMinorTick','on','YTick',...
    vout_ticks);

subplot2.XAxis.Exponent = -3;
subplot2.YAxis.Exponent = vout_exp;

xlim(subplot2,'manual');
xlim(subplot2,time_limits);

ylim(subplot2,'manual');
ylim(subplot2,vout_limits);



end

