library(httr)
library(magrittr)
library(jsonlite)

u_base <- "https://pokeapi.co/api/v2/"

# 1. Acesse todos os resultados de "type"
# Dica: qual é o endpoint que devemos utilizar?

u_type <- paste0(u_base, "type")
r_type <- httr::GET(u_type, query = list(limit = 12))

# 2. Encontre o link do type "grass" e guarde em um objeto.
# Dica: você pode fazer isso manualmente ou com um código em R, usando {purrr}

httr::content(r_type)$results %>%
  purrr::keep(~.x$name == "grass") %>%
  purrr::pluck(1, "url")

u_grass <- httr::content(r_type, simplifyDataFrame = TRUE)$results %>%
  dplyr::filter(name == "grass") %>%
  dplyr::pull(url)

# 3. Crie um data.frame com os 20 primeiros pokemons do tipo "grass"
# Além disso, tabelas ficam mais fáceis de visualizar quando rodamos
# tibble::as_tibble(tab)

r_grass <- httr::GET(u_grass)

tab_pokemon <- httr::content(r_grass, "text") %>%
  jsonlite::fromJSON() %>%
  purrr::pluck("pokemon") %>%
  head(20) %>%
  tibble::as_tibble()

# lista[[1]]
# lista %>% purrr::pluck(1)

# lista$elemento
# lista %>% purrr::pluck("elemento")

# lista$elemento$outro_elemento
# lista %>% purrr::pluck("elemento", "outro_elemento")

# lista$elemento[[3]]
# lista %>% purrr::pluck("elemento", 3)
