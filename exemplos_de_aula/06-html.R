library(xml2)

# ler o HTML
html <- read_html("exemplos_de_aula/html_exemplo.html")

# Coletar todos os nodes com a tag <p>
nodes <- xml_find_all(html, "//p")
nodes

# buscar no documento todo ou dentro das tags
xml_find_all(nodes, "//head")
xml_find_all(nodes, "/head")

# Extrair o texto contido em cada um dos nodes
text <- xml_text(nodes)
text

# extração de atributos
xml_attrs(nodes)
xml_attr(nodes, "style")
