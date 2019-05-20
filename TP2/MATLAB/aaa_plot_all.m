%Close images.
close all;

% Clean command line.
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create directories.

spice_directory = fullfile('..', 'LTSPICE');

images_directory = fullfile('..', 'Informe', 'img');

points_directory = 'puntos';

mkdir(images_directory);

if (7 ~= exist(images_directory, 'dir'))
    error('Could not create directory: "%s".\n', images_directory);
end

img_points_directory = fullfile(images_directory, points_directory);

mkdir(img_points_directory);

if (7 ~= exist(img_points_directory, 'dir'))
    error('Could not create directory: "%s".\n', img_points_directory);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P11g_phase_margin(spice_directory, points_directory, ... % Check.
    images_directory, false);