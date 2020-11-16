# 1. Crie uma função tjsp_baixar_pag() que baixa a página
## Dica: usar httr::write_disk()

# 2. Baixe todos os resultados

# 3. Crie uma funcao ler_item que lê cada item da tabela, como fizemos

# 4. Aplique a sua função em todos os elementos da saída e empilhe
## Dica: usar purrr::map_dfr()

# 5. Separe o título do conteúdo
## Dica: usar tidyr::separate()

# 6. Aplique tidyr::pivot_wider() para ficar com uma linha
## para cada processo. Cuidado: a linha com o número do processo é diferente

# 7. Armazene o resultado final em tab_tjsp

# 8.  Rode tibble::glimpse(tab_tjsp)
## e cole o resultado abaixo. Deixe o resultado como um comentário
## Dica: Selecione as linhas que deseja comentar e aplique Ctrl+Shift+C

# 9. [extra] monte um wordcloud.
## Dica: use tidytext para separar as palavras e ggwordcloud para o gráfico.
## Dica: mostre apenas palavras que aparecem mais do que 5 vezes.