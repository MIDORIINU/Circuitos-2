%Close images.
close all;

% Clean command line.
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create directories.

spice_directory = fullfile('..', 'LTSPICE', 'amplifier_V_2.1');

images_directory = fullfile('..', 'Informe', 'img');

sims_directory = 'sims';

mkdir(images_directory);

if (7 ~= exist(images_directory, 'dir'))
    error('Could not create directory: "%s".\n', images_directory);
end

img_points_directory = fullfile(images_directory, sims_directory);

mkdir(img_points_directory);

if (7 ~= exist(img_points_directory, 'dir'))
    error('Could not create directory: "%s".\n', img_points_directory);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% P11g_phase_margin(spice_directory, points_directory, ... % Check.
%     images_directory, false);
% 
% P11b_Ri(spice_directory, points_directory, ... % Check.
%     images_directory, false);
% 
% P11c_Ro(spice_directory, points_directory, ... % Check.
%     images_directory, false);

% P11d_RF_1W(spice_directory, points_directory, ... % Check.
%     images_directory, false);

% P11e_Power_BW(spice_directory, points_directory, ... % Check.
%     images_directory, false);

% P11f_I_step_small_signal(spice_directory, points_directory, ... % Check.
%     images_directory, false);

aab_Slew_Rate(spice_directory, sims_directory, ... % Check.
    images_directory, false);






