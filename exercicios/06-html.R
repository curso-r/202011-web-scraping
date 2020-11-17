library(xml2)

# ler o HTML
html <- read_html("exemplos_de_aula/html_exemplo.html")

# 1. Qual a diferença entre xml_find_all() e xml_find_first()?

# esses dois são equivalentes
xml2::xml_find_all(html, "//body")[[1]]
xml2::xml_find_first(html, "//body")

# esses dois não são
xml2::xml_find_all(html, "//body")
xml2::xml_find_first(html, "//body")

# 2. O que faz a função contains() aplicada dentro do XPath?
## Dica: xml_find_all(html, "//p[contains(@style, 'blue')]")

xml_find_all(html, "//p[contains(@style, 'blue')]")

xml_find_all(html, "//p[contains(text(), 'Sou')]")

# é como str_detect(), mas para xpath
