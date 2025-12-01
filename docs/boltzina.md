# Análise Boltzina

## Descrição do arquivo `analise_boltziana.ipynb`
O notebook contém visualizações destinadas a inspecionar graficamente os resultados de docking e das métricas fornecidas pelos modelos Boltzina para os conjuntos MCR e Mer. Ele apresenta distribuições, comparações de rankings e relações diretas entre variáveis usadas na triagem.

### Histogramas de docking score

Mostram a distribuição dos valores de docking score (após filtragem para valores negativos).  
Os gráficos exibem como esses scores se espalham em cada conjunto.

### Histogramas de `affinity_probability_binary`
Apresentam a distribuição das probabilidades binárias de afinidade fornecidas pelo modelo Boltzina para MCR e Mer.  
Servem para visualizar a forma geral da distribuição dessa métrica nos dois conjuntos.

### Comparação entre rankings (docking vs Boltz)
Scatter plots relacionam o ranking de docking ao ranking do Boltz para cada conjunto.  
O propósito é visualizar como os rankings se organizam quando colocados lado a lado.

### Relação entre docking score e probabilidades de afinidade
Gráficos de dispersão relacionam o docking score com diferentes variantes de probabilidade (`affinity_probability_binary`, `binary1`, `binary2`).  
Permitem observar como essas variáveis variam umas em função das outras.

### Relação entre valores previstos (`affinity_pred_value1` e `affinity_pred_value2`) e suas probabilidades correspondentes
Scatter plots adicionais mostram a relação direta entre cada valor previsto pelo modelo e sua respectiva probabilidade binária.

### Comparação interna das previsões em MCR e Mer
O notebook ordena cada conjunto por `affinity_probability_binary` e exibe, no mesmo gráfico, as curvas associadas a `binary1`, `binary2` e à média utilizada como métrica principal.  
Serve para observar visualmente o contraste entre as previsões internas do modelo dentro de cada conjunto.

### Contagem de átomos dos ligantes e possíveis vieses simples
O notebook contabiliza o número de átomos de cada ligante a partir dos arquivos PDBQT e gera gráficos relacionando o número de átomos ao ranking de docking e ao ranking do Boltz.  
Esses gráficos permitem visualizar como o tamanho do ligante aparece distribuído ao longo dos rankings.

### Painel final cruzando número de átomos, ranking de Boltz e ranking de docking
Um conjunto de quatro scatter plots resume a relação entre:
- número de átomos e ranking do Boltz para MCR e Mer  
- número de átomos e ranking de docking para MCR e Mer  
Esse painel fornece uma visualização consolidada das variáveis principais utilizadas na triagem.
