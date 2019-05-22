function P11d_RF_1W(spice_directory, points_directory, ...
    images_directory, close_figures)


bode_simulation_colors = [1 0.4 0.1; 0.1 0.4 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RF.

simulation_name = 'P11d_RF_1W';

simulation_title = 'Respuesta en frecuencia a 1W de potencia';

simulation_mod_limits = [0 1.1];

simulation_mod_ticks = (0:0.1:1.1);

simulation_ang_limits = [-1080 0];

simulation_ang_ticks = unique(sort([(-1100:100:0) 0]), 'first');

graphic_handle = aab_power_rf(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_colors, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks);

image_file_name = fullfile(images_directory, ...
    points_directory, ...
    strjoin({simulation_name, '.png'}, ''));

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

