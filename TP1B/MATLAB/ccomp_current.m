function ccomp_current(spice_directory, loop_directory, rf_directory, ...
    dynamic_directory, images_directory, close_figures)


bode_simulation_color_list = [1 0.4 0.1; 0.4 1 0.1; 0.4 0.1 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DYNAMIC RESPONSE.

component_values = {'5n', '10n', '20n'};
component_labels = {'5nF', '10nF', '20nF'};

for idx = (1 : length(component_values))
    
    dynamic_plot_mode_3(component_values{idx}, ...
        component_labels{idx}, spice_directory, ...
        dynamic_directory, images_directory, close_figures);
    
    dynamic_plot_mode_4(component_values{idx}, ...
        component_labels{idx}, spice_directory, ...
        dynamic_directory, images_directory, close_figures);
    
end

% Execute crop script.
olddir = cd(fullfile(images_directory, ...
    dynamic_directory));

[status,~] = system('crop.cmd');

if status
    warning('%s.\n', 'Cannot execute system command.');
end

cd(olddir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOOP CURRENT MODE.

simulation_name = 'power_supply_CCOMP_LOOP_Modo3';

simulation_directory = 'Ccomp_corriente';

parametric_labels = {'5nF', '10nF', '20nF'};

simulation_title = strjoin({'Ganancia de lazo ', ...
    '$ \left( a \cdot f \right)', ...
    '_{ \left( j \cdot \omega \right)} $', ...
    ' parametrizada por Ccomp en modo corriente, 2A'}, '');

simulation_prealocation_count = 65000;

simulation_mod_limits = [-150 100];

simulation_mod_ticks = (-150:25:100);

simulation_ang_limits = [-500 50];

simulation_ang_ticks = sort([(-500 :50: 50) -180]);

graphic_handle = aab_loop_gain(...
    fullfile(spice_directory, simulation_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_color_list, ...
    simulation_prealocation_count, 3, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks, ...
    parametric_labels);

image_file_name = fullfile(images_directory, ...
    loop_directory, ...
    strjoin({simulation_name, '.png'}, ''));

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end

%%%%-----------------------------------------------

simulation_name = 'power_supply_CCOMP_LOOP_Modo4';

simulation_title = ...
    strjoin({'Ganancia de lazo $ \left( a \cdot f \right)', ...
    '_{ \left( j \cdot \omega \right)} $', ...
    ' parametrizada por Ccomp en modo corriente, 200mA'}, '');

simulation_prealocation_count = 65000;

simulation_mod_limits = [-150 100];

simulation_mod_ticks = (-150:25:100);

simulation_ang_limits = [-500 50];

simulation_ang_ticks = sort([(-500 :50: 50) -180]);

graphic_handle = aab_loop_gain(...
    fullfile(spice_directory, simulation_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_color_list, ...
    simulation_prealocation_count, 3, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks, ...
    parametric_labels);

image_file_name = fullfile(images_directory, ...
    loop_directory, ...
    strjoin({simulation_name, '.png'}, ''));

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end

% Execute crop script.
olddir = cd(fullfile(images_directory, ...
    loop_directory));

[status,~] = system('crop.cmd');

if status
    warning('%s.\n', 'Cannot execute system command.');
end

cd(olddir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RF CURRENT MODE.

simulation_name = 'power_supply_CCOMP_RF_Modo3';

simulation_directory = 'Ccomp_corriente';

parametric_labels = {'5nF', '10nF', '20nF'};

simulation_title = strjoin({'Respuesta en frecuencia $',...
    ' \left( \frac{I_{L}}{V_{Ref}} \right)', ...
    '_{ \left( j \cdot \omega \right)} $', ...
    ' parametrizada por Ccomp en modo corriente, 2A', ''});

simulation_prealocation_count = 65000;

simulation_mod_limits = [-75 55];

simulation_mod_ticks = (-75:10:55);

simulation_ang_limits = [-240 90];

simulation_ang_ticks = unique(sort([(-240 :30: 90) 0]), 'first');

graphic_handle = aab_rf(...
    fullfile(spice_directory, simulation_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_color_list, ...
    simulation_prealocation_count, 3, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks, ...
    parametric_labels);

image_file_name = fullfile(images_directory, ...
    rf_directory, ...
    strjoin({simulation_name, '.png'}, ''));

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end

%%%%-----------------------------------------------

simulation_name = 'power_supply_CCOMP_RF_Modo4';

simulation_title = strjoin({'Respuesta en frecuencia $', ...
    ' \left( \frac{I_{L}}{V_{Ref}} \right)', ...
    '_{ \left( j \cdot \omega \right)} $', ...
    ' parametrizada por Ccomp en modo corriente, 200mA'}, '');

simulation_prealocation_count = 65000;

simulation_mod_limits = [-75 55];

simulation_mod_ticks = (-75:10:55);

simulation_ang_limits = [-240 90];

simulation_ang_ticks = unique(sort([(-240 :30: 90) 0]), 'first');

graphic_handle = aab_rf(...
    fullfile(spice_directory, simulation_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_color_list, ...
    simulation_prealocation_count, 3, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks, ...
    parametric_labels);

image_file_name = fullfile(images_directory, ...
    rf_directory, ...
    strjoin({simulation_name, '.png'}, ''));

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end

% Execute crop script.
olddir = cd(fullfile(images_directory, ...
    rf_directory));

[status,~] = system('crop.cmd');

if status
    warning('%s.\n', 'Cannot execute system command.');
end

cd(olddir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end



function dynamic_plot_mode_3(component_value, component_label, ...
    spice_directory, dynamic_directory, images_directory, close_figures)

time_simulation_color_list = [1 0.4 0.1; 0.4 0.1 1];

simulation_name = sprintf('power_supply_CCOMP_%s_STEP_Modo3', ...
    component_value);

simulation_save_name = simulation_name;

simulation_directory = 'Ccomp_corriente';

simulation_title = strjoin({...
    'Respuesta din\''{a}mica a un salto de carga ', ...
    ' para $ Ccomp = ', ...
    component_label, ..., ...
    '$ en modo corriente, 2A'}, '');

simulation_voltage_limits = [0 12];

simulation_voltage_ticks = (0 :1:12);

simulation_current_limits = [0 70];

simulation_current_ticks = (0 :5:70);

graphic_handle = aab_dynamic_response(...
    fullfile(spice_directory, simulation_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, 100, time_simulation_color_list, ...
    simulation_voltage_limits, simulation_voltage_ticks, ...
    simulation_current_limits, simulation_current_ticks);

image_file_name = fullfile(images_directory, ...
    dynamic_directory, ...
    strjoin({simulation_save_name, '.png'}, ''));

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end

end


function dynamic_plot_mode_4(component_value, component_label, ...
    spice_directory, dynamic_directory, images_directory, close_figures)

time_simulation_color_list = [1 0.4 0.1; 0.4 0.1 1];

simulation_name = sprintf('power_supply_CCOMP_%s_STEP_Modo4', ...
    component_value);

simulation_save_name = simulation_name;

simulation_directory = 'Ccomp_corriente';

simulation_title = strjoin(...
    {'Respuesta din\''{a}mica a un salto de carga ', ...
    ' para $ Ccomp = ', ...
    component_label, ..., ...
    '$ en modo corriente, 200mA'}, '');

simulation_voltage_limits = [0 12];

simulation_voltage_ticks = (0 :1:12);

simulation_current_limits = [0 70];

simulation_current_ticks = (0 :5:70);

graphic_handle = aab_dynamic_response(...
    fullfile(spice_directory, simulation_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, 100, time_simulation_color_list, ...
    simulation_voltage_limits, simulation_voltage_ticks, ...
    simulation_current_limits, simulation_current_ticks);

image_file_name = fullfile(images_directory, ...
    dynamic_directory, ...
    strjoin({simulation_save_name, '.png'}, ''));

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end

end




