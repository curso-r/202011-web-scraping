library(tidyverse)
library(httr)
library(rvest)

u_cdg <- "http://www.chancedegol.com.br/br19.htm"

cdg_html <- u_cdg %>%
  GET() %>%
  content('text', encoding = 'latin1')

cdg_table <- cdg_html  %>%
  read_html() %>%
  xml_find_first('//table')

cores <- cdg_html %>%
  xml_find_all('//font[@color="#FF0000"]') %>%
  xml_text()

