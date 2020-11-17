library(magrittr)

baixar_ano_mes <- function(ano, mes) {

  arquivo <- stringr::str_glue("result_{ano}_{mes}.xls")

  if (!file.exists(arquivo)) {
    u_ssp <- "http://www.ssp.sp.gov.br/transparenciassp/Consulta.aspx"
    r0 <- httr::GET(u_ssp)

    pegar_state <- function(r, parm) {
      r %>%
        xml2::read_html() %>%
        xml2::xml_find_first(stringr::str_glue("//*[@id='{parm}']")) %>%
        xml2::xml_attr("value")
    }


    # carrega a tabela de resultados
    vs <- pegar_state(r0, "__VIEWSTATE")
    ev <- pegar_state(r0, "__EVENTVALIDATION")
    vsg <- pegar_state(r0, "__VIEWSTATEGENERATOR")

    body <- list(
      "__EVENTTARGET" = "ctl00$cphBody$btnHomicicio",
      "__EVENTARGUMENT" = "",
      "__VIEWSTATE" = vs,
      "__VIEWSTATEGENERATOR" = vsg,
      "__EVENTVALIDATION" = ev,
      "ctl00$cphBody$hdfExport" = ""
    )

    r_homicidio <- httr::POST(
      u_ssp, body = body,
      encode = "form"
    )

    # exporta excel

    # carrega resultados para um ano/mes especifico

    vs <- pegar_state(r_homicidio, "__VIEWSTATE")
    ev <- pegar_state(r_homicidio, "__EVENTVALIDATION")
    vsg <- pegar_state(r_homicidio, "__VIEWSTATEGENERATOR")

    body <- list(
      "__EVENTTARGET" = paste0("ctl00$cphBody$lkAno", ano),
      "__EVENTARGUMENT" = "",
      "__VIEWSTATE" = vs,
      "__VIEWSTATEGENERATOR" = vsg,
      "__EVENTVALIDATION" = ev,
      "ctl00$cphBody$hdfExport" = ""
    )

    r_homicidio_ano <- httr::POST(
      u_ssp, body = body,
      encode = "form"
    )

    vs <- pegar_state(r_homicidio_ano, "__VIEWSTATE")
    ev <- pegar_state(r_homicidio_ano, "__EVENTVALIDATION")
    vsg <- pegar_state(r_homicidio_ano, "__VIEWSTATEGENERATOR")

    body <- list(
      "__EVENTTARGET" = paste0("ctl00$cphBody$lkMes", mes),
      "__EVENTARGUMENT" = "",
      "__VIEWSTATE" = vs,
      "__VIEWSTATEGENERATOR" = vsg,
      "__EVENTVALIDATION" = ev,
      "ctl00$cphBody$hdfExport" = ""
    )

    r_homicidio_ano_mes <- httr::POST(
      u_ssp, body = body,
      encode = "form"
    )

    # exporta excel
    vs <- pegar_state(r_homicidio_ano_mes, "__VIEWSTATE")
    ev <- pegar_state(r_homicidio_ano_mes, "__EVENTVALIDATION")
    vsg <- pegar_state(r_homicidio_ano_mes, "__VIEWSTATEGENERATOR")

    body <- list(
      "__EVENTTARGET" = "ctl00$cphBody$ExportarBOLink",
      "__EVENTARGUMENT" = "",
      "__VIEWSTATE" = vs,
      "__VIEWSTATEGENERATOR" = vsg,
      "__EVENTVALIDATION" = ev,
      "ctl00$cphBody$hdfExport" = ""
    )

    r_homicidio_ano_mes <- httr::POST(
      u_ssp, body = body,
      encode = "form",
      httr::write_disk(arquivo, TRUE)
    )

  }
}

baixar_ano_mes(18, 5)


# httr::BROWSE("r_homicidio_ano_mes.html")


## ARQUIVO BUGADO

# readr::read_delim(
#   "result_19_2.xlsx", delim = "\0"
# )
# readr::read_file_raw("result_19_2.xlsx") %>%
#   rawToChar() %>%
#   stringr::str_remove_all("\\0")
#
#
# data.table::fread("result_19_2.xlsx", sep = "\0")
#
# readxl::read_excel("result_19_2.xlsx")
