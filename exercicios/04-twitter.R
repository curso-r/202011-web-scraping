library(tidyverse)
library(httr)


# 1. faça rodar tab_twitter <- rtweet::get_my_timeline()




# 2. Rode tibble::glimpse(dplyr::select(tab_twitter, 1:20), 80)
## e cole o resultado abaixo. Deixe o resultado como um comentário
## Dica: Selecione as linhas que deseja comentar e aplique Ctrl+Shift+C





# 3. [extra] faça uma tabela mostrando apenas as colunas "screen_name" e "text",
# agrupando pela coluna "screen_name" usando reactable::reactable().
## Dica: use o parâmetro groupBy= do reactable::reactable()
