# 1. Obtenha o vetor com as probabilidades dos resultados que realmente aconteceram
## Dica: qual é a cor deles?

library(tidyverse)
library(xml2)
library(httr)

u_cdg <- "http://www.chancedegol.com.br/br19.htm"

cdg_html <- GET(u_cdg)

# 2. Construa a tabela final e armazene em tab_cdg
## Dica: utilize rvest::html_table() e adicione a coluna cores

cdg_table <- cdg_html  %>%
  read_html() %>%
  xml_find_first('//table') %>%
  rvest::html_table() %>%
  tibble::as_tibble() %>%
  set_names(janitor::make_clean_names(.[1,])) %>%
  slice(-1)

cores <- cdg_html %>%
  read_html() %>%
  xml_find_all('//font[@color="#FF0000"]') %>%
  xml_text()

# codigo perigoso
cdg_table$vermelho <- cores


# 3. Rode tibble::glimpse(tab_cdg)
## e cole o resultado abaixo. Deixe o resultado como um comentário
## Dica: Selecione as linhas que deseja comentar e aplique Ctrl+Shift+C

# tibble::glimpse(cdg_table)

# Rows: 376
# Columns: 8
# $ data                 <chr> "27/04/2019", "27/04/2019", "27/04/2019", "27/04/2019…
# $ mandante             <chr> "Atlético MG", "São Paulo", "Flamengo", "Chapecoense"…
# $ x                    <chr> "2x1", "2x0", "3x1", "2x0", "1x2", "4x0", "4x0", "0x1…
# $ visitante            <chr> "Avaí", "Botafogo", "Cruzeiro", "Internacional", "San…
# $ vitoria_do_mandante  <chr> "54.6 %", "56.9 %", "51.7 %", "24.2 %", "60.4 %", "56…
# $ empate               <chr> "24.5 %", "27.8 %", "25.1 %", "31.3 %", "23.7 %", "26…
# $ vitoria_do_visitante <chr> "20.9 %", "15.2 %", "23.2 %", "44.6 %", "15.8 %", "17…
# $ vermelho             <chr> "54.6 %", "56.9 %", "51.7 %", "24.2 %", "15.8 %", "56…

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

cdg_table %>%
  mutate(across(-c(1:4), parse_number)) %>%
  mutate(
    acertou = pmax(vitoria_do_mandante, empate, vitoria_do_visitante) == vermelho
  ) %>%
  pivot_longer(c(mandante, visitante)) %>%
  group_by(value) %>%
  summarise(prop_acertos = mean(acertou), .groups = "drop") %>%
  mutate(value = fct_reorder(value, prop_acertos)) %>%
  ggplot(aes(x = prop_acertos, y = value)) +
  geom_col(fill = "darkblue") +
  scale_x_continuous(labels = scales::percent) +
  theme_minimal(12) +
  labs(
    x = "Proporção de acertos",
    y = "Time"
  )

