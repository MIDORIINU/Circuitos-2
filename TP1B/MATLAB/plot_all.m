
%Close images.
close all;

% Clean command line.
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create directories.

spice_directory = fullfile('..', 'LTSPICE');

images_directory = fullfile('..', 'Informe', 'img', 'plots');

loop_directory = 'loop';

rf_directory = 'rf';

dynamic_directory = 'dynamic';


mkdir(images_directory);

if (7 ~= exist(images_directory, 'dir'))
    error('Could not create directory: "%s".\n', images_directory);
end

img_loop_directory = fullfile(images_directory, loop_directory);

mkdir(img_loop_directory);

if (7 ~= exist(img_loop_directory, 'dir'))
    error('Could not create directory: "%s".\n', img_loop_directory);
end

img_rf_directory = fullfile(images_directory, rf_directory);

mkdir(img_rf_directory);

if (7 ~= exist(img_rf_directory, 'dir'))
    error('Could not create directory: "%s".\n', img_rf_directory);
end

img_dynamic_directory = fullfile(images_directory, dynamic_directory);

mkdir(img_dynamic_directory);

if (7 ~= exist(img_dynamic_directory, 'dir'))
    error('Could not create directory: "%s".\n', img_dynamic_directory);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ccomp_current(spice_directory, loop_directory, rf_directory, ...
    dynamic_directory, images_directory);

ccomp_voltage(spice_directory, loop_directory, rf_directory, ...
    dynamic_directory, images_directory);

ccomp2(spice_directory, loop_directory, rf_directory, ...
    dynamic_directory, images_directory);

ccomp3(spice_directory, loop_directory, rf_directory, ...
    dynamic_directory, images_directory);

ccomp4(spice_directory, loop_directory, rf_directory, ...
    dynamic_directory, images_directory);

camort(spice_directory, loop_directory, rf_directory, ...
    dynamic_directory, images_directory);















