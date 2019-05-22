#!/bin/bash

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for f in *.png
do
  convert -trim "$f" "$f"
done
IFS=$SAVEIFS
