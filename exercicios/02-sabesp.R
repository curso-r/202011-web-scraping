# 1. Escreva uma função que recebe uma data e retorna a tabela dos mananciais

baixar_sabesp <- function(data) {
  # ...
  # Dica: u_base <- "http://mananciais.sabesp.com.br/api/Mananciais/ResumoSistemas/"
}

# 2. Armazene no objeto tab_sabesp a tabela do dia `Sys.Date() - 1` (ontem)

tab_sabesp <- "..."

# 3. [extra] Arrume os dados para que fique assim:

# Observations: 7
# Variables: 2
# $ nome   <fct> Cantareira, Alto Tietê, Guarapiranga, Cotia, Rio Grande, Rio Claro, São Lourenço
# $ volume <dbl> 63.25681, 90.35307, 84.25839, 102.28429, 93.66445, 99.85615, 97.33682
