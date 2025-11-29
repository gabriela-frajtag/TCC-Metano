# Análises

Esta pasta reúne os notebooks e arquivos auxiliares usados para pós-processar os resultados de docking, Boltzina, dinâmica molecular, estimativa de pKa e triagem virtual de compostos descritos na monografia.

A documentação detalhada de cada conjunto de análises está organizada nos READMEs das subpastas:

### Boltzina

[Boltzina](boltz.md)

Subpasta com o notebook `analise_boltzina.ipynb` e as planilhas `boltzina_mcr.xlsx` e `boltzina_mer.xlsx`. O notebook lê as saídas do modelo Boltzina e dos dockings para MCR e Mer, monta dataframes consolidados e gera:

- histogramas dos docking scores;
- histogramas das probabilidades de afinidade (`affinity_probability_binary` e variantes);
- comparações gráficas entre rankings de docking e rankings do Boltzina;
- relações simples entre score de docking, probabilidades binárias e valores previstos pelos modelos.

Os gráficos são salvos em arquivos `.png` na própria pasta.

### Dinâmica Molecular

[Dinâmica Molecular](dinamica.md)

Subpasta que reúne o notebook `Análise DM.ipynb`, o pacote `Análise DM.zip` e as saídas do GROMACS organizadas nas pastas:

- `analises_mcr_6mer_apo`
- `analises_mcr_6mer_holo`
- `analises_mer_4mer_apo`
- `analises_mer_4mer_f420`

O notebook converte arquivos `.xvg` em dataframes pandas com funções auxiliares, calcula médias e desvios padrão entre réplicas e gera séries temporais e envelopes de incerteza para:

- RMSD médio da MCR e da Mer em diferentes condições (apo e com cofator);
- RMSF médio por resíduo e por cadeia da MCR e da Mer;
- área acessível ao solvente (SASA) total e por resíduo;
- raio de giro (Rg) ao longo do tempo;
- número de ligações de hidrogênio ao longo da simulação.

As figuras são salvas em arquivos `.jpg` na própria pasta.

### PropKa

[PropKa](propka.md)

Subpasta com o notebook `Análise de pKa.ipynb` e arquivos intermediários (`pka_formatado_3colunas.csv`, `pka_mcr6mer_3colunas.csv`, `RESUMO_mcr_6mer_pka.txt`). O notebook:

- formata o resumo textual do PropKa em tabelas (`csv`) padronizadas;
- separa resíduos por cadeia para Mer e MCR;
- remove terminais, cisteínas e tirosinas quando necessário;
- gera gráficos de barras de pKa por resíduo, colorindo por tipo (ASP, GLU, HIS, LYS, ARG etc.);
- produz versões focadas em resíduos com pKa anômalo para a MCR.

Cada cadeia é plotada separadamente, e os gráficos são salvos como arquivos `.jpg`.

### Triagem virtual

Subpasta contendo o notebook `Biblioteca de compostos.ipynb` e a pasta `Bibliotecas`, onde estão as tabelas originais das bibliotecas utilizadas:

- `Enamine_Agro-like_Library_plated_10240cmpds_20250720.csv`
- `Enamine_Essential_Fragment_Library_plated_320cmpds_20251026.csv`
- `flavonoids.xlsx`
- `alkaloids_terpenoids.xlsx`

O notebook reúne e padroniza informações dessas bibliotecas, gera SMILES e identificadores limpos, concatena os conjuntos de produtos naturais e cria automaticamente arquivos `.yaml` preenchidos com cada SMILES para os modelos MCR e Mer.  
Ele também converte cada SMILES em estruturas 3D otimizadas (formato `.sdf`) utilizando RDKit, salvando os arquivos resultantes nas pastas correspondentes.


