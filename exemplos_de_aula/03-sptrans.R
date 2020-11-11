library(tidyverse)
library(httr)

u_sptrans <- "http://api.olhovivo.sptrans.com.br/v2.1"
endpoint <- "/Posicao"

u_sptrans_busca <- paste0(u_sptrans, endpoint)
(r_sptrans <- httr::GET(u_sptrans_busca))
httr::content(r_sptrans)

# caso voce nao queira/nao tenha conseguido fazer uma conta
api_key <- "4af5e3112da870ac5708c48b7a237b30206806f296e1d302e4cb611660e2e03f"

# Obtenha a API key e coloque no seu ambiente
## Dica: usar usethis::edit_r_environ("project")

u_sptrans_login <- paste0(u_sptrans, "/Login/Autenticar")
q_sptrans_login <- list(token = Sys.getenv("API_OLHO_VIVO"))
# q_sptrans_login <- list(token = api_key)
r_sptrans_login <- POST(u_sptrans_login, query = q_sptrans_login)

# precisa ser TRUE!
content(r_sptrans_login)

# agora sim, estamos autenticados :)

(r_sptrans <- httr::GET(u_sptrans_busca))
httr::content(r_sptrans)

# base de dados de posicoes (live)

# base desaninhada (live)

# visualizacao! (live)

