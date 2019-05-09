function [CF_index] = find_cutoff_freq(module, ~)
%FIND_MARGINS Find high cutoff frequency.

[~, CF_index] = min( abs(module - module(1)*(sqrt(2)/2)) );



end

