function [CF_index] = find_bandwidth(module, ~)
%FIND_MARGINS Find high cutoff frequency.

[~, CF_index] = min( abs(module - module(1) - 3) );



end

