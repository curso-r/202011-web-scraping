library(magrittr)

baixar_dia <- function(dia, pasta) {
  fs::dir_create(pasta)
  caminho <- paste0(pasta, "/", caminho)
  if (!file.exists(caminho)) {
    u <- paste0("http://mananciais.sabesp.com.br/api/Mananciais/ResumoSistemas/", dia)
    r <- httr::GET(u, httr::write_disk(caminho, TRUE))
  }
  caminho
}

# montar web scraper e salvar cada requisicao realizada em um log

da <- tibble::tibble(
  date = r$date,
  consulta = r$url,
  status = r$status_code
)
readr::write_csv(da, "log.csv", append = TRUE)

# montar web scraper e salvar cada requisicao realizada em um sqlite

con <- RSQLite::dbConnect(RSQLite::SQLite(), dbname = "log.sqlite")
da <- tibble::tibble(
  date = r$date,
  consulta = r$url,
  status = r$status_code
)
RSQLite::dbWriteTable(con, "log", da, append = TRUE)
RSQLite::dbDisconnect(con)

# para ler depois
da_log <- dplyr::tbl(con, "log")

# montar web scraper e salvar cada requisicao realizada em um arquivo rds
readr::write_rds(r, caminho_rds)