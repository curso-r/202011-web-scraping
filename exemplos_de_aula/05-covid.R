library(tidyverse)
library(httr)

u_msaude <- "https://covid.saude.gov.br"

httr::GET(
  u_msaude,
  httr::write_disk("pagina_msaude.html")
)


# (live)

u_portal_geral <- "https://xx9p7hp1p7.execute-api.us-east-1.amazonaws.com/prod/PortalGeral"

r <- httr::GET(
  u_portal_geral,
  httr::add_headers(
    "x-parse-application-id" = "unAFkcaNDeXajurGB7LChj8SgQYS2ptm"
  )
)

link_csv <- httr::content(r) %>%
  purrr::pluck("results", 1, "arquivo", "url")

httr::GET(
  link_csv,
  httr::write_disk("dados_covid.csv"),
  httr::progress()
)


# grafico -----------------------------------------------------------------

da <- vroom::vroom("dados_covid.csv")

library(ggplot2)

# versao incompleta
da %>%
  janitor::clean_names() %>%
  dplyr::filter(
    regiao != "Brasil",
    !is.na(estado),
    is.na(municipio)
  ) %>%
  dplyr::arrange(data) %>%
  dplyr::group_by(regiao, estado, semana_epi) %>%
  dplyr::summarise(
    obitos_acumulado = dplyr::last(obitos_acumulado),
    pop = dplyr::last(populacao_tcu2019),
    .groups = "drop"
  ) %>%
  dplyr::mutate(taxa = obitos_acumulado / pop) %>%
  ggplot(aes(x = semana_epi, y = taxa,
             colour = estado)) +
  geom_step() +
  facet_wrap(~regiao)











