library(httr)
library(magrittr)
library(jsonlite)

u_base <- "https://pokeapi.co/api/v2/"

# 1. Acesse todos os resultados de "type"
# Dica: qual é o endpoint que devemos utilizar?

# 2. Encontre o link do type "grass" e guarde em um objeto.
# Dica: você pode fazer isso manualmente ou com um código em R, usando {purrr}

# 3. Crie um data.frame com os 20 primeiros pokemons do tipo "grass"
# Dica: utilize o parâmetro query=.
# Além disso, tabelas ficam mais fáceis de visualizar quando rodamos 
# tibble::as_tibble(tab)
