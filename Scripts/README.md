# Scripts

Esta pasta reúne os scripts usados para preparar sistemas, corrigir trajetórias, rodar simulações em lote no cluster e parametrizar ligantes. Eles foram escritos para um ambiente com GROMACS, Slurm e Singularity, e assumem uma certa organização de arquivos descrita no README principal do repositório.

## run-gmx_big.sh

Script de submissão para rodar várias simulações de produção em GPU usando Slurm e um container Singularity com GROMACS.

O script espera dois argumentos. O primeiro é uma lista de caminhos com prefixos no formato `caminho/prefixo`, separados por espaço. Cada prefixo identifica um par de arquivos `.tpr` e `.cpt` ou `.xtc` dentro de um diretório. O segundo argumento é opcional e ativa o modo de teste, que reduz o número de passos.

Exemplo de uso em um nó de cluster:

```bash
sbatch run-gmx_big.sh "mcr/apo/md mcr/holo/md mer/apo/md" teste
```

Para cada entrada da lista, o script entra no diretório correspondente, monta a linha de comando do `mdrun` com aceleração em GPU e chama:

```bash
singularity run --nv ~/gromacs_2024.5_gpu.sif mdrun -s PREFIX.tpr -v -deffnm PREFIX -pin off -nstlist 150 -nb gpu -bonded gpu -pme gpu -ntomp $SLURM_CPUS_PER_TASK
```

Se existir `PREFIX.xtc`, o script retoma a simulação com `-cpi PREFIX.cpt -append`. Quando o segundo argumento não está vazio, ele adiciona `-nsteps 50000 -resetstep 40000 -noconfout`, útil para testar se o ambiente está configurado corretamente antes de rodar simulações longas.

## gmx_analyze.sh

Script de pós-processamento das trajetórias de dinâmica molecular. Ele cria um diretório `analises` e, para cada réplica, gera arquivos de RMSD, RMSF, SASA, raio de giração, pontes de hidrogênio e trajetórias em PDB para visualização.

Os parâmetros principais são definidos no início do arquivo: número total de réplicas (`total`), intervalo de amostragem em ps (`dt`), tempo total da simulação (`e`) e flags que ativam ou desativam cada tipo de análise. O script assume arquivos `md_fit.N.xtc` e `md.N.tpr` para cada réplica e cria `index.ndx` automaticamente se ele não existir.

Uso típico depois de já ter processado PBC e gerado `md_fit.N.xtc`:

```bash
bash gmx_analyze.sh
```

Os resultados são escritos em `analises/`, com nomes como `rmsd_ca-ca.1.xvg`, `rmsf_100-200ns.2.xvg`, `sasa.3.xvg`, além de trajetórias PDB recortadas em diferentes janelas de tempo.

## gmx_pbc.sh

Script para corrigir problemas de contorno periódico e gerar trajetórias adequadas para visualização e análise. Ele recebe dois argumentos: o prefixo dos arquivos (`md`, por exemplo) e o índice da réplica.

Exemplo:

```bash
bash gmx_pbc.sh md 1
```

O script aplica, em sequência, `gmx trjconv` para tornar as moléculas inteiras, extrair o primeiro frame, remover saltos de PBC, recentralizar o sistema em torno de um grupo de referência (Protein), reconstruir uma caixa compacta, ajustar a trajetória ao grupo de ajuste (C-alpha) e gerar versões sem água e um TPR correspondente. Também produz uma trajetória PDB recortada no intervalo de interesse, com passos definidos por `b`, `e` e `dt` em ps.

## gromacs_build.sh

Script para construir e solvar o sistema de proteína, ajustar o número de moléculas de água, neutralizar cargas e adicionar íons até a força iônica desejada, além de montar as etapas de minimização e equilibração.

O script espera encontrar um arquivo de proteína preparado (`prot_ok.pdb`) e um campo de força previamente configurado. Ele:

1. Define a caixa dodecaédrica e centraliza a proteína com `gmx editconf`.
2. Solva o sistema em duas etapas, gerando `shell.gro` e `water.gro` com o modelo de água especificado.
3. Remove águas extras de forma controlada, recalcula o número total de átomos e atualiza o arquivo `top.top`.
4. Faz a neutralização das cargas com `gmx genion` a partir de um `ion_neutral.tpr`.
5. Calcula o número de íons para atingir a força iônica desejada e gera um sistema com íons (`ion_is.gro`).
6. Executa minimizações em duas etapas (`min_none` e `min`) usando os arquivos `.mdp` em `../mdps`.
7. Gera `min.pdb` como estrutura minimizada.
8. Prepara três arquivos de equilibração (`eq.1`, `eq.2`, `eq.3`) com `gmx grompp`, prontos para rodar com `mdrun`.

A chamada típica é feita após preparar `prot_ok.pdb` e o diretório de topologias:

```bash
bash gromacs_build.sh
```

## parametrize_lig.sh

Script para parametrizar ligantes em AMBER e converter para GROMACS usando AmberTools e parmed. Ele recebe dois argumentos: o nome base do arquivo PDB do ligante (sem extensão) e a carga total do ligante.

Pré-requisitos sugeridos:

```bash
conda create -n ambertools python==3.8
conda activate ambertools
pip install numpy==1.18.0 parmed
conda install conda-forge::ambertools
```

Uso típico:

```bash
bash parametrize_lig.sh LIGANTE 0
```

O script copia `LIGANTE.pdb` para `lig.pdb`, gera `lig.mol2` com `antechamber` usando GAFF2 e cargas BCC, cria um arquivo `lig.frcmod` com `parmchk2`, monta um script `tleap.in` para produzir `lig.prmtop` e `lig.inpcrd`, e em seguida usa um pequeno script Python com `parmed` para aplicar Hydrogen Mass Repartitioning e salvar `lig.top` e `lig.gro`. No final, renomeia todos os arquivos para usar o nome original do ligante e remove arquivos temporários.

Esse script é o ponto de partida para integrar novos ligantes ao pipeline de DM com o mesmo padrão de parametrização usado ao longo do projeto.
