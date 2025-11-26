#!/bin/bash

# Pré-requisito:
#
# conda create -n ambertools python==3.8
# conda activate ambertools
# pip install numpy==1.18.0
# pip install parmed
# conda install conda-forge::ambertools

name=$1 # Nome do arquivo .pdb que tem o ligante
nc=$2   # Carga total do ligante

cp "$name".pdb lig.pdb

# PDB -> MOl2 com nomes de átomos do GAFF2 e com cargas fitadas pelo BCC (reproduz Gaussian)
antechamber -i lig.pdb -fi pdb -o lig.mol2 -fo mol2 -nc $nc -c bcc -at gaff2 -pf yes -rn LIG 

# Gera arquivo FRCMOD com parâmetros desconhecidos
# FRCMOD -> FORCEfield MODification
# OBS: Aqui o parmchk2 vai chutar os parâmetros que o GAFF não tem
parmchk2 -i lig.mol2 -f mol2 -o lig.frcmod

# Constrói o script do TLEAP (programa do AMBER)
echo 'source leaprc.gaff2' > tleap.in # Lê o GAFF2
echo 'loadamberparams lig.frcmod' >> tleap.in # Aplica modificações no GAFF2 (frcmod gerado pelo parmchk2)
echo 'set default PBRadii mbondi2' >> tleap.in # Define os raios atômicos
echo 'lig = loadmol2 lig.mol2' >> tleap.in # Carrega mol2 do ligante (gerado pelo antechamber)
echo 'saveamberparm lig lig.prmtop lig.inpcrd' >> tleap.in # Salva topologia (prmtop) e estrutura (inpcrd) do AMBER
echo 'quit' >> tleap.in

# Executa o TLEAP (gera arquivos de topologia e estrutura do AMBER: PRMTOP e INPCRD)
tleap -f tleap.in

# Traduz AMBER->GROMACS: PRMTOP->TOP e INPCRD->GRO
# Aplica Hydrogen Mass Repartitioning
echo 'import parmed' > convert.py
echo 'lig = parmed.load_file("lig.prmtop", "lig.inpcrd")' >> convert.py
echo 'parmed.tools.actions.HMassRepartition(lig).execute()' >> convert.py
echo 'lig.save("lig.top", overwrite=True)' >> convert.py
echo 'lig.save("lig.gro", overwrite=True)' >> convert.py
python3 convert.py

# Move os arquivos para renomeá-los
mv lig.prmtop "$name".prmtop
mv lig.inpcrd "$name".inpcrd
mv lig.frcmod "$name".frcmod
mv lig.mol2   "$name".mol2
mv lig.top    "$name".top
mv lig.gro    "$name".gro

# Apaga os arquivos temporários/intermediários
rm leap.log sqm.in sqm.pdb sqm.out lig.pdb convert.py tleap.in

