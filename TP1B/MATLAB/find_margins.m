function [PM_index, GM_index] = find_margins(module, phase_angle)
%FIND_MARGINS Find phase margins and gain margins in data arrays.

% PM_index = find( Y1 >= 2.028, 1);

[~, PM_index] = min( abs(module - 1) );

% module(PM_index-1:PM_index+1)


[~, GM_index] = min( abs(phase_angle + pi) );
 
% phase_angle(GM_index-1:GM_index+1)

end

