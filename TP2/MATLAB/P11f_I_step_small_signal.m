function P11f_I_step_small_signal(spice_directory, points_directory, ...
    images_directory, close_figures)


time_simulation_color_list = [1 0.4 0.1; 0.4 0.1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DYNAMIC RESPONSE.

simulation_name = 'P11f_I_step_small_signal';

simulation_title = ...
    'Respuesta din\''{a}mica a un escal\''{o}n en peque\~{n}a se\~{n}al';

simulation_time_limits = [0 1.5];

simulation_time_ticks = (0 : round((1.5/30)*1E5)/1E5 : 1.5);

simulation_vin_limits = [0 4E-2];

simulation_vin_ticks = (0 :2.5E-3:4E-2);

simulation_vout_limits = [-1.1 1.1];

simulation_vout_ticks = (-1.1 :0.1:1.1);

graphic_handle = aab_dynamic_response(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, 100, time_simulation_color_list, ...
    simulation_time_limits, simulation_time_ticks, ...
    simulation_vin_limits, simulation_vin_ticks, -3,...
    simulation_vout_limits, simulation_vout_ticks, 0);

image_file_name = fullfile(images_directory, ...
    points_directory, ...
    strjoin({simulation_name, '.png'}, ''));

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end


%%%%% ZOOM.

simulation_save_name = 'P11f_I_step_small_signal_zoom';

simulation_title = ...
    'Respuesta din\''{a}mica a un escal\''{o}n en peque\~{n}a se\~{n}al';

simulation_time_limits = [249.9925E-3 250.0095E-3];

simulation_time_ticks = (249.9925E-3:8.5E-7:250.0095E-3);

simulation_vin_limits = [0 4E-2];

simulation_vin_ticks = (0 :2.5E-3:4E-2);

simulation_vout_limits = [-1.1 1.1];

simulation_vout_ticks = (-1.1:0.1:1.1);

graphic_handle = aab_dynamic_response(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, 100, time_simulation_color_list, ...
    simulation_time_limits, simulation_time_ticks, ...
    simulation_vin_limits, simulation_vin_ticks, -3,...
    simulation_vout_limits, simulation_vout_ticks, 0);

image_file_name = fullfile(images_directory, ...
    points_directory, ...
    strjoin({simulation_save_name, '.png'}, ''));

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end


% Execute crop script.
olddir = cd(fullfile(images_directory, ...
    points_directory));

[status,~] = system('crop.cmd');

if status
    warning('%s.\n', 'Cannot execute system command.');
end

cd(olddir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end