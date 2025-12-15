#!/usr/bin/bash
for $fic in ./Ntraite/*.jpeg
do
    tailleX=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 1
    tailleY=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 2
    if 
done