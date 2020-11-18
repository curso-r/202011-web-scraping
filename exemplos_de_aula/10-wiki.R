library(magrittr)
library(xml2)
library(purrr)
library(httr)
library(future)
library(furrr)
library(progressr)

# Na página da Wikipédia, encontrar o objeto correspondente à tabela lateral de 
# informações. Pegar apenas os elementos correspondentes a links.

links <- "https://en.wikipedia.org/wiki/R_language" %>%
  read_html() %>%
  xml_find_all("//table[@class='infobox vevent']//a")

head(links)

# Extrair todos os URLs dos links e completá-los com o resto do caminho da
# Wikipédia. Continuar usando apenas _pipes_.

urls <- "https://en.wikipedia.org/wiki/R_language" %>%
  read_html() %>%
  xml_find_all("//table[@class='infobox vevent']//a") %>%
  xml_attr("href") %>%
  paste0("https://en.wikipedia.org", .)

head(urls)

# Baixar todas as páginas da Wikipédia.
# para impedir erros quando o URL for inválido; procure saber sobre 
# a função `map2()` para iterar em mais de uma lista

# salvar os arquivos com `GET(..., write_disk(path))`

dir.create("out")

paths <- paste0("out/", seq_along(urls), ".html")

maybe_get <- function(url, path) {
  possibly(GET, NULL)(url, write_disk(path))
}

out <- map2(urls, paths, maybe_get)

length(compact(out))

# fazendo o mesmo, em paralelo

plan(multisession)
out <- future_map2(urls, paths, maybe_get)

# fazendo o mesmo, com barra de progresso

# reescrevendo a funcao
maybe_get_progress <- function(url, path, prog) {
  if (!missing(prog)) prog()
  possibly(GET, NULL)(url, write_disk(path))
}

with_progress({
  p <- progressor(length(urls))
  out <- future_map2(urls, paths, maybe_get_progress, p)
})


# curiosidade -------------------------------------------------------------

handlers(list(
  handler_progress(),
  handler_beepr(
    initiate = 2L,
    update = 10L,
    finish = 11L
  )
))

progressr::with_progress({
  p <- progressr::progressor(20)
  walk(1:20, ~{
    p()
    Sys.sleep(1)
  })
})
