
%Cierro las figuras existentes.
close all;

clc;






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creo los directorios.
images_directory = '../Informe/img/plots';

mkdir(images_directory);

if (7 ~= exist(images_directory, 'dir'))
    error('Could not create directory: "%s".\n', images_directory);
end

img_loop_directory = fullfile(images_directory, 'loop');

mkdir(img_loop_directory);

if (7 ~= exist(img_loop_directory, 'dir'))
    error('Could not create directory: "%s".\n', img_loop_directory);
end

img_rf_directory = fullfile(images_directory, 'rf');

mkdir(img_rf_directory);

if (7 ~= exist(img_rf_directory, 'dir'))
    error('Could not create directory: "%s".\n', img_rf_directory);
end

img_dynamic_directory = fullfile(images_directory, 'dynamic');

mkdir(img_dynamic_directory);

if (7 ~= exist(img_dynamic_directory, 'dir'))
    error('Could not create directory: "%s".\n', img_dynamic_directory);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOOP CURRENT MODE.

graphic_handle = loop_gain(...
    '../LTSPICE/Ccomp3_corriente/power_supply_CCOMP3_LOOP_Modo3.txt', ...
    'Ganancia de lazo (a \cdot f) parametrizada por Ccomp3 en modo corriente, 2A', ...
    100, [1 0.4 0.1; 0.4 1 0.1; 0.4 0.1 1], ...
    270000, 3, ...
    [-150 100], (-150:25:100), ...
    [-500 50], sort([(-500 :50: 50) -180]), ...
    {'5nF', '10nF', '20nF'});


% Salvo el gráfico en un archivo.
saveas(graphic_handle, fullfile(images_directory, ...
    'loop/power_supply_CCOMP3_LOOP_Modo3.png'));

graphic_handle = loop_gain(...
    '../LTSPICE/Ccomp3_corriente/power_supply_CCOMP3_LOOP_Modo4.txt', ...
    'Ganancia de lazo (a \cdot f) parametrizada por Ccomp3 en modo corriente, 200mA', ...
    100, [1 0.4 0.1; 0.4 1 0.1; 0.4 0.1 1], ...
    270000, 3, ...
    [-150 100], (-150:25:100), ...
    [-500 50], sort([(-500 :50: 50) -180]), ...
    {'5nF', '10nF', '20nF'});


% Salvo el gráfico en un archivo.
saveas(graphic_handle, fullfile(images_directory, ...
    'loop/power_supply_CCOMP3_LOOP_Modo4.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RF CURRENT MODE.

graphic = rf(...
    '../LTSPICE/Ccomp3_corriente/power_supply_CCOMP3_RF_Modo3.txt', ...
    'Respuesta en frecuencia parametrizada por Ccomp3 en modo corriente, 2A', ...
    100, [1 0.4 0.1; 0.4 1 0.1; 0.4 0.1 1], ...
    270000, 3, ...
    [-65 30], (-65:10:30), ...
    [-240 60], (-240 :30: 60), ...
    {'5nF', '10nF', '20nF'});

% Salvo el gráfico en un archivo.
saveas(graphic_handle, fullfile(images_directory, ...
    'rf/power_supply_CCOMP3_RF_Modo3.png'));


graphic_handle = rf(...
    '../LTSPICE/Ccomp3_corriente/power_supply_CCOMP3_RF_Modo4.txt', ...
    'Respuesta en frecuencia parametrizada por Ccomp3 en modo corriente, 200mA', ...
    100, [1 0.4 0.1; 0.4 1 0.1; 0.4 0.1 1], ...
    270000, 3, ...
    [-70 50], (-70:10:50), ...
    [-190 80], (-190 :30: 80), ...
    {'5nF', '10nF', '20nF'});

% Salvo el gráfico en un archivo.
saveas(graphic_handle, fullfile(images_directory, ...
    'rf/power_supply_CCOMP3_RF_Modo4.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

