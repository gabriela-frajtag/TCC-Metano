
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

[amber03ws](https://github.com/gabriela-frajtag/TCC-Metano/tree/main/amber03ws/README.md)
: A pasta `amber03ws` contém o campo de força AMBER03ws utilizado nas simulações. Detalhes específicos encontram-se em  

[Análises](https://github.com/gabriela-frajtag/TCC-Metano/tree/main/Análises/README.md): As análises de dinâmica molecular, pKa e triagem virtual estão organizadas em  

A documentação escrita, incluindo explicações das metodologias, preparação dos sistemas e descrição dos protocolos, está em  
[docs](https://github.com/gabriela-frajtag/TCC-Metano/tree/main/docs/index.md)

Os arquivos de parâmetros .mdp utilizados na montagem e execução das simulações estão descritos em  
[mdps](https://github.com/gabriela-frajtag/TCC-Metano/tree/main/mdps/README.md)

As estruturas base de Mer e MCR utilizadas para gerar os sistemas simulados são explicadas em  
[PDBs](https://github.com/gabriela-frajtag/TCC-Metano/tree/main/PDBs/README.md)

Os scripts de preparação, execução em cluster e pós-processamento das trajetórias podem ser consultados em  
[Scripts](https://github.com/gabriela-frajtag/TCC-Metano/tree/main/Scripts/README.md)


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
