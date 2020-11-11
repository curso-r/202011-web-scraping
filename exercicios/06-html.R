library(xml2)

# ler o HTML
html <- read_html("exemplos_de_aula/html_exemplo.html")

# 1. Qual a diferença entre xml_find_all() e xml_find_first()?

# 2. O que faz a função contains() aplicada dentro do XPath?
## Dica: xml_find_all(html, "//p[contains(@style, 'blue')]")

