# 1. Crie uma função tjsp_baixar_pag() que baixa a página
## Dica: usar httr::write_disk()

tjsp_carregar_resultados <- function() {
  u_tjsp <- "https://esaj.tjsp.jus.br/cjsg/resultadoCompleta.do"
  b_tjsp <- list(
    dados.buscaInteiroTeor = "coronavirus",
    dados.origensSelecionadas = "T"
  )
  # Dica: abjutils::chrome_to_body()
  r_tjsp <- POST(u_tjsp, body = b_tjsp)
}

tjsp_baixar_pag <- function(pag) {
  u_tjsp_pag <- "https://esaj.tjsp.jus.br/cjsg/trocaDePagina.do"
  q_tjsp_pag <- list(tipoDeDecisao = "A", pagina = 1, conversationId = "")
  r_tjsp_pag <- GET(
    u_tjsp_pag, query = q_tjsp_pag,
    httr::write_disk(paste0("pagina", pag, ".html"))
  )
}

# muitas vezes precisa disso aqui
# r_tjsp <- POST(u_tjsp, body = b_tjsp, encode = "form")

parse_pagina <- function(arquivo) {
  tab_html <- arquivo %>%
    read_html(encoding = "UTF-8") %>%
    ## alternativa
    # xml_find_all("//table//tr")
    xml_find_all("//tr[@class='fundocinza1']//table")
  purrr::map_dfr(tab_html, ler_item, .id = "id")
}


ler_item <- function(item) {
  item %>%
    rvest::html_table(fill = TRUE) %>%
    as_tibble() %>%
    mutate(X1 = str_squish(X1))
}



# 2. Baixe todos os resultados

tjsp_carregar_resultados()
tjsp_baixar_pag(1)

# 3. Crie uma funcao ler_item que lê cada item da tabela, como fizemos

# 4. Aplique a sua função em todos os elementos da saída e empilhe
## Dica: usar purrr::map_dfr()

parse_pagina("pagina1.html")


# 5. Separe o título do conteúdo
## Dica: usar tidyr::separate()

# 6. Aplique tidyr::pivot_wider() para ficar com uma linha
## para cada processo. Cuidado: a linha com o número do processo é diferente

# 7. Armazene o resultado final em tab_tjsp

tab_tjsp <- parse_pagina("pagina1.html") %>%
  select(id, X1) %>%
  mutate(n_processo = str_extract(X1, "^[0-9.-]+")) %>%
  fill(n_processo) %>%
  group_by(id) %>%
  slice(-1) %>%
  ungroup() %>%
  separate(X1, c("titulo", "conteudo"), sep = ": ", extra = "merge") %>%
  pivot_wider(names_from = titulo, values_from = conteudo) %>%
  janitor::clean_names()

# 8.  Rode tibble::glimpse(tab_tjsp)
## e cole o resultado abaixo. Deixe o resultado como um comentário
## Dica: Selecione as linhas que deseja comentar e aplique Ctrl+Shift+C

# 9. [extra] monte um wordcloud.
## Dica: use tidytext para separar as palavras e ggwordcloud para o gráfico.
## Dica: mostre apenas palavras que aparecem mais do que 5 vezes.
