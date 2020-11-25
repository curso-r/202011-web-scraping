tjmg_cpopg_download <- function(id, dir = ".", modelo = NULL) {

  fs::dir_create(dir)
  id <- stringr::str_remove_all(id, "[^0-9]")
  
  dir <- paste0(dir, "/", id)
  
  if (!dir.exists(dir)) {
    fs::dir_create(dir)
    u <- "https://www4.tjmg.jus.br/juridico/sf/proc_resultado.jsp?"
    q <- list(
      comrCodigo = stringr::str_sub(id, -4, -1),
      numero = "1",
      listaProcessos = id,
      btn_pesquisar = "Pesquisar"
    )
    r0 <- httr::GET(u, query = q)
    captcha <- tjmg_has_captcha(r0)
    
    if (!is.na(captcha)) {
      tmp <- tempfile(fileext = ".png")
      httr::GET(
        paste0("https://www4.tjmg.jus.br/juridico/sf/", captcha),
        httr::write_disk(tmp, overwrite = TRUE)
      )
      solved_captcha <- decryptr::decrypt(tmp, modelo)
      
      payload <- list(
        "callCount" = "1",
        "nextReverseAjaxIndex" = "0",
        "c0-scriptName" = "ValidacaoCaptchaAction",
        "c0-methodName" = "isCaptchaValid",
        "c0-id" = "0",
        "c0-param0" = paste0("string:", solved_captcha),
        "batchId" = "0",
        "instanceId" = "0",
        "page" = "",
        "scriptSessionId" = ""
      )
      u_captcha <- "https://www4.tjmg.jus.br/juridico/sf/dwr/call/plaincall/ValidacaoCaptchaAction.isCaptchaValid.dwr"
      r_captcha <- httr::POST(u_captcha, body = payload, encode = "form")
    }
    f <- paste0(dir, "/", id, ".html")
    r <- httr::GET(u, query = q, httr::write_disk(f, overwrite = TRUE))
    links <- tjmg_get_links(r)
    purrr::walk(links, tjmg_complemento, path = dir)
  }
  dir
}

tjmg_has_captcha <- function(r) {
  r %>%
    httr::content("text", encoding = "latin1") %>%
    xml2::read_html() %>%
    xml2::xml_find_first("//*[@id='captcha_image']") %>%
    xml2::xml_attr("src")
}

tjmg_get_links <- function(r) {
  r %>%
    httr::content("text", encoding = "latin1") %>%
    xml2::read_html() %>%
    xml2::xml_find_all("//a[@onclick='return validaPesquisa();']") %>%
    xml2::xml_attr("href")
}

tjmg_complemento <- function(link, path) {
  nm <- stringr::str_extract(link, "[a-z_]+")
  f <- paste0(path, "/", nm, ".html")
  if (!file.exists(f)) {
    u <- paste0("https://www4.tjmg.jus.br/juridico/sf/", link)
    httr::GET(u, httr::write_disk(f, overwrite = TRUE))
  }
}

library(magrittr)

m <- decryptr::load_model("tjmg")
tjmg_cpopg_download(
  "03024173020168130105",
  "out",
  modelo = m
)
