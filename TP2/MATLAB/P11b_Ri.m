function P11b_Ri(spice_directory, points_directory, ...
    images_directory, close_figures)


z_simulation_colors = [1 0.4 0.1; 0.1 0.4 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ri.

simulation_name = 'P11b_Ri';

simulation_title = strjoin({'Impedancia de ', ...
    'entrada $\left( Z_{i} \right)$.'}, '');

simulation_freq_limits = [1E-2 1E9];

simulation_freq_ticks = 10.^(-2:1:9);

simulation_mod_limits = [0 10.5E6];

simulation_mod_ticks = (0:0.7E6:10.5E6);

simulation_ang_limits = [-150 0];

simulation_ang_ticks = (-150:10:0);


graphic_handle = aab_impedance(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, z_simulation_colors, ...
    simulation_freq_limits, simulation_freq_ticks, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks, ...
    6, 400);

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

