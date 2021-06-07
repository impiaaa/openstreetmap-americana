#!/bin/bash

for file in build/overpass/*.otf; do
    fontname=$(basename $file | sed 's/-/ /g;s/.otf$//;s/^overpass/Overpass/;s/bold/Bold/;s/light/Light/;s/ regular/ Regular/;s/ extra/ Extra/;s/ italic/ Italic/;s/ heavy/ Heavy/;s/ semi/ Semi/;s/ thin/ Thin/')
    mkdir "fonts/$fontname"
    npx build-glyphs $file "./fonts/$fontname"
done
