function aab_Power_BW(spice_directory, points_directory, ...
    images_directory, close_figures)


bode_simulation_colors = [1 0.4 0.1; 0.1 0.4 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RF.

simulation_name = 'amplifier_V2.1_POWER_BW';

simulation_save_name = 'Power_BW';

simulation_title ="Respuesta en frecuencia a m\'{a}xima potencia";

simulation_mod_limits = [0 65];

simulation_mod_ticks = (0:2:65);

simulation_ang_limits = [-1200 0];

simulation_ang_ticks = unique(sort([(-1200:100:0) 0]), 'first');

graphic_handle = aab_power_rf(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_colors, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks);

image_file_name = fullfile(images_directory, ...
    points_directory, ...
    strjoin({simulation_save_name, '.png'}, ''));

% Salvo el gr�fico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gr�fico luego de salvado.
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

