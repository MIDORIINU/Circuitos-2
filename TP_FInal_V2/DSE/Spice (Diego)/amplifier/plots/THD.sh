#!/bin/bash

cat ../amplifier_THD_vs_freq_20_to_1K.txt ../amplifier_THD_vs_freq_1k_to_25k.txt | grep "Total Harmonic Distortion:" | cut -d: -f 2 | cut -d' ' -f 2 | cut -d% -f 1
