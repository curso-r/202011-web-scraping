# 1. Obtenha o vetor com as probabilidades dos resultados que realmente aconteceram
## Dica: qual é a cor deles?

# 2. Construa a tabela final e armazene em tab_cdg
## Dica: utilize rvest::html_table() e adicione a coluna cores

# 3. Rode tibble::glimpse(tab_cdg)
## e cole o resultado abaixo. Deixe o resultado como um comentário
## Dica: Selecione as linhas que deseja comentar e aplique Ctrl+Shift+C

# 4. [extra] Construa um gráfico que mostra qual é a proporção
# de acertos do Chance de Gol por time. Os passos são
# a) obter qual seria o chute do Chance de Gol, dado pelo resultado com
# maior probabilidade em cada jogo
# b) construir uma coluna "acertou", que é TRUE se o modelo acertou 
# e FALSE caso contrário
# c) empilhar a base (usar tidyr::gather ou tidyr::pivot_longer) para considerar
# tanto mandantes quanto visitantes
# d) agrupar por time e calcular a proporção de acertos. Ordenar a variável
# pela proporção de acertos
# e) montar o gráfico!
