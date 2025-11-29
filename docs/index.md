![header](https://github.com/gabriela-frajtag/TCC-Metano/blob/main/header%20tcc.png?raw=true)

# INIBIÇÃO DE ENZIMAS METANOGÊNICAS COM PRODUTOS NATURAIS COMO ESTRATÉGIA DE MITIGAÇÃO DA EMISSÃO DE METANO 🐄

Repositório com as ferramentas e códigos utilizados no Trabalho de Conclusão de Curso desenvolvido na **Ilum Escola de Ciência**.

O estudo investiga se é possível **reduzir a emissão de metano** atuando diretamente nas **enzimas metanogênicas** presentes nos ruminantes.

| Equipe | |
|---|---|
| Autores | **Bruno Brischi**, **Gabriela Frajtag** |
| Supervisão | **Dr. Leandro Oliveira Bortot**, **Dra. Juliana Helena Costa Smetana** |
| Colaboração | **Iasodara do Carmo Lima dos Santos**, **Carlos Daniel Marques Santos Simões** |

---

## Estrutura do repositório

O diagrama abaixo resume a organização das pastas principais mencionadas ao longo da documentação.

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

---

## Seções de documentação

| Documento | Descrição |
|-----------|-----------|
| [`analises.md`](analises.md) | Notas unificadas dos resultados de Docking, Boltzina, Dinâmica Molecular, PropKa e Triagem virtual |
| [`scripts.md`](scripts.md)   | Manual dos scripts Bash usados para preparo, execução e pós‑processamento das simulações |
| [`boltzina.md`](boltzina.md) | Detalhes do notebook *analise_boltzina.ipynb* e das planilhas associadas |
| [`dinamica.md`](dinamica.md) | Resumo do notebook *Análise DM.ipynb* e organização das saídas do GROMACS |
| [`propka.md`](propka.md)     | Explicação da formatação e visualização dos resultados do PropKa |

---

## Dependências principais

```text
Simulação:
  • GROMACS com suporte a GPU
  • Singularity
  • GPU NVIDIA compatível

Parametrização de ligantes:
  • conda
  • AmberTools (antechamber, parmchk2, tleap)
  • Python 3 + numpy + parmed

Notebooks:
  • Python 3
  • Jupyter
  • numpy, pandas, matplotlib
```

---

## Como citar

```
Brischi, B. F.; Frajtag, G.; Simões, C. D. M. S.; Santos, I. C. L.
Inibição de enzimas metanogênicas com produtos naturais como estratégia de mitigação da emissão de metano.
Ilum Escola de Ciência – CNPEM, 2025.
https://github.com/gabriela-frajtag/TCC-Metano
```
