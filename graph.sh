#!/bin/bash



set terminal png
set output "RDF.png"
set size 1, 0.5


set origin 0.0,0.0
set ylabel "RDF"
set xlabel "T"
set grid
set title "Radial distribution function"
plot "lj/col_0.7/rdf.txt" using 2:3 with lines,"lj/col_0.8/rdf.txt" using 2:3 with lines,"lj/col_0.92/rdf.txt" using 2:3 with lines,"lj/col_0.96/rdf.txt" using 2:3 with lines
