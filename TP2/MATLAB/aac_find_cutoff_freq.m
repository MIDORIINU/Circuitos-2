function [CF_index_low, CF_index_high, max_mod, max_mod_index] = ...
    aac_find_cutoff_freq(module, ~, freq)
%FIND_MARGINS Find cutoff frequencies.

[max_mod, max_mod_index] = max(module);

CF_index_low = find((module - max_mod/2) > 0, 1);

freq(CF_index_low)

CF_index_high = find((module(max_mod_index:end) - max_mod/2) < 0, 1) + ...
    max_mod_index;

freq(CF_index_high)


end

