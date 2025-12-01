# Análise de pKa (`Análise de pKa.ipynb`)

Este notebook organiza e visualiza os resultados de pKa obtidos com o PropKa para Mer e MCR. Os arquivos de saída em texto são convertidos para arquivos `.csv` com três colunas principais (`Resíduo`, `pKa`, `pKa modelo`). Em seguida, os resíduos são separados por cadeia (A, B, C, D para Mer; A–F para MCR), preservando a informação de resíduo e cadeia em dataframes independentes.

São removidos dos conjuntos os resíduos terminais (rótulos como `N+1` e `C-327`) e, por decisão metodológica, todas as Cisteínas (`CYS`) e Tirosinas (`TYR`). Isso gera uma tabela limpa de resíduos ionizáveis relevantes, usada para construção dos gráficos.

A função `process_pka` faz o pré-processamento dos arquivos `.csv`, separando por cadeia e extraindo o identificador do resíduo. Já a função `plot_pka` gera gráficos de barras de pKa por resíduo, com cores diferentes para cada tipo de resíduo (ASP, GLU, HIS, LYS, ARG, etc.) e uma linha horizontal de referência no eixo y (pH ≈ 7). Para Mer, são gerados gráficos completos de pKa para cada cadeia, mostrando todos os resíduos após os filtros.

Para MCR, o notebook também recria o `.csv` a partir do resumo em texto (`RESUMO_mcr_6mer_pka.txt`), repete o mesmo tratamento de cadeias e filtros, e gera gráficos destacados para resíduos com pKa considerado “anômalo” segundo critérios definidos no código (por exemplo, ácidos fora de uma faixa de referência e básicos com pKa mais baixo do que o esperado). Esses gráficos marcam explicitamente apenas os resíduos classificados como anômalos no eixo x, o que facilita localizar visualmente essas posições nas diferentes cadeias.

