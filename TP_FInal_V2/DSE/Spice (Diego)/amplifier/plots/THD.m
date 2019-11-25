close all, clear all, clc;

images_directory= './';

%%

THD_vs_freq = dlmread('THD_vs_freq.txt', '\t');

f_THD_vs_freq = @(y) interp1(THD_vs_freq(:,1), THD_vs_freq(:,2), ...
    y, 'spline');

freq_points=THD_vs_freq(1,1):0.01:THD_vs_freq(length(THD_vs_freq(:,1)),1);

figure1 = figure('WindowState','maximized');

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');


% Create ylabel
ylabel(axes1,'THD [%]');

% Create xlabel
xlabel(axes1,'Frequency [Hz]');

title(axes1,'THD vs Frequency (Maximum power)');

box(axes1,'on');

xtickangle(axes1,75);

axes1.XAxis.Exponent = 0;

axes1.YAxis.Exponent = 0;

THD_points = 0:0.01:max(THD_vs_freq(:,2));

freq_points_sp=0:500:THD_vs_freq(length(THD_vs_freq(:,1)),1);

xlim(axes1, [0 THD_vs_freq(length(THD_vs_freq(:,1)),1)]);

% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    freq_points_sp, 'XTickLabel', ...
    cellfun(@num2str,num2cell(freq_points_sp),'uni',false), ...
    'YGrid','on','YMinorTick','on','YTick',...
    THD_points, 'YTickLabel', ...
    cellfun(@num2str,num2cell(THD_points),'uni',false));

plot(axes1, freq_points, f_THD_vs_freq(freq_points),'Color',[1 0 0]);

fprintf(...
    'Salvando el gráfico en un archivo "PNG"......');

% Salvo el gráfico en un archivo.
saveas(figure1, fullfile(images_directory, ...
    'THD_vs_freq.png'));

% Generación completa.
fprintf('Listo\n\n');


%%

THD_vs_power = dlmread('THD_vs_power.txt', '\t');

f_THD_vs_power = @(y) interp1(THD_vs_power(:,1), THD_vs_power(:,2), ...
    y, 'spline');

power_points=THD_vs_power(1,1):0.001:ceil(THD_vs_power(length(THD_vs_power(:,1)),1));

figure2 = figure('WindowState','maximized');

% Create axes
axes2 = axes('Parent',figure2);
hold(axes2,'on');


% Create ylabel
ylabel(axes2,'THD [%]');

% Create xlabel
xlabel(axes2,'Power [Watt]');

title(axes2,'THD vs Power');

box(axes2,'on');

xtickangle(axes2,75);

axes2.XAxis.Exponent = 0;

axes2.YAxis.Exponent = 0;

THD_points = 0:0.00001:max(THD_vs_power(:,2));

power_points_sp=0:1:THD_vs_power(length(THD_vs_power(:,1)),1);


xlim(axes2, [0 THD_vs_power(length(THD_vs_power(:,1)),1)]);

% Set the remaining axes properties
set(axes2,'XGrid','on','XMinorTick','on','XTick',...
    power_points_sp, 'XTickLabel', ...
    cellfun(@num2str,num2cell(power_points_sp),'uni',false), ...
    'YGrid','on','YMinorTick','on','YTick',...
    THD_points, 'YTickLabel', ...
    cellfun(@num2str,num2cell(THD_points),'uni',false));

plot(axes2, power_points, f_THD_vs_power(power_points));

fprintf(...
    'Salvando el gráfico en un archivo "PNG"......');

% Salvo el gráfico en un archivo.
saveas(figure2, fullfile(images_directory, ...
    'THD_vs_power.png'));

% Generación completa.
fprintf('Listo\n\n');
