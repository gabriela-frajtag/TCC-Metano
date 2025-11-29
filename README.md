
![alt text](https://github.com/gabriela-frajtag/TCC-Metano/blob/main/header%20tcc.png?raw=true)
# INIBIÇÃO DE ENZIMAS METANOGÊNICAS COM PRODUTOS NATURAIS COMO ESTRATÉGIA DE MITIGAÇÃO DA EMISSÃO DE METANO🐄
Repositório para disponibilizar as ferramentas e códigos usados para realizar o Trabalho de Conclusão de Curso


**Oi**! Tudo bem? 👋

Você sabia que os **ruminantes** (🐄🐑🐐) liberam **metano** durante a digestão?
E que esse metano contribui significativamente para o **aquecimento global**? 🌍🔥

Este repositório reúne o material que desenvolvemos para o nosso Trabalho de Conclusão de Curso (TCC) na  na Ilum Escola de Ciência, onde exploramos a seguinte ideia:
**E se a gente reduzisse o metano atuando direto nas enzimas que o produzem?**

Os autores do projeto são **Bruno Brischi** e **Gabriela Frajtag**, com a supervisão do **Dr. Leandro Oliveira Bortot** e da **Dra. Juliana Helena Costa Smetana** e colaboração de **Iasodara do Carmo Lima dos Santos** e **Carlos Daniel Marques Santos Simões**


**Organização do Repositório**

```plaintext

TCC-Metano/
├── Análises/
│   ├── Boltz (não usada)/
│   ├── Boltzina/
│   ├── Dinâmica Molecular/
│   ├── PropKa/
│   └── Triagem virtual/
│
├── PDBs/
│   ├── mcr.pdb
│   └── mer.pdb
│
├── Scripts/
│   ├── gmx_analyze.sh
│   ├── gmx_pbc.sh
│   ├── gromacs_build.sh
│   ├── parametriz_lig.sh
│   └── run-gmx_big.sh
│
├── amber03ws/       
├── mdps/            
└── README.md
```


[Análises](Análises/README.md): Arquivo contendo a descrição geral das análises realizadas. Para detalhes de cada análise, basta verificar: [Boltziana](Análises/Boltzina/README.md), [Dinamica Molecular](Análises/Dinâmica%20Molecular/README.md), [PropKa](Análises/PropKa/README.md).

[Scripts](Scripts/README.md): Os scripts de preparação, execução em cluster e pós-processamento das trajetórias podem ser consultados em  


## Dependências

```text
Simulação:
  GROMACS com GPU
  Singularity
  GPU NVIDIA compatível

Parametrização de ligantes:
  conda
  AmberTools (antechamber, parmchk2, tleap)
  Python 3
  numpy
  parmed

Notebooks:
  Python 3
  Jupyter
  numpy
  pandas
  matplotlib
```

## Citação

```
Brischi, B. F.; Frajtag, G.; Simões, C. D. M. S.; Santos, I. C. L. Inibição de enzimas metanogênicas com produtos naturais como estratégia de mitigação da emissão de metano. Ilum Escola de Ciência – CNPEM, 2025. Disponível em: https://github.com/gabriela-frajtag/TCC-Metano
```
