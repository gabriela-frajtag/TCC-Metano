#!/bin/bash

prefix=$1 # nomes dos arquivos xtc e tpr
r=$2 # réplica
# exemplo: para uma simulação que está nos arquivos md.1.xtc e md.1.tpr, prefix=md e r=1.

grp_center='Protein'
grp_fit='C-alpha'

keep_files=0 # Se =0, apaga arquvios intermediários ao final do script

# Tempos, em ps, para gerar trajetória de visualização
b=0      # ps
e=200000 # ps
dt=1000  # ps

let viz_b=$b/1000
let viz_e=$e/1000
let viz_dt=$dt/1000

echo 'Replica '$r

echo 'Making all molecules whole ... '
echo 'System' | gmx trjconv -f "$prefix"."$r".xtc -s "$prefix"."$r".tpr -o "$prefix"_whole."$r".xtc -pbc whole

echo 'Extracting the first frame ... '
echo 'System' | gmx trjconv -f "$prefix"_whole."$r".xtc -s "$prefix"."$r".tpr -o "$prefix"_whole_t0."$r".gro -e 0 -pbc mol -ur compact

echo 'Removing jumps ... '
echo 'System' | gmx trjconv -f "$prefix"_whole."$r".xtc -s "$prefix"_whole_t0."$r".gro -o "$prefix"_nojump."$r".xtc -pbc nojump

echo 'Centering on group '$grp_center' ... '
echo $grp_center' System' | gmx trjconv -f "$prefix"_nojump."$r".xtc -s "$prefix"."$r".tpr -o "$prefix"_center."$r".xtc -center

echo 'Reconstructing a compact box ... '
echo 'System' | gmx trjconv -f "$prefix"_center."$r".xtc -s "$prefix"."$r".tpr -o "$prefix"_pbc."$r".xtc -pbc mol -ur compact

echo 'Fitting to group '$grp_fit' ... '
echo $grp_fit' System' | gmx trjconv -f "$prefix"_pbc."$r".xtc -s "$prefix"."$r".tpr -o "$prefix"_fit."$r".xtc -fit rot+trans

echo 'Creating non-water trajectory ... '
echo 'Non-water' | gmx trjconv -f "$prefix"_fit."$r".xtc -s "$prefix"."$r".tpr -o "$prefix"_non-water."$r".xtc

echo 'Creating non-water tpr ... '
echo 'Non-water' | gmx convert-tpr -s "$prefix"."$r".tpr -o "$prefix"_non-water."$r".tpr

echo 'Creating a pdb non-water visualization trajectory ... '
echo 'Non-water' | gmx trjconv -f "$prefix"_fit."$r".xtc -s "$prefix"."$r".tpr -o "$prefix"_non-water_viz_"$viz_b"ns-"$viz_e"ns_dt"$viz_dt"ns."$r".pdb -b $b -e $e -dt $dt

if [ $keep_files -eq 0 ]; then
	rm md_whole."$r".xtc md_whole_t0."$r".gro md_nojump."$r".xtc md_center."$r".xtc md_pbc."$r".xtc
fi

