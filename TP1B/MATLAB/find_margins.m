function [PM_index, GM_index] = find_margins(freq, module, phase_angle)
%FIND_MARGINS Find phase margins and gain margins in data arrays.

%[~, PM_index] = min( abs(module - 1) );

PM_index = find((module - 1) < 0, 1);

if isempty(PM_index)
    PM_index = length(module);
end

% [~, GM_index] = min( abs(phase_angle + pi) );

GM_index = find((phase_angle + pi) < 0, 1);

if isempty(GM_index)
    GM_index = length(phase_angle);
end

end

