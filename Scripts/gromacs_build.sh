#!/bin/bash

pdb='prot_ok.pdb'

#echo '1 0 0 1  1 0 0 1  1 0 0 1  1 0 0 1' | gmx pdb2gmx -f $pdb -p top.top -ignh -his -ff amber03ws_ok -water tip4p -o solute.pdb -heavyh

#cat top.top | sed 's/tip4p.itp/tip4p2005s.itp/g' > tmp.top
#mv tmp.top top.top

echo 'Protein' | gmx editconf -f solute.pdb -o box.gro -d 1.2 -princ -c -bt dodecahedron

gmx solvate -cp box.gro   -o shell.gro -p top.top -cs ../topologies/amber03ws_ok.ff/tip4p2005.gro -shell 0.5
gmx solvate -cp shell.gro -o water.gro -p top.top -cs ../topologies/amber03ws_ok.ff/tip4p2005.gro


# Remove as águas extras

top='top.top'
n_w_atoms=4
n_line_first_wat=$(cat water.gro | grep SOL -n | head -n 1 | awk -F ':' '{print $1}')
n_wat_atm_to_remove=$(cat $top | grep ^'SOL   ' | head -n 1 | awk -v type_water=$n_w_atoms '{print $2 * type_water'})
echo $n_w_atoms
echo $n_line_first_wat
echo $n_wat_atm_to_remove
let n_last_line_pt1=$n_line_first_wat-1
let n_first_line_pt2=$n_line_first_wat+$n_wat_atm_to_remove
cat water.gro | head -n  $n_last_line_pt1   > tmp.gro
cat water.gro | tail -n +$n_first_line_pt2 >> tmp.gro
n_atm=$(wc -l tmp.gro | awk '{print $1}')
let n_atm=$n_atm-3
head -n 1 tmp.gro > water_ok.gro
echo $n_atm >> water_ok.gro
tail -n +3 tmp.gro >> water_ok.gro
rm tmp.gro
head -n -2 $top > tmp.top
tail -n 1 $top >> tmp.top
mv tmp.top $top


# Neutralização das cargas

gmx grompp -f ../mdps/min.mdp -c water_ok.gro -p top.top -o ion_neutral.tpr -maxwarn 1


valence=1
is=0.150
z_pos=1
z_neg=1
pos='K'
neg='CL'
z_pos_counter=1
z_neg_counter=1
pos_counter='K'
neg_counter='CL'

echo 'SOL' | gmx genion -s ion_neutral.tpr -o ion_neutral.gro -p top.top -pname $pos_counter -nname $neg_counter -pq $z_pos_counter -nq "-"$z_neg_counter  -neutral -conc 0.00

n_wat=$(cat ion_neutral.gro | grep 'SOL ' | grep 'OW' | wc -l | awk '{print $1}')

c_pos=$(echo '' | awk -v is=$is -v z_pos=$z_pos -v z_neg=$z_neg -v v=$valence '{a=(2*is)/((z_pos^2)+(v*(z_neg^2))) ; print a}')
c_neg=$(echo '' | awk -v c_pos=$c_pos -v v=$valence '{c_neg=v*c_pos ; print c_neg}')

n_pos=$(echo '' | awk -v c_pos=$c_pos -v n_wat=$n_wat '{n_pos=c_pos*(n_wat/55.55); printf "%.0f\n", n_pos}')
n_neg=$(echo '' | awk -v n_pos=$n_pos -v v=$valence '{n_neg=v*n_pos ; print n_neg}')


gmx grompp -f ../mdps/min.mdp -c ion_neutral.gro -o ion_is.tpr -p top.top -maxwarn 1
echo 'SOL' | gmx genion -s ion_is.tpr -o ion_is.gro -p top.top -pname $pos -nname $neg -np $n_pos -nn $n_neg
#echo 'System' | gmx trjconv -f ion_is.gro -s min.tpr -o ion_is.pdb -pbc mol -ur compact


gmx grompp -f ../mdps/min_none.mdp -c ion_is.gro -p top.top -maxwarn 1 -o min_none.tpr
gmx mdrun -s min_none.tpr -v -deffnm min_none

gmx grompp -f ../mdps/min.mdp -c min_none.gro -p top.top -maxwarn 1 -o min.tpr
gmx mdrun -s min.tpr -v -deffnm min

echo 0 | gmx trjconv -f min.gro -s min.tpr -o min.pdb -pbc mol -ur compact

# Equilibração

n=1
while [ $n -le 3 ]; do
gmx grompp -f ../mdps/eq_hmr.mdp -c min.gro -r min.gro -p top.top -o eq.$n -maxwarn 2
let n=$n+1
done

#gmx mdrun -s eq.1.tpr -v -deffnm eq.1
