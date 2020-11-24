# 1. Adicione tratamento de erros e barras de progresso na função
# de baixar uma página

library(magrittr)

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

# http://example.webscraping.com

# 2. Rode a função de baixar páginas em paralelo

verificar_next <- function(html_file) {
  l <- html_file %>%
    xml2::read_html() %>%
    xml2::xml_find_all("//a[contains(text(), 'Next >')]") %>%
    length()
  l > 0
}

continua <- TRUE
ii <- 1
while (continua) {
  arq <- baixar_pagina(ii, "out")
  ii <- ii + 1
  continua <- verificar_next(arq)
}

verificar_next("out/1.html")
verificar_next("out/60.html")
baixar_pagina(60, "out")


# 3. Verifique se todos os arquivos baixaram corretamente
# Obs: Pode ser que seu IP tenha sido bloqueado!

# 4. Como você resolveria esse problema?
