function aab_phase_margin_C(spice_directory, points_directory, ...
    images_directory, close_figures)


bode_simulation_colors = [1 0.4 0.1; 0.1 0.4 1];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOOP.

simulation_name = 'amplifier_V2.1_LOOP';

simulation_save_name = 'gain_loop_C';

simulation_title = strjoin({'Ganancia de lazo ', ...
    '$ \left( a \cdot f \right)', ...
    '_{ \left( j \cdot \omega \right)} $'}, '');

simulation_mod_limits = [-120 90];

simulation_mod_ticks = (-120:10:90);

simulation_ang_limits = [-400 50];

simulation_ang_ticks = unique(sort([(-400 :25: 50) -180]), 'first');

graphic_handle = aab_loop_gain(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_colors, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks);

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



