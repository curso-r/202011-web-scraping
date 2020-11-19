library(tidyverse)

# u <- "http://example.webscraping.com"
# httr::GET(u)

# login
u_login <- "http://example.webscraping.com/places/default/user/login"
r_login <- httr::GET(u_login)

form_key <- r_login %>%
  xml2::read_html() %>%
  xml2::xml_find_first("//*[@name='_formkey']") %>%
  xml2::xml_attr("value")

body <- list(
  "email" = Sys.getenv("WS_LOGIN"),
  "password" = Sys.getenv("WS_PWD"),
  "_next" = "/places/default/index",
  "_formkey" = form_key,
  "_formname" = "login"
)

r_logado <- httr::POST(
  u_login, body = body,
  httr::write_disk("ws_site.html")
)

# baixar uma pagina

baixar_pagina <- function(pag, pasta) {
  arquivo <- paste0(pasta, "/", pag, ".html")
  if (!file.exists(arquivo)) {
    u_pag <- paste0(
      "http://example.webscraping.com/places/default/index/",
      pag - 1
    )
    # arquivo <- stringr::str_glue("{pasta}/{pag}.html")
    httr::GET(u_pag, httr::write_disk(arquivo, overwrite = TRUE))
  }
  arquivo
}

maybe_baixar_pagina <- purrr::possibly(baixar_pagina, "erro")

maybe_baixar_pagina_progresso <- function(pag, pasta, prog) {
  if (!missing(prog)) prog()
  Sys.sleep(1)
  maybe_baixar_pagina(pag, pasta)
}

future::plan(future::sequential)
progressr::with_progress({
  paginas <- 1:26
  p <- progressr::progressor(length(paginas))
  furrr::future_map(
    paginas,
    maybe_baixar_pagina_progresso,
    pasta = "ws_site",
    prog = p
  )
})

# scrapy
# {later}

# scrapear uma pagina

# baixar um pais

# scrapear um pais
