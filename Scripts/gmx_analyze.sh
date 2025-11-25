#!/bin/bash

# Cria diretório para as análises
path_out='analises'
mkdir $path_out 2>/dev/null

# "Flags" para controlar quais análises serão executadas
trj=1
rmsd=1 # RMSD - Mudança estrutural
rmsf=1 # RMSF - Flexibilidade estrutural
sasa=1 # SASA - Solvent Accessible Surface Area
rg=1   # Radius of Gyration
hb=1   # Hydrogen Bonds

total=3  # Número total de réplicas (md.1, md.2, md.3)
dt=1000   # Intervalo de tempo dos frames analisados (em ps)
e=200000 # Tempo total da simulação (em ps)

xvg='xmgrace' # Formata arquivos .xvg? Para não formatar, use "none". Para formatar, use "xmgrace".

#######################################################SÓ POSSO MEXER DAQUI PRA CIMA#################################################
# Strings dos tempos de começo e fim em ns
b=$(echo $e | awk '{printf "%d\n",$1/2}')
b_ns=$(echo $b | awk '{printf "%d\n",$1/1000}')
e_ns=$(echo $e | awk '{printf "%d\n",$1/1000}')

# Cria o arquivo de índice caso ele não exista
if [ ! -e "index.ndx" ]; then
    echo -e 'q'"\n" | gmx make_ndx -f md.1.tpr -o index.ndx
fi

n=1
while [ $n -le $total ]; do


    if [ $trj -eq 1 ]; then
            # Gera trajetórias para visualização no PyMOL

            echo 'C-alpha non-water' | gmx trjconv -f md_fit."$n".xtc -s md."$n".tpr -o "$path_out"/trj_000-"$e_ns"ns."$n".pdb     -fit rot+trans -dt $dt -b 0  -e $e -n index.ndx
            echo 'C-alpha non-water' | gmx trjconv -f md_fit."$n".xtc -s md."$n".tpr -o "$path_out"/trj_"$b_ns"-"$e_ns"ns."$n".pdb -fit rot+trans -dt $dt -b $b -e $e -n index.ndx
    fi


    # ---------- RMSD ----------  (Root Mean Square Deviation, Medida de mudança estrutural ao longo do tempo)
    if [ $rmsd -eq 1 ]; then
        # RMSD geral entre todos os C-alpha
        echo 'C-alpha C-alpha' | gmx rms -f md_fit."$n".xtc -s md."$n".tpr -o "$path_out"/rmsd_ca-ca."$n".xvg -xvg "$xvg" -dt $dt -n index.ndx
    fi


    # ---------- RMSF ---------- (Root Mean Square Fluctuation, Medida de flexibilidade estrutural)
    if [ $rmsf -eq 1 ]; then
        # Calcula RMSF dos C-alpha com base na estrutura média dos C-alpha de cada trajetória
        echo 'C-alpha' | gmx rmsf -f md_fit."$n".xtc -s md."$n".tpr -o "$path_out"/rmsf_"$b_ns"-"$e_ns"ns."$n".xvg -xvg "$xvg" -res -dt $dt -b $b -e $e -ox avg_ca_"$b_ns"-"$e_ns"ns."$n".pdb -n index.ndx
	# >>>> RMSF por cadeia (cada replica = 6 xvgs)
    fi


    # ---------- SASA ---------- (Surface Accessible Solvent Area, medida de área exposta ao solvente)
    if [ $sasa -eq 1 ]; then
        gmx sasa -f md_fit."$n".xtc -s md."$n".tpr -o "$path_out"/sasa."$n".xvg -or "$path_out"/sasa_res."$n".xvg -tv "$path_out"/sasa_vol."$n".xvg -surface Protein -output Protein -xvg "$xvg" -dt $dt -n index.ndx
    fi


    # ---------- RG ----------
    if [ $sasa -eq 1 ]; then
        echo 'Protein' | gmx gyrate -f md_fit."$n".xtc -s md."$n".tpr -o "$path_out"/rg."$n".xvg -xvg "$xvg" -dt $dt -n index.ndx
    fi


    # ---------- HB ----------
    if [ $hb -eq 1 ]; then
        echo 'Protein Protein' | gmx hbond-legacy -f md_fit."$n".xtc -s md."$n".tpr -num "$path_out"/hb."$n".xvg -xvg "$xvg" -dt $dt -n index.ndx
    fi


    let n=$n+1
done


rm "$path_out"/\#* 2>/dev/null

