library(magrittr)

baixar_dia <- function(dia, pasta) {
  fs::dir_create(pasta)
  caminho <- paste0(pasta, "/", dia, ".json")
  if (!file.exists(caminho)) {
    u <- paste0("http://mananciais.sabesp.com.br/api/Mananciais/ResumoSistemas/", dia)
    r <- httr::GET(u, httr::write_disk(caminho, TRUE))
  }
  caminho
}

baixar_dia("2020-11-24", ".")

# montar web scraper e salvar cada requisicao realizada em um log


baixar_dia_csv <- function(dia, pasta) {
  fs::dir_create(pasta)
  caminho <- paste0(pasta, "/", dia, ".json")

  safe_get <- purrr::safely(httr::GET, otherwise = NULL)
  if (!file.exists(caminho)) {
    u <- paste0("http://mananciais.sabesp.com.br/api/Mananciais/ResumoSistemas/", dia)
    r <- safe_get(u, httr::write_disk(caminho, TRUE))
  }
  if (!is.null(r$error)) {
    erro <- as.character(r$error)
    da <- tibble::tibble(
      date = Sys.time(),
      consulta = u,
      status = erro
    )
  } else {
    da <- tibble::tibble(
      date = r$result$date,
      consulta = r$result$url,
      status = r$result$status_code
    )
  }
  readr::write_csv(da, "log.csv", append = TRUE)
  caminho
}
purrr::walk(c(as.character(Sys.Date() - 1:10), "a"),
            baixar_dia_csv, "out")

# montar web scraper e salvar cada requisicao realizada em um sqlite

con <- RSQLite::dbConnect(RSQLite::SQLite(), dbname = "log.sqlite")
baixar_dia_sql <- function(dia, pasta, con) {
  fs::dir_create(pasta)
  caminho <- paste0(pasta, "/", dia, ".json")
  if (!file.exists(caminho)) {
    u <- paste0("http://mananciais.sabesp.com.br/api/Mananciais/ResumoSistemas/", dia)
    r <- httr::GET(u, httr::write_disk(caminho, TRUE))
  }

  da <- tibble::tibble(
    date = r$date,
    consulta = r$url,
    status = r$status_code
  )
  RSQLite::dbWriteTable(con, "log", da, append = TRUE)
  caminho
}
purrr::walk(Sys.Date() - 1:10, baixar_dia_sql, "out", con)
RSQLite::dbDisconnect(con)

# para ler depois
da_log <- dplyr::tbl(con, "log")

# montar web scraper e salvar cada requisicao realizada em um arquivo rds

baixar_dia_rds <- function(dia, pasta) {
  fs::dir_create(pasta)
  caminho <- paste0(pasta, "/", dia, ".json")
  if (!file.exists(caminho)) {
    u <- paste0("http://mananciais.sabesp.com.br/api/Mananciais/ResumoSistemas/", dia)
    r <- httr::GET(u, httr::write_disk(caminho, TRUE))
  }
  caminho_rds <- fs::path_ext_set(caminho, ".rds")
  readr::write_rds(r, caminho_rds)
  caminho
}
purrr::walk(Sys.Date() - 1:10, baixar_dia_rds, "out")

