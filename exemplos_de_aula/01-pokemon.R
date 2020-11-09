library(httr)
library(magrittr)
library(jsonlite)

u_base <- "https://pokeapi.co/api/v2/"
endpoint <- "/pokemon/ditto"
u_pokemon <- paste0(u_base, endpoint)
r_pokemon <- GET(u_pokemon)

# 1. Entenda a diferença entre essas formas de pegar o conteúdo do resultado

content(r_pokemon)
content(r_pokemon, "text")
content(r_pokemon, "raw")
content(r_pokemon, "parsed")

content(r_pokemon, "parsed", simplifyDataFrame = TRUE)

fromJSON(content(r_pokemon, "text"))

# 2. Pegar informações filtrando com o código

q_pokemon <- list(
  limit = 8, 
  offset = 1
)

r_pokemon_filtrado <- GET(
  paste0(u_base, "/pokemon"), 
  query = q_pokemon
)

content(r_pokemon_filtrado, simplifyDataFrame = TRUE)

# 3. O que faz httr::write_disk()?

dir.create("output", showWarnings = FALSE, recursive = TRUE)

GET(
  paste0(u_base, "/pokemon"), 
  query = q_pokemon, 
  write_disk("output/01-pokemon.json")
)
