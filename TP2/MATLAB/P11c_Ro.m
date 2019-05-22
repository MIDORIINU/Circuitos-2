function P11c_Ro(spice_directory, points_directory, ...
    images_directory, close_figures)


z_simulation_colors = [1 0.4 0.1; 0.1 0.4 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ri.

simulation_name = 'P11c_Ro';

simulation_title = strjoin({'Impedancia de ', ...
    'salida $\left( Z_{o} \right)$.'}, '');

simulation_freq_limits = [1E-2 1E9];

simulation_freq_ticks = 10.^(-2:1:9);

simulation_mod_limits = [0 10];

simulation_mod_ticks = (0:0.5:10);

simulation_ang_limits = [-80 120];

simulation_ang_ticks = (-80:10:120);


graphic_handle = aab_impedance(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, z_simulation_colors, ...
    simulation_freq_limits, simulation_freq_ticks, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks, ...
    0, 100);

image_file_name = fullfile(images_directory, ...
    points_directory, ...
    strjoin({simulation_name, '.png'}, ''));

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

